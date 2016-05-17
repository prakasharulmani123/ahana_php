app.controller('FutureAppointmentController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', 'modalService', '$modal', '$log', function ($rootScope, $scope, $timeout, $http, $state, $filter, modalService, $modal, $log) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        $scope.more_max = 4;

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.checkboxes = {'checked': false, items: {}};
        $scope.futureappointmentSelectedItems = [];
        $scope.futureappointmentSelected = 0;

        $scope.encounterIDs = [];
        //Encounter Page
        $scope.loadFutureAppointmentsList = function () {
            $scope.errorData = '';
            $scope.isLoading = true;
            $scope.rowCollection = [];  // base collection
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/appointment/getfutureappointmentslist?consultant_id=' + $state.params.consultant_id + '&date=' + $state.params.date)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.result;
                            $scope.displayedCollection = [].concat($scope.rowCollection);

                            $scope.more_li = {};

                            angular.forEach(response.result[0].all, function (value) {
                                $scope.encounterIDs.push({
                                    'consultantID': value.consultant_id,
                                    'consultantName': value.consultant_name,
                                    'statusDate': value.status_date,
                                    'encounterID': value.encounter_id,
                                    'patientID': value.patient_id,
                                    'patientName': value.patient_name,
                                    'selected': false
                                })
                            });

                            $scope.checkboxes = {'checked': false, items: {}};
                            $scope.futureappointmentSelectedItems = [];
                            $scope.futureappointmentSelected = 0;
                        } else {
                            $scope.errorData = response.message;
                        }
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading encounter!";
                    });
        };

        // watch for data checkboxes
        $scope.$watch('checkboxes.items', function (values) {
            $scope.futureappointmentSelectedItems = [];
            if (!$scope.rowCollection) {
                return;
            }
            var checked = 0, unchecked = 0, total = 0;

            if ($scope.rowCollection.length > 0) {
                total = $scope.rowCollection[0].all.length;
                angular.forEach($scope.rowCollection[0].all, function (item) {
                    if ($scope.checkboxes.items[item.appt_id]) {
                        $scope.futureappointmentSelectedItems.push(item);
                    }
                    checked += ($scope.checkboxes.items[item.appt_id]) || 0;
                    unchecked += (!$scope.checkboxes.items[item.appt_id]) || 0;
                });
            }

            if ((unchecked == 0) || (checked == 0)) {
                $scope.checkboxes.checked = (checked == total);
            }

            $scope.futureappointmentSelected = checked;
        }, true);

        $scope.cancelSelected = function () {
            $scope.selectedIDs = [];
            angular.forEach($scope.encounterIDs, function (item) {
                if (item.selected) {
                    $scope.selectedIDs.push({
                        'encounter_id': item.encounterID,
                        'patient_id': item.patientID,
                    });
                }
            });
            $scope.cancelFutureAppointments();
        };

        $scope.rescheduleAppointments = function () {
            var modalInstance = $modal.open({
                templateUrl: 'tpl/modal_form/modal.patient_appointment_reschedule.html',
                controller: "AppointmentRescheduleController",
                resolve: {
                    scope: function () {
                        return $scope;
                    },
                }
            });
            modalInstance.data = $scope.futureappointmentSelectedItems;

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
        };

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

        $scope.cancelFutureAppointments = function () {
            var conf = confirm('Are you sure to cancel these appointments ?');
            if (conf) {
                $scope.loadbar('show');
                post_url = $rootScope.IRISOrgServiceUrl + '/appointment/bulkcancel';
                method = 'POST';
                succ_msg = 'Appointment cancelled successfully';
                var PatAppointment = $scope.selectedIDs;
                $http({
                    method: method,
                    url: post_url,
                    data: PatAppointment,
                }).success(
                        function (response) {
                            $scope.successMessage = succ_msg;
                            $scope.loadbar('hide');
                            $scope.encounterIDs = [];
                            $scope.selectedIDs = [];
                            $scope.loadFutureAppointmentsList();
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            } else {
                $scope.encounterIDs = [];
                $scope.selectedIDs = [];
            }
        }












        $scope.statuses = [
            {value: 'A', text: 'Arrived'},
        ];

        $scope.arr_statuses = [
            {value: 'S', text: 'Seen'},
        ];

        $scope.setTimings = function (key, mode) {
            if (mode == 'set') {
                st_d = moment().format('YYYY-MM-DD');
                st_t = moment().format('hh:mm A');
            } else {
                st_d = st_t = '';
            }
            $scope.displayedCollection[key].sts_date = st_d;
            $scope.displayedCollection[key].sts_time = st_t;
        }

        $scope.onTimeSet = function (newDate, oldDate, main_key, key) {
            $scope.displayedCollection[main_key].all[key].date = moment(newDate).format('YYYY-MM-DD hh:mm A');
        }

        $scope.moreOptions = function (key, enc_id, type, row_sts, id, status, is_swap) {
            console.log(row_sts);
            $scope.more_li = [];

            $('.enc_chk').not('#enc_' + enc_id + key).attr('checked', false);

            if ($('#enc_' + enc_id + key).is(':checked')) {
                if (type == 'IP') {
                    $scope.more_li = [
                        {href: 'patient.transfer({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Transfer', mode: 'sref'},
                        {href: 'patient.discharge({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Clinical Discharge', mode: 'sref'},
                        {href: 'patient.swapping({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Swapping', mode: 'sref'},
                    ];

                    if (status == '1' && row_sts != 'A') {

                        if (is_swap == '1')
                            row_sts = 'SW';

                        $scope.more_li.push({href: "cancelAdmission(" + enc_id + ", " + id + ", '" + row_sts + "')", name: 'Cancel', mode: 'click'});
                    }
                } else if (type == 'OP') {
                    if (status == '1') {
                        $scope.more_li.push(
                                {href: 'patient.changeStatus({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Change Status', mode: 'sref'},
                        {href: "cancelAppointment(" + enc_id + ")", name: 'Cancel Appointment', mode: 'click'});
                    }

                    $scope.more_li.push(
                            {href: 'patient.editDoctorFee({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Edit Doctor Fee', mode: 'sref'});

                }
            }
        }

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $scope.loadbar('show');
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        $scope.loadbar('hide');
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.cancelAdmission = function (enc_id, id, row_sts) {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    if (response.model.encounter_id != enc_id) {
                        alert("This is not an active Encounter");
                        $state.go("patient.encounter", {id: $state.params.id});
                    } else {
                        $scope.errorData = "";

                        var notes = '';
                        var headerText = '';
                        var bodyText = '';

                        if (row_sts == 'TR') {
                            notes = 'Transfer (Room) Cancelled';
                            headerText = 'Cancel Room Transfer?';
                            bodyText = 'Are you sure you want to cancel this Room Transfer?';
                        } else if (row_sts == 'TD') {
                            notes = 'Transfer (Doctor) Cancelled';
                            headerText = 'Cancel Doctor Transfer?';
                            bodyText = 'Are you sure you want to cancel this Doctor Transfer?';
                        } else if (row_sts == 'SW') {
                            notes = 'Room Swapping Cancelled';
                            headerText = 'Cancel Room Swapping?';
                            bodyText = 'Are you sure you want to cancel this Room Swapping?';
                        }

                        var modalOptions = {
                            closeButtonText: 'No',
                            actionButtonText: 'Yes',
                            headerText: headerText,
                            bodyText: bodyText
                        };
                        modalService.showModal({}, modalOptions).then(function (result) {
                            $scope.loadbar('show');
                            post_url = $rootScope.IRISOrgServiceUrl + '/admission/canceladmission';
                            method = 'POST';
                            succ_msg = 'Room Transfer cancelled successfully';

                            var PatAdmission = {
                                admn_id: id,
                                admission_status: "C",
                                status_date: moment().format('YYYY-MM-DD HH:mm:ss'),
                                patient_id: $scope.app.patientDetail.patientId,
                                encounter_id: enc_id,
                                status: '0',
                                notes: notes,
                                row_sts: row_sts,
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAdmission,
                            }).success(
                                    function (response) {
                                        $scope.loadbar('hide');
                                        if (response.success) {
                                            $scope.successMessage = succ_msg;
                                            $scope.loadPatientEncounters('Current');
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
                        });
                    }
                }
            });
        };

        $scope.cancelAppointment = function (enc_id) {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    if (response.model.encounter_id != enc_id) {
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
                                encounter_id: enc_id
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAppointment,
                            }).success(
                                    function (response) {
                                        $scope.successMessage = succ_msg;
                                        $scope.loadbar('hide');
                                        $scope.loadPatientEncounters('Current');
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

        $scope.changeAppointmentStatus = function (_data, key) {
            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/appointments',
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = 'Status changed successfully';
                        $scope.loadPatientEncounters('Current');
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };
    }]);

//app.filter('moment', function () {
//    return function (dateString, format) {
//        return moment(dateString).format(format);
//    };
//});