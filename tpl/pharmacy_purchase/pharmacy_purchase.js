app.controller('PurchaseController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

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
                            $scope.loadbar('hide');
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

        $scope.updateBatchRow = function (item, model, label, key, purchaseitem) {
            $scope.purchaseitems[key].batch_id = item.batch_no;
            $scope.purchaseitems[key].expiry_date = item.expiry_date;
            
            $('#i_expiry_date_'+key).addClass('hide');
            $('#t_expiry_date_'+key).removeClass('hide');
        }
        
        $scope.updateProductRow = function (item, model, label, key) {
            $scope.purchaseitems[key].product_name = item.product_name;
            $scope.purchaseitems[key].product_id = item.product_id;
            $scope.purchaseitems[key].vat_percent = item.purchaseVat.vat;
            
            $scope.loadbar('show');
            $rootScope.commonService.GetBatchListByProduct(item.product_id, function (response) {
                $scope.batches = response.batchList;
                $scope.loadbar('hide');
            });
        }

        $scope.updateRow = function (purchaseitem, key) {
            var qty = parseFloat(purchaseitem.quantity.$modelValue);
            var rate = parseFloat(purchaseitem.purchase_rate.$modelValue);
            var disc_perc = parseFloat(purchaseitem.discount_percent.$modelValue);
            var vat_perc = parseFloat($scope.purchaseitems[key].vat_percent);
            var free_qty = parseFloat(purchaseitem.free_quantity.$modelValue);

            qty = angular.isNumber(qty) ? qty : 0;
            rate = angular.isNumber(rate) ? rate : 0;
            disc_perc = angular.isNumber(disc_perc) ? disc_perc : 0;
            vat_perc = angular.isNumber(vat_perc) ? vat_perc : 0;
            free_qty = angular.isNumber(free_qty) ? free_qty : 0;

            var purchase_amount = (qty * rate).toFixed(2);
            var disc_amount = disc_perc > 0 ? (purchase_amount * (disc_perc / 100)).toFixed(2) : 0;

            var total_amount = (purchase_amount - disc_amount).toFixed(2);
            var vat_amount = (purchase_amount * (vat_perc / 100)).toFixed(2);

            $scope.purchaseitems[key].purchase_amount = purchase_amount;
            $scope.purchaseitems[key].discount_amount = disc_amount;
            $scope.purchaseitems[key].total_amount = total_amount;
            $scope.purchaseitems[key].vat_amount = vat_amount;
            $scope.purchaseitems[key].free_quantity_unit = free_qty;

            $scope.updatePurchaseRate();
        }

        $scope.updatePurchaseRate = function () {
            var total_purchase_amount = total_discount_amount = total_vat_amount = total_amount = 0;
            var before_disc_total = after_disc_total = roundoff_amount = net_amount = 0;

            //Get Total Purchase, VAT, Discount Amount
            angular.forEach($scope.purchaseitems, function (item) {
                total_purchase_amount = total_purchase_amount + parseFloat(item.total_amount);
                total_discount_amount = total_discount_amount + parseFloat(item.discount_amount);
                total_vat_amount = total_vat_amount + parseFloat(item.vat_amount);
            });

            $scope.data.total_item_purchase_amount = total_purchase_amount.toFixed(2);
            $scope.data.total_item_vat_amount = total_vat_amount.toFixed(2);
            
            //Get Before Discount Amount (Total Purchase Amount + Total VAT)
            before_disc_total = (total_purchase_amount + total_vat_amount).toFixed(2);
            $scope.data.before_disc_total = before_disc_total;

            //Get Discount Amount
            var disc_perc = parseFloat($scope.data.discount_percent);
            disc_perc = angular.isNumber(disc_perc) ? (disc_perc).toFixed(2) : 0;
            
            var disc_amount = disc_perc > 0 ? (before_disc_total * (disc_perc / 100)).toFixed(2) : 0;
            $scope.data.discount_amount = disc_amount;
            
            after_disc_total = (parseFloat(before_disc_total) - parseFloat(disc_amount));
            $scope.data.after_disc_total = after_disc_total.toFixed(2);
            
            // Net Amount = (Total Amount - Discount Amount) +- RoundOff
            net_amount = Math.round(parseFloat(after_disc_total));
            roundoff_amount = Math.abs(net_amount - after_disc_total);
            
            $scope.data.roundoff_amount = roundoff_amount.toFixed(2);
            $scope.data.net_amount = net_amount.toFixed(2);
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

                if (angular.isObject(purchaseitem.product_name)) {
                    $scope.purchaseitems[key].product_name = purchaseitem.product_name.product_name;
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


        // editable table
        $scope.purchaseitems = [];

        // add Row
        $scope.addRow = function () {
            $scope.inserted = {
                product_name: '',
                batch_id: '',
                expiry_date: '',
                quantity: '0',
                free_quantity: '0',
                free_quantity_unit: '0',
                mrp: '0',
                purchase_rate: '0',
                discount_percent: '0',
                package_name: '',
                vat_percent: '0',
                vat_amount: '0',
                total_amount: '0',
                product_id: '',
                purchase_amount: '0'
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

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});