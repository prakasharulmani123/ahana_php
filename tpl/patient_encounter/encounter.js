app.controller('EncounterController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, $filter, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.more_max = 4;

        //Encounter Page
        $scope.loadPatientEncounters = function (type) {
            $scope.errorData = '';
            $scope.encounterView = type;
            $scope.isLoading = true;
            $scope.rowCollection = [];  // base collection
//            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.encounters;
                            $scope.activeEncounter = response.active_encounter;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                            $scope.more_li = {};
                        } else {
                            $scope.errorData = response.message;
                        }
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading encounter!";
                    });
        };

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

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
                    } else if (status == '1' && row_sts == 'A') {
                        $scope.more_li.push({href: "cancelAdmissionCloseEncounter(" + enc_id + ", " + id + ", '" + row_sts + "')", name: 'Admission Cancel', mode: 'click'});
                    }
                } else if (type == 'OP') {
                    if (status == '1') {
                        $scope.more_li.push({
                            href: 'patient.changeStatus({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})',
                            name: 'Change Status',
                            mode: 'sref'
                        },
                        {
                            href: "cancelAppointment(" + enc_id + ")",
                            name: 'Cancel Appointment',
                            mode: 'click'
                        });
                    }

                    $scope.more_li.push({
                        href: 'patient.editDoctorFee({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})',
                        name: 'Edit Doctor Fee',
                        mode: 'sref'
                    });
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

        $scope.cancelAdmissionCloseEncounter = function (enc_id, id, row_sts) {
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

                        if (row_sts == 'A') {
                            notes = 'Admission Cancelled';
                            headerText = 'Admission Cancelled?';
                            bodyText = 'Are you sure you want to cancel this Admission?';
                        }

                        var modalOptions = {
                            closeButtonText: 'No',
                            actionButtonText: 'Yes',
                            headerText: headerText,
                            bodyText: bodyText
                        };
                        modalService.showModal({}, modalOptions).then(function (result) {
                            $scope.loadbar('show');
                            post_url = $rootScope.IRISOrgServiceUrl + '/admissions'
                            method = 'POST';
                            succ_msg = 'Admission cancelled successfully';

                            var PatAdmission = {
                                admission_status: "AC",
                                status_date: moment().format('YYYY-MM-DD HH:mm:ss'),
                                patient_id: $scope.app.patientDetail.patientId,
                                encounter_id: enc_id,
                                status: '1',
                                notes: notes,
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAdmission,
                            }).success(
                                    function (response) {
                                        $scope.loadbar('hide');
                                        if (response.success == false) {
                                            $scope.errorData = response.message;
                                        } else {
                                            $scope.successMessage = succ_msg;
                                            $scope.loadPatientEncounters('Current');
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