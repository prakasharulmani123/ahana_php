app.controller('PurchaseMakePaymentController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', '$filter', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state, $filter) {

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };
        
        $scope.maxDate = new Date();
        
        purchase = $modalInstance.data.purchase;

        var bill_amount = purchase.net_amount;
        var paid = purchase.billings_total_paid_amount;
        var balance = purchase.billings_total_balance_amount;
        var purchase_payment_type = purchase.payment_type;
        var paid_date = moment().format('YYYY-MM-DD');

        $scope.bill_amount = bill_amount;
        $scope.paid = paid;
        $scope.balance = balance;
        $scope.purchase_payment_type = purchase_payment_type;
        $scope.paid_date = paid_date;

        $scope.data = {};
        $scope.data.purchase_id = purchase.purchase_id;
        $scope.data.paid_date = paid_date;
        $scope.data.paid_amount = balance;
        $scope.data.payment_mode = 'CA';
        
        $rootScope.commonService.GetPaymentModes(function (response) {
            $scope.paymentModes = response;
        });

        $scope.saveForm = function () {
            _that = this;
            if (_that.data.payment_mode != 'CD') {
                _that.data.card_type = '';
                _that.data.card_number = '';
            }

            if (_that.data.payment_mode != 'CH') {
                _that.data.cheque_no = '';
            }

            if (_that.data.payment_mode != 'ON') {
                _that.data.ref_no = '';
            }

            if ((_that.data.payment_mode != 'ON') && (_that.data.payment_mode != 'CH')) {
                _that.data.bank_name = '';
                _that.data.bank_date = '';
            }

            $scope.errorData = "";
            scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/pharmacypurchasebilling/makepayment';
            method = 'POST';
            succ_msg = 'Payment added successfully';

            scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        if (response.success == false) {
                            scope.loadbar('hide');
                            if (status == 422)
                                $scope.errorData = scope.errorSummary(data);
                            else
                                $scope.errorData = response.message;
                        } else {
                            scope.loadbar('hide');
                            scope.msg.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
//                                scope.updateDisplayCollection(response.sales[0]);
                                scope.loadPurchaseItemList(purchase_payment_type);
                                $modalInstance.dismiss('cancel');
                            }, 1000)
                        }
                    }
            ).error(function (data, status) {
                scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    }]);
  