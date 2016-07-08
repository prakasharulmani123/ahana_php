app.controller('ReordersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //Index Page
        $scope.loadReordersList = function () {
            $scope.loadbar('show');
            $scope.isLoading = true;

            $scope.errorData = "";
            $scope.successMessage = "";

            $rootScope.commonService.GetSupplierList('', '1', false, function (response) {
                $scope.suppliers = response.supplierList;
                $scope.user_id = '';

                $http({
                    url: $rootScope.IRISOrgServiceUrl + '/user/getuserslistbyuser',
                    method: "GET"
                }).then(
                        function (response) {
                            $scope.users = response.data.userList;

                            // Get data's from service
                            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyreorderhistory/reorder')
                                    .success(function (response) {
                                        $scope.loadbar('hide');
                                        $scope.isLoading = false;
                                        $scope.records = response.report;
                                        $scope.date = moment().format('YYYY-MM-DD HH:MM:ss');

                                    })
                                    .error(function () {
                                        $scope.errorData = "An Error has occured while loading products!";
                                    });
                        }
                );
            });
        };
        
        $scope.moreOptions = function(key, row){
            if ($("#reorder_" + key).is(':checked')) {
                $("#reorder_" + key).closest("tr").addClass("selected_row");
            } else {
                $("#reorder_" + key).closest("tr").removeClass("selected_row");
            }
        }

        //Save Both Add & Update Data
        $scope.addReorderHistory = function () {
            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyreorderhistory/addreorderhistory';
            method = 'POST';
            succ_msg = 'Reorder saved successfully';
            
            records = [];
            angular.forEach($scope.records, function(record){
                if(record.selected == '1'){
                    records.push(record);
                }
            })

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: {records: records, user_id: $scope.user_id},
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
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
        };
    }]);