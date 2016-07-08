app.controller('ReordersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $filter) {

        //For Form
        $scope.initForm = function () {
            $scope.loadbar('show');
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
                $rootScope.commonService.GetPackageUnitList('', '1', false, function (response) {
                    $scope.loadForm();
                    $scope.packings = response.packingList;
                    $scope.batches = [];
                    $scope.loadbar('hide');
                });
            });
        }

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
                        $scope.data = response;
                        $scope.data.invoice_date = moment().format('YYYY-MM-DD');
                        if ($scope.data.payment_type != null)
                            $scope.getPaytypeDetail($scope.data.payment_type);

                        $scope.products = [];

                        $scope.purchaseitems = response.items;
                        angular.forEach($scope.purchaseitems, function (item, key) {
                            angular.extend($scope.purchaseitems[key], {
                                is_temp: '0',
                                full_name: item.product.full_name,
//                                batch_no: item.batch.batch_no,
//                                batch_details: item.batch.batch_details,
//                                temp_expiry_date: item.batch.expiry_date,
//                                temp_mrp: item.batch.mrp,
                                temp_package_name: item.package_name,
                                temp_free_quantity_unit: item.free_quantity_unit
                            });
                            $scope.updateProductRow(item, key);

                            $timeout(function () {
                                $scope.showOrHideRowEdit('hide', key);
                                $scope.showOrHideProductBatch('hide', key);
                            });
                        });

                        console.log($scope.purchaseitems);
                        return;

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

        $scope.getPaytypeDetail = function (payment_type) {
            if (payment_type == 'CA') {
                $scope.purchase_type_name = 'Cash';
            }
            if (payment_type == 'CR') {
                $scope.purchase_type_name = 'Credit';
            }
        }

        $scope.updateProductRow = function (item, key) {
            $scope.purchaseitems[key].product_id = item.product_id;
            $scope.purchaseitems[key].vat_percent = item.purchaseVat.vat;

            $scope.loadbar('show');
            $scope.updateRow(key);
            $rootScope.commonService.GetBatchListByProduct(item.product_id, function (response) {
                $scope.loadbar('hide');
                $scope.batches = response.batchList;

                $scope.purchaseitems[key].batch_no = '';
                $scope.purchaseitems[key].expiry_date = '';
                $scope.purchaseitems[key].temp_expiry_date = '';
                $scope.purchaseitems[key].mrp = 0;
                $scope.purchaseitems[key].temp_mrp = 0;
                $scope.purchaseitems[key].package_name = '';
                $scope.purchaseitems[key].temp_package_name = '';
                $scope.purchaseitems[key].quantity = 0;
                $scope.purchaseitems[key].free_quantity = 0;
                $scope.purchaseitems[key].free_quantity_unit = "";
                $scope.purchaseitems[key].temp_free_quantity_unit = "";
                $scope.purchaseitems[key].purchase_rate = 0;
                $scope.purchaseitems[key].discount_percent = 0;

            });
        }

        $scope.showOrHideRowEdit = function (mode, key) {
            if (mode == 'hide') {
                i_addclass = t_removeclass = 'hide';
                i_removeclass = t_addclass = '';
                $scope.purchaseitems[key].is_temp = '1';
            } else {
                i_addclass = t_removeclass = '';
                i_removeclass = t_addclass = 'hide';
                $scope.purchaseitems[key].is_temp = '0';
            }
            $('#i_expiry_date_' + key).addClass(i_addclass).removeClass(i_removeclass);
            $('#i_mrp_' + key).addClass(i_addclass).removeClass(i_removeclass);
            $('#i_package_name_' + key).addClass(i_addclass).removeClass(i_removeclass);
            $('#i_free_quantity_unit_' + key).addClass(i_addclass).removeClass(i_removeclass);

            $('#t_expiry_date_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_mrp_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_package_name_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_free_quantity_unit_' + key).addClass(t_addclass).removeClass(t_removeclass);
        }

        $scope.showOrHideProductBatch = function (mode, key) {
            if (mode == 'hide') {
                i_addclass = t_removeclass = 'hide';
                i_removeclass = t_addclass = '';
            } else {
                i_addclass = t_removeclass = '';
                i_removeclass = t_addclass = 'hide';
            }
            $('#i_full_name_' + key).addClass(i_addclass).removeClass(i_removeclass);
            $('#i_batch_details_' + key).addClass(i_addclass).removeClass(i_removeclass);

            $('#t_full_name_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_batch_details_' + key).addClass(t_addclass).removeClass(t_removeclass);
        }

        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened1 = true;
                    break;
            }
        };

        $scope.minDate = $scope.minDate ? null : new Date();













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