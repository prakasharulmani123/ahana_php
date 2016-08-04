app.controller('EncounterController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, $filter, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.disabled = function (date, mode) {
            date = moment(date).format('YYYY-MM-DD');
            return $.inArray(date, $scope.enabled_dates) === -1;
        };

        $scope.more_max = 3;

        //Encounter Page
        $scope.enabled_dates = [];
        $scope.loadPatientEncounters = function (type, date) {
            $scope.errorData = '';
            $scope.encounterView = type;
            $scope.isLoading = true;
            $scope.rowCollection = [];  // base collection
//            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            if (typeof date == 'undefined') {
                url = $rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type;
            } else {
                date = moment(date).format('YYYY-MM-DD');
                url = $rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type + '&date=' + date;
            }

            $http.get(url)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.encounters;
                            
                            angular.forEach($scope.rowCollection, function (row) {
                                row.last_row_sts = '';
                                angular.forEach(row.all, function (all) {
                                    var today_date = moment().format('YYYY-MM-DD');
                                    var encounter_date = moment(all.date).format('YYYY-MM-DD');
                                    var result = (moment(encounter_date).isAfter(today_date));
                                    all.is_future = result;
                                    row.last_row_sts = all.row_sts;
                                });
                            });

                            if(response.active_encounter){
                                $scope.class1 = 'col-sm-9';
                                $scope.class2 = '';
                                $scope.class3 = 'col-sm-3';
                            } else {
                                $scope.class1 = 'col-sm-3';
                                $scope.class2 = 'col-sm-6';
                                $scope.class3 = 'col-sm-3';
                            }
                            
                            $scope.activeEncounter = response.active_encounter;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                            $scope.more_li = {};

                            angular.forEach($scope.rowCollection, function (row) {
                                angular.forEach(row.all, function (all) {
                                    var result = $filter('filter')($scope.enabled_dates, moment(all.date_time).format('YYYY-MM-DD'));
                                    if (result.length == 0)
                                        $scope.enabled_dates.push(moment(all.date_time).format('YYYY-MM-DD'));
                                });
                            });
                            $scope.$broadcast('refreshDatepickers');
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
                    if ($('.enc_chk_' + enc_id).length == 1)
                        $scope.more_li.push({href: 'patient.update_admission({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Modify Admission', mode: 'sref'});

                    $scope.more_li.push({href: 'patient.transfer({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Transfer', mode: 'sref'});
                    $scope.more_li.push({href: 'patient.discharge({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Clinical Discharge', mode: 'sref'});
                    $scope.more_li.push({href: 'patient.swapping({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Swapping', mode: 'sref'});

                    if (status == '1' && row_sts != 'A') {

                        if (is_swap == '1')
                            row_sts = 'SW';

                        $scope.more_li.push({href: "cancelAdmission(" + enc_id + ", " + id + ", '" + row_sts + "')", name: 'Cancel', mode: 'click', url: 'patient.cancelLastEncounter'});
                    } else if (status == '1' && row_sts == 'A') {
                        $scope.more_li.push({href: "cancelAdmissionCloseEncounter(" + enc_id + ", " + id + ", '" + row_sts + "')", name: 'Admission Cancel', mode: 'click', url: 'patient.cancelAdmission'});
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
                            mode: 'click',
                            url: 'patient.cancelAppointment'
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

        $scope.printBillData = {};
        $scope.printOPBill = function (item) {
            $scope.printBillData.date = item.date;
            $scope.printBillData.doctor = item.doctor;

            //Patient Billing Types List
            $rootScope.commonService.GetPatientBillingList(function (response) {
                $scope.bill_types = response;
            });

            //Get appointment details
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/appointmentseenencounter', {patient_id: $state.params.id, enc_id: item.encounter_id})
                    .success(function (response) {
                        //appointment seen amount
                        $scope.printBillData.op_amount = response.model.appointmentSeen.amount;

                        //Get Patient Bill Type
                        if (response.model.appointmentSeen.patient_bill_type) {
                            var billinfo = $filter('filter')($scope.bill_types, {
                                value: response.model.appointmentSeen.patient_bill_type
                            });
                            $scope.printBillData.patient_bill_type = billinfo[0].label;
                        } else {
                            $scope.printBillData.patient_bill_type = '-';
                        }

                        //Patient Cateogry
                        consultant_id = item.consultant_id;
                        $http.get($rootScope.IRISOrgServiceUrl + '/default/getconsultantcharges?consultant_id=' + consultant_id)
                                .success(function (response2) {
                                    $scope.chargesList = response2.chargesList;
                                    var charge = $filter('filter')($scope.chargesList, {patient_cat_id: response.model.appointmentSeen.patient_cat_id});
                                    if (typeof charge[0] != 'undefined') {
                                        $scope.printBillData.patient_cat_name = charge[0].op_dept;
                                    }
                                }, function (x) {
                                    response2 = {success: false, message: 'Server Error'};
                                });
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                    });

            $timeout(function () {
                var innerContents = document.getElementById('Getprintval').innerHTML;
                var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
                popupWinindow.document.open();
                popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
                popupWinindow.document.close();
            }, 1000);
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
                                patient_id: $scope.patientObj.patient_id,
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
                                            $scope.msg.successMessage = succ_msg;
                                            $scope.loadPatientEncounters('Current');
                                            $scope.loadView();
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
                        var succ_msg = '';

                        if (row_sts == 'TR') {
                            notes = 'Transfer (Room) Cancelled';
                            headerText = 'Cancel Room Transfer?';
                            bodyText = 'Are you sure you want to cancel this Room Transfer?';
                            succ_msg = 'Room Transfer cancelled successfully';
                        } else if (row_sts == 'TD') {
                            notes = 'Transfer (Doctor) Cancelled';
                            headerText = 'Cancel Doctor Transfer?';
                            bodyText = 'Are you sure you want to cancel this Doctor Transfer?';
                            succ_msg = 'Doctor Transfer cancelled successfully';
                        } else if (row_sts == 'SW') {
                            notes = 'Room Swapping Cancelled';
                            headerText = 'Cancel Room Swapping?';
                            bodyText = 'Are you sure you want to cancel this Room Swapping?';
                            succ_msg = 'Room Swapping cancelled successfully';
                        } else if (row_sts == 'CD') {
                            notes = 'Clinical Discharge Cancelled';
                            headerText = 'Cancel Clinical Discharge?';
                            bodyText = 'Are you sure you want to cancel this Clinical Discharge?';
                            succ_msg = 'Clinical Discharge cancelled successfully';
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
                            succ_msg = succ_msg;

                            var PatAdmission = {
                                admn_id: id,
                                admission_status: "C",
                                status_date: moment().format('YYYY-MM-DD HH:mm:ss'),
                                patient_id: $scope.patientObj.patient_id,
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
                                            $scope.msg.successMessage = succ_msg;
                                            $scope.loadPatientEncounters('Current');
                                            $scope.loadView();
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
                                patient_id: $scope.patientObj.patient_id,
                                encounter_id: enc_id
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAppointment,
                            }).success(
                                    function (response) {
                                        $scope.msg.successMessage = succ_msg;
                                        $scope.loadbar('hide');
                                        $scope.loadPatientEncounters('Current');
                                        $scope.loadView();
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
            $scope.msg.successMessage = "";

            angular.extend(_data, {
                status_date: moment().format('YYYY-MM-DD'),
                status_time: moment().format('hh:mm A')
            });

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/appointments',
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = 'Status changed successfully';
                        $scope.loadPatientEncounters('Current');
                        $scope.loadView();
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.loadView = function () {
            $timeout(function () {
                $scope.mode = 'view';
                $http.post($rootScope.IRISOrgServiceUrl + '/patient/getpatientbyguid', {guid: $state.params.id})
                        .success(function (patient) {
                            $scope.patientObj = patient;
                            $rootScope.commonService.GetLabelFromValue(patient.patient_gender, 'GetGenderList', function (response) {
                                $scope.app.patientDetail.patientSex = response;
                            });
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured while loading patient!";
                        });
            }, 3000)
        }
    }]);