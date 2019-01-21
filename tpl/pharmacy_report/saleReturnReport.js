app.controller('saleReturnReportController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened1 = $scope.opened2 = false;
            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened2 = true;
                    break;
            }
        };

        $scope.clearReport = function () {
            $scope.showTable = false;
            $scope.data = {};
            $scope.data.to = moment().format('YYYY-MM-DD');
            $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
            $scope.data.payment_type = '';
            $scope.data.patient_group_name = '';
            $scope.deselectAll();
            $scope.fromMaxDate = new Date($scope.data.to);
            $scope.toMinDate = new Date($scope.data.from);
        }

        $scope.initReport = function () {
            $scope.paymentTypes = [];
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
                $scope.paymentTypes.push({value: 'COD', label: 'Cash On Delivery'});
            });

            $scope.saleGroups = {};
            $scope.saleGroupsLength = 0;
            $rootScope.commonService.GetSaleGroups('', '1', false, function (response) {
                $scope.saleGroups = response.saleGroupsList;
                $scope.saleGroupsLength = Object.keys($scope.saleGroups).length;
            });
            $rootScope.commonService.GetPatientRegisterModelList(function (response) {
                $scope.registerModes = response;
            });
            $scope.clearReport();
        }

        $scope.deselectAll = function () {
            $timeout(function () {
                // anything you want can go here and will safely be run on the next digest.
                var patient_group_button = $('button[data-id="patient_group"]').next();
                var patient_group_deselect_all = patient_group_button.find(".bs-deselect-all");
                patient_group_deselect_all.click();
            });
        }

        $scope.$watch('data.from', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.toMinDate = new Date($scope.data.from);
            }
        }, true);
        $scope.$watch('data.to', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.fromMaxDate = new Date($scope.data.to);
            }
        }, true);

        //Index Page
        $scope.loadReport = function () {
            $scope.records = [];
            $scope.sale = {};
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var data = {};
            if (typeof $scope.data.from !== 'undefined' && $scope.data.from != '')
                angular.extend(data, {from: moment($scope.data.from).format('YYYY-MM-DD')});
            if (typeof $scope.data.to !== 'undefined' && $scope.data.to != '')
                angular.extend(data, {to: moment($scope.data.to).format('YYYY-MM-DD')});
            if (typeof $scope.data.encounter_type !== 'undefined' && $scope.data.encounter_type != '')
                angular.extend(data, {encounter_type: $scope.data.encounter_type});
            if (typeof $scope.data.patient_group_name !== 'undefined' && $scope.data.patient_group_name != '')
                angular.extend(data, {patient_group_name: $scope.data.patient_group_name});

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyreport/salereturnreport?addtfields=salereturnreport', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                        $scope.tableid = [];
                        $scope.sheet_name = [];
                        $scope.tableid.push('sale_return_report');
                        $scope.sheet_name.push($scope.app.org_name);
                        $scope.tableid.push('table_datewise_report');
                        $scope.sheet_name.push('Date Wise Summary');
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured";
                    });
        };

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

        //For Print
        $scope.printHeader = function () {
            return {
                text: "Sale Return Report",
                margin: 5,
                alignment: 'center'
            };
        }

        $scope.printFooter = function () {
//            return true;
        }

        $scope.printStyle = function () {
            return {
                header: {
                    bold: true,
                    color: '#000',
                    fontSize: 11
                },
                demoTable: {
                    color: '#000',
                    fontSize: 10,
                }
            };
        }

        $scope.printloader = '';
        $scope.printContent = function () {
            var generated_on = $scope.generated_on;
            var generated_by = $scope.app.username;
            var date_rage = moment($scope.data.from).format('YYYY-MM-DD') + " - " + moment($scope.data.to).format('YYYY-MM-DD');
            var branch_name = $scope.app.org_name;

            var reports = [];
            reports.push([
                {text: branch_name, style: 'header', colSpan: 8}, "", "", "", "", "", "", "", ""
            ]);
            reports.push([
                {text: 'S.No', style: 'header'},
                {text: 'Date', style: 'header'},
                {text: 'Bill No', style: 'header'},
                {text: 'Patient Name', style: 'header'},
                {text: 'UHID', style: 'header'},
                {text: 'Encounter', style: 'header'},
                {text: 'Product Name', style: 'header'},
                {text: 'Tax Rate', style: 'header'},
                {text: 'Item Amount', style: 'header'},
            ]);

            var serial_no = 1;
            var result_count = $scope.records.length;
            var total = 0;
            angular.forEach($scope.records, function (record, key) {
                var s_no_string = serial_no.toString();
                reports.push([
                    s_no_string,
                    moment(record.sale_return.sale_return_date).format('DD-MM-YYYY'),
                    record.sale_return.bill_no,
                    record.sale_return.patient_name,
                    record.sale_return.patient_uhid,
                    record.sale_return.sale_ret_encounter_id+'('+record.sale_return.sale_ret_encounter_type+')',
                    record.product.full_name,
                    (parseFloat(record.cgst_percent) + parseFloat(record.sgst_percent)),
                    record.total_amount,
                ]);
                total += parseFloat(record.total_amount);
                if (serial_no == result_count) {
                    $scope.printloader = '';
                }
                serial_no++;
            });
            reports.push([
                {
                    text: 'Total Sale Return Value',
                    style: 'header',
                    alignment: 'right',
                    colSpan: 8
                },
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                {
                    text: total.toFixed(2).toString(),
                    style: 'header',
                    alignment: 'right'
                }
            ]);

            var content = [];
            content.push({
                columns: [
                    {
                        text: [
                            {text: 'Report Name: ', bold: true},
                            'Sale Return Report'
                        ],
                        margin: [0, 0, 0, 20]
                    },
                    {
                        text: [
                            {text: ' Generated On: ', bold: true},
                            generated_on
                        ],
                        margin: [0, 0, 0, 20]
                    }
                ]
            }, {
                columns: [
                    {
                        text: [
                            {text: 'Date: ', bold: true},
                            date_rage
                        ],
                        margin: [0, 0, 0, 20]
                    },
                    {
                        text: [
                            {text: ' Generated By: ', bold: true},
                            generated_by
                        ],
                        margin: [0, 0, 0, 20]
                    }
                ]
            }, {
                style: 'demoTable',
                table: {
                    headerRows: 2,
                    widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', '*'],
                    body: reports,
                    dontBreakRows: true,
                },
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                    }
                }
            });

            var sale_date_wise = $filter('groupBy')($scope.records, 'sale_return.sale_return_date');
            var date_info = [];
            date_info.push({
                columns: [
                    {
                        text: [
                            {text: 'Date Wise Summary: ', bold: true},
                        ],
                    }, ]
            });

            var branch_item = [];

            branch_item.push([
                {text: 'Date', style: 'header'},
                {text: 'Amount', alignment: 'right'}
            ]);

            angular.forEach(sale_date_wise, function (branch, sale_date) {
                var date_wise_total = 0;
                angular.forEach(branch, function (record, key) {
                    date_wise_total += parseFloat(record.total_amount);
                });
                var date_total = date_wise_total.toFixed(2).toString()
                branch_item.push([
                    {text: moment(sale_date).format('DD-MM-YYYY')},
                    {text: date_total, alignment: 'right'}
                ]);
            });

            date_info.push({
                style: 'demoTable1',
                table: {
                    widths: ['*', 'auto'],
                    body: branch_item,
                },
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                    }
                },
            });
            content.push(date_info);

            return content;
        }

        $scope.printReport = function () {
            $scope.printloader = '<i class="fa fa-spin fa-spinner"></i>';
            $timeout(function () {
                var print_content = $scope.printContent();
                if (print_content.length > 0) {
                    var docDefinition = {
                        header: $scope.printHeader(),
                        footer: $scope.printFooter(),
                        styles: $scope.printStyle(),
                        content: print_content,
                        pageMargins: ($scope.deviceDetector.browser == 'firefox' ? 75 : 50),
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