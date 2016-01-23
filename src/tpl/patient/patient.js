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
                        $scope.app.patientDetail.patientSex = patient.patient_gender;
                        $scope.app.patientDetail.patientDOA = patient.patient_reg_date;
                        $scope.app.patientDetail.patientOrg = patient.tenant_id;
                        $scope.data = patient;
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading patient!";
                    });
        };

    }]);