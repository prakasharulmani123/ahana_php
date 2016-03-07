app.controller('PurchaseController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Index Page
        $scope.loadpurchaseitem = function () {
            $scope.errorData = $scope.successMessage = '';
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $scope.generics = {};
            $rootScope.commonService.GetGenericList('', '1', false, false, function (response) {
                $scope.setGenericList(response);
                // Get data's from service
                $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyPurchase')
                        .success(function (Purchases) {
                            $scope.isLoading = false;
                            $scope.rowCollection = Purchases;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured while loading Purchases!";
                        });
            });


        };

        // editable table
        $scope.purchaseitems = [];
        $scope.deletedpurchaseitems = [];

        $scope.showGeneric = function (product_id) {
            var selected = $filter('filter')($scope.generics, {value: product_id});
            return (product_id && selected.length) ? selected[0].text : 'Not set';
        };

        //For Form
        $scope.initForm = function () {
            $scope.loadbar('show');
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;

                $rootScope.commonService.GetSupplierList('', '1', false, function (response) {
                    $scope.suppliers = response.supplierList;

                    $rootScope.commonService.GetProductList('', '1', false, function (response) {
                        $scope.products = response.productList;

                        $rootScope.commonService.GetPackageUnitList('', '1', false, function (response) {
                            $scope.packings = response.packingList;
                            $scope.addRow();
                        });
                    });

                });
            });

        }

        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened1 = true;
                    break;
            }
        };

        $scope.updateProductRow = function (item, model, label, key) {
            $scope.purchaseitems[key].product_id = item.product_id;
            $scope.purchaseitems[key].vat_percent = item.purchaseVat.vat;
        }

        $scope.updateRow = function (purchaseitem, key) {
            var qty = parseFloat(purchaseitem.quantity.$modelValue);
            var rate = parseFloat(purchaseitem.purchase_rate.$modelValue);
            var disc_perc = parseFloat(purchaseitem.discount_percent.$modelValue);
            var vat_perc = parseFloat($scope.purchaseitems[key].vat_percent);
            
            qty = angular.isNumber(qty) ? qty : 0;
            rate = angular.isNumber(rate) ? rate : 0;
            disc_perc = angular.isNumber(disc_perc) ? disc_perc : 0;
            vat_perc = angular.isNumber(vat_perc) ? vat_perc : 0;
            
            var purchase_amount = (qty * rate);
            var disc_amount = disc_perc > 0 ? purchase_amount * (disc_perc / 100) : 0;
            
            var total_amount = purchase_amount - disc_amount;
            var vat_amount = purchase_amount * (vat_perc / 100);
            
            $scope.purchaseitems[key].purchase_amount = purchase_amount;
            $scope.purchaseitems[key].discount_amount = disc_amount;
            $scope.purchaseitems[key].total_amount = total_amount;
            $scope.purchaseitems[key].vat_amount = vat_amount;
        }

        $scope.formatLabel = function (model) {
            for (var i = 0; i < $scope.products.length; i++) {
                if (model === $scope.products[i].value) {
                    return $scope.products[i].text;
                }
            }
        };

        $scope.getGenericList = function (response) {
            $rootScope.commonService.GetGenericList('', '1', false, true, function (response) {
                $scope.setGenericList(response);
            });
        }

        $scope.setGenericList = function (response) {
            $scope.generics = [];

            angular.forEach(response.genericList, function (generic) {
                $scope.generics.push({'value': generic.product_id, 'text': generic.generic_name});
            });
        }

        $scope.checkInput = function (data, id) {
            if (data == '') {
                return "Field should not be empty.";
            }
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            angular.forEach($scope.purchaseitems, function (purchaseitem, key) {
                $scope.purchaseitems[key].expiry_date = moment(purchaseitem.expiry_date).format('YYYY-MM-DD HH:mm:ss');
                
                if(typeof purchaseitem.product !== 'undefined'){
                    alert('asdad');
                    $scope.purchaseitems[key].product_id = purchaseitem.product.product_id;
                }
            })
            angular.extend(_that.data, {product_items: $scope.purchaseitems});
            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacypurchase/savepurchase',
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        if (response.success == true) {
                            $scope.loadbar('hide');
                            $scope.successMessage = 'Drug class assigned successfully';
                            $scope.data = {};
                            $timeout(function () {
                                $state.go('pharmacy.Purchase');
                            }, 1000)
                        } else {
                            $scope.loadbar('hide');
                            $scope.errorData = response.message;
                        }

                        return false;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };


        // add Row
        $scope.addRow = function () {
            $scope.inserted = {
                product_id: '',
                batch_id: '',
                expiry_date: '',
                quantity: '0',
                free_quantity: '0',
                mrp: '0',
                purchase_rate: '0',
                discount_percent: '0',
                package_name: '',
                vat_percent: '0',
                vat_amount: '0',
                total_amount: '0',
            };
            $scope.purchaseitems.push($scope.inserted);
        };

        // remove Row
        $scope.removeSubcat = function (index, id) {
            if (id != '')
                $scope.deletedpurchaseitems.push(id);
            $scope.purchaseitems.splice(index, 1);
        };

        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };
    }]);
