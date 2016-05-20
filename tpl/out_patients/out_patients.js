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

        //Index Page
        $scope.loadOutPatientsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = []; // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection); // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/outpatients')
                    .success(function (OutPatients) {
                        $scope.isLoading = false;
                        $scope.rowCollection = OutPatients.result;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

                        //Checkbox initialize
                        $scope.checkboxes = {'checked': false, items: []};
                        $scope.currentAppointmentSelectedItems = [];
                        $scope.currentAppointmentSelected = 0;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patients!";
                    });
        };

        $scope.moreOptions = function (op_key, key, consultant_id, appt_id, row) {
            appt_exists = $filter('filter')($scope.checkboxes.items, {appt_id: appt_id});
            if ($('#oplist_' + op_key + '_' + key).is(':checked')) {
                if (appt_exists.length == 0) {
                    consultant_exists = $filter('filter')($scope.checkboxes.items, {consultant_id: consultant_id});
                    if (consultant_exists.length == 0) {
                        $('.oplistcheckbox').not('#oplist_' + op_key + '_' + key).attr('checked', false);
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
                $scope.loadOutPatientsList();
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
                            $scope.loadOutPatientsList();
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            } else {
                $scope.loadOutPatientsList();
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
                        $scope.displayedCollection[op_key]['all'][key].liveAppointmentArrival = response;
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