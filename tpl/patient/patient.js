app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.loadView = function () {
            $http.post($rootScope.IRISOrgServiceUrl + '/patient/getpatientbyguid', {guid: $state.params.id})
                    .success(function (patient) {
                        $scope.view_data = {};
                        $scope.view_data = patient;
                        $rootScope.commonService.GetLabelFromValue(patient.patient_bill_type, 'GetPatientBillingList', function (response) {
                            $scope.view_data.bill_type = response;
                        });

                        $rootScope.commonService.GetLabelFromValue(patient.patient_reg_mode, 'GetPatientRegisterModelList', function (response) {
                            $scope.view_data.reg_mode = response;
                        });

                        $rootScope.commonService.GetLabelFromValue(patient.patient_marital_status, 'GetMaritalStatus', function (response) {
                            $scope.view_data.marital_status = response;
                        });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient!";
                    });
        }
    }]);