app.controller('EditArrivalModalInstanceCtrl', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

        $scope.data = $modalInstance.data;

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

        $scope.saveForm = function () {
            _that = this;
            scope.errorData = "";
            scope.msg.successMessage = "";
            angular.extend(_that.data, {
                status_date: moment(_that.data.arrival_date).format('YYYY-MM-DD'),
                status_time: moment(_that.data.arrival_date).format('hh:mm A')
            });

            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/appointment/checkbookingtime',
                data: _that.data,
            }).success(
                    function (response) {
                        if (response.success == true) {
                            $http({
                                method: 'PUT',
                                url: $rootScope.IRISOrgServiceUrl + '/appointments/' + _that.data.id,
                                data: _that.data,
                            }).success(
                                    function (response) {
                                        scope.msg.successMessage = "Arrival Updated Successfully";
                                        $timeout(function () {
                                            $modalInstance.dismiss('cancel');
                                            $state.reload();
                                        }, 1000)
                                    }
                            ).error(function (data, status) {
                                $scope.loadbar('hide');
                                if (status == 422)
                                    $scope.errorData = $scope.errorSummary(data);
                                else
                                    $scope.errorData = data.message;
                            });

                        } else {
                            $scope.errorData = response.message;
                        }
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }
    }]);
  