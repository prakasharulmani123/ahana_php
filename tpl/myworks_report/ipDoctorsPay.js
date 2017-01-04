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
                text: $scope.app.name + " ( " + $scope.app.org_name + " )",
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
            var monthly_pay = $filter('groupBy')($scope.records, 'consultant_name');

            var result_count = Object.keys(monthly_pay).length;
            var index = 1;
            angular.forEach(monthly_pay, function (value, key) {
                var items = [];

                items[0] = [{text: 'S.No', style: 'header'},
                    {text: 'Patient Name', style: 'header'},
                    {text: 'UHID', style: 'header'},
                    {text: 'No.of.Visits', style: 'header'},
                    {text: 'Amount', style: 'header'}];

                var serial_no = 1;
                var total = 0;
                angular.forEach(value, function (patient_infos) {
                    var s_no_string = serial_no.toString();
                    items[serial_no] = [
                        s_no_string,
                        patient_infos.patient_name,
                        patient_infos.patient_global_int_code,
                        patient_infos.total_visit,
                        patient_infos.total_charge_amount
                    ];
                    total += parseFloat(patient_infos.total_charge_amount);
                    serial_no++;
                });
                items[serial_no] = ["", {
                        text: "Total",
                        colSpan: 3,
                        alignment: 'right',
                        style: 'header'
                    }, "", "", {
                        text: total.toString(),
                        style: 'header'
                    }];

                content.push({
                    text: 'To,'
                },
                {
                    text: key,
                    margin: [20, 10, 0, 10]
                },
                {
                    text: 'Dear Doctor,'
                },
                {
                    text: 'Thank you for your support to us for your patients.  I wish your satisfaction towards the quality of our service',
                    margin: [0, 10, 0, 10]
                },
                {
                    text: 'I hereby enclose the details and the payment due for you',
                    margin: [0, 10, 0, 10]
                },
                {
                    style: 'demoTable',
                    table: {
                        headerRows: 1,
                        widths: ['*', '*', '*', '*', '*'],
                        body: items,
                    },
                    pageBreak: (index === result_count ? '' : 'after'),
                });
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