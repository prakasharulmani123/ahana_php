app.controller('PurchaseReturnController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Index Page
        $scope.loadPurchaseReturnItemList = function () {
            $scope.errorData = $scope.successMessage = '';
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacypurchasereturn')
                    .success(function (purchasereturnList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = purchasereturnList;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading purchasereturnList!";
                    });


        };

        //For Form
        $scope.initForm = function () {
            $scope.loadbar('show');
            $rootScope.commonService.GetSupplierList('', '1', false, function (response) {
                $scope.suppliers = response.supplierList;

                if ($scope.data.formtype == 'update') {
                    $scope.loadForm();
                } else {
                    $scope.data.invoice_date = moment().format('YYYY-MM-DD');
                    $scope.addRow();
                }
                $scope.products = [];
                $scope.batches = [];
                $scope.packings = response.packingList;
                $scope.loadbar('hide');

            });
        }

        var changeTimer = false;

        $scope.getProduct = function (purchasereturnitem) {
            var name = purchasereturnitem.full_name.$viewValue;
            if (changeTimer !== false)
                clearTimeout(changeTimer);

            changeTimer = setTimeout(function () {
                $scope.loadbar('show');
                $rootScope.commonService.GetProductListByName(name, function (response) {
                    if (response.productList.length > 0)
                        $scope.products = response.productList;
                    $scope.loadbar('hide');
                });
                changeTimer = false;
            }, 300);
        }

        // editable table
        $scope.purchasereturnitems = [];

        // add Row
        $scope.addRow = function () {
            $scope.inserted = {
                full_name: '',
                batch_details: '',
                quantity: '0',
                free_quantity: '0',
                free_quantity_unit: '0',
                purchase_ret_rate: '0',
                discount_percent: '0',
                discount_amount: '0',
                vat_percent: '0',
                vat_amount: '0',
                total_amount: '0',
                product_id: '',
                purchase_ret_amount: '0',
                batch_no: '0',
            };
            $scope.purchasereturnitems.push($scope.inserted);

            if ($scope.purchasereturnitems.length > 1) {
                $timeout(function () {
                    $scope.setFocus('full_name', $scope.purchasereturnitems.length - 1);
                });
            }
        };

        $scope.setFocus = function (id, index) {
            angular.element(document.querySelectorAll("#" + id))[index].focus();
        };

        // remove Row
        $scope.removeSubcat = function (index) {
            if ($scope.purchasereturnitems.length == 1) {
                alert('Can\'t Delete. PurchaseReturn Item must be atleast one.');
                return false;
            }
            $scope.purchasereturnitems.splice(index, 1);
            $scope.updatePurchaseReturnRate();
            $timeout(function () {
                $scope.setFocus('full_name', $scope.purchasereturnitems.length - 1);
            });
        };

        $scope.checkInput = function (data) {
            if (!data) {
                return "Field should not be empty.";
            }
        };

        $scope.checkAmount = function (data) {
            if (data <= 0) {
                return "Value should not be 0.";
            }
        };

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

        $scope.updateBatchRow = function (item, model, label, key) {
            $scope.purchasereturnitems[key].batch_no = item.batch_no;
            $scope.purchasereturnitems[key].expiry_date = item.expiry_date;
            $scope.purchasereturnitems[key].mrp = item.mrp;
            $scope.purchasereturnitems[key].package_name = item.product.purchasePackageName;

        }

        $scope.updateProductRow = function (item, model, label, key) {
            $scope.purchasereturnitems[key].product_id = item.product_id;
            $scope.purchasereturnitems[key].vat_percent = item.purchaseVat.vat;
            $scope.purchasereturnitems[key].package_name = item.purchasePackageName;
            $scope.purchasereturnitems[key].purchase_ret_rate = item.product_price;

            $scope.loadbar('show');
            $scope.updateRow(key);
            $rootScope.commonService.GetBatchListByProduct(item.product_id, function (response) {
                $scope.loadbar('hide');
                $scope.batches = response.batchList;

                $scope.purchasereturnitems[key].batch_no = '';
                $scope.purchasereturnitems[key].expiry_date = '';
                $scope.purchasereturnitems[key].mrp = 0;
                $scope.purchasereturnitems[key].quantity = 0;
                $scope.purchasereturnitems[key].free_quantity = 0;
                $scope.purchasereturnitems[key].free_quantity_unit = 0;
                $scope.purchasereturnitems[key].purchase_ret_rate = 0;
                $scope.purchasereturnitems[key].discount_percent = 0;

            });
        }

        $scope.showOrHideProductBatch = function (mode, key) {
            if (mode == 'hide') {
                i_addclass = t_removeclass = 'hide';
                i_removeclass = t_addclass = '';
            } else {
                i_addclass = t_removeclass = '';
                i_removeclass = t_addclass = 'hide';
            }
            $('#i_full_name_' + key).addClass(i_addclass).removeClass(i_removeclass);
            $('#i_batch_details_' + key).addClass(i_addclass).removeClass(i_removeclass);

            $('#t_full_name_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_batch_details_' + key).addClass(t_addclass).removeClass(t_removeclass);
        }

        $scope.updateColumn = function ($data, key, column) {
            $scope.purchasereturnitems[key][column] = $data;

            $scope.updateRow(key);
        }

        $scope.updateRow = function (key) {
            //Get Data
            var qty = parseFloat($scope.purchasereturnitems[key].quantity);
            var rate = parseFloat($scope.purchasereturnitems[key].purchase_ret_rate);
            var disc_perc = parseFloat($scope.purchasereturnitems[key].discount_percent);
            var vat_perc = parseFloat($scope.purchasereturnitems[key].vat_percent);
            var free_qty = parseFloat($scope.purchasereturnitems[key].free_quantity);

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            rate = !isNaN(rate) ? rate : 0;
            disc_perc = !isNaN(disc_perc) ? disc_perc : 0;
            vat_perc = !isNaN(vat_perc) ? vat_perc : 0;
            free_qty = !isNaN(free_qty) ? free_qty : 0;

            var purchase_ret_amount = (qty * rate).toFixed(2);
            var disc_amount = disc_perc > 0 ? (purchase_ret_amount * (disc_perc / 100)).toFixed(2) : 0;

            var total_amount = (purchase_ret_amount - disc_amount).toFixed(2);
            var vat_amount = (purchase_ret_amount * (vat_perc / 100)).toFixed(2);

            $scope.purchasereturnitems[key].purchase_ret_amount = purchase_ret_amount;
            $scope.purchasereturnitems[key].discount_amount = disc_amount;
            $scope.purchasereturnitems[key].total_amount = total_amount;
            $scope.purchasereturnitems[key].vat_amount = vat_amount;
            $scope.purchasereturnitems[key].free_quantity_unit = free_qty;

            $scope.updatePurchaseReturnRate();
        }

        $scope.updatePurchaseReturnRate = function () {
            var total_purchase_ret_amount = total_discount_amount = total_vat_amount = total_amount = 0;
            var before_disc_amount = after_disc_amount = roundoff_amount = net_amount = 0;

            //Get Total PurchaseReturn, VAT, Discount Amount
            angular.forEach($scope.purchasereturnitems, function (item) {
                total_purchase_ret_amount = total_purchase_ret_amount + parseFloat(item.total_amount);
                total_discount_amount = total_discount_amount + parseFloat(item.discount_amount);
                total_vat_amount = total_vat_amount + parseFloat(item.vat_amount);
            });

            $scope.data.total_item_purchase_ret_amount = total_purchase_ret_amount.toFixed(2);
            $scope.data.total_item_discount_amount = total_discount_amount.toFixed(2);
            $scope.data.total_item_vat_amount = total_vat_amount.toFixed(2);

            //Get Before Discount Amount (Total PurchaseReturn Amount + Total VAT)
            before_disc_amount = (total_purchase_ret_amount + total_vat_amount).toFixed(2);
            $scope.data.before_disc_amount = before_disc_amount;

            //Get Discount Amount
            var disc_perc = parseFloat($scope.data.discount_percent);
            disc_perc = !isNaN(disc_perc) ? (disc_perc).toFixed(2) : 0;

            var disc_amount = disc_perc > 0 ? (total_purchase_ret_amount * (disc_perc / 100)).toFixed(2) : 0;
            $scope.data.discount_amount = disc_amount;

            after_disc_amount = (parseFloat(before_disc_amount) - parseFloat(disc_amount));
            $scope.data.after_disc_amount = after_disc_amount.toFixed(2);

            // Net Amount = (Total Amount - Discount Amount) +- RoundOff
            net_amount = Math.round(parseFloat(after_disc_amount));
            roundoff_amount = Math.abs(net_amount - after_disc_amount);

            $scope.data.roundoff_amount = roundoff_amount.toFixed(2);
            $scope.data.net_amount = net_amount.toFixed(2);
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.data.invoice_date = moment($scope.data.invoice_date).format('YYYY-MM-DD');

            angular.forEach($scope.purchasereturnitems, function (purchasereturnitem, key) {

                if (angular.isObject(purchasereturnitem.full_name)) {
                    $scope.purchasereturnitems[key].full_name = purchasereturnitem.full_name.full_name;
                } else if (typeof purchasereturnitem.full_name == 'undefined') {
                    $scope.purchasereturnitems[key].product_id = '';
                }

                if (angular.isObject(purchasereturnitem.batch_details)) {
                    $scope.purchasereturnitems[key].batch_details = purchasereturnitem.batch_details.batch_details;
                } else if (typeof purchasereturnitem.batch_details == 'undefined') {
                    $scope.purchasereturnitems[key].batch_no = '';
                } else if ((purchasereturnitem.batch_no == '0' || purchasereturnitem.batch_no == '') && typeof purchasereturnitem.batch_details !== 'undefined') {
                    $scope.purchasereturnitems[key].batch_no = purchasereturnitem.batch_details;
                }
            });

            angular.extend(_that.data, {product_items: $scope.purchasereturnitems});
            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacypurchasereturn/savepurchasereturn',
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        if (response.success == true) {
                            $scope.loadbar('hide');
                            $scope.successMessage = 'PurchaseReturn Saved successfully';
                            $scope.data = {};
                            $timeout(function () {
                                $state.go('pharmacy.purchaseReturn');
                            }, 1000)
                        } else {
                            $scope.loadbar('hide');
                            $scope.errorData = response.message;
                        }

                        return false;
                    }
            ).error(function (data, status) {
                $anchorScroll();
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
                url: $rootScope.IRISOrgServiceUrl + "/pharmacypurchasereturns/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {

                        $rootScope.commonService.GetProductList('', '1', false, function (response2) {
                            $scope.loadbar('hide');

                            $scope.data = response;
                            $scope.products = response2.productList;

                            $scope.purchasereturnitems = response.items;
                            angular.forEach($scope.purchasereturnitems, function (item, key) {
                                angular.extend($scope.purchasereturnitems[key], {full_name: item.product.full_name, batch_no: item.batch.batch_no, batch_details: item.batch.batch_details, expiry_date: item.batch.expiry_date});
                                $timeout(function () {
                                    $scope.showOrHideProductBatch('hide', key);
                                });
                            });

                            $timeout(function () {
                                delete $scope.data.supplier;
                                delete $scope.data.items;
                            }, 3000);
                        });
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});