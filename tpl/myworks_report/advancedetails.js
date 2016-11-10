app.controller('advancedetailsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter, $timeout) {

        //Index Page
        $scope.loadReport = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/myworkreports/advancedetails')
                    .success(function (advancedetails) {
                        console.log(advancedetails);
                        return false;
                        $scope.isLoading = false;
                        $scope.rowCollection = users;

                        //Avoid pagination problem, when come from other pages.
                        $scope.footable_redraw();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading users!";
                    });
        };

        $scope.printReport = function () {
            var innerContents = document.getElementById("printThisElement").innerHTML;
            var popupWinindow = window.open('', '_blank', 'width=830,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
            popupWinindow.document.open();
            popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
            popupWinindow.document.close();
        }
    }]);