app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        $scope.app.settings.patientFooterClass = 'app-footer';
        
        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $scope.data = $scope.patientObj;

                $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_bill_type, 'GetPatientBillingList', function (response) {
                    $scope.data.patient_bill_type = response;
                });

                $rootScope.commonService.GetLabelFromValue($scope.patientObj.patient_reg_mode, 'GetPatientRegisterModelList', function (response) {
                    $scope.data.patient_reg_mode = response;
                });
            }
        }, true);

    }]);