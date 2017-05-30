app.controller('opdoctorpayController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

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
            $scope.data.consultant_id = '';
            $scope.data.tenant_id = '';
            $scope.data.to = moment().format('YYYY-MM-DD');
            $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
            $scope.fromMaxDate = new Date($scope.data.to);
            $scope.toMinDate = new Date($scope.data.from);
            $scope.deselectAll('branch_wise');
            $scope.deselectAll('consultant_wise');
        }

        $scope.initReport = function () {
            $scope.doctors = [];
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });

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
                } else if (type == 'consultant_wise') {
                    var consultant_wise_button = $('button[data-id="consultant_wise"]').next();
                    var consultant_wise_deselect_all = consultant_wise_button.find(".bs-deselect-all");
                    consultant_wise_deselect_all.click();
                }
                $('#get_report').attr("disabled", true);
            });
        }

        $scope.$watch('data.from', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.toMinDate = new Date($scope.data.from);

                if (angular.isDefined($scope.data.consultant_id)) {
                    if ($scope.data.consultant_id.length == $scope.doctors.length) {
                        $scope.data.to = moment($scope.data.from).add(+1, 'days').format('YYYY-MM-DD');
                    } else if ($scope.data.consultant_id.length > 2 && (angular.isUndefined($scope.data.tenant_id) || $scope.data.tenant_id.length != Object.keys($scope.tenants).length)) {
                        $scope.data.to = moment($scope.data.from).add(+6, 'days').format('YYYY-MM-DD');
                    }
                }

                if (angular.isDefined($scope.data.tenant_id)) {
                    if ($scope.data.tenant_id.length == Object.keys($scope.tenants).length) {
                        $scope.data.to = moment($scope.data.from).add(+1, 'days').format('YYYY-MM-DD');
                    } else if ($scope.data.tenant_id.length > 2 && (angular.isUndefined($scope.data.consultant_id) || $scope.data.consultant_id.length != $scope.doctors.length)) {
                        $scope.data.to = moment($scope.data.from).add(+6, 'days').format('YYYY-MM-DD');
                    }
                }
            }
        }, true);
        $scope.$watch('data.to', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.fromMaxDate = new Date($scope.data.to);

                if (angular.isDefined($scope.data.consultant_id)) {
                    if ($scope.data.consultant_id.length == $scope.doctors.length) {
                        $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
                    } else if ($scope.data.consultant_id.length > 2 && (angular.isUndefined($scope.data.tenant_id) || $scope.data.tenant_id.length != Object.keys($scope.tenants).length)) {
                        $scope.data.from = moment($scope.data.to).add(-6, 'days').format('YYYY-MM-DD');
                    }
                }

                if (angular.isDefined($scope.data.tenant_id)) {
                    if ($scope.data.tenant_id.length == Object.keys($scope.tenants).length) {
                        $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
                    } else if ($scope.data.tenant_id.length > 2 && (angular.isUndefined($scope.data.consultant_id) || $scope.data.consultant_id.length != $scope.doctors.length)) {
                        $scope.data.from = moment($scope.data.to).add(-6, 'days').format('YYYY-MM-DD');
                    }
                }
            }
        }, true);
        $scope.$watch('data.consultant_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                if ($scope.data.consultant_id.length == $scope.doctors.length) {
                    $timeout(function () {
                        $scope.deselectAll('branch_wise');
                        $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
                    });
                } else if ($scope.data.consultant_id.length > 2 && (angular.isUndefined($scope.data.tenant_id) || $scope.data.tenant_id.length != Object.keys($scope.tenants).length)) {
                    $scope.data.from = moment($scope.data.to).add(-6, 'days').format('YYYY-MM-DD');
                }
            }
        }, true);
        $scope.$watch('data.tenant_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                if ($scope.data.tenant_id.length == Object.keys($scope.tenants).length) {
                    $timeout(function () {
                        $scope.deselectAll('consultant_wise');
                        $scope.data.from = moment($scope.data.to).add(-1, 'days').format('YYYY-MM-DD');
                    });
                } else if ($scope.data.tenant_id.length > 2 && (angular.isUndefined($scope.data.consultant_id) || $scope.data.consultant_id.length != $scope.doctors.length)) {
                    $scope.data.from = moment($scope.data.to).add(-6, 'days').format('YYYY-MM-DD');
                }
            }
        }, true);

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
            if (typeof $scope.data.to !== 'undefined' && $scope.data.to != '')
                angular.extend(data, {to: moment($scope.data.to).format('YYYY-MM-DD')});
            if (typeof $scope.data.consultant_id !== 'undefined' && $scope.data.consultant_id != '')
                angular.extend(data, {consultant_id: $scope.data.consultant_id});
            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});
            
            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/myworkreports/opdoctorpaymentreport', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.loading = false;
                        $scope.showTable = true;
                        $scope.records = response.report;
                        $scope.tableid = [];
                        $scope.sheet_name = [];
                        angular.forEach(response.sheetname, function (item, key) {
                            $scope.tableid.push('table_' + item.consultant_id);
                            $scope.sheet_name.push(item.consultant_name);
                        });
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
                text: "OP Payments",
                margin: 5,
                alignment: 'center'
            };
        }

        $scope.printFooter = function () {
            return {
                text: [
                    {
                        text: 'Report Genarate On : ',
                        bold: true
                    },
                    moment().format('YYYY-MM-DD HH:mm:ss')
                ],
                margin: 5
            };
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
            var consultant_wise = $filter('groupBy')($scope.records, 'consultant_name');
            var result_count = Object.keys(consultant_wise).length;
            var index = 1;
            angular.forEach(consultant_wise, function (details, doctor_name) {
                var content_info = [];
                var date_rage = moment($scope.data.from).format('YYYY-MM-DD') + " - " + moment($scope.data.to).format('YYYY-MM-DD');
                var generated_on = $scope.generated_on;
                var generated_by = $scope.app.username;
                var consultant_wise_total = 0;
                //Branchwise
                var branch_wise = $filter('groupBy')(details, 'branch_name');
                var branches = [];
                branches.push(
                        [{text: 'Branches', alignment: 'center', style: 'header', colSpan: 2}, ""],
                        [{text: 'Branch Name', style: 'header'}, {text: 'Amount', style: 'header'}]
                        );
                angular.forEach(branch_wise, function (branch, branch_name) {
                    var branch_wise_total = 0;
                    angular.forEach(branch, function (record, key) {
                        branch_wise_total += parseFloat(record.payment_amount);
                        consultant_wise_total += parseFloat(record.payment_amount);
                    });
                    var branch_total = branch_wise_total.toString();
                    branches.push([
                        {text: branch_name},
                        {text: branch_total, alignment: 'right'}
                    ]);
                });
                branches.push([
                    {
                        text: 'Total',
                        style: 'header',
                        alignment: 'right'
                    },
                    {
                        text: consultant_wise_total.toString(),
                        style: 'header',
                        alignment: 'right'
                    }
                ]);
                content_info.push({
                    columns: [
                        {
                            text: [
                                {text: 'Name of the Doctor: ', bold: true},
                                doctor_name
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
                                {text: 'Date Range: ', bold: true},
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
                }, {
                    text: [
                        {text: 'Total Amount: ', bold: true},
                        consultant_wise_total.toString()
                    ],
                    margin: [0, 0, 0, 5]
                }, {
                    style: 'demoTable',
                    table: {
                        headerRows: 1,
                        widths: ['*', '*'],
                        body: branches,
                    }
                });
                angular.forEach(branch_wise, function (branch, branch_name) {
                    var items = [];
                    items.push([
                        {text: branch_name, style: 'header', colSpan: 6}, "", "", "", "", ""
                    ]);
                    items.push([
                        {text: 'S.No', style: 'header'},
                        {text: 'Patient Name', style: 'header'},
                        {text: 'UHID', style: 'header'},
                        {text: 'Mobile', style: 'header'},
                        {text: 'Seen On', style: 'header'},
                        {text: 'Amount', style: 'header'}
                    ]);
                    var items_serial_no = 1;
                    var total = 0;
                    angular.forEach(branch, function (record, key) {
                        var s_no_string = items_serial_no.toString();
                        items.push([
                            s_no_string,
                            record.patient_name,
                            record.patient_global_int_code,
                            record.patient_mobile,
                            record.op_seen_date_time,
                            record.payment_amount
                        ]);
                        total += parseFloat(record.payment_amount);
                        items_serial_no++;
                    });
                    items.push([
                        {
                            text: "Total",
                            colSpan: 5,
                            alignment: 'right',
                            style: 'header'
                        }, "", "", "", "", {
                            text: total.toString(),
                            style: 'header'
                        }
                    ]);
                    content_info.push({
                        style: 'demoTable',
                        table: {
                            widths: [40, '*', '*', 'auto', '*', 'auto'],
                            headerRows: 2,
                            dontBreakRows: true,
                            body: items,
                        },
                        layout: {
                            hLineWidth: function (i, node) {
                                return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                            }
                        },
                        pageBreak: (index === result_count ? '' : 'after'),
                    });
                });
                content.push(content_info);
                if (index == result_count) {
                    $scope.printloader = '';
                }
                index++;
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
        
                $scope.tablesToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,'
                    , tmplWorkbookXML = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
                    + '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
                    + '<Styles>'
                    + '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
                    + '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
                    + '<Style ss:ID="Bold"><Font ss:Bold="1"></Font></Style>'
                    + '</Styles>'
                    + '{worksheets}</Workbook>'
                    , tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>'
                    , tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>'
                    , base64 = function (s) {
                        return window.btoa(unescape(encodeURIComponent(s)))
                    }
            , format = function (s, c) {
                return s.replace(/{(\w+)}/g, function (m, p) {
                    return c[p];
                })
            }
            return function (tabless, wsnames, wbname, appname) {
                var ctx = "";
                var workbookXML = "";
                var worksheetsXML = "";
                var rowsXML = "";

                for (var i = 0; i < tabless.length; i++) {

                    var particularDiv = document.getElementById(tabless[i]);

                    if (particularDiv) {
                        var allTables = particularDiv.getElementsByTagName('table').length;
                        tables = [];
                        for (var x = 0; x < allTables; x++) {
                            tables[i] = document.getElementById(tabless[i]).getElementsByTagName('table')[x];
                            for (var j = 0; j < tables[i].rows.length; j++) {
                                rowsXML += '<Row>'
                                for (var k = 0; k < tables[i].rows[j].cells.length; k++) {
                                    var dataType = tables[i].rows[j].cells[k].getAttribute("data-type");
                                    var dataStyle = tables[i].rows[j].cells[k].getAttribute("data-style");
                                    var dataValue = tables[i].rows[j].cells[k].getAttribute("data-value");
                                    //var dataTagvalue = (dataValue) ? dataValue : tables[i].rows[j].cells[k];
                                    dataValue = (dataValue) ? dataValue : tables[i].rows[j].cells[k].innerText;
                                    
                                   // if(dataTagvalue === '<th>') dataStyle = 'Bold'; else dataStyle = 'Boldss';
                                    
                                    var dataFormula = tables[i].rows[j].cells[k].getAttribute("data-formula");
                                    dataFormula = (dataFormula) ? dataFormula : (appname == 'Calc' && dataType == 'DateTime') ? dataValue : null;
                                    ctx = {attributeStyleID: (dataStyle == 'Currency' || dataStyle == 'Date') ? ' ss:StyleID="' + dataStyle + '"' : ''
                                        , nameType: (dataType == 'Number' || dataType == 'DateTime' || dataType == 'Boolean' || dataType == 'Error') ? dataType : 'String'
                                        , data: (dataFormula) ? '' : dataValue
                                        , attributeFormula: (dataFormula) ? ' ss:Formula="' + dataFormula + '"' : ''
                                    };
                                    rowsXML += format(tmplCellXML, ctx);
                                }
                                rowsXML += '</Row>'
                            }
                        }
                    }
                    ctx = {rows: rowsXML, nameWS: wsnames[i] || 'Sheet' + i};
                    worksheetsXML += format(tmplWorksheetXML, ctx);
                    rowsXML = "";
                }
                    
                ctx = {created: (new Date()).getTime(), worksheets: worksheetsXML};
                workbookXML = format(tmplWorkbookXML, ctx);

                var link = document.createElement("A");
                link.href = uri + base64(workbookXML);
                link.download = wbname || 'Workbook.xls';
                link.target = '_blank';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }
        })();
    }]);