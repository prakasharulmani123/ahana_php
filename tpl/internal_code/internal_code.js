/* Controllers */
app.controller('InternalCodeController', ['$scope', '$http', '$filter', '$state', '$rootScope', '$timeout', function ($scope, $http, $filter, $state, $rootScope, $timeout) {

        //Get Billing code details
        $rootScope.commonService.GetInternalCodeList('', 'B', '1', false, function (response) {
            $scope.data = response.code;
            if(response.code == null)
                $scope.data = {formtype : 'add'};
        });

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/internalcodes';
                method = 'POST';
                succ_msg = 'Internal code saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/internalcodes/' + _that.data.internal_code_id;
                method = 'PUT';
                succ_msg = 'Internal code updated successfully';
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
                        $timeout(function () {
                            $state.go('configuration.internalCode');
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

    }]);