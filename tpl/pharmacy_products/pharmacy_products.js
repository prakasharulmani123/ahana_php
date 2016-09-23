app.controller('ProductsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$modal', '$log', '$filter', '$location', '$localStorage', 'DTOptionsBuilder', 'DTColumnBuilder', '$compile', function ($rootScope, $scope, $timeout, $http, $state, $modal, $log, $filter, $location, $localStorage, DTOptionsBuilder, DTColumnBuilder, $compile) {

        $scope.$on('HK_CREATE', function (e) {
            if ($location.path() == '/pharmacy/products') {
                $state.go('pharmacy.productAdd');
            }
        });

        $scope.$on('HK_SAVE', function (e) {
            var location_url = $location.path().split('/');
            var url = location_url[1] + '/' + location_url[2];
            var allowedPages = $.inArray(url, ['pharmacy/productAdd', 'pharmacy/productEdit']) > -1;
            if (allowedPages) {
                $timeout(function () {
                    angular.element("#save").trigger('click');
                }, 100);
            }
            e.preventDefault();
        });

        $scope.$on('HK_LIST', function (e) {
            $state.go('pharmacy.products');
        });

        $scope.$on('HK_SEARCH', function (e) {
            $('#filter').focus();
        });

        var vm = this;
        vm.persons = {};
        var token = $localStorage.user.access_token;
        vm.dtOptions = DTOptionsBuilder.newOptions()
                .withOption('ajax', {
                    // Either you specify the AjaxDataProp here
                    // dataSrc: 'data',
                    url: $rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproducts?access-token=' + token,
                    type: 'POST',
                    beforeSend: function (request) {
                        request.setRequestHeader("x-domain-path", $rootScope.clientUrl);
                    }
                })
                // or here
                .withDataProp('data')
                .withOption('processing', true)
                .withOption('serverSide', true)
                .withOption('bLengthChange', false)
                .withPaginationType('full_numbers')
                .withOption('createdRow', createdRow);
        vm.dtColumns = [
            DTColumnBuilder.newColumn('product_id').withTitle('Product ID').notVisible(),
            DTColumnBuilder.newColumn('product_name').withTitle('Product Name'),
            DTColumnBuilder.newColumn('product_code').withTitle('Product Code'),
            DTColumnBuilder.newColumn('product_type').withTitle('Product Type'),
            DTColumnBuilder.newColumn('product_brand').withTitle('Product Brand'),
            DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable().renderWith(actionsHtml)
        ];

        function createdRow(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
        }

        function actionsHtml(data, type, full, meta) {
            vm.persons[data.product_id] = data;
            return '<a class="label bg-dark" title="Edit" check-access  ui-sref="pharmacy.productEdit({id: ' + data.product_id + '})">' +
                    '   <i class="fa fa-pencil"></i>' +
                    '</a>&nbsp;&nbsp;&nbsp;' +
                    '<a class="hide" title="Delete" ng-click="removeRow(row)">' +
                    '   <i class="fa fa-trash"></i>' +
                    '</a>';
        }

        //Index Page
//        $scope.loadProductsList = function () {
//            $scope.isLoading = true;
//            // pagination set up
//            $scope.rowCollection = [];  // base collection
//            $scope.itemsByPage = 10; // No.of records per page
//            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection
//
//            // Get data's from service
//            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct')
//                    .success(function (products) {
//                        $scope.isLoading = false;
//                        $scope.rowCollection = products;
//                        $scope.displayedCollection = [].concat($scope.rowCollection);
//                    })
//                    .error(function () {
//                        $scope.errorData = "An Error has occured while loading brand!";
//                    });
//        };

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
            $scope.msg.successMessage = "";

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
                        $scope.msg.successMessage = succ_msg;
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
            $scope.msg.successMessage = "";
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
//                                    $scope.msg.successMessage = 'Brand Rep Deleted Successfully';
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
            if (purchasePackage.length > 0) {
                $scope.packing_unit = purchasePackage[0].package_unit;
            } else {
                $scope.packing_unit = 0;
                $scope.data.sales_package_id = '';
            }
        }
    }]);

app.filter('packingunitFilter', function () {
    return function (items, validate_package_unit) {
        var filtered = [];
        angular.forEach(items, function (item) {
            if (item.package_unit <= validate_package_unit) {
                filtered.push(item);
            }
        });
        return filtered;
    }
});