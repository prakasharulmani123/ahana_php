app.controller('PharmacymakepamentController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

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

        //Expand table in Index page
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.clearReport = function () {
            $scope.showTable = false;
            $scope.data = {};
            $scope.data.tenant_id = '';
            $scope.data.from = moment().format('YYYY-MM-DD');
            $scope.fromMaxDate = new Date();
            $scope.deselectAll('branch_wise');
        }

        $scope.initReport = function () {
            $scope.tenants = [];
            $rootScope.commonService.GetTenantList(function (response) {
                if (response.success == true) {
                    $scope.tenants = response.tenantList;
                }
            });
            $scope.clearReport();
        }

        $scope.deselectAll = function (type) {
            $timeout(function () {
                // anything you want can go here and will safely be run on the next digest.
                if (type == 'branch_wise') {
                    var branch_wise_button = $('button[data-id="branch_wise"]').next();
                    var branch_wise_deselect_all = branch_wise_button.find(".bs-deselect-all");
                    branch_wise_deselect_all.click();
                }
                $('#get_report').attr("disabled", true);
            });
        }

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

        //Index Page
        $scope.loadReport = function () {
            $scope.records = [];
            $scope.loadbar('show');
            $scope.loading = true;
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var data = {};
            if (typeof $scope.data.from !== 'undefined' && $scope.data.from != '')
                angular.extend(data, {from: moment($scope.data.from).format('YYYY-MM-DD')});
            if (typeof $scope.data.consultant_id !== 'undefined' && $scope.data.consultant_id != '')
                angular.extend(data, {consultant_id: $scope.data.consultant_id});
            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacysalebilling/getmakepayment', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.loading = false;
                        $scope.showTable = true;
                        $scope.records = response.report;
                        $scope.tableid = [];
                        $scope.sheet_name = [];
                        var newunique = {};
                        angular.forEach(response.report, function (item, key) {
                            if (!newunique[item.branch_name]) {
                                $scope.sheet_name.push(item.branch_name);
                                $scope.tableid.push('table_' + item.branch_name);
                                newunique[item.branch_name] = item;
                            }
                        });
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured";
                    });
        };

        //For Print
        $scope.printHeader = function () {
            return {
                text: "Pharmacy Credit Make Payment Report",
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
                    margin: [0, 0, 0, 20]
                }
            };
        }

        $scope.printloader = '';
        $scope.printContent = function () {

            var content = [];

            var date_rage = moment($scope.data.from).format('YYYY-MM-DD');
            var generated_on = $scope.generated_on;
            var generated_by = $scope.app.username;

            var branch_wise = $filter('groupBy')($scope.records, 'branch_name');
            var result_count = Object.keys(branch_wise).length;
            var index = 1;
            angular.forEach(branch_wise, function (branch, branch_name) {
                var content_info = [];
                content_info.push({
                    columns: [
                        {
                            text: [
                                {text: 'Branch Name: ', bold: true},
                                branch_name
                            ],
                            margin: [0, 0, 0, 5]
                        },
                        {
                            text: [
                                {text: 'Generated On: ', bold: true},
                                generated_on
                            ],
                            margin: [0, 0, 0, 5]
                        }
                    ]
                }, {
                    columns: [
                        {
                            text: [
                                {text: 'Date: ', bold: true},
                                date_rage
                            ],
                            margin: [0, 0, 0, 5]
                        },
                        {
                            text: [
                                {text: ' Generated By: ', bold: true},
                                generated_by
                            ],
                            margin: [0, 0, 0, 5]
                        }
                    ]
                });

                var patient_wise = $filter('groupBy')(branch, 'patient_name');

                angular.forEach(patient_wise, function (detail, patient_name) {
                    var items = [];
                    items.push([
                        {text: patient_name, style: 'header', colSpan: 5}, "", "", "", ""
                    ]);

                    items.push([
                        {text: 'S.No', style: 'header'},
                        {text: 'Bill No', style: 'header'},
                        {text: 'Bill Date', style: 'header'},
                        {text: 'Paid Date', style: 'header'},
                        {text: 'Paid Amount', style: 'header'},
                    ]);

                    var serial_no = 1;
                    var result_count = $scope.records.length;
                    var total = 0;
                    angular.forEach(detail, function (record, key) {
                        var s_no_string = serial_no.toString();
                        items.push([
                            s_no_string,
                            record.bill_no,
                            record.bill_date,
                            record.paid_date,
                            record.paid_amount,
                        ]);
                        total += parseFloat(record.paid_amount);
                        if (serial_no == result_count) {
                            $scope.printloader = '';
                        }
                        serial_no++;
                    });
                    items.push([
                        {
                            text: 'Total Pending Amount',
                            style: 'header',
                            alignment: 'right',
                            colSpan: 4
                        }, "", "", "",
                        {
                            text: total.toString(),
                            style: 'header',
                            alignment: 'right'
                        }
                    ]);
                    content_info.push({
                        style: 'demoTable',
                        table: {
                            widths: ['auto', '*', '*', '*', 'auto'],
                            headerRows: 1,
                            body: items,
                        },
                        layout: {
                            hLineWidth: function (i, node) {
                                return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                            }
                        },
                        //pageBreak: (index === result_count ? '' : 'after'),
                    });
                });
                content.push(content_info);

            });
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

        $scope.total_pending = function (a, b) {
            if (a == undefined)
                return b;
            if (a != undefined)
            {
                var total = parseFloat(a.replace(',', '')) + parseFloat(b.replace(',', ''));
                return total.toFixed(2);
            }
        }
    }]);