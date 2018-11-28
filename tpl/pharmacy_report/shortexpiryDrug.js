app.controller('purchaseReportController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

        
        $scope.initReport = function () {
            $scope.showTable = false;
            $scope.data = {};
            $scope.short_expiry_list = [{value: '1 WEEK', label: '1 Week'}, {value: '1 MONTH', label: '1 Month'}, {value: '2 MONTH', label: '2 Month'}, {value: '3 MONTH', label: '3 Month'},
            {value: '4 MONTH', label: '4 Month'}, {value: '5 MONTH', label: '5 Month'}, {value: '6 MONTH', label: '6 Month'} ];
        };
        
        //Index Page
        $scope.loadReport = function () {
            $scope.records = [];
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var data = {};
            
            if (typeof $scope.data.short_expiry !== 'undefined' && $scope.data.short_expiry != '')
                angular.extend(data, {short_expiry: $scope.data.short_expiry});
            
            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyproductbatch/shortexpiry?addtfields=expiry_report', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured";
                    });
        };
        
        $scope.clearReport = function () {
            $scope.showTable = false;
            $scope.data = {};
        }

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

        //For Print
        $scope.printHeader = function () {
            return {
                text: "Short Expiry Drug",
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
                {text: branch_name, style: 'header', colSpan: 6}, "", "", "", "", ""
            ]);
            reports.push([
                {text: 'S.No', style: 'header'},
                {text: 'Batch no', style: 'header'},
                {text: 'Product Name', style: 'header'},
                {text: 'Available Qty', style: 'header'},
                {text: 'Expiry Date', style: 'header'},
                {text: 'Product Price', style: 'header'},
            ]);

            var serial_no = 1;
            var result_count = $scope.records.length;
            var total = 0;
            angular.forEach($scope.records, function (record, key) {
                var s_no_string = serial_no.toString();
                reports.push([
                    s_no_string,
                    record.batch_no,
                    record.product.full_name,
                    record.originalQuantity,
                    moment(record.expiry_date).format('MMM YYYY'),
                    record.per_unit_price,
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
                            'Short Expiry Drug'
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
                    },{
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
                    widths: ['auto', 'auto', '*', 'auto', 'auto', 'auto'],
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
    }]);