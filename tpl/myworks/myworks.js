app.controller('MyworksController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        var docDefinition = {
            header: {text: 'simple text', margin: 5},
            footer: {
                columns: [
                    'Left part',
                    {text: 'Right part', alignment: 'center'}
                ],
                margin: 5
            },
            content: [
                {
                    text: 'Fruits and Calories'
                },
                {
                    style: 'demoTable',
                    table: {
                        headerRows: 1,
                        widths: ['*', '*', '*'],
                        body: [
                            [
                                {text: 'Fruit', style: 'header'},
                                {text: 'Quantity', style: 'header'},
                                {text: 'Calories', style: 'header'}
                            ],
                            ['Apple', '100 grams', '52'],
                            ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'], ['Bananas', '100 grams', '89'],
                            ['Guava', '100 grams', '68'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33'],
                            ['Lemon', '100 grams', '29'],
                            ['Mangos', '100 grams', '60'],
                            ['Orange', '100 grams', '47'],
                            ['Strawberries', '100 grams', '33']
                        ]
                    }
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
                        }
                        else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

    }]);