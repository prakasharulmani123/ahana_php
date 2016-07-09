app.controller('ReordersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';
        
        //Expand table in Index page
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Index Page
        $scope.initReordersList = function () {
            $rootScope.commonService.GetSupplierList('', '1', false, function (response) {
                $scope.suppliers = response.supplierList;

                $http({
                    url: $rootScope.IRISOrgServiceUrl + '/user/getuserslistbyuser',
                    method: "GET"
                }).then(
                        function (response) {
                            $scope.users = response.data.userList;
                            var currentUser = $rootScope.authenticationService.getCurrentUser();
                            $scope.user_id = currentUser.credentials.user_id;
                            $scope.loadReordersList('RE');
                        }
                );
            });
        }

        $scope.loadReordersList = function (mode) {
            $scope.loadbar('show');
            $scope.isLoading = true;

            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.activeMenu = mode;

            if (mode == 'RE') {
                $scope.reorder_page_heading = 'Reorders';

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
            } else if (mode == 'RH') {
                $scope.reorder_page_heading = 'Reorders History';
                
                // pagination set up
                $scope.rowCollection = [];  // base collection
                $scope.itemsByPage = 10; // No.of records per page
                $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

                // Get data's from service
                $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyreorderhistory')
                        .success(function (response) {
                            $scope.isLoading = false;
                            $scope.loadbar('hide');
                            $scope.rowCollection = response;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                            $scope.form_filter = null;
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured while loading saleList!";
                        });
            }
        };

        $scope.moreOptions = function (key, row) {
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
            angular.forEach($scope.records, function (record) {
                if (record.selected == '1') {
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
                            $scope.user_id = '';
                            
                            for (var i = 0; i < $scope.records.length; i++) {
                                var obj = $scope.records[i];
                                if (obj.selected == '1') {
                                    $scope.records.splice(i, 1);
                                }
                            }
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

        //For Form - Nad
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
                        $scope.data.payment_type = 'CA';
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
//                                temp_package_name: item.package_name,
//                                temp_free_quantity_unit: item.free_quantity_unit
                            });

                            $scope.updateProductRow(item, key);

                            $timeout(function () {
                                $scope.showOrHideRowEdit('show', key);
                                $scope.showOrHideProductBatch('hide', key);
                            });
                        });

//                        $timeout(function () {
//                            delete $scope.data.supplier;
//                            delete $scope.data.items;
//                        }, 3000);
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.updateProductRow = function (item, key) {
            $scope.purchaseitems[key].product_id = item.product_id;
            $scope.purchaseitems[key].vat_percent = item.product.purchaseVat.vat;

            $scope.loadbar('show');
//            $scope.updateRow(key);

            $rootScope.commonService.GetBatchListByProduct(item.product_id, function (response) {
                $scope.loadbar('hide');
                
                supplier_details = $filter('filter')($scope.batches, {supplier_id: supplier_id});
                $scope.batches.push(response.batchList);

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

        $scope.getPaytypeDetail = function (payment_type) {
            if (payment_type == 'CA') {
                $scope.purchase_type_name = 'Cash';
            }
            if (payment_type == 'CR') {
                $scope.purchase_type_name = 'Credit';
            }
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
            $('#i_batch_details_' + key).addClass(i_addclass).removeClass(i_removeclass);


            $('#t_expiry_date_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_mrp_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_package_name_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_free_quantity_unit_' + key).addClass(t_addclass).removeClass(t_removeclass);
            $('#t_batch_details_' + key).addClass(t_addclass).removeClass(t_removeclass);
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
            $('#t_full_name_' + key).addClass(t_addclass).removeClass(t_removeclass);
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
    }]);