app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        $scope.app.settings.patientFooterClass = 'app-footer';
        
        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $scope.data = {};
                var pat_det = $scope.patientObj;
                
                $scope.data = pat_det;

                $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_bill_type, 'GetPatientBillingList', function (response) {
                    $scope.data.bill_type = response;
                });

                $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_reg_mode, 'GetPatientRegisterModelList', function (response) {
                    $scope.data.reg_mode = response;
                });

                $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_marital_status, 'GetMaritalStatus', function (response) {
                    $scope.data.marital_status = response;
                });
            }
        }, true);

    }]);