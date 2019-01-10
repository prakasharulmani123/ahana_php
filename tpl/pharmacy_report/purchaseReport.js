app.controller('purchaseReportController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

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
            $scope.data.from = moment().subtract(1, 'months').format('YYYY-MM-DD');
            $scope.fromMaxDate = new Date($scope.data.to);
            $scope.toMinDate = new Date($scope.data.from);
        }

        $scope.initReport = function () {
            $scope.tenants = [];
            $rootScope.commonService.GetTenantList(function (response) {
                if (response.success == true) {
                    $scope.tenants = response.tenantList;
                }
            });
            $scope.paymentTypes = [];
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
            });
            $scope.clearReport();
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
            $scope.purchase = {};
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var data = {};
            if (typeof $scope.data.from !== 'undefined' && $scope.data.from != '')
                angular.extend(data, {from: moment($scope.data.from).format('YYYY-MM-DD')});
            if (typeof $scope.data.to !== 'undefined' && $scope.data.to != '')
                angular.extend(data, {to: moment($scope.data.to).format('YYYY-MM-DD')});
            if (typeof $scope.data.payment_type !== 'undefined' && $scope.data.payment_type != '')
                angular.extend(data, {payment_type: $scope.data.payment_type});
            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyreport/purchasereport?addtfields=purchasereport', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
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
                        $scope.tableid.push('branchwise_report');
                        $scope.sheet_name.push('Branchwise Report');
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
                text: "Purchase Report",
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
            var content = [];
            var generated_on = $scope.generated_on;
            var generated_by = $scope.app.username;
            var date_rage = moment($scope.data.from).format('YYYY-MM-DD') + " - " + moment($scope.data.to).format('YYYY-MM-DD');
            var branch_name = $scope.app.org_name;
            
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
                //angular.forEach(branch, function (item) {
                var items = [];
                items.push([
                    {text: 'S.No', style: 'header'},
                    {text: 'GR no', style: 'header'},
                    {text: 'Invoice no', style: 'header'},
                    {text: 'Date Of Purchase', style: 'header'},
                    {text: 'Supplier', style: 'header'},
                    {text: 'Payment Type', style: 'header'},
                    {text: 'Purchase Value', style: 'header'},
                ]);
                var items_serial_no = 1;
                var total = 0;
                angular.forEach(branch, function (record, key) {
                    if(record.payment_type == 'CA')
                        var payment = 'Cash';
                    else
                        var payment = 'Card';
                    var s_no_string = items_serial_no.toString();
                    items.push([
                        s_no_string,
                        record.gr_num,
                        record.invoice_no,
                        moment(record.invoice_date).format('DD-MM-YYYY'),
                        record.supplier_name,
                        payment,
                        record.net_amount,
                    ]);
                    total += parseFloat(record.net_amount);
                    items_serial_no++;
                });
                items.push([
                    {
                        text: "Total",
                        colSpan: 4,
                        alignment: 'right',
                        style: 'header'
                    }, "", "", "", {
                        text: total.toString(),
                        style: 'header',
                        colSpan: 3,
                    }, "",""
                ]);
                content_info.push({
                    style: 'demoTable',
                    table: {
                        widths: ['auto', '*', '*', 'auto', '*', 'auto','auto'],
                        headerRows: 1,
                        body: items,
                    },
                    layout: {
                        hLineWidth: function (i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        }
                    },
                    pageBreak: (index === result_count ? '' : 'after'),
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
        
        $scope.nameReplace = function (a) {
            return a.replace('&', '');
        }
    }]);