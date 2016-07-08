app.controller('ReordersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //Index Page
        $scope.loadReordersList = function () {
            $scope.loadbar('show');
            $scope.showTable = true;

            $scope.errorData = "";
            $scope.successMessage = "";

            var data = {};

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/pharmacyreport/reorder', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                        $scope.date = moment().format('YYYY-MM-DD HH:MM:ss');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyReorders';
                method = 'POST';
                succ_msg = 'Reorder saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyReorders/' + _that.data.Reorder_id;
                method = 'PUT';
                succ_msg = 'Reorder updated successfully';
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
                            $state.go('pharmacy.Reorder');
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
                url: $rootScope.IRISOrgServiceUrl + "/pharmacyreorderhistories/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        console.log(response);
                        return ;

                        $scope.data = response;
                        if ($scope.data.supplier_id != null)
                            $scope.getSupplierDetail($scope.data.supplier_id);

                        if ($scope.data.payment_type != null)
                            $scope.getPaytypeDetail($scope.data.payment_type);

                        $scope.products = [];

                        $scope.purchaseitems = response.items;
                        angular.forEach($scope.purchaseitems, function (item, key) {
                            angular.extend($scope.purchaseitems[key], {is_temp: '0', full_name: item.product.full_name, batch_no: item.batch.batch_no, batch_details: item.batch.batch_details, temp_expiry_date: item.batch.expiry_date, temp_mrp: item.batch.mrp, temp_package_name: item.package_name, temp_free_quantity_unit: item.free_quantity_unit});
                            $timeout(function () {
                                $scope.showOrHideRowEdit('hide', key);
                                $scope.showOrHideProductBatch('hide', key);
                            });
                        });

                        $timeout(function () {
                            delete $scope.data.supplier;
                            delete $scope.data.items;
                        }, 3000);
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
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/pharmacyReorder/remove",
                        method: "POST",
                        data: {id: row.Reorder_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadReordersList();
                                    $scope.successMessage = 'Reorder Deleted Successfully';
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