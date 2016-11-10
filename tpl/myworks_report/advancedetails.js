app.controller('advancedetailsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter) {

        //Index Page
        $scope.loadReport = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/myworkreports/advancedetails')
                    .success(function (advancedetails) {
                        $scope.isLoading = false;
                        $scope.rowCollection = advancedetails;

                        //Avoid pagination problem, when come from other pages.
                        $scope.footable_redraw();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading reports!";
                    });
        };
    }]);