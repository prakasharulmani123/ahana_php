app.controller('BrandModalInstanceCtrl', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http) {
        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/pharmacybrands';
            method = 'POST';
            succ_msg = 'Brand saved successfully';

            scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            scope.brands.push(response);
                            scope.data.brand_id = response.brand_id;
                            $modalInstance.dismiss('cancel');
                        }, 1000)

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
  