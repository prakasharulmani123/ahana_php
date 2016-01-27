app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';

        //Index Page
        $scope.loadPatientDetail = function () {
            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patients/' + $state.params.id)
                    .success(function (patient) {
                        $scope.app.patientDetail.patientTitleCode = patient.patient_title_code;
                        $scope.app.patientDetail.patientName = patient.patient_firstname;
                        $scope.app.patientDetail.patientId = patient.patient_id;
                        $scope.app.patientDetail.patientDOA = patient.doa;
                        $scope.app.patientDetail.patientOrg = patient.org_name;
                        $scope.app.patientDetail.patientAge = patient.patient_age;
                        $rootScope.commonService.GetLabelFromValue(patient.patient_gender, 'GetGenderList', function (response) {
                            $scope.app.patientDetail.patientSex = response;
                        });

                        $http.get($rootScope.IRISOrgServiceUrl + '/patient/getpatientaddress?id=' + patient.patient_id)
                                .success(function (resp) {
                                    $scope.data = patient;
                                    $scope.data.address = resp.address;

                                    $rootScope.commonService.GetLabelFromValue(patient.patient_bill_type, 'GetPatientBillingList', function (response) {
                                        $scope.data.patient_bill_type = response;
                                    });

                                    $rootScope.commonService.GetLabelFromValue(patient.patient_reg_mode, 'GetPatientRegisterModelList', function (response) {
                                        $scope.data.patient_reg_mode = response;
                                    });

                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading patient address!";
                                });

                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading patient!";
                    });
        };

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