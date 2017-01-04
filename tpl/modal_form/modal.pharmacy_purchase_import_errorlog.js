app.controller('PharmacyPurchaseImportController', ['$scope', '$rootScope', '$http', 'AuthenticationService', function ($scope, $rootScope, $http, AuthenticationService) {

        $scope.loadErrorLogs = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.rowCollection = [].concat($scope.rowCollection);  // displayed collection

            var currentUser = AuthenticationService.getCurrentUser();
            $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacypurchase/getimporterrorlog?tenant_id=' + currentUser.credentials.logged_tenant_id,
            }).success(
                    function (response) {
                        $scope.isLoading = false;
                        $scope.rowCollection = response.result;
                        $scope.rowCollection = [].concat($scope.rowCollection);
                    }
            ).error(function (data, status) {
                $scope.errorData = "An Error has occured while loading cities!";
            });
        }
    }]);
  