app.controller('ModalPatientAppointmentController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {
        
        $scope.title = $modalInstance.data.title;
        $scope.date = $modalInstance.data.date;
        
        $scope.getTitle = function(){
            return $modalInstance.data.title;
        };

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };
        
        $scope.initForm = function () {
            //Load Doctor List
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            
            //Patients List
            $rootScope.commonService.GetPatientList('', '1', false, function (response) {
                $scope.patients = response.patientlist;
            });
        }
        
        $scope.initAppointmentForm = function () {
            $scope.data = {};
            $scope.data.status_date = moment($scope.date).format('YYYY-MM-DD');
        }
        
        $scope.formatPatient = function ($item, $model, $label) {
            $scope.data.patient_id = $item.patient_id;
        }
        
        $scope.getTimeOfAppointment = function () {
            if (typeof (this.data) != "undefined") {
                if (typeof (this.data.consultant_id) != 'undefined' && typeof (this.data.status_date != 'undefined')) {
                    $scope.getTimeSlots(this.data.consultant_id, this.data.status_date);
                }
            }
        }

        $scope.getTimeSlots = function (doctor_id, date) {
            $http.post($rootScope.IRISOrgServiceUrl + '/doctorschedule/getdoctortimeschedule', {doctor_id: doctor_id, schedule_date: date})
                    .success(function (response) {
                        $scope.timeslots = [];
                        angular.forEach(response.timerange, function (value) {
                            $scope.timeslots.push(value.time);
                        });
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                    });
        }
        
        //Save Both Add Data
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

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    }]);
  