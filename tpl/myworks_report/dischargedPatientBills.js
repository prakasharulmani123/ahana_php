app.controller('dischargedPatientBillsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter) {
        
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
            $scope.isLoading = true;
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
            $http.post($rootScope.IRISOrgServiceUrl + '/myworkreports/dischargedpatientbills', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response;
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
        
        $scope.printHeader = function () {
            return {
                text: "Discharged Patient Bills",
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
            var generated_on = $scope.generated_on;
            var generated_by = $scope.app.username;
            var date_rage = moment($scope.data.from).format('YYYY-MM-DD') + " - " + moment($scope.data.to).format('YYYY-MM-DD');

            var content = [];
            var branch_wise = $filter('groupBy')($scope.records, 'branch_name');

            var result_count = Object.keys(branch_wise).length;
            var index = 1;
            angular.forEach(branch_wise, function (details, branch_name) {
                var content_info = [];

                var branches = [];
                branches.push([
                    {text: branch_name, style: 'header', colSpan: 10}, "", "", "", "", "", "", "", "", ""
                ]);

                branches.push([
                    {text: 'S.No', style: 'header'},
                    {text: 'Bill No', style: 'header'},
                    {text: 'UHID', style: 'header'},
                    {text: 'Patient Name', style: 'header'},
                    {text: 'Admission Date', style: 'header'},
                    {text: 'Discharge Date', style: 'header'},
                    {text: 'Room', style: 'header'},
                    {text: 'Consultant', style: 'header'},
                    {text: 'Charges', style: 'header'},
                    {text: 'Due', style: 'header'}
                ]);

                var serial_no = 1;
                angular.forEach(details, function (row, key) {
                    var s_no_string = serial_no.toString();
                    branches.push([
                        s_no_string,
                        row.bill_no,
                        row.apptPatientData.patient_global_int_code,
                        row.apptPatientData.fullname,
                        row.encounter_date,
                        row.clinical_discharge_date,
                        row.apptPatientData.current_room,
                        row.patient.consultant_name,
                        (row.viewChargeCalculation.total_charge - row.viewChargeCalculation.total_concession).toString(),
                        row.viewChargeCalculation.balance.toString(),
                    ]);
                    serial_no++;
                });

                content_info.push({
                    columns: [
                        {
                            text: [
                                {text: 'Report Name: ', bold: true},
                                'Discharged Patient Bills'
                            ],
                            margin: [0, 0, 0, 20]
                        },
                        {
                            text: [
                                {text: 'Generated On: ', bold: true},
                                generated_on
                            ],
                            margin: [0, 0, 0, 20]
                        }
                        
                    ]
                },{
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
                        headerRows: 1,
                        widths: ['*', '*','*', '*','*', '*','*', '*','*', '*'],
                        body: branches,
                    },
                    pageBreak: (index === result_count ? '' : 'after'),
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
                pageOrientation: 'landscape',
            };
            pdfMake.createPdf(docDefinition).print();
        }
    }]);