app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';

        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                        $http.get($rootScope.IRISOrgServiceUrl + '/patient/getpatientaddress?id=' + $scope.patientObj.patient_id)
                                .success(function (resp) {
                                    $scope.data = $scope.patientObj;
                                    $scope.data.address = resp.address;

                                    $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_bill_type, 'GetPatientBillingList', function (response) {
                                        $scope.data.patient_bill_type = response;
                                    });

                                    $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_reg_mode, 'GetPatientRegisterModelList', function (response) {
                                        $scope.data.patient_reg_mode = response;
                                    });

                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading patient address!";
                                });
            }
        }, true);

        //Encounter Page
        $scope.loadPatientEncounters = function (type) {
            $scope.encounterView = type;
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.encounters;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                        } else {
                            $scope.error = response.message;
                        }
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading encounter!";
                    });
        };
    }]);