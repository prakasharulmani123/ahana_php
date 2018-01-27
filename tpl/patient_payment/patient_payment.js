app.controller('BillingPaymentController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';
        $scope.payment_type = '';
        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveunfinalizedencounter', {patient_id: $state.params.id, encounter_id: $state.params.enc_id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.parseFloatIgnoreCommas = function (amount) {
            var numberNoCommas = amount.replace(/,/g, '');
            return parseFloat(numberNoCommas);
        }

        $scope.enc = {};
        $scope.$watch('patientObj.patient_id', function (newValue, oldValue) {
            if (newValue != '') {
                $rootScope.commonService.GetEncounterListByPatientAndType('', '0,1', false, $scope.patientObj.patient_id, 'IP', function (response) {
                    //Most probably because splice() mutates the array, and angular.forEach() uses invalid indexes
                    //That's y used while instead of foreach
                    var i = response.length;
                    while (i--) {
                        var patient_details = response[i];
                        if (patient_details.encounter_type == 'IP') {
                            patient_details.encounter_id = patient_details.encounter_id.toString();
                        } else {
                            response.splice(i, 1);
                        }
                    }
                    $scope.encounters = response;
                    if (response != null) {
                        var sel_enc = $scope.encounters[0];
                        if ($state.params.enc_id) {
                            sel_enc = $filter('filter')($scope.encounters, {encounter_id: $state.params.enc_id});
                            sel_enc = sel_enc[0];
                        }
                        $scope.enc.selected = sel_enc;
                    }
                });
            }
        }, true);
        $scope.initCanAddPayment = function () {
            $scope.spinnerbar('show');
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    $scope.spinnerbar('hide');
                    alert("Sorry, you can't add payment");
                    $state.go("patient.billing", {id: $state.params.id});
                } else {
                    $rootScope.commonService.GetPaymentModes(function (response) {
                        $scope.paymentModes = response;
                    });
                    $rootScope.commonService.GetCardTypes(function (response) {
                        $scope.cardTypes = response;
                    });
                    $scope.encounter = response.model;
                    $scope.data = {};
                    $scope.data.payment_date = moment().format('YYYY-MM-DD HH:mm:ss');
                    $scope.data.formtype = 'add';
                    $scope.data.payment_mode = 'CA';
                    $scope.data.bank_date = moment().format('YYYY-MM-DD HH:mm:ss');
                    $scope.spinnerbar('hide');
                }
            });
        }

//Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;
            _that.data.payment_date = moment(_that.data.payment_date).format('YYYY-MM-DD HH:mm:ss');
            _that.data.bank_date = moment(_that.data.bank_date).format('YYYY-MM-DD HH:mm:ss');
            if (_that.data.payment_mode != 'CD') {
                _that.data.card_type = '';
                _that.data.card_number = '';
            }

            if (_that.data.payment_mode != 'CH') {
                _that.data.cheque_no = '';
            }

            if (_that.data.payment_mode != 'ON') {
                _that.data.ref_no = '';
            }

            if ((_that.data.payment_mode != 'ON') && (_that.data.payment_mode != 'CH')) {
                _that.data.bank_name = '';
                _that.data.bank_date = '';
            }

            $scope.errorData = "";
            $scope.msg.successMessage = "";
            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayments';
                method = 'POST';
                succ_msg = 'Billing payment saved successfully';
                angular.extend(_that.data, {
                    patient_id: $scope.patientObj.patient_id,
                    encounter_id: $scope.encounter.encounter_id
                });
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayments/' + _that.data.payment_id;
                method = 'PUT';
                succ_msg = 'Billing payment updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = succ_msg;
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
        };
        //Get Data for update Form
        $scope.loadForm = function () {
            $rootScope.commonService.GetPaymentModes(function (response) {
                $scope.paymentModes = response;
            });
            $rootScope.commonService.GetCardTypes(function (response) {
                $scope.cardTypes = response;
            });
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientbillingpayments/" + $state.params.payment_id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        if (response.bank_date == null) {
                            $scope.data.bank_date = moment().format('YYYY-MM-DD HH:mm:ss');
                        }
                        $scope.encounter = {encounter_id: response.encounter_id};
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };
        //Delete
        $scope.removeRow = function (row) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patientnotes/remove",
                        method: "POST",
                        data: {id: row.pat_note_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadPatNotesList();
                                    $scope.msg.successMessage = 'Patient Note Deleted Successfully';
                                } else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };
        $scope.PaymentType = function (type) {
            $scope.payment_type = type;
            if (type == 'settlement') {
                $scope.spinnerbar('show');
                $scope.billing_data = {};
                $scope.data.writeoff_amount = '0';
                $scope.data.procedure_id = [];
                $scope.data.professional_id = [];
                $scope.data.othercharges_id = [];
                $scope.data.pharmacy_id = [];
                $scope.data.recurring = false;
                $scope.data.paid_amount = 0;
                $http({
                    method: 'GET',
                    url: $rootScope.IRISOrgServiceUrl + '/encounter/getpendingamount?encounter_id=' + $state.params.enc_id,
                }).success(
                        function (response) {
                            $scope.billing_data = response;
                            $timeout(function () {
                                $scope.calculateNetamount();
                            }, 1000)
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
                $http({
                    method: 'GET',
                    url: $rootScope.IRISOrgServiceUrl + '/patientbillingothercharge/getipbilldetails?addtfields=patient_report&encounter_id=' + $state.params.enc_id,
                }).success(
                        function (response) {
                            $scope.professional = response.professional;
                            $scope.recurring = response.recurring;
                            $scope.procedure = response.procedure;
                            $scope.otherCharges = response.otherCharges;
                            $scope.pharmacyCharges = response.pharmacyCharges;
                            $scope.writeoffAmount = response.writeoffAmount;
                            $timeout(function () {
                                $scope.spinnerbar('hide');
                            }, 2000)
                            
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
//                $scope.total_select_bill_amount = 0;
//                $scope.data.billing_paid_amount = 0;
//                $scope.data.pharmacy_paid_amount = 0;

//                $http({
//                    method: 'GET',
//                    url: $rootScope.IRISOrgServiceUrl + '/pharmacysale/getsalebilling?addtfields=patient_report&encounter_id=' + $state.params.enc_id,
//                }).success(
//                        function (response) {
//                            var total = 0.00;
//                            $scope.data.pharmacy_sale_id = [];
//                            angular.forEach(response.sale, function (value) {
//                                if (value.billings_total_balance_amount)
//                                    total = total + $scope.parseFloatIgnoreCommas(value.billings_total_balance_amount);
//                                $scope.data.pharmacy_sale_id.push(value.sale_id);
//                            });
//                            $scope.data.pharmacy_pending_amount = total;
//                        }
//                ).error(function (data, status) {
//                    $scope.loadbar('hide');
//                    if (status == 422)
//                        $scope.errorData = $scope.errorSummary(data);
//                    else
//                        $scope.errorData = data.message;
//                });
//
//                $http({
//                    method: 'GET',
//                    url: $rootScope.IRISOrgServiceUrl + '/encounter/getpendingamount?encounter_id=' + $state.params.enc_id,
//                }).success(
//                        function (response) {
//                            if (response.balance > 0) {
//                                $scope.data.bill_pending_amount = response.balance - parseFloat($scope.data.pharmacy_pending_amount);
//                            } else {
//                                $scope.data.bill_pending_amount = 0;
//                            }
//                        }
//                ).error(function (data, status) {
//                    $scope.loadbar('hide');
//                    if (status == 422)
//                        $scope.errorData = $scope.errorSummary(data);
//                    else
//                        $scope.errorData = data.message;
//                });
            }
        }

        $scope.updatePaid = function () {
            $scope.data.bills = [];
            $scope.total_select_bill_amount = amt = 0;
            $('.chk:checked').each(function () {
                $scope.data.bills.push($(this).data('bill'));
                var a = $(this).val();
                a = a.replace(/\,/g, ''); // 1125, but a string, so convert it to number
                a = parseInt(a, 10);
                amt = amt + a;
            });
            $scope.total_select_bill_amount = amt;
        }

        $scope.saveSettleForm = function () {
            _that = this;
            if (parseFloat(_that.data.net_amount) <= parseFloat(_that.data.writeoff_amount)) {
                $scope.totalErrormessage = "Write off amount Must be less than to net amount";
                return false;
            }

            post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayment/savesettlementbill';
            method = 'POST';
            succ_msg = 'Billing payment saved successfully';
            $scope.loadbar('show');
            angular.extend(_that.data, {
                patient_id: $scope.patientObj.patient_id,
                encounter_id: $scope.encounter.encounter_id
            });
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = succ_msg;
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

//            pharmacy = $filter('filter')($scope.data.bills, 'purchase');
//            billing = $filter('filter')($scope.data.bills, 'billing');
//
//            if (parseFloat(_that.data.paid_amount) != parseFloat(_that.data.billing_paid_amount) + parseFloat(_that.data.pharmacy_paid_amount)) {
//                $scope.totalErrormessage = "Must be Payable amount is equal to total amount";
//                return false;
//            }
//
//            if ((billing.length > 0) && (_that.data.bill_pending_amount != 0) && (parseFloat(_that.data.bill_pending_amount) < parseFloat(_that.data.billing_paid_amount))) {
//                $scope.totalErrormessage = '';
//                $scope.billErrormessage = "Invalid amount";
//                return false;
//            }
//
//            if ((pharmacy.length > 0) && (_that.data.pharmacy_pending_amount != 0) && (parseFloat(_that.data.pharmacy_pending_amount) < parseFloat(_that.data.pharmacy_paid_amount))) {
//                $scope.totalErrormessage = '';
//                $scope.billErrormessage = '';
//                $scope.pharmacyErrormessage = "Invalid amount";
//                return false;
//            }
//
//            post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayment/savesettlementbill';
//            method = 'POST';
//            succ_msg = 'Billing payment saved successfully';
//            $scope.loadbar('show');
//            angular.extend(_that.data, {
//                patient_id: $scope.patientObj.patient_id,
//                encounter_id: $scope.encounter.encounter_id
//            });
//            $http({
//                method: method,
//                url: post_url,
//                data: _that.data,
//            }).success(
//                    function (response) {
//                        $scope.loadbar('hide');
//                        $scope.msg.successMessage = succ_msg;
//                        $scope.data = {};
//                        $timeout(function () {
//                            $state.go('patient.billing', {id: $state.params.id});
//                        }, 1000)
//
//                    }
//            ).error(function (data, status) {
//                $scope.loadbar('hide');
//                if (status == 422)
//                    $scope.errorData = $scope.errorSummary(data);
//                else
//                    $scope.errorData = data.message;
//            });
        }

        $scope.getTotalamount = function (total_charge_amount, concession_amount, extra_amount) {
            return parseFloat(total_charge_amount) - parseFloat(concession_amount) + parseFloat(extra_amount);
        }

        $scope.addChargesAmount = function (key, mode, total_amount, concession_amount, extra_amount, pk_mode_id) {
            var row_id = '#' + mode + '_' + key;
            if ((mode == 'professional') || (mode == 'procedure')) {
                var amount = parseFloat(total_amount) - parseFloat(concession_amount) + parseFloat(extra_amount);
            } else {
                var amount = parseFloat(total_amount);
            }
            if ($(row_id).is(':checked')) {
                $scope.data.writeoff_amount = parseFloat($scope.data.writeoff_amount) + amount; //Add Write Off session amount
                //Push the primary key and foregin key ids
                if (mode == 'professional') {
                    $scope.data.professional_id.push(pk_mode_id);
                } else if (mode == 'procedure') {
                    $scope.data.procedure_id.push(pk_mode_id);
                } else if (mode == 'othercharges') {
                    $scope.data.othercharges_id.push(pk_mode_id);
                } else if (mode == 'pharmacy') {
                    $scope.data.pharmacy_id.push(pk_mode_id);
                } else {
                    $scope.data.recurring = true;
                    $scope.data.recurring_amount = total_amount;
                }
            } else {
                $scope.data.writeoff_amount = parseFloat($scope.data.writeoff_amount) - amount; //Minus the write off session amount
                //Remove the primary key and foregin key ids
                if (mode == 'professional') {
                    var index = $scope.data.professional_id.indexOf(pk_mode_id);
                    $scope.data.professional_id.splice(index, 1);
                } else if (mode == 'procedure') {
                    var index = $scope.data.procedure_id.indexOf(pk_mode_id);
                    $scope.data.procedure_id.splice(index, 1);
                } else if (mode == 'othercharges') {
                    var index = $scope.data.othercharges_id.indexOf(pk_mode_id);
                    $scope.data.othercharges_id.splice(index, 1);
                } else if (mode == 'pharmacy') {
                    var index = $scope.data.pharmacy_id.indexOf(pk_mode_id);
                    $scope.data.pharmacy_id.splice(index, 1);
                } else {
                    $scope.data.recurring = false;
                    $scope.data.recurring_amount = '';
                }
            }
        }

        $scope.calculateNetamount = function () {
            if ($scope.billing_data.total_paid) {
                $scope.data.net_amount = parseFloat($scope.data.paid_amount) + parseFloat($scope.billing_data.total_paid);
            } else {
                $scope.data.net_amount = parseFloat($scope.data.paid_amount);
            }
        }
    }]);