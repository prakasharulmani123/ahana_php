app.controller('PrintBillController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

//        var encounter_id = $modalInstance.data.encounter_id;
//        var column = $modalInstance.data.column;
//        var value = $modalInstance.data.value;
//        
        $scope.report_generated_date = moment().format('DD/MM/YYYY');
        $scope.app = scope.app;
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

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

//        $scope.printBill = function () {
//            var innerContents = document.getElementById($scope.bill_type).innerHTML;
//            var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
//            popupWinindow.document.open();
//            popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
//            popupWinindow.document.close();
//        }

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
            return true;
        }

        $scope.printFooter = function () {
            return true;
        }

        $scope.printStyle = function () {
            return {
                rows: {
                    fontSize: 10
                }
            };
        }

        $scope.printFirstRow = function () {
            if ($scope.enc.selected.bill_no)
                var billNo = $scope.enc.selected.bill_no;
            else
                var billNo = '-';

            if ($scope.bill_type == 'detailed_bill') {
                var h1 = 'DETAILED BILLING SUMMARY';
            } else {
                var h1 = 'BILLING SUMMARY';
            }

            return [
                {
                    margin: [0, 20, 0, 20],
                    colSpan: 2,
                    text: [
                        {text: 'Bill NO : ', bold: true},
                        billNo
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
                        {text: 'Generated On: ', bold: true},
                        $scope.report_generated_date
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

            return [
                {
                    colSpan: 3,
                    layout: 'noBorders',
                    table: {
                        widths: ['auto', 10, 'auto'],
                        body: [
                            [{text: 'Patient Detail :', bold: true, colSpan: 3, decoration: 'underline'}, {}, {}],
                            [{text: 'Name', bold: true}, ':', $scope.patientObj.fullname],
                            [{text: 'Patient ID', bold: true}, ':', $scope.patientObj.patient_global_int_code],
                            [{text: 'Age', bold: true}, ':', $scope.patientObj.patient_age.toString()],
                            [{text: 'Gender', bold: true}, ':', $scope.app.patientDetail.patientSex]
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
                        body: [
                            [{text: 'Admission Date', bold: true}, ':', admission_date],
                            [{text: 'Discharge Date', bold: true}, ':', discharge_date],
                            [{text: 'Ward No', bold: true}, ':', $scope.patientObj.current_room],
                            [{text: 'No.ofDays', bold: true}, ':', $scope.enc.selected.stay_duration.toString()],
                            [{text: 'Consultant Name', bold: true}, ':', $scope.patientObj.consultant_name],
                        ]
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
                {text: 'Billing Summary:', bold: true, colSpan: 6, decoration: 'underline', margin: [0, 10, 0, 10]},
                {},
                {},
                {},
                {},
                {}
            ]);
            bill.push([
                {text: 'Description of service', bold: true, colSpan: 5},
                {},
                {},
                {},
                {},
                {text: 'Unit Price', bold: true, alignment:'right'}
            ]);
            bill.push([
                {text: 'Recurring Charges', style: 'rows', colSpan: 5},
                {},
                {},
                {},
                {},
                {text: $scope.recurr_billing.total.recurring_total.toFixed(2).toString(), alignment:'right'}
            ]);
            bill.push([
                {text: 'Non-recurring charges', style: 'rows', colSpan: 5},
                {},
                {},
                {},
                {},
                {text: $scope.billing.total.price.toFixed(2).toString(), alignment:'right'}
            ]);
            
            bill.push([
                {
                    text: 'Gradn Total : ' + (parseFloat($scope.billing.total.price) + parseFloat($scope.recurr_billing.total.recurring_total)).toFixed(2).toString(),
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
                    text: 'Advance : ' + $scope.billing.total.advance_charge.toFixed(2).toString(),
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
                    text: 'Room Discount : ' + $scope.enc.selected.concession_amount.toString(),
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
                    text: 'Other Discount : ' + $scope.billing.total.concession.toFixed(2).toString(),
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
                    text: 'Net Total : ' + ((parseFloat($scope.billing.total.price) + parseFloat($scope.recurr_billing.total.recurring_total)) - parseFloat($scope.billing.total.advance_charge) - parseFloat($scope.enc.selected.concession_amount)).toFixed(2).toString(),
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

            bill.push([
                {text: 'Billing Summary:', bold: true, colSpan: 6, decoration: 'underline', margin: [0, 10, 0, 10]},
                {},
                {},
                {},
                {},
                {}
            ]);

            //Recurring charges START
            bill.push([
                {text: 'Room Charge', bold: true, colSpan: 6, fillColor: '#eeeeee', margin: [2, 10, 0, 10]},
                {},
                {},
                {},
                {},
                {}
            ]);
            bill.push([
                {text: 'From Date', bold: true},
                {text: 'To Date', bold: true},
                {text: 'Description', bold: true},
                {text: 'Debit', bold: true, alignment: 'right'},
                {text: 'Credit', bold: true, alignment: 'right'},
                {text: 'Net', bold: true, alignment: 'right'},
            ]);
            angular.forEach($scope.recurring_charges, function (row, key) {
                var recu_price = $scope.getTotalRecurringPrice(row);
                var recu_from = moment(row.from_date).format('DD/MM/YYYY');
                var recu_to = moment(row.to_date).format('DD/MM/YYYY');
                bill.push([
                    {text: recu_from, style: 'rows'},
                    {text: recu_to, style: 'rows'},
                    {text: row.charge_item + '(' + row.charge_amount + '*' + row.duration + ')' + '(' + row.room_type + ')', style: 'rows'},
                    {text: recu_price.toString(), style: 'rows', alignment: 'right'},
                    '',
                    {text: row.net_amount.toString(), style: 'rows', alignment: 'right'},
                ]);
                detailed_recurr_billing.total.recurring_total = parseFloat(detailed_recurr_billing.total.recurring_total) + recu_price
            });
            bill.push([
                {
                    text: 'Sub Total',
                    bold: true,
                    margin: [0, 10, 0, 0],
                    alignment: 'right',
                    colSpan: 3
                },
                '',
                '',
                {
                    text: detailed_recurr_billing.total.recurring_total.toString(),
                    bold: true,
                    alignment: 'right',
                    margin: [0, 10, 0, 0]
                },
                '',
                {
                    text: detailed_recurr_billing.total.recurring_total.toString(),
                    bold: true,
                    alignment: 'right',
                    margin: [0, 10, 0, 0]
                },
            ]);
            //Recurring charges END          

            //Procedure charges START
            if ($scope.procedures) {
                bill.push([
                    {text: 'Procedure Charges', bold: true, colSpan: 6, fillColor: '#eeeeee', margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                bill.push([
                    {text: 'Description', bold: true, colSpan: 3},
                    {},
                    {},
                    {text: 'Debit', bold: true, alignment: 'right'},
                    {text: 'Credit', bold: true, alignment: 'right'},
                    {text: 'Net', bold: true, alignment: 'right'},
                ]);
                angular.forEach($scope.procedures, function (row, key) {
                    detailed_billing.total.net_step_1_total = detailed_recurr_billing.total.recurring_total;
                    var row_total = $scope.getTotalPrice(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_1_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: row.category, colSpan: 3, style: 'rows'},
                        '',
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
                    {text: 'Sub Total', bold: true, margin: [0, 10, 0, 0], alignment: 'right', colSpan: 3},
                    '',
                    '',
                    {text: detailed_billing.total.procedure_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    '',
                    {text: detailed_billing.total.procedure_net_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                ]);
            }
            if (detailed_billing.total.procedure_net_total == '0') {
                detailed_billing.total.procedure_net_total = detailed_recurr_billing.total.recurring_total;
            }
            //Procedure charges END

            //Professional charges START
            if ($scope.consultants) {
                bill.push([
                    {text: 'Professional Charges', bold: true, colSpan: 6, fillColor: '#eeeeee', margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                bill.push([
                    {text: 'Description', bold: true, colSpan: 3},
                    {},
                    {},
                    {text: 'Debit', bold: true, alignment: 'right'},
                    {text: 'Credit', bold: true, alignment: 'right'},
                    {text: 'Net', bold: true, alignment: 'right'},
                ]);
                angular.forEach($scope.consultants, function (row, key) {
                    detailed_billing.total.net_step_2_total = detailed_billing.total.procedure_net_total;
                    var row_total = $scope.getTotalPrice(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_2_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: row.category + '(' + row.headers + ')', style: 'rows', colSpan: 3},
                        '',
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
                    {text: 'Sub Total', bold: true, margin: [0, 10, 0, 0], alignment: 'right', colSpan: 3},
                    '',
                    '',
                    {text: detailed_billing.total.consultant_total.toString(), alignment: 'right', bold: true, margin: [0, 10, 0, 0]},
                    '',
                    {text: detailed_billing.total.consultant_net_total.toString(), alignment: 'right', bold: true, margin: [0, 10, 0, 0]},
                ]);
            }
            if (detailed_billing.total.consultant_net_total == '0') {
                detailed_billing.total.consultant_net_total = detailed_billing.total.procedure_net_total;
            }
            //Professional charges END

            //Other charges START
            if ($scope.other_charges) {
                bill.push([
                    {text: 'Other Charges', bold: true, colSpan: 6, fillColor: '#eeeeee', margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                bill.push([
                    {text: 'Description', bold: true, colSpan: 3},
                    {},
                    {},
                    {text: 'Debit', bold: true, alignment: 'right'},
                    {text: 'Credit', bold: true, alignment: 'right'},
                    {text: 'Net', bold: true, alignment: 'right'},
                ]);
                angular.forEach($scope.other_charges, function (row, key) {
                    detailed_billing.total.net_step_3_total = detailed_billing.total.consultant_net_total;
                    var row_total = $scope.getTotalPrice(row);
                    var net_total = parseFloat(detailed_billing.total.net_step_3_total) + parseFloat(row.net_amount)
                    bill.push([
                        {text: row.category + '(' + row.headers + ')', colSpan: 3, style: 'rows'},
                        '',
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
                    {text: 'Sub Total', bold: true, margin: [0, 10, 0, 0], alignment: 'right', colSpan: 3},
                    '',
                    '',
                    {text: detailed_billing.total.other_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    '',
                    {text: detailed_billing.total.other_net_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                ]);
            }
            if (detailed_billing.total.other_net_total == '0') {
                detailed_billing.total.other_net_total = detailed_billing.total.consultant_net_total;
            }
            //Other charges END

            //Advance START
            if ($scope.advances) {
                bill.push([
                    {text: 'Advance', bold: true, colSpan: 6, fillColor: '#eeeeee', margin: [2, 10, 0, 10]},
                    {},
                    {},
                    {},
                    {},
                    {}
                ]);
                bill.push([
                    {text: 'Date', bold: true},
                    {text: 'Description', bold: true, colSpan: 2},
                    {},
                    {text: 'Debit', bold: true, alignment: 'right'},
                    {text: 'Credit', bold: true, alignment: 'right'},
                    {text: 'Net', bold: true, alignment: 'right'},
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
                    {text: 'Sub Total', bold: true, margin: [0, 10, 0, 0], alignment: 'right', colSpan: 4},
                    '',
                    '',
                    '',
                    {text: detailed_billing.total.advance_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                    {text: detailed_billing.total.advance_net_total.toString(), bold: true, margin: [0, 10, 0, 0], alignment: 'right'},
                ]);
            }
            //Advance END
            bill.push([
                {
                    text: 'Gradn Total : ' + (parseFloat($scope.billing.total.price) + parseFloat($scope.recurr_billing.total.recurring_total)).toString(),
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
                    text: 'Advance : ' + $scope.billing.total.advance_charge.toString(),
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
                    text: 'Room Discount : ' + $scope.enc.selected.concession_amount.toString(),
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
                    text: 'Other Discount : ' + $scope.billing.total.concession.toString(),
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
                    text: 'Net Total : ' + ((parseFloat($scope.billing.total.price) + parseFloat($scope.recurr_billing.total.recurring_total)) - parseFloat($scope.billing.total.advance_charge) - parseFloat($scope.enc.selected.concession_amount)).toString(),
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
  