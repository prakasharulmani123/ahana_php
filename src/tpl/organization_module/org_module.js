app.controller('OrganizationModulesController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', function ($rootScope, $scope, $timeout, $http, $state, toaster) {

        //Index Page
        $scope.loadOrganizationModulesList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/organization/getorgmodules')
                    .success(function (response) {
                        $scope.rowCollection = response.modules;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roles!";
                    });
        };


    }]);