app.controller('AuditController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.loadAllauditlog = function () {
            $scope.report_menu =false;
            $scope.log_status = 'grid';
            $scope.date = '';
            $scope.isLoading = true;

            $scope.maxSize = 10;     // Limit number for pagination display number.  
            $scope.totalCount = 0;  // Total number of items in all pages. initialize as a zero  
            $scope.pageIndex = 1;   // Current page number. First page is 1.-->  
            $scope.pageSizeSelected = 10; // Maximum number of items per page.

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

        //Audit Log Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened':
                    $scope.opened = true;
                    break;
            }
        };

        $scope.getReport = function () {
            $scope.isLoading = true;
            $scope.loadbar('show');
            $scope.log_status = 'report';
            $http.post($rootScope.IRISOrgServiceUrl + '/auditlog/getreport?date=' + moment($scope.date).format('YYYY-MM-DD'))
                    .success(function (log) {
                        $scope.isLoading = false;
                        $scope.loadbar('hide');
                        $scope.records = log.records;
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        };

        $scope.clearReport = function () {
             $scope.report_menu = false;
            $scope.log_status = 'grid';
            $scope.date = '';
            $scope.getAuditlist();
        };
        
        $scope.$watch('date', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.report_menu=true;
            }
        }, true);
    }]);