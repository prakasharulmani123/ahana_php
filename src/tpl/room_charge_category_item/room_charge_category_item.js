app.controller('RoomChargeCategoryItemsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', function ($rootScope, $scope, $timeout, $http, $state, toaster) {

        //Index Page
        $scope.loadRoomChargeCategoryItemsList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/roomchargeitems')
                    .success(function (roomChargeCategoryItems) {
                        $scope.rowCollection = roomChargeCategoryItems;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roomChargeCategoryItems!";
                    });
        };
        
        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetRoomChargeCategoryList('', '1', false, function (response) {
                $scope.categories = response.categoryList;
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/roomchargeitems';
                method = 'POST';
                succ_msg = 'RoomChargeCategory saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/roomchargeitems/' + _that.data.charge_item_id;
                method = 'PUT';
                succ_msg = 'RoomChargeCategory updated successfully';
            }

            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('configuration.roomChargeCategoryItem');
                        }, 1000)

                    }
            ).error(function (data, status) {
                $('.butterbar').removeClass('active').addClass('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $('.butterbar').removeClass('hide').addClass('active');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/roomchargeitems/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $scope.data = response;
                    }
            ).error(function (data, status) {
                $('.butterbar').removeClass('active').addClass('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Delete
        $scope.removeRow = function (row) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/roomchargeitem/remove",
                        method: "POST",
                        data: {id: row.charge_item_id}
                    }).then(
                            function (response) {
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };
    }]);