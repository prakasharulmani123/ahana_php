app.controller('PatientsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, $filter, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.initCanCreateAppointment = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    alert("This patient already have an active appointment. You can't create a new appointment");
                    $state.go("patient.view", {id: $state.params.id});
                }
            });
        }

        $scope.initCanSaveAppointment = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    if (response.model.encounter_id != $state.params.enc_id) {
                        alert("This is not an active Encounter");
                        $state.go("patient.encounter", {id: $state.params.id});
                    } else {
                        var consultant_id = '';
                        if (response.model.liveAppointmentArrival.hasOwnProperty('appt_id')) {
                            $scope.data = {'PatAppointment': {'appt_status': 'A', 'dummy_status': 'A'}};
                            consultant_id = response.model.liveAppointmentArrival.consultant_id;
                        } else if (response.model.liveAppointmentBooking.hasOwnProperty('appt_id')) {
                            $scope.data = {'PatAppointment': {'appt_status': 'B', 'dummy_status': 'B'}};
                            consultant_id = response.model.liveAppointmentArrival.consultant_id;
                        }
                        if (consultant_id) {
                            $http.get($rootScope.IRISOrgServiceUrl + '/default/getconsultantcharges?consultant_id=' + consultant_id)
                                    .success(function (response) {
                                        $scope.chargesList = response.chargesList;
                                    }, function (x) {
                                        response = {success: false, message: 'Server Error'};
                                    });
                        }
                    }
                } else {
                    alert("This is not an active Encounter");
                    $state.go("patient.encounter", {id: $state.params.id});
                }
            });
        }

        $scope.chargeAmount = '';
        $scope.updateCharge = function () {
            _that = this;
            console.log(_that.data.PatAppointment.patient_cat_id);
            var charge = $filter('filter')($scope.chargesList, {patient_cat_id: _that.data.PatAppointment.patient_cat_id});
            $scope.chargeAmount = charge[0].charge_amount;
        }

        $scope.initForm = function () {
            //Load Doctor List
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            $rootScope.commonService.GetPatientAppointmentStatus(function (response) {
                $scope.appt_status_lists = response;
            });
        }

        $scope.initAppointmentForm = function () {
            $scope.data = {};
            $scope.data.status_date = moment().format('YYYY-MM-DD');
        }



        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
            }
        };

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.toggleMin = function () {
            $scope.minDate = $scope.minDate ? null : new Date();
        };
        $scope.toggleMin();

        $scope.disabled = function (date, mode) {
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
        };

        $scope.initTimepicker = function () {
            $('.timepicker').timepicker();
        }

        $scope.getTimeOfAppointment = function () {
            if (typeof (this.data) != "undefined") {
                if (typeof (this.data.consultant_id) != 'undefined' && typeof (this.data.status_date != 'undefined')) {
                    $http.post($rootScope.IRISOrgServiceUrl + '/doctorschedule/getdoctortimeschedule', {doctor_id: this.data.consultant_id, schedule_date: this.data.status_date})
                            .success(function (response) {
                                $scope.timeslots = response.timerange;
                            }, function (x) {
                                response = {success: false, message: 'Server Error'};
                            });
                }
            }
        }

        //Save Both Add Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/encounter/createappointment';
            method = 'POST';
            succ_msg = 'Appointment saved successfully';
            angular.extend(_that.data, {patient_id: $scope.app.patientDetail.patientId});

            _that.data.status_date = moment(_that.data.status_date).format('YYYY-MM-DD');
            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
                        } else {
                            $scope.errorData = response.message;
                        }

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.changeAppointmentStatus = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (typeof (_that.data) != "undefined") {
                if (_that.data.hasOwnProperty('PatAppointment')) {
                    angular.extend(_that.data.PatAppointment, {patient_id: $scope.app.patientDetail.patientId, encounter_id: $state.params.enc_id});
                }
            }

            post_url = $rootScope.IRISOrgServiceUrl + '/appointments';
            method = 'POST';
            succ_msg = 'Status changed successfully';

            if (_that.data.PatAppointment.status_date) {
                _that.data.PatAppointment.status_time = moment(_that.data.PatAppointment.status_date).format('HH:mm:ss');
                _that.data.PatAppointment.status_date = moment(_that.data.PatAppointment.status_date).format('YYYY-MM-DD');
            }

            if (mode == 'arrived') {
                _that.data.PatAppointment.appt_status = "A";
            } else if (mode == 'seen') {
                _that.data.PatAppointment.appt_status = "S";
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data.PatAppointment,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go("patient.encounter", {id: $state.params.id});
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

        $scope.cancelAppointment = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    if (response.model.encounter_id != $state.params.enc_id) {
                        alert("This is not an active Encounter");
                        $state.go("patient.encounter", {id: $state.params.id});
                    } else {
                        $scope.errorData = "";
                        var modalOptions = {
                            closeButtonText: 'No',
                            actionButtonText: 'Yes',
                            headerText: 'Cancel Appointment?',
                            bodyText: 'Are you sure you want to cancel this appointment?'
                        };
                        modalService.showModal({}, modalOptions).then(function (result) {
                            $scope.loadbar('show');
                            post_url = $rootScope.IRISOrgServiceUrl + '/appointments';
                            method = 'POST';
                            succ_msg = 'Appointment cancelled successfully';
                            var PatAppointment = {
                                appt_status: "C",
                                status_time: moment().format('HH:mm:ss'),
                                status_date: moment().format('YYYY-MM-DD'),
                                patient_id: $scope.app.patientDetail.patientId,
                                encounter_id: $state.params.enc_id
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAppointment,
                            }).success(
                                    function (response) {
                                        $scope.loadbar('hide');
                                        $scope.successMessage = succ_msg;
                                        $scope.data = {};
                                        $timeout(function () {
                                            $state.go("patient.encounter", {id: $state.params.id});
                                        }, 1000)

                                    }
                            ).error(function (data, status) {
                                $scope.loadbar('hide');
                                if (status == 422)
                                    $scope.errorData = $scope.errorSummary(data);
                                else
                                    $scope.errorData = data.message;
                            });
                        });
                    }
                }
            });
        };
    }]);