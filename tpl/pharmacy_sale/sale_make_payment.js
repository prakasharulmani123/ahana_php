app.controller('SaleMakePaymentController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

        var sale_id = $modalInstance.data.sale_id;
        var bill_amount = $modalInstance.data.bill_amount;
        var paid = $modalInstance.data.paid;
        var balance = $modalInstance.data.balance;
        var sale_payment_type = $modalInstance.data.sale_payment_type;
        $scope.bill_amount = bill_amount;
        $scope.paid = paid;
        $scope.balance = balance;
        $scope.data = {};
        $scope.data.paid_date = moment().format('YYYY-MM-DD');

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };
        
        $scope.maxDate = new Date();

        $scope.saveForm = function () {
            _that = this;
            angular.extend(_that.data, {sale_id: sale_id});

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/pharmacysalebilling/makepayment';
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
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
                                scope.loadSaleItemList(sale_payment_type);
                                $modalInstance.dismiss('cancel');
                                
//                                $state.go('pharmacy.sales');
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
  