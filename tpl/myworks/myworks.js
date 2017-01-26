app.controller('MyworksController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Organization Index
        $scope.loadData = function () {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/organization/getorg",
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            _that.data = response.data.return;
                        } else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        var docDefinition = {
            pageSize: {width: 4 * 72, height: 8 * 72},
            pageOrientation: 'landscape',
//            pageMargins: [40, 160, 40, 60],

            header: {text: 'Ahana', margin: 5},
            footer: {
                text: [
                    {
                        text: 'Report Genarate On : ',
                        bold: true
                    },
                    '12/15/2016 12:05:11 PM'
                ],
                margin: 5
            },
            content: [
                {
                    style: 'demoTable',
                    table: {
                        headerRows: 1,
                        widths: ['*', '*', '*', '*', '*', '*', '*', '*'],
                        body: [
                            [
                                {text: 'S.No', style: 'header'},
                                {text: 'Particulars', style: 'header'},
                                {text: 'MFR', style: 'header'},
                                {text: 'Batch', style: 'header'},
                                {text: 'Expiry', style: 'header'},
                                {text: 'Qty', style: 'header'},
                                {text: 'Rate', style: 'header'},
                                {text: 'Amount', style: 'header'},
                            ],
                            ['1', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['2', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['3', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['4', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['5', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['6', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', {text: '150.00', pageBreak: 'after'}],
                            ['7', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['8', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['9', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['10', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['11', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', {text: '150.00', pageBreak: 'after'}],
                            ['12', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['13', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['14', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                            ['15', 'Syp', 'RPG', '123456', '07/16', '5', '30.00', '150.00'],
                        ]
                    },
                }
            ],
            styles: {
                header: {
                    bold: true,
                    color: '#000',
                    fontSize: 11
                },
                demoTable: {
                    color: '#666',
                    fontSize: 10
                }
            }
        };

        $scope.openPdf = function () {
            pdfMake.createPdf(docDefinition).open();
        };
        $scope.downloadPdf = function () {
            pdfMake.createPdf(docDefinition).download();
        };
        $scope.printPdf = function () {
            pdfMake.createPdf(docDefinition).print();
        };

    }]);