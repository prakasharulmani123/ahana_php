app.controller('ModalPatientFutureAppointmentController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

        //Scope Variables
        $scope.title = $modalInstance.data.title;
        $scope.app = scope.app;

        //For Datepicker
        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        //Initialize Form
        $scope.initAppointmentForm = function () {
            $scope.data = {};
            $scope.data.status_date = moment($scope.date).format('YYYY-MM-DD');
            $scope.data.patient_id = $scope.app.patientDetail.patientId;
            $scope.data.consultant_id = $scope.app.patientDetail.patientLastConsultantId;
            $scope.getTimeOfAppointment();
        }

        //Time Slots Preparation
        $scope.getTimeOfAppointment = function () {
            if (typeof (this.data) != "undefined") {
                if (typeof ($scope.app.patientDetail.patientLastConsultantId) != 'undefined' && typeof (this.data.status_date != 'undefined')) {
                    $scope.getTimeSlots($scope.app.patientDetail.patientLastConsultantId, this.data.status_date);
                }
            }
        }
        $scope.getTimeSlots = function (doctor_id, date) {
            $http.post($rootScope.IRISOrgServiceUrl + '/doctorschedule/getdoctortimeschedule', {doctor_id: doctor_id, schedule_date: date})
                    .success(function (response) {
                        $scope.timeslots = [];
                        angular.forEach(response.timerange, function (value) {
                            $scope.timeslots.push({
                                time: value.time,
                                color: value.color,
                            });
                        });
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                    });
        }

        //Save Form
        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/encounter/createappointment';
            method = 'POST';
            succ_msg = 'Appointment saved successfully';

            scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
                                $modalInstance.dismiss('cancel');
                                $state.go($state.current, {}, {reload: true});
                            }, 1000)
                        } else {
                            $scope.errorData = response.message;
                        }
                    }
            ).error(function (data, status) {
                scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Cancel Modal Popup
        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    }]);
  