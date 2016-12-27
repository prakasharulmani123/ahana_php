app.controller('OutPatientsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$filter', '$modal', '$log', 'modalService', '$interval', '$cookieStore', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $filter, $modal, $log, modalService, $interval, $cookieStore) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        //index.html - To Avoid the status column design broken, used the below controlsTpl
        editableThemes.bs3.controlsTpl = '<div class="editable-controls" ng-class="{\'has-error\': $error}"></div>';
        editableOptions.theme = 'bs3';

        $scope.ctrl = {};
        $scope.allExpanded = true;
//        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.expandAllRow(expanded);
//            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Checkbox initialize
        $scope.checkboxes = {'checked': false, items: []};
        $scope.currentAppointmentSelectedItems = [];
        $scope.currentAppointmentSelected = 0;

        //Index page height
        $scope.css = {'style': ''};

        //Index Page
        $scope.loadOutPatientsList = function (type, clearObj) {
            $scope.op_type = type;

            // pagination set up
            if (typeof clearObj == 'undefined') {
                $scope.isLoading = true;
                $scope.rowCollection = []; // base collection
                $scope.itemsByPage = 10; // No.of records per page
                $scope.displayedCollection = [].concat($scope.rowCollection); // displayed collection
            }

            var all = 0;
            if ($scope.checkAccess('patient.viewAllDoctorsAppointments')) {
                all = 1;
            }

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/outpatients?addtfields=oplist&type=' + type + '&all=' + all)
                    .success(function (OutPatients) {
                        var prepared_result = $scope.prepareCollection(OutPatients);
                        $scope.rowCollection = prepared_result;
//                        $scope.rowCollection = OutPatients.result;

                        $scope.updateCollection();

                        //Checkbox initialize
                        $scope.checkboxes = {'checked': false, items: []};
                        $scope.currentAppointmentSelectedItems = [];
                        $scope.currentAppointmentSelected = 0;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patients!";
                    });
        };

        $timeout(function () {
            $scope.startAutoRefresh();
        }, 5000);
        var stop;
        $scope.last_log_id = "";
        $scope.startAutoRefresh = function () {
            // Don't start a new fight if we are already fighting
            if (angular.isDefined(stop))
                return;
            stop = $interval(function () {
                // Get data's from service
                $http.get($rootScope.IRISOrgServiceUrl + '/default/getlog')
                        .success(function (log) {
                            setTimeout(function () {
                                if ($scope.last_log_id === "") {
                                    $scope.last_log_id = log.last_log_id;
                                } else {
                                    if ($scope.last_log_id != log.last_log_id) {
                                        $scope.loadOutPatientsList('current', true);
                                        $scope.last_log_id = log.last_log_id;
                                    }
                                }
                            }, 100);
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured";
                        });
            }, 20000);
        };
        $scope.stopAutoRefresh = function () {
            if (angular.isDefined(stop)) {
                $interval.cancel(stop);
                stop = undefined;
            }
        };
        $scope.$on('$destroy', function () {
            // Make sure that the interval is destroyed too
            $scope.stopAutoRefresh();
        });

        $scope.updateCheckbox = function (parent, parent_key) {
            angular.forEach($scope.displayedCollection, function (value, op_key) {
                value.selected = '0';

                if (parent_key == op_key)
                    value.selected = parent.selected;

                angular.forEach(value.all, function (row, key) {
                    row.selected = '0';

                    if (parent_key == op_key) {
                        row.selected = parent.selected;
                    }
                });
            });

            $timeout(function () {
                angular.forEach($scope.displayedCollection, function (value, op_key) {
                    angular.forEach(value.all, function (row, key) {
                        $scope.moreOptions(op_key, key, row.consultant_id, row.apptBookingData.appt_id, row);
                    });
                });
            }, 800);
        }

        $scope.moreOptions = function (op_key, key, consultant_id, appt_id, row) {
            appt_exists = $filter('filter')($scope.checkboxes.items, {appt_id: appt_id});
            if ($('#oplist_' + op_key + '_' + key).is(':checked')) {
                $('#oplist_' + op_key + '_' + key).closest('tr').addClass('selected_row');

                $('.tr_oplistcheckbox').not('.tr_oplistcheckbox_' + op_key).each(function () {
                    $(this).removeClass('selected_row');
                });

                if (appt_exists.length == 0) {
                    consultant_exists = $filter('filter')($scope.checkboxes.items, {consultant_id: consultant_id});
                    rowData = row.apptBookingData;
                    angular.extend(rowData, {patient_name: row.apptPatientData.fullname, consultant_id: row.consultant_id, encounter_id: row.encounter_id, patient_id: row.patient_id});
                    if (consultant_exists.length == 0) {
                        $('.oplistcheckbox').not('.oplistcheckbox_' + op_key).attr('checked', false);
//                        $('.oplistcheckbox').not('#oplist_' + op_key + '_' + key).attr('checked', false);
                        $scope.checkboxes.items = [];
                        $scope.checkboxes.items.push({
                            appt_id: appt_id,
                            consultant_id: consultant_id,
                            row: rowData
                        });
                    } else {
                        $scope.checkboxes.items.push({
                            appt_id: appt_id,
                            consultant_id: consultant_id,
                            row: rowData
                        });
                    }
                }
            } else {
                $('#oplist_' + op_key + '_' + key).closest('tr').removeClass('selected_row');
                if (appt_exists.length > 0) {
                    $scope.checkboxes.items.splice($scope.checkboxes.items.indexOf(appt_exists[0]), 1);
                }
            }
            $scope.prepareMoreOptions();
        }

        $scope.prepareMoreOptions = function () {
            $scope.currentAppointmentSelectedItems = [];
            angular.forEach($scope.checkboxes.items, function (item) {
                $scope.currentAppointmentSelectedItems.push(item.row);
            });
            $scope.currentAppointmentSelected = $scope.currentAppointmentSelectedItems.length;
        }

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
            modalInstance.data = $scope.currentAppointmentSelectedItems;

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
//                $scope.loadOutPatientsList($scope.op_type);
                $log.info('Modal dismissed at: ' + new Date());
            });
        };

        $scope.cancelAppointments = function () {
            var modalOptions = {
                closeButtonText: 'No',
                actionButtonText: 'Yes',
                headerText: 'Cancel Appointments?',
                bodyText: 'Are you sure to cancel these appointments ?'
            };

            modalService.showModal({}, modalOptions).then(function (result) {
                $scope.loadbar('show');
                post_url = $rootScope.IRISOrgServiceUrl + '/appointment/bulkcancel';
                method = 'POST';
                succ_msg = 'Appointment cancelled successfully';
                $http({
                    method: method,
                    url: post_url,
                    data: $scope.currentAppointmentSelectedItems
                }).success(
                        function (response) {
                            $scope.msg.successMessage = succ_msg;
                            $scope.loadbar('hide');
                            $scope.loadOutPatientsList($scope.op_type);
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status === 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            });
        };

        $scope.statuses = [
            {value: 'A', text: 'Arrived'},
        ];

        $scope.arr_statuses = [
            {value: 'S', text: 'Seen'},
        ];

        $scope.updatePatient = function (id, _data, val) {
            if (val == '') {
                return 'Mobile can not be empty';
            }
            if (!val.match(/^[0-9]{10}$/)) {
                return 'Mobile must be 10 digits only';
            }
            $http({
                method: 'PUT',
                url: $rootScope.IRISOrgServiceUrl + '/patients/' + id,
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = 'Patient updated successfully';
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.setTimings = function (op_key, key, mode) {
            if (mode == 'set') {
                st_d = moment().format('YYYY-MM-DD');
                st_t = moment().format('hh:mm A');
            } else {
                st_d = st_t = '';
            }
            $scope.displayedCollection[op_key]['all'][key].sts_date = st_d;
            $scope.displayedCollection[op_key]['all'][key].sts_time = st_t;
        }

        $scope.onTimeSet = function (newDate, oldDate, op_key, key) {
            $scope.displayedCollection[op_key]['all'][key].sts_date = moment(newDate).format('YYYY-MM-DD');
            $scope.displayedCollection[op_key]['all'][key].sts_time = moment(newDate).format('hh:mm A');
        }

        $scope.changeAppointmentStatus = function (_data, op_key, key) {
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/appointments',
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = 'Status changed successfully';
                        $scope.rowCollection[op_key]['all'][key].apptArrivalData = response;
                        $scope.displayedCollection[op_key]['all'][key].apptArrivalData = response;

                        angular.forEach($scope.displayedCollection, function (value, parent_key) {
                            if (parent_key == op_key) {
                                value.booking_count--;
                                value.arrived_count++;
                            }
                        });

                        $scope.updateCollection();
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.prepareCollection = function (OutPatients) {
            var result = [];
            var key_index = 0;
            $scope.census = OutPatients.result.length;
            if ($scope.census > 6) {
                $scope.css = {
                    'style': 'height:550px; overflow-y: auto; overflow-x: hidden;',
                };
            }

            grouped_result = $filter('groupBy')(OutPatients.result, 'consultant_id');
            angular.forEach(grouped_result, function (value,key) {
                result[key_index] = {
                    consultant_id: key,
                    consultant_name: value[0].apptConsultantData.fullname,
                    all: value,
                    seen_count: OutPatients.consultants[key].seen,
                    booking_count: OutPatients.consultants[key].booked,
                    arrived_count: OutPatients.consultants[key].arrival,
                    selected: '0',
                    seenExpanded: false,
                };
                key_index++;
            });
            return result
        }

        $scope.updateCollection = function () {
            $scope.isLoading = true;
            rowCollection = $scope.rowCollection;
            displayedCollection = $scope.rowCollection;

            $scope.rowCollection = []; // base collection
            $scope.displayedCollection = [].concat($scope.rowCollection); // displayed collection

            $timeout(function () {
                $scope.rowCollection = rowCollection;

                angular.forEach($scope.rowCollection, function (row) {

                    angular.forEach(row.all, function (appt) {
                        if (appt.apptArrivalData == '-' && appt.apptSeenData == '-') {
                            appt.sts = 'B';
                        }
                        if (appt.apptArrivalData != '-' && appt.apptSeenData == '-') {
                            appt.sts = 'A';
                        }
                        appt.selected = '0';
                    });

                    row.expanded = $scope.getRowExpand(row.consultant_id);
                    row.all = $filter('orderBy')(row.all, ['sts', 'apptArrivalData.status_datetime', 'apptBookingData.status_datetime', 'apptSeenData.status_datetime']);
                });
                $scope.displayedCollection = [].concat($scope.rowCollection);
                $scope.isLoading = false;
            }, 200);
        }

        $scope.setRowExpanded = function (consultant_id, rowopen) {
            var opRowExpand = [];
            if (typeof $cookieStore.get('op_list') !== 'undefined') {
                opRowExpand = $cookieStore.get('op_list');
            }
            exists = $filter('filter')(opRowExpand, {consultant_id: consultant_id});
            if (exists.length == 0) {
                opRowExpand.push({
                    'consultant_id': consultant_id,
                    'rowopen': rowopen,
                });
            } else {
                exists[0].rowopen = rowopen;
            }
            $cookieStore.put('op_list', opRowExpand);
        }

        $scope.getRowExpand = function (consultant_id) {
            if (typeof $cookieStore.get('op_list') !== 'undefined') {
                var opRowExpand = $cookieStore.get('op_list');
                exists = $filter('filter')(opRowExpand, {consultant_id: consultant_id});
                if (exists.length == 0) {
                    return true;
                } else {
                    return exists[0].rowopen;
                }
            }
            return true;
        };

        $scope.expandAllRow = function (expanded) {
            angular.forEach($scope.rowCollection, function (row) {
                row.expanded = expanded;
                $scope.setRowExpanded(row.consultant_id, expanded);
            });
        };
    }]);