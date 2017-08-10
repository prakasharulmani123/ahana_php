app.controller('AuditController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.loadAllauditlog = function () {
            $scope.isLoading = true;

            $scope.maxSize = 10;     // Limit number for pagination display number.  
            $scope.totalCount = 0;  // Total number of items in all pages. initialize as a zero  
            $scope.pageIndex = 1;   // Current page number. First page is 1.-->  
            $scope.pageSizeSelected = 10; // Maximum number of items per page.

            // Get data's from service
//            $http.get($rootScope.IRISOrgServiceUrl + '/auditlog')
//                    .success(function (log) {
//                        $scope.isLoading = false;
//                        $scope.rowCollection = log;
//
//                        //Avoid pagination problem, when come from other pages.
//                        $scope.footable_redraw();
//                    })
//                    .error(function () {
//                        $scope.errorData = "An Error has occured while loading roles!";
//                    });
            $scope.rowCollection = [];  // base collection
            $scope.getAuditlist();
        };

        $scope.getAuditlist = function () {
            $http.post($rootScope.IRISOrgServiceUrl + '/auditlog/getauditlog?pageIndex=' + $scope.pageIndex + '&pageSize=' + $scope.pageSizeSelected)
                    .success(function (log) {
                        $scope.isLoading = false;
                        $scope.loadbar('hide');

                        $scope.rowCollection = log.audit;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        $scope.totalCount = log.totalCount;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        }

        $scope.pageChanged = function () {
            $scope.getAuditlist();
        };
    }]);