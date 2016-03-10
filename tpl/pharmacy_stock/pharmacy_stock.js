app.controller('stockController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.initForm = function () {
            $scope.searchByLists = [{'value': 'pha_product.product_name', 'label': 'Product Name'}, {'value': 'pha_product.product_code', 'label': 'Product Code'}, {'value': 'available_qty', 'label': 'Available'}, {'value': 'batch_no', 'label': 'Batch No'}];
            $scope.searchTypes = [{'value': 'B', 'label': 'Begin With'}, {'value': 'C', 'label': 'Content With'}, {'value': 'E', 'label': 'End With'}];
        }


        $scope.displayedCollection = [];
        $scope.showTable = false;

        //Index Page
        $scope.loadStockList = function () {
            $scope.loadbar('show');
            $scope.showTable = true;
            $scope.isLoading = true;
            
            $scope.errorData = "";
            $scope.successMessage = "";
            
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 20; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/searchbycriteria', $scope.data)
                    .success(function (products) {
                        $scope.isLoading = false;
                        $scope.loadbar('hide');
                        angular.forEach(products.productLists, function (product, key) {
                            angular.extend(products.productLists[key], {add_stock: 0});
                        });
                        $scope.rowCollection = products.productLists;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        };

        $scope.adjustStock = function ($data, batch_id, key) {
            $scope.loadbar('show');
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/adjuststock', {'batch_id': batch_id, 'adjust_qty': $data})
                    .success(function (response) {
                        $scope.loadbar('hide');
                        if (response.success === true) {
                            $scope.successMessage = 'Stock Adjusted successfully';
                            $scope.displayedCollection[key].available_qty = response.batch.available_qty;
                            $scope.displayedCollection[key].add_stock = 0;
                        } else {
                            $scope.errorData = response.message;
                        }
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        }

        $scope.checkInput = function (data) {
            if (data == '' || data == 0) {
                return "Field should not be empty.";
            }
        };
    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});
