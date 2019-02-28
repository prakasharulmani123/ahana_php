app.controller('minMaxSoldQuantityController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

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
            $scope.data.tenant_id = '';
            $scope.data.to = moment().format('YYYY-MM-DD');
            $scope.data.from = moment($scope.data.to).add(-100, 'days').format('YYYY-MM-DD');
            $scope.deselectAll('branch_wise');
            $scope.fromMaxDate = new Date($scope.data.to);
            $scope.toMinDate = new Date($scope.data.from);
        }

        $scope.$watch('data.from', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.toMinDate = new Date($scope.data.from);
                var from = moment($scope.data.from);
                var to = moment($scope.data.to);
                var difference = to.diff(from, 'days') + 1;

                if (difference > 101) {
                    $scope.data.to = moment($scope.data.from).add(+100, 'days').format('YYYY-MM-DD');
                }
            }
        }, true);
        $scope.$watch('data.to', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.fromMaxDate = new Date($scope.data.to);
                var from = moment($scope.data.from);
                var to = moment($scope.data.to);
                var difference = to.diff(from, 'days') + 1;

                if (difference > 101) {
                    $scope.data.from = moment($scope.data.to).add(-100, 'days').format('YYYY-MM-DD');
                }
            }
        }, true);

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

//        $scope.initReport = function () {
//            $scope.showTable = false;
//            $scope.data = {};
//            $rootScope.commonService.GetMonth(function (response) {
//                $scope.months = response;
//            });
//            $rootScope.commonService.GetYear(function (response) {
//                $scope.years = response;
//            });
//        };

        $scope.initReport = function () {
            $scope.tenants = [];
            $rootScope.commonService.GetTenantList(function (response) {
                if (response.success == true) {
                    $scope.tenants = response.tenantList;
                }
            });
            $scope.clearReport();
        }

        //Index Page
        $scope.loadReport = function () {
            $scope.records = [];
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var data = {};
            if (typeof $scope.data.from !== 'undefined' && $scope.data.from != '')
                angular.extend(data, {from: moment($scope.data.from).format('YYYY-MM-DD')});
            if (typeof $scope.data.to !== 'undefined' && $scope.data.to != '')
                angular.extend(data, {to: moment($scope.data.to).format('YYYY-MM-DD')});
            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacysale/minmaxquantity', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
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
                text: "Sold Quantity Report",
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
            var branch_name = $scope.app.org_name;

            var reports = [];
            reports.push([
                {text: branch_name, style: 'header', colSpan: 7}, "", "", "", "", "", ""
            ]);
            reports.push([
                {text: 'S.No', style: 'header'},
                {text: 'Product Name', style: 'header'},
                {text: 'Brand Name', style: 'header'},
                {text: 'Min Quantity', style: 'header'},
                {text: 'Max Quantity', style: 'header'},
                {text: 'No Of Bills', style: 'header'},
                {text: 'Total Sale Qty', style: 'header'},
            ]);

            var serial_no = 1;
            var result_count = $scope.records.length;
            var total = 0;
            angular.forEach($scope.records, function (record, key) {
                var s_no_string = serial_no.toString();
                reports.push([
                    s_no_string,
                    record.product_name,
                    record.brand_name,
                    record.min_qty,
                    record.max_qty,
                    record.sale_count,
                    record.total_qty
                ]);
                if (serial_no == result_count) {
                    $scope.printloader = '';
                }
                serial_no++;
            });

            var content = [];
            content.push({
                columns: [
                    {
                        text: [
                            {text: 'Report Name: ', bold: true},
                            'Sold Quantity Report'
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
                            {text: ' Generated By: ', bold: true},
                            generated_by
                        ],
                        margin: [0, 0, 0, 20]
                    }, {
                        text: [
                            {text: ''},
                        ],
                        margin: [0, 0, 0, 20]
                    },
                ]
            }, {
                style: 'demoTable',
                table: {
                    headerRows: 2,
                    widths: ['auto', 150, 82, 62, 62, 42, 42],
                    body: reports,
                    dontBreakRows: true,
                },
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                    }
                }
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
            if (a) {
                return a.replace(/[&,()%]/g, '');
            } else {
                //return '-';
            }
        }
    }]);