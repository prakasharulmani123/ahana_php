app.controller('PrintBillController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

//        var encounter_id = $modalInstance.data.encounter_id;
//        var column = $modalInstance.data.column;
//        var value = $modalInstance.data.value;
//        
        $scope.report_generated_date = moment().format('DD/MM/YYYY');
        $scope.app = scope.app;
        $scope.report_generated_by = $scope.app.username;
        $scope.patientObj = scope.patientObj;
        $scope.billing = scope.billing;
        $scope.recurr_billing = scope.recurr_billing;
        $scope.recurring_charges = scope.recurring_charges;
        $scope.procedures = scope.procedures;
        $scope.consultants = scope.consultants;
        $scope.other_charges = scope.other_charges;
        $scope.advances = scope.advances;
        $scope.enc = scope.enc;

        $scope.detailed_billing = {};
        $scope.detailed_recurr_billing = {};

        $scope.bill_type = 'bill_summary';
        $scope.isShown = function (bill_type) {
//            console.log(bill_type);
            return bill_type === $scope.bill_type;
        };

        $scope.getTotalRecurringPrice = function (row) {
            tot = parseFloat(row.total_charge);
            return tot;
        }

        $scope.getTotalPrice = function (row) {
            tot = parseFloat(row.total_charge) + parseFloat(row.extra_amount) - parseFloat(row.concession_amount);
            return tot;
        }

        $scope.getTotalExtra = function (row) {
            tot = parseFloat(row.total_charge) + parseFloat(row.extra_amount);
            return tot;
        }

        $scope.greaterThan = function (prop, val) {
            return function (item) {
                return item[prop] > val;
            }
        }

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

        //PRINT
        $scope.printHeader = function () {
//            return true;
        }

        $scope.printFooter = function () {
//            return true;
        }

        $scope.printStyle = function () {
            return {
                rows: {
                    fontSize: 10
                }
            };
        }

        $scope.printFirstRow = function () {
            if ($scope.bill_type == 'detailed_bill') {
                var h1 = 'DETAILED BILL';
            } else {
                var h1 = 'BILL SUMMARY';
            }

            return [
                {
                    margin: [0, 20, 0, 20],
                    colSpan: 2,
                    text: [
                        {text: 'Generated On: ', bold: true},
                        $scope.report_generated_date
                    ]
                },
                {},
                {
                    margin: [0, 20, 0, 20],
                    colSpan: 2,
                    bold: true,
                    alignment: 'center',
                    text: h1
                },
                {},
                {
                    margin: [0, 20, 0, 20],
                    colSpan: 2,
                    text: [
                        {text: 'Generated By: ', bold: true},
                        $scope.report_generated_by
                    ]
                },
                {}
            ];
        }

        $scope.printPatientDetails = function () {
            var admission_date = moment($scope.enc.selected.encounter_date).format('DD/MM/YYYY - hh:mm A');
            if ($scope.enc.selected.discharge_date)
                var discharge_date = moment($scope.enc.selected.discharge_date).format('DD/MM/YYYY - hh:mm A');
            else
                var discharge_date = '-';
            
            if ($scope.enc.selected.bill_no)
                var bill_no = $scope.enc.selected.bill_no;
            else
                var bill_no = '-';
            
            var patient_details_right = [];
            patient_details_right.push([{text: 'Admission Date', bold: true}, ':', admission_date]);
            patient_details_right.push([{text: 'Discharge Date', bold: true}, ':', discharge_date]);
            patient_details_right.push([{text: 'Ward No', bold: true}, ':', $scope.enc.selected.currentAdmission.room_details]);
            patient_details_right.push([{text: 'No.ofDays', bold: true}, ':', $scope.enc.selected.stay_duration.toString()]);
            patient_details_right.push([{text: 'Consultant Name', bold: true}, ':', $scope.enc.selected.currentAdmission.consultant_name]);
            if($scope.enc.selected.authorize == 0){
                patient_details_right.push([{text: ''}, '', {text: 'NOT DISCHARGED', bold: true}]);
            }
            
            return [
                {
                    colSpan: 3,
                    layout: 'noBorders',
                    table: {
                        widths: ['auto', 10, 'auto'],
                        body: [
                            [{text: 'Patient Detail :', bold: true, colSpan: 3, decoration: 'underline'}, {}, {}],
                            [{text: 'Bill No', bold: true}, ':', bill_no],
                            [{text: 'Name', bold: true}, ':', $scope.patientObj.fullname],
                            [{text: 'Patient ID', bold: true}, ':', $scope.patientObj.patient_global_int_code],
                            [{text: 'Age', bold: true}, ':', $scope.patientObj.patient_age_ym.toString() + ' / ' + $scope.app.patientDetail.patientSex],
                            [{text: 'Encounter #', bold: true}, ':', $scope.enc.selected.encounter_id],
                            [{text: 'Branch Name', bold: true}, ':', $scope.app.org_name],
                        ]
                    }
                },
                {},
                {},
                {
                    colSpan: 3,
                    layout: 'noBorders',
                    table: {
                        widths: ['auto', 10, 'auto'],
                        body: patient_details_right
                    }
                },
                {},
                {}
            ];
        }

        $scope.printBillingSummary = function () {
            if ($scope.bill_type == 'detailed_bill') {
                var content = $scope.detailedBillSummaryContent();
            } else {
                var content = $scope.billSummaryContent();
            }

            return [
                {
                    colSpan: 6,
                    layout: 'noBorders',
                    table: {
                        widths: ['auto', 'auto', '*', 'auto', 'auto', 'auto'],
                        dontBreakRows: true,
                        body: content
                    }
                },
                {},
                {},
                {},
                {},
                {}
            ]
        }

        $scope.billSummaryContent = function () {
            var bill = [];
            bill.push([
                {text: 'Service', bold: true, colSpan: 6},
                {},
                {},
                {},
                {},
                {},
            ]);
            bill.push([
                {text: 'Room Charges', style: 'rows', colSpan: 5},
                {},
                {},
                {},
                {},
                {text: $scope.recurr_billing.total.recurring_total.toFixed(2).toString(), alignment: 'right'}
            ]);
            if ($scope.procedures.length > 0) {
                var proce_charge = 0;
                angular.forEach($scope.procedures, function (row, key) {
                    proce_charge += $scope.getTotalExtra(row);
                });
                bill.push([
                    {text: 'Procedures charges', style: 'rows', colSpan: 5},
                    {},
                    {},
                    {},
                    {},
                    {text: proce_charge.toFixed(2).toString(), alignment: 'right'}
                ]);
            }
            if ($scope.consultants.length > 0) {
                var profe_charge = 0;
                angular.forEach($scope.consultants, function (row, key) {
                    profe_charge += $scope.getTotalExtra(row);
                });
                bill.push([
                    {text: 'Professional charges', style: 'rows', colSpan: 5},
                    {},
                    {},
                    {},
                    {},
                    {text: profe_charge.toFixed(2).toString(), alignment: 'right'}
                ]);
            }
            if ($scope.other_charges) {
                var other_charge = 0;
                angular.forEach($scope.other_charges, function (row, key) {
                    other_charge += $scope.getTotalPrice(row);
                });
                bill.push([
                    {text: 'Other charges', style: 'rows', colSpan: 5},
                    {},
                    {},
                    {},
                    {},
                    {text: other_charge.toFixed(2).toString(), alignment: 'right'}
                ]);
            }
            if(typeof $scope.billing.total == 'undefined'){
                charge = 0.00;
                extra = 0.00;
                advance_charge = 0.00;
                price = 0.00;
            } else {
                charge = $scope.billing.total.charge;
                extra = $scope.billing.total.extra;
                advance_charge = (typeof $scope.billing.total.advance_charge == 'undefined') ? '0.00' : $scope.billing.total.advance_charge.toFixed(2);
                price = $scope.billing.total.price;
            }
            
            bill.push([
                {
                    text: 'Grand Total : ' + (parseFloat(charge) + parseFloat(extra) + parseFloat($scope.recurr_billing.total.recurring_total)).toFixed(2).toString(),
                    fillColor: '#eeeeee',
                    bold: true,
                    margin: [0, 10, 2, 0],
                    alignment: 'right',
                    colSpan: 6,
                },
                '',
                '',
                '',
                '',
                '',
            ]);
            
            bill.push([
                {
                    text: 'Advance : ' + advance_charge.toString(),
                    fillColor: '#eeeeee',
                    bold: true,
                    margin: [0, 10, 2, 0],
                    alignment: 'right',
                    colSpan: 6,
                },
                '',
                '',
                '',
                '',
                '',
            ]);
            if ($scope.billing.discount > 0) {
                var discount = parseFloat($scope.billing.total.concession) + parseFloat($scope.enc.selected.concession_amount);
                bill.push([
                    {
                        text: 'Discount : ' + discount.toFixed(2).toString(),
                        fillColor: '#eeeeee',
                        bold: true,
                        margin: [0, 10, 2, 0],
                        alignment: 'right',
                        colSpan: 6,
                    },
                    '',
                    '',
                    '',
                    '',
                    '',
                ]);
            }
            bill.push([
                {
                    text: 'Net Total : ' + ((parseFloat(price) + parseFloat($scope.recurr_billing.total.recurring_total)) - parseFloat(advance_charge) - parseFloat($scope.enc.selected.concession_amount)).toFixed(2).toString(),
                    fillColor: '#eeeeee',
                    bold: true,
                    margin: [0, 10, 2, 0],
                    alignment: 'right',
                    colSpan: 6,
                },
                '',
                '',
                '',
                '',
                '',
            ]);
            return bill;
        }

        $scope.detailedBillSummaryContent = function () {
            var bill = [];
            var detailed_billing = {
                total: {
                    net_step_1_total: '0',
                    procedure_net_total: '0',
                    procedure_total: '0',
                    net_step_2_total: '0',
                    consultant_net_total: '0',
                    consultant_total: '0',
                    net_step_3_total: '0',
                    other_net_total: '0',
                    other_total: '0',
                    net_step_4_total: '0',
                    advance_net_total: '0',
                    advance_total: '0',
                    net_step_5_total: '0',
                    proc_concession_net_total: '0',
                    net_step_6_total: '0',
                    cons_concession_net_total: '0',
                }
            };
            var detailed_recurr_billing = {
                total: {
                    recurring_total: '0'
                }
            };
            var detailed_non_billing = {
                total: {
                    charge: '0'
                }
            };

            //Recurring charges START

            bill.push([
                {text: 'Date', bold: true, fillColor: '#eeeeee'},
                {text: 'Description', bold: true, colSpan: 2, fillColor: '#eeeeee'},
                {},
                {text: 'Debit', bold: true, alignment: 'right', fillColor: '#eeeeee'},
                {text: 'Credit', bold: true, alignment: 'right', fillColor: '#eeeeee'},
                {text: 'Net', bold: true, alignment: 'right', fillColor: '#eeeeee'},
            ]);
            bill.push([
                {text: 'Room Charge', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                {},
                {},
                {},
                {},
                {}
            ]);
            angular.forEach($scope.recurring_charges, function (row, key) {
                var recu_price = $scope.getTotalRecurringPrice(row);
                var recu_to = moment(row.to_date).format('DD/MM/YYYY');
                bill.push([
                    {text: recu_to, style: 'rows'},
                    {text: row.charge_item + '(' + row.charge_amount + '*' + row.duration + ')' + '(' + row.room_type + ')', style: 'rows', colSpan: 2},
                    '',
                    {text: recu_price.toString(), style: 'rows', alignment: 'right'},
                    '',
                    {text: row.net_amount.toString(), style: 'rows', alignment: 'right'},
                ]);
                detailed_recurr_billing.total.recurring_total = parseFloat(detailed_recurr_billing.total.recurring_total) + recu_price
            });
            bill.push([
                '',
                '',
                '',
                {
                    text: detailed_recurr_billing.total.recurring_total.toString(),
                    bold: true,
                    alignment: 'right',
                    margin: [0, 10, 0, 0]
                },
                '',
                '',
            ]);
            //Recurring charges END          

            //Procedure charges START
            if ($scope.procedures.length > 0) {
                bill.push([
                    {text: 'Procedure Charges', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                angular.forEach($scope.procedures, function (row, key) {
                    var proce_date = moment(row.date).format('DD/MM/YYYY');
                    detailed_billing.total.net_step_1_total = detailed_recurr_billing.total.recurring_total;
                    var row_total = $scope.getTotalExtra(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_1_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: proce_date, style: 'rows'},
                        {text: row.headers, colSpan: 2, style: 'rows'},
                        '',
                        {text: row_total.toString(), style: 'rows', alignment: 'right'},
                        '',
                        {text: net_total.toString(), style: 'rows', alignment: 'right'}
                    ]);

                    detailed_non_billing.total.charge = parseFloat(detailed_non_billing.total.charge) + row_total;
                    detailed_billing.total.procedure_total = parseFloat(detailed_billing.total.procedure_total) + row_total;
                    detailed_billing.total.procedure_net_total = detailed_recurr_billing.total.recurring_total + parseFloat(row.net_amount);
                });
                bill.push([
                    '',
                    '',
                    '',
                    {text: detailed_billing.total.procedure_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    '',
                    '',
                ]);
            }
            if (detailed_billing.total.procedure_net_total == '0') {
                detailed_billing.total.procedure_net_total = detailed_recurr_billing.total.recurring_total;
            }
            //Procedure charges END

            //Professional charges START
            if ($scope.consultants.length > 0) {
                bill.push([
                    {text: 'Professional Charges', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                angular.forEach($scope.consultants, function (row, key) {
                    var profe_date = moment(row.date).format('DD/MM/YYYY');
                    detailed_billing.total.net_step_2_total = detailed_billing.total.procedure_net_total;
                    var row_total = $scope.getTotalExtra(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_2_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: profe_date, style: 'rows'},
                        {text: row.headers, style: 'rows', colSpan: 2},
                        '',
                        {text: row_total.toString(), style: 'rows', alignment: 'right'},
                        '',
                        {text: net_total.toString(), style: 'rows', alignment: 'right'}
                    ]);

                    detailed_non_billing.total.charge = parseFloat(detailed_non_billing.total.charge) + row_total;
                    detailed_billing.total.consultant_total = parseFloat(detailed_billing.total.consultant_total) + row_total;
                    detailed_billing.total.consultant_net_total = parseFloat(detailed_billing.total.procedure_net_total) + parseFloat(row.net_amount);
                });
                bill.push([
                    '',
                    '',
                    '',
                    {text: detailed_billing.total.consultant_total.toString(), alignment: 'right', bold: true, margin: [0, 10, 0, 0]},
                    '',
                    '',
                ]);
            }
            if (detailed_billing.total.consultant_net_total == '0') {
                detailed_billing.total.consultant_net_total = detailed_billing.total.procedure_net_total;
            }
            //Professional charges END

            //Other charges START
            if ($scope.other_charges) {
                bill.push([
                    {text: 'Other Charges', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                angular.forEach($scope.other_charges, function (row, key) {
                    var other_date = moment(row.date).format('DD/MM/YYYY');
                    detailed_billing.total.net_step_3_total = detailed_billing.total.consultant_net_total;
                    var row_total = $scope.getTotalPrice(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_3_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: other_date, style: 'rows'},
                        {text: row.category + '(' + row.headers + ')', colSpan: 2, style: 'rows'},
                        '',
                        {text: row_total.toString(), style: 'rows', alignment: 'right'},
                        '',
                        {text: net_total.toString(), style: 'rows', alignment: 'right'}
                    ]);

                    detailed_non_billing.total.charge = parseFloat(detailed_non_billing.total.charge) + row_total;
                    detailed_billing.total.other_total = parseFloat(detailed_billing.total.other_total) + row_total;
                    detailed_billing.total.other_net_total = parseFloat(detailed_billing.total.consultant_net_total) + parseFloat(row.net_amount);
                });
                bill.push([
                    '',
                    '',
                    '',
                    {text: detailed_billing.total.other_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    '',
                    '',
                ]);
            }
            if (detailed_billing.total.other_net_total == '0') {
                detailed_billing.total.other_net_total = detailed_billing.total.consultant_net_total;
            }
            //Other charges END

            //Advance START
            if ($scope.advances) {
                bill.push([
                    {text: 'Advance', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                angular.forEach($scope.advances, function (row, key) {
                    detailed_billing.total.net_step_4_total = detailed_billing.total.other_net_total;
                    var row_total = parseFloat(row.total_charge);
                    var net_total = parseFloat(detailed_billing.total.net_step_4_total) - parseFloat(row.net_amount);
                    var payment_date = moment(row.payment_date).format('DD/MM/YYYY');
                    bill.push([
                        {text: payment_date, style: 'rows'},
                        {text: row.headers, colSpan: 2, style: 'rows'},
                        '',
                        '',
                        {text: parseInt(row.total_charge).toString(), style: 'rows', alignment: 'right'},
                        {text: net_total.toString(), style: 'rows', alignment: 'right'}
                    ]);

                    detailed_non_billing.total.adv_charge = parseFloat(detailed_non_billing.total.adv_charge) + row_total;
                    detailed_billing.total.advance_total = parseFloat(detailed_billing.total.advance_total) + row_total;
                    detailed_billing.total.advance_net_total = parseFloat(detailed_billing.total.other_net_total) - parseFloat(row.net_amount);
                });
                bill.push([
                    '',
                    '',
                    '',
                    '',
                    {text: detailed_billing.total.advance_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    '',
                ]);
            }
            if (detailed_billing.total.advance_net_total == '0') {
                detailed_billing.total.advance_net_total = detailed_billing.total.other_net_total;
            }
            //Advance END

            //Discount
            if ($scope.billing.discount > 0) {
                bill.push([
                    {text: 'Discount', bold: true, colSpan: 6, margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);

                angular.forEach($scope.procedures, function (row, key) {
                    if (row.concession_amount > 0.00) {
                        var proce_date = moment(row.date).format('DD/MM/YYYY');
                        detailed_billing.total.net_step_5_total = detailed_billing.total.advance_net_total;
                        var net_total = parseFloat(detailed_billing.total.net_step_5_total) - parseFloat(row.concession_net_amount)
                        bill.push([
                            {text: proce_date, style: 'rows'},
                            {text: 'Procedure > ' + row.headers, colSpan: 2, style: 'rows'},
                            '',
                            '',
                            {text: row.concession_amount, style: 'rows', alignment: 'right'},
                            {text: net_total.toString(), style: 'rows', alignment: 'right'}
                        ]);
                        detailed_billing.total.proc_concession_net_total = detailed_billing.total.advance_net_total - parseFloat(row.concession_net_amount);
                    }
                });
                if (detailed_billing.total.proc_concession_net_total == '0') {
                    detailed_billing.total.proc_concession_net_total = detailed_billing.total.advance_net_total;
                }

                angular.forEach($scope.consultants, function (row, key) {
                    if (row.concession_amount > 0.00) {
                        var cons_date = moment(row.date).format('DD/MM/YYYY');
                        detailed_billing.total.net_step_6_total = detailed_billing.total.proc_concession_net_total;
                        var net_total = parseFloat(detailed_billing.total.net_step_6_total) - parseFloat(row.concession_net_amount)
                        bill.push([
                            {text: cons_date, style: 'rows'},
                            {text: 'Professionals > ' + row.headers, colSpan: 2, style: 'rows'},
                            '',
                            '',
                            {text: row.concession_amount, style: 'rows', alignment: 'right'},
                            {text: net_total.toString(), style: 'rows', alignment: 'right'}
                        ]);
                        detailed_billing.total.cons_concession_net_total = detailed_billing.total.proc_concession_net_total - parseFloat(row.concession_net_amount);
                    }
                });
                if (detailed_billing.total.cons_concession_net_total == '0') {
                    detailed_billing.total.cons_concession_net_total = detailed_billing.total.proc_concession_net_total;
                }

                if ($scope.enc.selected.concession_amount != '0.00') {
                    var room_dis = (detailed_billing.total.cons_concession_net_total - $scope.enc.selected.concession_amount)
                    bill.push([
                        '',
                        {text: 'Room Discount', colSpan: 2, style: 'rows'},
                        '',
                        '',
                        {text: parseInt($scope.enc.selected.concession_amount).toString(), style: 'rows', alignment: 'right'},
                        {text: room_dis.toString(), style: 'rows', alignment: 'right'}
                    ]);
                }
            }
            if(typeof $scope.billing.total == 'undefined'){
                charge = 0.00;
                extra = 0.00;
                advance_charge = 0.00;
                price = 0.00;
            } else {
                charge = $scope.billing.total.charge;
                extra = $scope.billing.total.extra;
                advance_charge = (typeof $scope.billing.total.advance_charge == 'undefined') ? '0.00' : $scope.billing.total.advance_charge.toFixed(2);
                price = $scope.billing.total.price;
            }
            bill.push([
                {
                    text: 'Grand Total : ' + (parseFloat(charge) + parseFloat(extra) + parseFloat($scope.recurr_billing.total.recurring_total)).toString(),
                    fillColor: '#eeeeee',
                    bold: true,
                    margin: [0, 10, 2, 0],
                    alignment: 'right',
                    colSpan: 6,
                },
                '',
                '',
                '',
                '',
                '',
            ]);
//            bill.push([
//                {
//                    text: 'Advance : ' + $scope.billing.total.advance_charge.toString(),
//                    fillColor: '#eeeeee',
//                    bold: true,
//                    margin: [0, 10, 2, 0],
//                    alignment: 'right',
//                    colSpan: 6,
//                },
//                '',
//                '',
//                '',
//                '',
//                '',
//            ]);
//            bill.push([
//                {
//                    text: 'Room Discount : ' + $scope.enc.selected.concession_amount.toString(),
//                    fillColor: '#eeeeee',
//                    bold: true,
//                    margin: [0, 10, 2, 0],
//                    alignment: 'right',
//                    colSpan: 6,
//                },
//                '',
//                '',
//                '',
//                '',
//                '',
//            ]);
//            bill.push([
//                {
//                    text: 'Other Discount : ' + $scope.billing.total.concession.toString(),
//                    fillColor: '#eeeeee',
//                    bold: true,
//                    margin: [0, 10, 2, 0],
//                    alignment: 'right',
//                    colSpan: 6,
//                },
//                '',
//                '',
//                '',
//                '',
//                '',
//            ]);
            bill.push([
                {
                    text: 'Net Total : ' + ((parseFloat(price) + parseFloat($scope.recurr_billing.total.recurring_total)) - parseFloat(advance_charge) - parseFloat($scope.enc.selected.concession_amount)).toString(),
                    fillColor: '#eeeeee',
                    bold: true,
                    margin: [0, 10, 2, 0],
                    alignment: 'right',
                    colSpan: 6,
                },
                '',
                '',
                '',
                '',
                '',
            ]);

            return bill;
        }

        //Detailed Bill Content
        $scope.printIPBill = function () {
            var content = [
                {
                    table: {
                        widths: ['*', '*', '*', '*', '*', 100],
                        headerRows: 1,
                        body: [
                            $scope.printFirstRow(),
                            $scope.printPatientDetails(),
                            $scope.printBillingSummary(),
                        ]
                    }
                }
            ];
            return content;
        }

        $scope.printBill = function () {
            $timeout(function () {
                var print_content = $scope.printIPBill();

                if (print_content.length > 0) {
                    var docDefinition = {
                        header: $scope.printHeader(),
                        footer: $scope.printFooter(),
                        styles: $scope.printStyle(),
                        content: print_content,
//                        pageMargins: (scope.deviceDetector.browser == 'firefox' ? 75 : 50),
                        pageSize: 'A4',
                    };
                    var pdf_document = pdfMake.createPdf(docDefinition);
                    var doc_content_length = Object.keys(pdf_document).length;
                    if (doc_content_length > 0) {
                        pdf_document.print();
                    }
                }
            }, 1000);
        }

    }]);
  