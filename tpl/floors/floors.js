app.controller('FloorsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'Restangular', function ($rootScope, $scope, $timeout, $http, $state, Restangular) {

        //Index Page
        $scope.loadFloorsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
//            Restangular.all("floor").getList().then(function (floors) {
//                $scope.isLoading = false;
//                $scope.rowCollection = floors;
//                $scope.displayedCollection = [].concat($scope.rowCollection);
//            }, function (response) {
//                $scope.errorData = "An Error has occured while loading floors!";
//            });
            $http.get($rootScope.IRISOrgServiceUrl + '/floor')
                    .success(function (floors) {
                        $scope.isLoading = false;
                        $scope.rowCollection = floors;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading floors!";
                    });
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/floors';
                method = 'POST';
                succ_msg = 'Floor saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/floors/' + _that.data.floor_id;
                method = 'PUT';
                succ_msg = 'Floor updated successfully';
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
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('configuration.floors');
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

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/floors/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Delete
        $scope.removeRow = function (row) {
            var conf = confirm('Are you sure to delete ? \nNote: All the wards & Rooms under this floor will also be deleted !!!');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/floor/remove",
                        method: "POST",
                        data: {id: row.floor_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadFloorsList();
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