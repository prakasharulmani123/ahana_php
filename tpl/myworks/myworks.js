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
                        }
                        else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        var
                nameList = ['Pierre', 'Pol', 'Jacques', 'Robert', 'Elisa'],
                familyName = ['Dupont', 'Germain', 'Delcourt', 'bjip', 'Menez'];

        function createRandomItem() {
            var
                    firstName = nameList[Math.floor(Math.random() * 4)],
                    lastName = familyName[Math.floor(Math.random() * 4)],
                    age = Math.floor(Math.random() * 100),
                    email = firstName + lastName + '@whatever.com',
                    balance = Math.random() * 3000;

            return{
                firstName: firstName,
                lastName: lastName,
                age: age,
                email: email,
                balance: balance
            };
        }

        $scope.rowCollection = [];
        for (var j = 0; j < 100; j++) {
            $scope.rowCollection.push(createRandomItem());
        }

//        var docDefinition = {
//            header: {text: 'Ahana', margin: 5},
//            footer: {
//                text: [
//                    {
//                        text: 'Report Genarate On : ',
//                        bold: true
//                    },
//                    '12/15/2016 12:05:11 PM'
//                ],
//                margin: 5
//            },
//            content: [
//                {
//                    text: 'To,'
//                },
//                {
//                    text: 'Dr.Jannet (Counsellor)',
//                    margin: [20, 10, 0, 10]
//                },
//                {
//                    text: 'Dear Doctor,'
//                },
//                {
//                    text: 'Thank you for your support to us for your patients.  I wish your satisfaction towards the quality of our service',
//                    margin: [0, 10, 0, 10]
//                },
//                {
//                    text: 'I hereby enclose the details and the payment due for you',
//                    margin: [0, 10, 0, 10]
//                },
//                {
//                    style: 'demoTable',
//                    table: {
//                        headerRows: 1,
//                        widths: ['*', '*', '*'],
//                        body: [
//                            [
//                                {text: 'Fruit', style: 'header'},
//                                {text: 'Quantity', style: 'header'},
//                                {text: 'Calories', style: 'header'}
//                            ],
//                            ['Apple', '100 grams', '52'],
//                            ['Apple1', '100 grams', '52'],
//                        ]
//                    },
//                    pageBreak: 'after',
//                }
//            ],
//            styles: {
//                header: {
//                    bold: true,
//                    color: '#000',
//                    fontSize: 11
//                },
//                demoTable: {
//                    color: '#666',
//                    fontSize: 10
//                }
//            }};
//
//        $scope.openPdf = function () {
//            pdfMake.createPdf(docDefinition).open();
//        };
//        $scope.downloadPdf = function () {
//            pdfMake.createPdf(docDefinition).download();
//        };
//        $scope.printPdf = function () {
//            pdfMake.createPdf(docDefinition).print();
//        };

    }]);

app.directive('stPersist', function () {
    return {
        require: '^stTable',
        link: function (scope, element, attr, ctrl) {
            var nameSpace = attr.stPersist;

            //save the table state every time it changes
            scope.$watch(function () {
                return ctrl.tableState();
            }, function (newValue, oldValue) {
                if (newValue !== oldValue) {
                    localStorage.setItem(nameSpace, JSON.stringify(newValue));
                }
            }, true);

            //fetch the table state when the directive is loaded
            if (localStorage.getItem(nameSpace)) {
                var savedState = JSON.parse(localStorage.getItem(nameSpace));
                var tableState = ctrl.tableState();

                angular.extend(tableState, savedState);
                ctrl.pipe();

            }

        }
    };
});