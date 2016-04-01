// this is a lazy load controller, 
// so start with "app." to register this controller

app.filter('propsFilter', function () {
    return function (items, props) {
        var out = [];

        if (angular.isArray(items)) {
            items.forEach(function (item) {
                var itemMatches = false;

                var keys = Object.keys(props);
                for (var i = 0; i < keys.length; i++) {
                    var prop = keys[i];
                    var text = props[prop].toLowerCase();
                    if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
                        itemMatches = true;
                        break;
                    }
                }

                if (itemMatches) {
                    out.push(item);
                }
            });
        } else {
            // Let the output be the input untouched
            out = items;
        }

        return out;
    };
})

app.controller('BillingController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', '$modal', function ($rootScope, $scope, $timeout, $http, $state, $filter, $modal) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.more_max = 4;
        $scope.total_billing = 0;

        //Collapse / Expand 
        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.enc = {};
        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;
                    if (response != null) {
                        $scope.enc.selected = $scope.encounters[0];
                    }
                });
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.loadBillingCharges(newValue);
                $scope.loadRoomConcession(newValue);
            }
        }, true);

        $scope.loadRoomConcession = function (enc_id) {
            var encounter_id = enc_id;
            var selected_encounter = $.grep($scope.encounters, function (encounter) {
                return encounter.encounter_id == encounter_id;
            })[0];
            $scope.data = selected_encounter;
        }

        $scope.saveRoomConcession = function () {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/encounters/' + _that.data.encounter_id;
            method = 'PUT';
            succ_msg = 'updated successfully';

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('patient.billing', {id: $state.params.id});
                        }, 1000)
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.loadBillingCharges = function (enc_id) {
            $scope.billing = {};
            $scope.recurr_billing = {};
            $scope.loadRecurringBilling(enc_id);
            $scope.loadNonRecurringBilling(enc_id);
        }

        $scope.loadRecurringBilling = function (enc_id) {
            $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/encounter/getrecurringbilling?encounter_id=' + enc_id,
            }).success(
                    function (response) {
                        $scope.recurring_charges = null;

                        if (typeof response.recurring != 'undefined')
                            $scope.recurring_charges = response.recurring;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.loadNonRecurringBilling = function (enc_id) {
            $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/encounter/getnonrecurringbilling?encounter_id=' + enc_id,
            }).success(
                    function (response) {
                        $scope.procedures = null;
                        $scope.consultants = null;
                        $scope.other_charges = null;
                        $scope.advances = null;

                        if (typeof response.Procedure != 'undefined')
                            $scope.procedures = response.Procedure;

                        if (typeof response.Consults != 'undefined')
                            $scope.consultants = response.Consults;

                        if (Object.keys(response.OtherCharge).length)
                            $scope.other_charges = response.OtherCharge;

                        if (Object.keys(response.Advance).length)
                            $scope.advances = response.Advance;

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.moreOptions = function (key, type, pk_id, link_id, concession_amount, extra_amount) {
            var row_id = '#enc_' + type + '_' + key;
            $scope.more_li = {};
            $scope.more_advance_li = {};

            $('.enc_chk').not(row_id).attr('checked', false);

            if ($(row_id).is(':checked')) {
                if (type == 'advance') {
                    $scope.more_advance_li = [
                        {href: 'patient.editPayment({id: "' + $state.params.id + '", payment_id: ' + pk_id + '})', name: 'Modify Payment', mode: 'sref'},
                        {href: "deletePayment('" + $state.params.id + "', " + pk_id + ")", name: 'Delete Payment', mode: 'click'}
                    ];
                }

                if (type == 'other') {
                    $scope.more_li = [
                        {href: 'patient.editOtherCharge({id: "' + $state.params.id + '", other_charge_id: ' + pk_id + '})', name: 'Modify Other Charge', mode: 'sref'},
                    ];
                } else if (type == 'procedure' || type == 'consultant') {
                    var ec_type = '';
                    if (type == 'procedure') {
                        ec_type = 'P';
                    }
                    if (type == 'consultant') {
                        ec_type = 'C';
                    }

                    if (extra_amount == '0.00') {
                        $scope.more_li = [
                            {href: 'patient.addExtraAmount({id: "' + $state.params.id + '", ec_type: "' + ec_type + '", link_id: "' + link_id + '"})', name: 'Add Extra Amount', mode: 'sref'},
                        ];
                    } else {
                        $scope.more_li = [
                            {href: 'patient.editExtraAmount({id: "' + $state.params.id + '", ec_id: "' + pk_id + '"})', name: 'Edit Extra Amount', mode: 'sref'},
                        ];
                    }

                    if (concession_amount == '0.00') {
                        $scope.more_li.push(
                                {href: 'patient.addConcessionAmount({id: "' + $state.params.id + '", ec_type: "' + ec_type + '", link_id: "' + link_id + '"})', name: 'Add Concession Amount', mode: 'sref'}
                        );
                    } else {
                        $scope.more_li.push(
                                {href: 'patient.editConcessionAmount({id: "' + $state.params.id + '", ec_id: "' + pk_id + '"})', name: 'Edit Concession Amount', mode: 'sref'}
                        );
                    }
                }
            }
        }

        $scope.getTotalPrice = function (row) {
            tot = parseFloat(row.total_charge) + parseFloat(row.extra_amount) - parseFloat(row.concession_amount);
            return tot;
        }

        $scope.getTotalRecurringPrice = function (row) {
            tot = parseFloat(row.total_charge);
            return tot;
        }

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

        //Delete
        $scope.deletePayment = function (patient_id, payment_id) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientbillingpayment/remove",
                    method: "POST",
                    data: {id: payment_id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
                                    console.log(newValue);
                                    if (newValue != '' && typeof newValue != 'undefined') {
                                        $scope.loadBillingCharges(newValue);
                                    }
                                }, true);
                                $scope.successMessage = 'Patient Consultant Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };

        $scope.password_auth = function (encounter_id, column, value) {
            var modalInstance = $modal.open({
                templateUrl: 'tpl/modal_form/modal.password_auth.html',
                controller: "PasswordAuthController",
                resolve: {
                    scope: function () {
                        return $scope;
                    },
                }
            });
            modalInstance.data = {
                encounter_id: encounter_id,
                column: column,
                value: value,
            };

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
        }

        //Delete
        $scope.removeRow = function (row) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patientconsultants/remove",
                        method: "POST",
                        data: {id: row.pat_consult_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadPatConsultantsList();
                                    $scope.successMessage = 'Patient Consultant Deleted Successfully';
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };

    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});