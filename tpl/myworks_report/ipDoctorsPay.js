app.controller('ipDoctorsPay', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

        $scope.initReport = function () {
            $scope.showTable = false;
            $scope.tenants = [];
            $scope.doctors = [];
            $scope.data = {};

            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            $rootScope.commonService.GetTenantList(function (response) {
                if (response.success == true) {
                    $scope.tenants = response.tenantList;
                }
            });
            $scope.data.from = moment().format('YYYY-MM-DD');
            $scope.data.to = moment().format('YYYY-MM-DD');
        }

        $scope.clearReport = function () {
            $scope.showTable = false;
            $scope.data = {};
            $scope.data.from = moment().format('YYYY-MM-DD');
            $scope.data.to = moment().format('YYYY-MM-DD');
            $scope.data.consultant_id = '';
            $scope.data.tenant_id = '';
        }
        
        $scope.$watch('data.consultant_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                if ($scope.data.consultant_id.length == $scope.doctors.length) {
                    $timeout(function () {
                        // anything you want can go here and will safely be run on the next digest.
                        var branch_wise_button = $('button[data-id="branch_wise"]').next();
                        var branch_wise_deselect_all = branch_wise_button.find(".bs-deselect-all");
                        branch_wise_deselect_all.click();
                        $('#get_report').attr("disabled", true);
                        $scope.data.from = moment().add(-1, 'days').format('YYYY-MM-DD');
                    });
                }
            }
        }, true);

        $scope.$watch('data.tenant_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                if ($scope.data.tenant_id.length == Object.keys($scope.tenants).length) {
                    $timeout(function () {
                        // anything you want can go here and will safely be run on the next digest.
                        var consultant_wise_button = $('button[data-id="consultant_wise"]').next();
                        var consultant_wise_deselect_all = consultant_wise_button.find(".bs-deselect-all");
                        consultant_wise_deselect_all.click();
                        $('#get_report').attr("disabled", true);
                        $scope.data.from = moment().add(-1, 'days').format('YYYY-MM-DD');
                    });
                }
            }
        }, true);

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

            if (typeof $scope.data.consultant_id !== 'undefined' && $scope.data.consultant_id != '')
                angular.extend(data, {consultant_id: $scope.data.consultant_id});

            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/myworkreports/ipdoctorspay', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured";
                    });
        };

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

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }
        
        $scope.printHeader = function () {
            return {
                text: "IP Doctors Pay",
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
                    fontSize: 10
                }
            };
        }

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
                        branch_wise_total += parseFloat(record.total_charge_amount);
                        consultant_wise_total += parseFloat(record.total_charge_amount);
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
                    },
                    margin: [0, 0, 0, 20]
                });

                angular.forEach(branch_wise, function (branch, branch_name) {
                    var items = [];

                    items.push([
                        {text: branch_name, style: 'header', colSpan: 5}, "", "", "", ""
                    ]);

                    items.push([
                        {text: 'S.No', style: 'header'},
                        {text: 'Patient Name', style: 'header'},
                        {text: 'UHID', style: 'header'},
                        {text: 'No.of.Visits', style: 'header'},
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
                            record.total_visit,
                            record.total_charge_amount
                        ]);
                        total += parseFloat(record.total_charge_amount);
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
                            style: 'header'
                        }
                    ]);

                    content_info.push({
                        style: 'demoTable',
                        table: {
                            headerRows: 1,
                            widths: ['*', '*', '*', '*', '*'],
                            body: items,
                        },
                        margin: [0, 0, 0, 20],
                        pageBreak: (index === result_count ? '' : 'after'),
                    });
                });
                content.push(content_info);
                index++;
            });
            return content;
        }

        $scope.printReport = function () {
            var docDefinition = {
                header: $scope.printHeader(),
                footer: $scope.printFooter(),
                styles: $scope.printStyle(),
                content: $scope.printContent(),
                pageMargins: ($scope.deviceDetector.browser == 'firefox' ? 75 : 50),
                pageSize: 'A4',
            };
            pdfMake.createPdf(docDefinition).print();
        }

    }]);