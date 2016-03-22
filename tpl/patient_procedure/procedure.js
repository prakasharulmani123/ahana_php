// this is a lazy load controller, 
// so start with "app." to register this controller
 
app.filter('propsFilter', function () {
    return function (items, props) {
        var out = [];

        if (angular.isArray(items)) {
            items.forEach(function (item) {
                var itemMatches = false;

                var keys = Object.keys(props);
                for (var i = 0; i < keys.length; i++) {
                    var prop = keys[i];
                    var text = props[prop].toLowerCase();
                    if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
                        itemMatches = true;
                        break;
                    }
                }

                if (itemMatches) {
                    out.push(item);
                }
            });
        } else {
            // Let the output be the input untouched
            out = items;
        }

        return out;
    };
})
app.controller('ProcedureController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$timeout', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $timeout, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.enc = {};
        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp){
                        resp.encounter_id = resp.encounter_id.toString(); 
                    });
                    $scope.encounters = response;
                    if(response != null){
                        $scope.enc.selected = $scope.encounters[0];
                    }
                });
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.loadProceduresList(newValue);
            }
        }, true);

        $scope.initProcedureIndex = function () {
            $scope.data = {};
        }
        
        $scope.loadProceduresList = function (enc_id) {
            $scope.loadbar('show');
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/procedure/getprocedurebyencounter?enc_id=' + enc_id)
                    .success(function (procedures) {
                        $scope.loadbar('hide');
                        $scope.isLoading = false;
                        $scope.rowCollection = procedures;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading procedures!";
                    });
        };

        $scope.initForm = function () {
            $scope.loadbar('show');
            $scope.data = {};
            $scope.data.proc_date = moment().format('YYYY-MM-DD HH:mm:ss');
            $rootScope.commonService.GetChargeCategoryList('', '1', false, 'PRC', function (response) {
                $scope.procedures = response.categoryList;
            });

            $scope.doctors = [];
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
                $scope.loadbar('hide');
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            docIds = [];
            angular.forEach($scope.data.consultant_ids, function (list) {
                docIds.push(list.user_id);
            });
            _that.data.proc_consultant_ids = docIds;
            angular.extend(_that.data, {patient_id: $scope.app.patientDetail.patientId});
            _that.data.proc_date = moment(_that.data.proc_date).format('YYYY-MM-DD HH:mm:ss');

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/procedures';
                method = 'POST';
                succ_msg = 'Procedure Added successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/procedures/' + _that.data.proc_id;
                method = 'PUT';
                succ_msg = 'Procedure updated successfully';
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
                            $state.go('patient.procedure', {id: $scope.app.patientDetail.patientGuid});
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
                url: $rootScope.IRISOrgServiceUrl + "/procedures/" + $state.params.proc_id,
                method: "GET"
            }).success(
                    function (response1) {
                        $scope.loadbar('hide');
                        $scope.ids = response1.proc_consultant_ids;
                        $scope.data = response1;

                        $scope.data.consultant_ids = [];
                        $scope.$watch('doctors', function (newValue, oldValue) {
                            angular.forEach($scope.doctors, function (n, i) {
                                if ($.inArray(n.user_id, $scope.ids) >= 0) {
                                    $scope.data.consultant_ids.push($scope.doctors[i]);
                                }
                            });
                        }, true);
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Delete
        $scope.removeRow = function (id) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
//                var index = $scope.displayedCollection.indexOf(row);
//                if (index !== -1) {
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/procedure/remove",
                    method: "POST",
                    data: {id: id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.loadProceduresList();
                                $scope.successMessage = 'Procedure Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
//                }
            }
        };

        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened2 = true;
                    break;
            }
        };

    }]);
