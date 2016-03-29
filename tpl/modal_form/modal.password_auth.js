app.controller('PasswordAuthController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

        var encounter_id = $modalInstance.data.encounter_id;
        var column = $modalInstance.data.column;
        var value = $modalInstance.data.value;

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.saveForm = function () {
            _that = this;
            
            angular.extend(_that.data, {
                encounter_id: encounter_id,
                column: column,
                value: value
            });

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/user/passwordauth';
            method = 'POST';
            succ_msg = 'Status updated successfully';

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
//                                scope.loadSaleItemList(sale_payment_type);
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
  