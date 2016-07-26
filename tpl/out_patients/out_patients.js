app.controller('OutPatientsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$filter', '$modal', '$log', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $filter, $modal, $log) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Checkbox initialize
        $scope.checkboxes = {'checked': false, items: []};
        $scope.currentAppointmentSelectedItems = [];
        $scope.currentAppointmentSelected = 0;

        //Index page height
        $scope.css = {'style': ''};

        //Index Page
        $scope.loadOutPatientsList = function (type) {
            $scope.op_type = type;
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = []; // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection); // displayed collection

            var all = 0;
            if ($scope.checkAccess('patient.viewAllDoctorsAppointments')) {
                all = 1;
            }

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/outpatients?type=' + type + '&all=' + all)
                    .success(function (OutPatients) {
                        $scope.rowCollection = OutPatients.result;

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
                        $scope.moreOptions(op_key, key, row.liveAppointmentConsultant.user_id, row.liveAppointmentBooking.appt_id, row);
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
                    if (consultant_exists.length == 0) {
                        $('.oplistcheckbox').not('.oplistcheckbox_' + op_key).attr('checked', false);
//                        $('.oplistcheckbox').not('#oplist_' + op_key + '_' + key).attr('checked', false);
                        $scope.checkboxes.items = [];
                        $scope.checkboxes.items.push({
                            appt_id: appt_id,
                            consultant_id: consultant_id,
                            row: row.liveAppointmentBooking
                        });
                    } else {
                        $scope.checkboxes.items.push({
                            appt_id: appt_id,
                            consultant_id: consultant_id,
                            row: row.liveAppointmentBooking
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
                $scope.loadOutPatientsList($scope.op_type);
                $log.info('Modal dismissed at: ' + new Date());
            });
        };

        $scope.cancelAppointments = function () {
            var conf = confirm('Are you sure to cancel these appointments ?');
            if (conf) {
                $scope.loadbar('show');
                post_url = $rootScope.IRISOrgServiceUrl + '/appointment/bulkcancel';
                method = 'POST';
                succ_msg = 'Appointment cancelled successfully';
                $http({
                    method: method,
                    url: post_url,
                    data: $scope.currentAppointmentSelectedItems,
                }).success(
                        function (response) {
                            $scope.successMessage = succ_msg;
                            $scope.loadbar('hide');
                            $scope.loadOutPatientsList($scope.op_type);
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            } else {
                $scope.loadOutPatientsList($scope.op_type);
            }
        }

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
                        $scope.successMessage = 'Patient updated successfully';
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
                        $scope.rowCollection[op_key]['all'][key].liveAppointmentArrival = response;
                        $scope.displayedCollection[op_key]['all'][key].liveAppointmentArrival = response;

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

        $scope.updateCollection = function () {
            $scope.isLoading = true;
            rowCollection = $scope.rowCollection;
            displayedCollection = $scope.rowCollection;

            $scope.rowCollection = []; // base collection
            $scope.displayedCollection = [].concat($scope.rowCollection); // displayed collection

            $timeout(function () {
                $scope.rowCollection = rowCollection;

                $scope.census = 0;
                angular.forEach($scope.rowCollection, function (row) {
                    var booked = 0;
                    var arrived = 0;

                    angular.forEach(row.all, function (appt) {
                        if (appt.liveAppointmentArrival == '-') {
                            appt.sts = 'B';
                            booked++;
                        }
                        if (appt.liveAppointmentArrival != '-') {
                            appt.sts = 'A';
                            arrived++;
                        }
                        appt.selected = '0';
                        $scope.census++;
                    });

                    if ($scope.census > 6) {
                        $scope.css = {
                            'style': 'height:550px; overflow-y: auto; overflow-x: hidden;',
                        };
                    }

                    row.booking_count = booked;
                    row.arrived_count = arrived;
                    row.selected = '0';
                    row.all = $filter('orderBy')(row.all, 'sts');
                });
                $scope.displayedCollection = [].concat($scope.rowCollection);
                $scope.isLoading = false;
            }, 200);
        }
    }]);