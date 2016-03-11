app.controller('reportController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.displayedCollection = [];
        $scope.showTable = false;

        //Index Page
        $scope.loadReport = function () {
            $scope.mode = $state.params.mode;
            
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.isLoading = true;
            
            $scope.errorData = "";
            $scope.successMessage = "";
            
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 20; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            if($state.params.mode == 'purchase'){
                url = '/pharmacypurchase/reportlist';
            }

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + url)
                    .success(function (purchase) {
                        $scope.isLoading = false;
                        $scope.records = purchase;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
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
    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});
