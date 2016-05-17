app.controller('OutPatientsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';
        
        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.encounterIDs = [];

        //Index Page
        $scope.loadOutPatientsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/outpatients')
                    .success(function (OutPatients) {
                        $scope.isLoading = false;
                        $scope.rowCollection = OutPatients.result;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        $scope.more_li = [];

//                        angular.forEach(OutPatients, function (value) {
//                            $scope.encounterIDs.push({
//                                'encounterID': value.encounter_id,
//                                'patientID': value.patient_id,
//                                'selected': false
//                            })
//                        });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patients!";
                    });
        };

        $scope.moreOptions = function (key, enc_id) {
            $scope.more_li = [];
            $scope.more_li.push({
                href: "cancelSelected()",
                name: 'Cancel Appointment',
                mode: 'click'
            });
        }

        $scope.selectedIDs = [];
        $scope.cancelSelected = function () {
            angular.forEach($scope.encounterIDs, function (item) {
                if (item.selected) {
                    $scope.selectedIDs.push({
                        'encounter_id': item.encounterID,
                        'patient_id': item.patientID,
                    });
                }
            });
            $scope.cancelAppointments();
        };

        $scope.cancelAppointments = function () {
            var conf = confirm('Are you sure to cancel these appointments ?');
            if (conf) {
                $scope.loadbar('show');
                post_url = $rootScope.IRISOrgServiceUrl + '/appointment/bulkcancel';
                method = 'POST';
                succ_msg = 'Appointment cancelled successfully';
                var PatAppointment = $scope.selectedIDs;
                $http({
                    method: method,
                    url: post_url,
                    data: PatAppointment,
                }).success(
                        function (response) {
                            $scope.successMessage = succ_msg;
                            $scope.loadbar('hide');
                            $scope.loadOutPatientsList();
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            }
        }

        $scope.statuses = [
            {value: 'A', text: 'Arrived'},
        ];

        $scope.arr_statuses = [
            {value: 'S', text: 'Seen'},
        ];

        $scope.updatePatient = function (id, _data, val) {
            if (val == '') {
                return 'Mobile can not be empty';
            }
            if (!val.match(/^[0-9]{10}$/)) {
                return 'Mobile must be 10 digits only';
            }
            $http({
                method: 'PUT',
                url: $rootScope.IRISOrgServiceUrl + '/patients/' + id,
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = 'Patient updated successfully';
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.setTimings = function (key, mode) {
            if (mode == 'set') {
                st_d = moment().format('YYYY-MM-DD');
                st_t = moment().format('hh:mm A');
            } else {
                st_d = st_t = '';
            }
            $scope.displayedCollection[key].sts_date = st_d;
            $scope.displayedCollection[key].sts_time = st_t;
        }

        $scope.onTimeSet = function (newDate, oldDate, key) {
            $scope.displayedCollection[key].sts_date = moment(newDate).format('YYYY-MM-DD');
            $scope.displayedCollection[key].sts_time = moment(newDate).format('hh:mm A');
        }

        $scope.changeAppointmentStatus = function (_data, key) {
            $scope.errorData = "";
            $scope.successMessage = "";

//            console.log(_data);
//            return false;

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/appointments',
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = 'Status changed successfully';
                        $scope.displayedCollection[key].liveAppointmentArrival = response;
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

//app.filter('moment', function () {
//    return function (dateString, format) {
//        return moment(dateString).format(format);
//    };
//});