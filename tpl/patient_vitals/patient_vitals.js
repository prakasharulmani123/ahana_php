app.controller('VitalsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.disabled = function (date, mode) {
            date = moment(date).format('YYYY-MM-DD');
            return $.inArray(date, $scope.enabled_dates) === -1;
        };

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.initCanCreateVital = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    alert("Sorry, you can't create a vital");
                    $state.go("patient.vitals", {id: $state.params.id});
                } else {
                    $scope.encounter = response.model
                }
            });
        }

        //Index Page
        $scope.enabled_dates = [];
        $scope.loadPatVitalsList = function (date) {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            if (typeof date == 'undefined') {
                url = $rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?patient_id=' + $state.params.id;
            } else {
                date = moment(date).format('YYYY-MM-DD');
                url = $rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?patient_id=' + $state.params.id + '&date=' + date;
            }

            // Get data's from service
            $http.get(url)
                    .success(function (vitals) {
                        $scope.isLoading = false;
                        $scope.rowCollection = vitals.result;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

                        angular.forEach($scope.rowCollection, function (row) {
                            var result = $filter('filter')($scope.enabled_dates, moment(row.vital_time).format('YYYY-MM-DD'));
                            if (result.length == 0)
                                $scope.enabled_dates.push(moment(row.vital_time).format('YYYY-MM-DD'));
                        });
                        $scope.$broadcast('refreshDatepickers');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientvital!";
                    });
        };

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.initForm = function () {
            $scope.data = {};
            $scope.data.vital_time = moment().format('YYYY-MM-DD HH:mm:ss');
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientvitals';
                method = 'POST';
                succ_msg = 'Vital saved successfully';

                angular.extend(_that.data, {
                    patient_id: $scope.patientObj.patient_id,
                    encounter_id: $scope.encounter.encounter_id,
                });
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientvitals/' + _that.data.vital_id;
                method = 'PUT';
                succ_msg = 'Vital updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('patient.vitals', {id: $state.params.id});
                        }, 1000)

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientvitals/" + $state.params.vital_id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        $scope.encounter = {encounter_id: response.encounter_id};
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };
    }]);