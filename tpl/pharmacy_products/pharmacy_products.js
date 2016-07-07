app.controller('ProductsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$modal', '$log', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $modal, $log, $filter) {

        //Index Page
        $scope.loadProductsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct')
                    .success(function (products) {
                        $scope.isLoading = false;
                        $scope.rowCollection = products;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading brand!";
                    });
        };

        //For Form
        $scope.initForm = function () {
            // Product Units list
            $rootScope.commonService.GetProductUnitsList(function (response) {
                $scope.productUnits = response;
            });

            // Product Description list
            $rootScope.commonService.GetProductDescriptionList('', '1', false, function (response) {
                $scope.productDescriptions = response.productDescriptionList;
            });

            // Brand list
            $rootScope.commonService.GetBrandsList('', '1', false, function (response) {
                $scope.brands = response.brandList;
            });

            // Division list
            $rootScope.commonService.GetDivisionsList('', '1', false, function (response) {
                $scope.divisions = response.divisionList;
            });

            // Generic list
            $rootScope.commonService.GetGenericList('', '1', false, false, function (response) {
                $scope.generics = response.genericList;
            });

            // Drug Class list
            $rootScope.commonService.GetDrugClassList('', '1', false, false, function (response) {
                $scope.drugClasses = response.drugList;
            });

            // Vat list
            $rootScope.commonService.GetVatList('', '1', false, function (response) {
                $scope.vats = response.vatList;
            });

            // Packing unit list
            $rootScope.commonService.GetPackageUnitList('', '1', false, function (response) {
                $scope.packingUnits = response.packingList;
            });

            $rootScope.commonService.GetSupplierList('', '1', false, function (response) {
                $scope.suppliers = response.supplierList;
            });

            if ($scope.data.formtype == 'add') {
                $scope.data.product_reorder_min = 0;
                $scope.data.product_reorder_max = 50;
            }
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyproducts';
                method = 'POST';
                succ_msg = 'Product saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyproducts/' + _that.data.product_id;
                method = 'PUT';
                succ_msg = 'Product updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('pharmacy.products');
                        }, 1000)

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/pharmacyproducts/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        $scope.setPackageUnit();
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.showDrugDropdown = false;
        $scope.getDrugByGeneric = function () {
            $scope.errorData = "";
            $scope.successMessage = "";
            if ($scope.data.generic_id) {
                $http({
                    url: $rootScope.IRISOrgServiceUrl + '/pharmacydrugclass/getdrugbygeneric?generic_id=' + $scope.data.generic_id,
                    method: "GET",
                }).then(
                        function (response) {
                            if (response.data.drug) {
                                $scope.data.drug_name = response.data.drug.drug_name;
                                $scope.data.drug_class_id = response.data.drug.drug_class_id;
                                $scope.showDrugDropdown = false;
                            } else {
                                $scope.data.drug_name = '';
                                $scope.data.drug_class_id = '';
                                $scope.showDrugDropdown = true;
                            }
                        }
                );
            } else {
                $scope.data.drug_name = '';
                $scope.data.drug_class_id = '';
                $scope.showDrugDropdown = false;
            }
        }

        //Delete
//        $scope.removeRow = function (row) {
//            var conf = confirm('Are you sure to delete ?');
//            if (conf) {
//                $scope.loadbar('show');
//                var index = $scope.displayedCollection.indexOf(row);
//                if (index !== -1) {
//                    $http({
//                        url: $rootScope.IRISOrgServiceUrl + "/pharmacybrandrep/remove",
//                        method: "POST",
//                        data: {id: row.brand_id}
//                    }).then(
//                            function (response) {
//                                $scope.loadbar('hide');
//                                if (response.data.success === true) {
//                                    $scope.displayedCollection.splice(index, 1);
//                                    $scope.loadBrandsList();
//                                    $scope.successMessage = 'Brand Rep Deleted Successfully';
//                                }
//                                else {
//                                    $scope.errorData = response.data.message;
//                                }
//                            }
//                    )
//                }
//            }
//        };

        $scope.open = function (size, ctrlr, tmpl, update_col) {
            var modalInstance = $modal.open({
                templateUrl: tmpl,
                controller: ctrlr,
                size: size,
                resolve: {
                    scope: function () {
                        return $scope;
                    },
                    column: function () {
                        return update_col;
                    },
                }
            });

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
        };

        $scope.setVat = function (mode) {
            if (mode == 'sale') {
                $scope.data.sales_vat_id = $scope.data.purchase_vat_id;
            } else if (mode == 'purchase') {
                $scope.data.purchase_vat_id = $scope.data.sales_vat_id;
            }
        }
        
        $scope.packing_unit = 0;
        $scope.setPackageUnit = function () {
            purchasePackage = $filter('filter')($scope.packingUnits, {package_id: $scope.data.purchase_package_id});
            $scope.packing_unit = purchasePackage[0].package_unit;
        }
    }]);

app.filter('packingunitFilter', function () {
    return function (items, validateunit) {
        var filtered = [];
        angular.forEach(items, function (item) {
            if (item.package_unit <= validateunit) {
                filtered.push(item);
            }
        });
        return filtered;
    }
});