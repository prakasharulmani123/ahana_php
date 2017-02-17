app.controller('SaleController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', '$modal', '$location', '$q', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout, $modal, $location, $q) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.show_patient_loader = false;
        $scope.show_consultant_loader = false;
        $scope.show_encounter_loader = false;
        $scope.show_group_loader = false;

        $scope.$on('HK_CREATE', function (e) {
            if ($location.path() == '/pharmacy/sales') {
                $scope.loadbar('show');
                $state.go('pharmacy.saleCreate', {}, {reload: true});
            }
        });

        $scope.$on('HK_CANCEL', function (e) {
            if (confirm('Are you sure want to leave?')) {
                $scope.loadbar('show');
                $state.go('pharmacy.sales');
            }
        });

        $scope.$on('HK_SAVE', function (e) {
            var location_url = $location.path().split('/');
            var url = location_url[1] + '/' + location_url[2];
            var allowedPages = $.inArray(url, ['pharmacy/saleCreate', 'pharmacy/saleUpdate']) > -1;
            if (allowedPages) {
                $timeout(function () {
                    angular.element("#save").trigger('click');
                }, 100);
            }
            e.preventDefault();
        });

        $scope.$on('HK_PRINT', function (e) {
            var location_url = $location.path().split('/');
            var url = location_url[1] + '/' + location_url[2];
            var allowedPages = $.inArray(url, ['pharmacy/saleCreate', 'pharmacy/saleUpdate']) > -1;
            if (allowedPages) {
                $timeout(function () {
                    angular.element("#save_print").trigger('click');
                }, 100);
            }
            e.preventDefault();
        });

        $scope.$on('HK_LIST', function (e) {
            $state.go('pharmacy.sales');
        });

        $scope.$on('HK_SEARCH', function (e) {
            $('#filter').focus();
        });

        //Expand table in Index page
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Create page height
        $scope.css = {'style': ''};

        //Index Page
        $scope.loadSaleItemList = function (payment_type) {
            $scope.errorData = $scope.msg.successMessage = '';
            $scope.isLoading = true;
            if (payment_type == 'CA') {
                $scope.sale_payment_type_name = 'Cash';
            }
            if (payment_type == 'CR') {
                $scope.sale_payment_type_name = 'Credit';
            }
            if (payment_type == 'COD') {
                $scope.sale_payment_type_name = 'Cash On Deleivery';
            }
            $scope.sale_payment_type = payment_type;

            $scope.activeMenu = payment_type;

            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysale/getsales?payment_type=' + payment_type + '&addtfields=sale_list')
                    .success(function (saleList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = saleList.sales;

                        angular.forEach($scope.rowCollection, function (row) {
                            row.all_dates = '';
                            angular.forEach(row.items, function (saleitem) {
                                row.all_dates += saleitem.sale_date + " ";
                            });
                        });

                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        $scope.form_filter = null;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading saleList!";
                    });

            //Consultant List - Index Print Bill Section 
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
        };

        //For Form
        $scope.formtype = '';
        $scope.initForm = function (formtype) {
            $scope.data = {};
            if (formtype == 'add') {
                $scope.formtype = 'add';
                $scope.data.payment_type = 'CA';
                $scope.data.sale_date = moment().format('YYYY-MM-DD');
                $scope.data.formtype = 'add';
//                $scope.setFutureInternalCode('SA', 'bill_no');
                $scope.addRow();
            } else {
                $scope.formtype = 'update';
                $scope.data.formtype = 'update';
                $scope.loadForm(); // Waiting For testing
            }

            $scope.encounters = [];

            $scope.show_consultant_loader = true;
            //Consultant List
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
                $scope.show_consultant_loader = false;
            });

            //Payment types
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
                $scope.paymentTypes.push({value: 'COD', label: 'Cash On Delivery'});
            });

            //Patient Groups
            $scope.show_group_loader = true;
            $rootScope.commonService.GetPatientGroup('1', false, function (response) {
                $scope.patientgroups = response.patientgroupList;
                $scope.show_group_loader = false;
            });

            $scope.productloader = '<i class="fa fa-spin fa-spinner"></i>';
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct?fields=product_id,full_name')
                    .success(function (products) {
                        $scope.products = products;
                        $scope.productloader = '';
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        }

        $scope.showExpiryDate = function (saleitem) {
            if (saleitem.expiry_date) {
                return moment(saleitem.expiry_date).format('MMM YYYY');
            } else {
                return 'empty';
            }
        };

        $scope.formatPatient = function ($item, $model, $label) {
            $scope.data.patient_id = $item.patient_id;
            $scope.data.patient_guid = $item.patient_guid;
            $scope.data.patient_name = $item.fullname;
            $scope.data.consultant_id = $item.last_consultant_id;

            $scope.getEncounter($item.patient_id, 'add', '');
            $scope.getPatientGroupByPatient($item.patient_guid);
        }

        $scope.getEncounter = function (patient_id, mode, encounter_id) {
            if (patient_id) {
                $scope.show_encounter_loader = true;
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;

                    if (response.length > 0 && response != null && mode == 'add') {
                        $scope.data.encounter_id = response[0].encounter_id;
                        $scope.getPrescription(); //Waiting For testing
                    } else if (mode == 'edit') {
                        $scope.data.encounter_id = encounter_id.toString();
                    }
                    $scope.show_encounter_loader = false;
                }, 'sale_encounter_id');
            }

        }

        $scope.getPatientGroupByPatient = function (patient_id) {
            if (patient_id) {
                $scope.show_group_loader = true;
                $http.get($rootScope.IRISOrgServiceUrl + '/patientgroup/getpatientgroupbypatient?id=' + patient_id)
                        .success(function (response) {
                            $scope.data.patient_group_id = $scope.data.patient_group_name = '';
                            if (response.groups.length) {
                                $scope.data.patient_group_id = response.groups[0].patient_group_id;
                                $scope.data.patient_group_name = response.groups[0].group_name;
                            }
                            $scope.show_group_loader = false;
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured while loading groups!";
                        });
            }
        }

        $scope.updatePatientGroupname = function () {
            selected = $filter('filter')($scope.patientgroups, {patient_group_id: $scope.data.patient_group_id}, true);
            if (selected.length)
                $scope.data.patient_group_name = selected[0].group_name;
            else
                $scope.data.patient_group_name = '';
        }

        //Sale Date Datepicker
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

        // Sale Items Array
        $scope.saleItems = [];
        // Add first row in sale item table.
        $scope.addRow = function (focus) {
            $scope.inserted = {
                product_id: '',
                product_name: '',
                product_location: '',
                full_name: '',
                batch_no: '',
                batch_details: '',
                expiry_date: '',
                quantity: '0',
                package_name: '',
                mrp: '0',
                item_amount: '0',
                discount_percentage: '0',
                discount_amount: '0',
                vat_percent: '0',
                vat_amount: '0',
                total_amount: '0',
                generic_id: '',
            };
            $scope.saleItems.push($scope.inserted);

            if (focus) {
                if ($scope.saleItems.length > 1) {
                    $timeout(function () {
                        $scope.setFocus('full_name', $scope.saleItems.length - 1);
                    });
                }
            }

            if ($scope.saleItems.length > 6) {
                $scope.css = {
                    'style': 'height:360px; overflow-y: auto; overflow-x: hidden;',
                };
            }
        };

        // Remove Sale Item
        $scope.removeSaleItem = function (index) {
            if ($scope.saleItems.length == 1) {
                alert('Can\'t Delete. Sale Item must be atleast one.');
                return false;
            }
            $scope.saleItems.splice(index, 1);
            $scope.updateSaleRate();
            $timeout(function () {
                $scope.setFocus('full_name', $scope.saleItems.length - 1);
            });

            if ($scope.saleItems.length <= 6) {
                $scope.css = {
                    'style': '',
                };
            }
        };

        //Set cursor to first input box
        $scope.setFocus = function (id, index) {
            angular.element(document.querySelectorAll("#" + id))[index].focus();
        };

        //Check all the input box.
        $scope.checkInput = function (data, key, index) {
            item = $scope.saleItems[key];
            if (typeof item != 'undefined') {
                if (key > 0 && item.product_name == '' && item.batch_no == '' && item.quantity == 0) {
                    $scope.removeSaleItem(index);
                } else {
                    if (!data) {
                        return "Not empty";
                    }
                }
            }
        };

        $scope.checkAmount = function (data, key, index) {
            item = $scope.saleItems[key];
            if (typeof item != 'undefined') {
                if (key > 0 && item.product_name == '' && item.batch_no == '' && item.quantity == 0) {
//                    $scope.removeSaleItem(index);
                } else {
                    if (data <= 0) {
                        return "Not be 0";
                    }
                }
            }
        };

        $scope.checkQuantity = function (data, key) {
            if ($scope.formtype == 'update') {
                var old = $scope.saleItems[key].old_quantity;
                var package_unit = $scope.saleItems[key].package_unit;
                var stock = $scope.saleItems[key].available_qty; //Stock
                var total_returned_quantity = $scope.saleItems[key].total_returned_quantity; // Prior returned quantities

                var error_exists = false;
                var error_msg = '';
                if (old > data) {
                    if (parseFloat(total_returned_quantity) > parseFloat(data)) {
                        error_exists = true;
                        error_msg = 'Qty Mismatch';
                    }
                } else {
                    var current_qty = (data - old) * package_unit;
                    if (current_qty > stock) {
                        error_exists = true;
                        error_msg = 'No stock';
                    }
                }

                if (error_exists && error_msg != '') {
                    return error_msg;
                }
            } else {
                if (data <= 0) {
                    return "Not be 0";
                }
            }
        }

        $scope.clearProductRow = function (data, key) {
            if (!data) {
                $scope.saleItems[key].product_id = '';
                $scope.saleItems[key].product_name = '';
                $scope.saleItems[key].product_location = '';
                $scope.saleItems[key].vat_percent = '0';
                $scope.saleItems[key].package_name = '';
                $scope.saleItems[key].batch_details = '';
                $scope.saleItems[key].batch_no = '';
                $scope.saleItems[key].expiry_date = '';
                $scope.saleItems[key].mrp = 0;
                $scope.saleItems[key].quantity = 0;
                $scope.saleItems[key].discount_percentage = 0;
                $scope.saleItems[key].generic_id = '';
                $scope.saleItems[key].product_batches = [];
                $scope.clearFormEditables(this.$form, key);
            }
        }

        $scope.clearFormEditables = function (form, key) {
            angular.forEach(form.$editables, function (editableValue, editableKey) {
                if (editableValue.scope.$index == key && editableValue.attrs.eName != 'full_name') {
                    if (editableValue.attrs.eName == 'quantity' ||
                            editableValue.attrs.eName == 'mrp' ||
                            editableValue.attrs.eName == 'discount_percentage') {
                        editableValue.scope.$data = "0";
                    } else {
                        editableValue.scope.$data = "";
                    }
                }
            });
            $scope.updateRow(key);
        }

        $scope.productDetail = function (product_id, product_obj) {
            var deferred = $q.defer();
            deferred.notify();
            var Fields = 'product_name,product_location,product_reorder_min,full_name,salesVat,salesPackageName,availableQuantity,generic_id,product_batches';

            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproducts/' + product_id + '?fields=' + Fields + '&addtfields=pharm_sale_prod_json')
                    .success(function (product) {
                        Fields.split(",").forEach(function (item) {
                            product_obj[item] = product[item];
                        });
                        deferred.resolve();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading product!";
                        deferred.reject();
                    });

            return deferred.promise;
        };

        $scope.updateAlternateProductRow = function (data, key, index) {
            if (data) {
                var selectedObj = $filter('filter')($scope.products, {product_id: data.product_id}, true)[0];
                $scope.productDetail(data.product_id, selectedObj).then(function () {
                    $scope.saleItems[key].product_id = selectedObj.product_id;
                    $scope.saleItems[key].full_name = selectedObj.full_name;
                    $scope.saleItems[key].product_name = selectedObj.product_name;
                    $scope.saleItems[key].product_location = selectedObj.product_location;
                    $scope.saleItems[key].vat_percent = selectedObj.salesVat.vat;
                    $scope.saleItems[key].package_name = selectedObj.salesPackageName;
                    $scope.saleItems[key].generic_id = selectedObj.generic_id;
                    $scope.saleItems[key].product_batches = selectedObj.product_batches;
                    $('#i_full_name_' + key + ' #full_name').val(selectedObj.full_name);

                    $scope.productInlineAlert(selectedObj, key);

                    $scope.updateRow(key);

                    if (!$scope.saleItems[key].out_of_stock_msg) {
                        $('#i_alternate_medicine_' + key).addClass('hide');
                        $scope.setFocus('batch_details', index);
                    }
                });
            }
        }

        //After product choosed, then update some obejct attributes in the sale items array.
        $scope.updateProductRow = function (item, model, label, key) {
            var selectedObj = $filter('filter')($scope.products, {product_id: item.product_id}, true)[0];
            $scope.productDetail(item.product_id, selectedObj).then(function () {
                $scope.saleItems[key].product_id = selectedObj.product_id;
                $scope.saleItems[key].product_name = selectedObj.product_name;
                $scope.saleItems[key].product_location = selectedObj.product_location;
                $scope.saleItems[key].full_name = selectedObj.full_name;
                $scope.saleItems[key].vat_percent = selectedObj.salesVat.vat;
                $scope.saleItems[key].package_name = selectedObj.salesPackageName;
                $scope.saleItems[key].generic_id = selectedObj.generic_id;
                $scope.saleItems[key].product_batches = selectedObj.product_batches;

                $scope.getreadyBatch(selectedObj, key);
                $scope.productInlineAlert(selectedObj, key);

                $scope.updateRow(key);
            });
        }

        $scope.getreadyBatch = function (item, key) {
            $scope.saleItems[key].batch_details = '';
            $scope.saleItems[key].batch_no = '';
            $scope.saleItems[key].expiry_date = '';
            $scope.saleItems[key].mrp = 0;
            $scope.saleItems[key].quantity = 0;
            if (item.availableQuantity <= 0) {
                $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbygeneric?generic_id=' + item.generic_id + '&addtfields=pharm_sale_alternateprod')
                        .success(function (product) {
                            //For alternate medicines
                            item.alternateproducts = product.productList.filter(function (n) {
                                return (n.product_id != item.product_id && n.product_batches_count > '0')
                            });
                            $scope.saleItems[key].alternateproducts = item.alternateproducts;
                            if ($scope.saleItems[key].alternateproducts.length) {
                                $('#i_alternate_medicine_' + key).removeClass('hide');
                            } else {
                                $('#i_alternate_medicine_' + key).addClass('hide');
                            }
                        })
                        .error(function () {
                            $scope.errorData = "An Error has occured while loading product!";
                        });
            }
        }

        $scope.productInlineAlert = function (item, key) {
            $scope.saleItems[key].min_reorder_msg = '';
            $scope.saleItems[key].out_of_stock_msg = '';

            if (item.availableQuantity == 0) {
                $scope.saleItems[key].out_of_stock_msg = 'Out of stock';
            } else if (item.availableQuantity <= item.product_reorder_min) {
                $scope.saleItems[key].min_reorder_msg = 'reached min order level (' + item.product_reorder_min + ')';
            }
        }

        $scope.updateDisplayCollection = function (enc_id, resp) {
            selected = $filter('filter')($scope.displayedCollection, {encounter_id: enc_id});
            var index = $scope.displayedCollection.indexOf(selected[0]);
            $scope.displayedCollection.splice(index, 1);
            $scope.displayedCollection.push(resp);
        }

        $scope.showBatch = function (batch, key) {
            if (batch) {
                prod_batches = $scope.saleItems[key].product_batches;
                selected = $filter('filter')(prod_batches, {batch_details: batch}, true);
                if (selected) {
                    return selected.length ? selected[0].batch_details : 'Not set';
                } else {
                    return 'Not set';
                }
            }
        };

        $scope.showAlternateProduct = function (product) {
            var selected = [];
            if (product.product_id) {
                selected = $filter('filter')($scope.products, {product_id: product.product_id});
            }
            if (selected) {
                return selected.length ? selected[0].full_name : 'Not set';
            } else {
                return 'Not set';
            }
        };

        //After barch choosed, then update some values in the row.
        $scope.updateBatchRow = function (batch, key) {
            var prod_batches = $scope.saleItems[key].product_batches;
            var selected = $filter('filter')(prod_batches, {batch_details: batch}, true);
            if (selected.length > 0) {
                item = selected[0];
                $scope.saleItems[key].batch_details = item.batch_details;
                $scope.saleItems[key].batch_no = item.batch_no;
                $scope.saleItems[key].expiry_date = item.expiry_date;
//            $scope.saleItems[key].mrp = item.mrp;
                $scope.saleItems[key].mrp = item.per_unit_price;

                $scope.setFocus('quantity', key);
                $scope.checkExpDate(item.expiry_date, key);
//            $scope.addRowWhenFocus(key);
            }
        }

        $scope.checkExpDate = function (data, key) {
            var choosen_date = new Date(data);
            var choosen_date_month = choosen_date.getMonth();
            var choosen_date_year = choosen_date.getYear();

            var today_date = new Date();
            var today_date_month = today_date.getMonth();
            var today_date_year = today_date.getYear();

            var show_warning_count = '3';
            var show_warning = parseFloat(choosen_date_month) - parseFloat(today_date_month);

            if (show_warning < show_warning_count && today_date_year == choosen_date_year) {
                $scope.saleItems[key].exp_warning = 'short expiry drug';
            } else {
                $scope.saleItems[key].exp_warning = '';
            }
        };

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

        $scope.updateColumn = function ($data, key, column) {
            $scope.saleItems[key][column] = $data;
            $scope.updateRow(key);
        }

        //Update other informations in the row
        $scope.updateRow = function (key) {
            //Get Data
            var qty = parseFloat($scope.saleItems[key].quantity);
            var mrp = parseFloat($scope.saleItems[key].mrp);
            var disc_perc = parseFloat($scope.saleItems[key].discount_percentage);
            var vat_perc = parseFloat($scope.saleItems[key].vat_percent);

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            disc_perc = !isNaN(disc_perc) ? disc_perc : 0;
            vat_perc = !isNaN(vat_perc) ? vat_perc : 0;

            var item_amount = (qty * mrp).toFixed(2);
            var disc_amount = disc_perc > 0 ? (item_amount * (disc_perc / 100)).toFixed(2) : 0;
            var total_amount = (item_amount - disc_amount).toFixed(2);

//            var vat_amount = (item_amount * (vat_perc / 100)).toFixed(2); // Exculding vat
            var vat_amount = ((total_amount * vat_perc) / (100 + vat_perc)).toFixed(2); // Including vat

            $scope.saleItems[key].item_amount = item_amount;
            $scope.saleItems[key].discount_amount = disc_amount;
            $scope.saleItems[key].total_amount = total_amount;
            $scope.saleItems[key].vat_amount = vat_amount;
            $scope.updateSaleRate();
        }

        $scope.updateSaleRate = function () {

            var roundoff_amount = bill_amount = total_item_discount_amount = total_item_amount = 0;

            //Get Total Sale, VAT, Discount Amount
            var total_item_vat_amount = total_item_sale_amount = 0;
            angular.forEach($scope.saleItems, function (item) {
                total_item_vat_amount = total_item_vat_amount + parseFloat(item.vat_amount);
                total_item_sale_amount = total_item_sale_amount + parseFloat(item.total_amount);
            });

            $scope.data.total_item_sale_amount = total_item_sale_amount.toFixed(2);
            $scope.data.total_item_vat_amount = total_item_vat_amount.toFixed(2);

            //Get Before Discount Amount (Total Sale Amount + Total VAT)
//            var before_discount_total = (total_item_sale_amount + total_item_vat_amount).toFixed(2); // Exculding vat
            var before_discount_total = (total_item_sale_amount).toFixed(2); // Inculding vat

            //Get Discount Amount
            var disc_perc = parseFloat($scope.data.total_item_discount_percent);
            disc_perc = !isNaN(disc_perc) ? (disc_perc).toFixed(2) : 0;

            var disc_amount = disc_perc > 0 ? (total_item_sale_amount * (disc_perc / 100)).toFixed(2) : 0;
            $scope.data.total_item_discount_amount = disc_amount;

            var after_discount_item_amount = (parseFloat(before_discount_total) - parseFloat(disc_amount));
            $scope.data.total_item_amount = after_discount_item_amount.toFixed(2);

            //Get Welfare Amount
            var welfare = 0;
            if ($scope.data.welfare_amount) {
                var welfare = parseFloat($scope.data.welfare_amount).toFixed(2);
            }

            // Bill Amount = (Total Amount - Discount Amount) +- RoundOff
            var total_bill_amount = parseFloat(after_discount_item_amount) + parseFloat(welfare);
            bill_amount = Math.round(total_bill_amount);
            roundoff_amount = Math.abs(bill_amount - total_bill_amount);

            $scope.data.roundoff_amount = roundoff_amount.toFixed(2);
            $scope.data.bill_amount = bill_amount.toFixed(2);
            $scope.data.amount_received = bill_amount;
            $scope.updateBalance();
        }

        $scope.updateBalance = function () {
            $scope.data.balance = $scope.data.amount_received - $scope.data.bill_amount;
        }

        $scope.getBtnId = function (btnid)
        {
            $scope.btnid = btnid;
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            if (!$scope.tableform.$valid) {
                $scope.data.patient_id = '';
            }
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            $scope.data.sale_date = moment($scope.data.sale_date).format('YYYY-MM-DD');

            angular.forEach($scope.saleItems, function (saleitem, key) {
                $scope.saleItems[key].expiry_date = moment(saleitem.expiry_date).format('YYYY-MM-DD');

                if (angular.isObject(saleitem.full_name)) {
                    $scope.saleItems[key].full_name = saleitem.full_name.full_name;
                } else if (typeof saleitem.full_name == 'undefined') {
                    $scope.saleItems[key].product_id = '';
                }

                if (angular.isObject(saleitem.batch_details)) {
                    $scope.saleItems[key].batch_details = saleitem.batch_details.batch_details;
                } else if (typeof saleitem.batch_details == 'undefined') {
                    $scope.saleItems[key].batch_no = '';
                } else if ((saleitem.batch_no == '0' || saleitem.batch_no == '') && typeof saleitem.batch_details !== 'undefined') {
                    $scope.saleItems[key].batch_no = saleitem.batch_details;
                }

                //Unset unwanted columns 
                delete saleitem.alternate_product;
                delete saleitem.alternateproducts;
//                delete saleitem.product_batches; // Need product batches if form success false.
            });

            /* For print bill */
            angular.extend(_that.data, {product_items: $scope.saleItems});
            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacysale/savesale',
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        if (response.success == true) {
                            $scope.loadbar('hide');
                            if (mode == 'add') {
                                msg = 'New bill generated ' + response.bill_no;
                            } else {
                                msg = 'Bill updated successfully';
                            }
                            $scope.msg.successMessage = msg;
                            if ($scope.btnid == "print") {
                                $scope.printSaleBill(response.saleId);
                            } else {
                                $state.go($state.current, {}, {reload: true});
                            }
                        } else {
//                            $scope.tableform.$show();
                            $scope.loadbar('hide');
                            $scope.errorData = response.message;
                        }

                        return false;
                    }
            ).error(function (data, status) {
                $anchorScroll();
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.changeGetConsultant = function () {
            _that = this;
            $scope.getConsultantDetail(_that.data.consultant_id);
        }

        $scope.getConsultantDetail = function (consultant_id) {
            if (consultant_id) {
                consultant_details = $filter('filter')($scope.doctors, {user_id: consultant_id}, true);
                if (consultant_details) {
                    $scope.consultant_name_taken = consultant_details.length > 0 ? consultant_details[0].fullname : '';
                }
            }
        }

        $scope.changeGetPayType = function () {
            _that = this;
            $scope.getPaytypeDetail(_that.data.payment_type);
        }

        $scope.getPaytypeDetail = function (payment_type) {
            if (payment_type == 'CA') {
                $scope.purchase_type_name = 'Cash';
            }
            if (payment_type == 'CR') {
                $scope.purchase_type_name = 'Credit';
            }
            if (payment_type == 'COD') {
                $scope.purchase_type_name = 'Cash On Delivery';
            }
        }

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/pharmacysales/" + $state.params.id + "?addtfields=sale_update",
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
//                        $scope.data.patient_name = response.patient.fullname;
                        $scope.data.patient_guid = response.patient.patient_guid;
                        $scope.getConsultantDetail($scope.data.consultant_id);
                        $scope.getPaytypeDetail($scope.data.payment_type);

                        $scope.saleItems = response.items;
                        angular.forEach($scope.saleItems, function (item, key) {
                            angular.extend($scope.saleItems[key], {
                                full_name: item.product.full_name,
                                batch_no: item.batch.batch_no,
                                batch_details: item.batch.batch_details,
                                expiry_date: item.batch.expiry_date,
                                oldAttributeQuantity: item.quantity,
                                old_quantity: item.quantity,
                                available_qty: item.batch.available_qty,
                            });
                            $timeout(function () {
                                $scope.showOrHideProductBatch('hide', key);
                            });
                        });

                        $scope.getEncounter(response.patient.patient_id, 'edit', response.encounter_id);

                        $timeout(function () {
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

        $scope.make_payment = function (sale_id, checked_sale_id) {
            sale = $filter('filter')($scope.displayedCollection, {sale_id: sale_id}, true);

            var modalInstance = $modal.open({
                templateUrl: 'tpl/pharmacy_sale/modal.makepayment.html',
                controller: "SaleMakePaymentController",
                size: 'lg',
                resolve: {
                    scope: function () {
                        return $scope;
                    },
                }
            });
            modalInstance.data = {
                sale_id: sale_id,
                sale: sale[0],
                checked_sale_id: checked_sale_id,
            };
        }

        var canceler;
        $scope.getPatients = function (patientName) {
            if (canceler)
                canceler.resolve();
            canceler = $q.defer();

            $scope.show_patient_loader = true;

            return $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/patient/getpatient?addtfields=salecreate&only=patients',
                data: {'search': patientName},
                timeout: canceler.promise,
            }).then(
                    function (response) {
                        $scope.patients = [];
                        $scope.patients = response.data.patients;
                        $scope.loadbar('hide');
                        $scope.show_patient_loader = false;
                        return $scope.patients;
                    }
            );
        };

        $scope.getPrescription = function () {
            $scope.loadbar('show');
            $http.get($rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $scope.data.patient_guid + '&encounter_id=' + $scope.data.encounter_id)
                    .success(function (prescriptionList) {
                        $scope.loadbar('hide');
                        $scope.saleItems = [];

                        ids = [];
                        angular.forEach(prescriptionList.prescriptions, function (prescription) {
                            angular.forEach(prescription.items, function (item) {
                                $scope.inserted = {
                                    full_name: item.product.full_name,
                                    batch_details: '',
                                    product_id: item.product_id,
                                    product_name: item.product_name,
                                    package_name: '',
                                    vat_percent: '0',
                                    batch_no: '',
                                    expiry_date: '',
                                    mrp: '0',
                                    quantity: '0',
                                    vat_amount: '0',
                                    item_amount: '0',
                                };

                                exists = $filter('filter')($scope.saleItems, {product_id: item.product_id}, true);
                                if (exists.length == 0) {
                                    $scope.saleItems.push($scope.inserted);
                                    ids.push(item.product_id);
                                }
                            });
                        });

//                        $rootScope.commonService.GetBatchListByProduct(ids, function (response) {
//                            $scope.batches = response.batchList;
//                        });

                        if ($scope.saleItems.length == 0) {
                            $scope.addRow();
                        }

                        $timeout(function () {
                            $scope.setFocus('full_name', $scope.saleItems.length - 1);
                        });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading list!";
                    });
        }

        /*PRINT BILL*/
        $scope.printHeader = function () {
            return true;
        }

        $scope.printFooter = function () {
            return true;
        }

        $scope.printStyle = function () {
            return {
                header: {
                    bold: true,
                    color: '#000',
                    fontSize: 8
                },
                demoTable: {
                    color: '#000',
                    fontSize: 8
                }
            };
        }

        $scope.printloader = '';
        $scope.printContent = function () {
            var generated_on = moment().format('YYYY-MM-DD hh:mm A');
            var generated_by = $scope.app.username;

            var content = [];

            var result_count = Object.keys($scope.saleItems2).length;
            var index = 1;
            var loop_count = 0;

            var groupedArr = createGroupedArray($scope.saleItems2, 2);
            var sale_info = $scope.data2;

            angular.forEach(groupedArr, function (sales, key) {
                var perPageInfo = [];

                var perPageItems = [];
                perPageItems.push([
                    {text: 'S.No', style: 'header'},
                    {text: 'Particulars', style: 'header'},
                    {text: 'MFR', style: 'header'},
                    {text: 'Batch', style: 'header'},
                    {text: 'Expiry', style: 'header'},
                    {text: 'Qty', style: 'header'},
                    {text: 'Rate', style: 'header'},
                    {text: 'Amount', style: 'header'},
                ]);

                angular.forEach(sales, function (row, key) {
                    var percentage = parseInt(row.discount_percentage);
                    if (percentage > 0) {
                        var particulars = {
                            columns: [
                                {
                                    width: 140,
                                    text: row.product.full_name,
                                    alignment: 'left'
                                },
                                {
                                    width: 'auto',
                                    text: percentage.toString(),
                                    alignment: 'right',
                                }
                            ]
                        }
                    } else {
                        var particulars = row.product.full_name;
                    }
                    perPageItems.push([
                        index.toString(),
                        particulars,
                        row.product.brand_code,
                        row.batch_no,
                        moment(row.expiry_date).format('MM/YY'),
                        row.quantity.toString(),
                        row.mrp,
                        row.total_amount,
                    ]);
                    index++;
                    loop_count++;
                });
                perPageItems.push([
                    {text: 'For Ahana Hospital', colSpan: 2},
                    "",
                    {text: 'GET WELL SOON', colSpan: 3, alignment: 'center'},
                    "",
                    "",
                    {text: 'TOTAL'},
                    {text: (loop_count === result_count ? sale_info.bill_amount.toString() : ''), colSpan: 2, alignment: 'right'},
                    "",
                ]);

                perPageInfo.push({
                    columns: [
                        {
                            text: [
                                {text: 'Pt. Name ', bold: true, fontSize: '9'},
                                {text: sale_info.patient_name, fontSize: '9'},
                            ],
//                            margin: [0, 0, 0, 20]
                        },
                        {
                            text: [
                                {text: 'No: ', bold: true, fontSize: '9'},
                                {text: sale_info.bill_no + "/" + sale_info.payment_type_name, fontSize: '9'},
                            ],
//                            margin: [0, 0, 0, 20]
                        }

                    ]
                }, {
                    columns: [
                        {
                            text: [
                                {text: 'Address: ', bold: true, fontSize: '9'},
                                {text: "Test address", fontSize: '9'}
                                
                            ],
//                            margin: [0, 0, 0, 20]
                        },
                        {
                            text: [
                                {text: ' Date: ', bold: true, fontSize: '9'},
                                {text: generated_on, fontSize: '9'}
                                
                            ],
//                            margin: [0, 0, 0, 20]
                        }
                    ]
                }, {
                    style: 'demoTable',
                    table: {
                        headerRows: 1,
                        widths: [20, 150, 50, '*', 'auto', 'auto', 50, 50],
                        body: perPageItems,
                    },
                    pageBreak: (loop_count === result_count ? '' : 'after'),
                });
                content.push(perPageInfo);
                if (index == result_count) {
                    $scope.printloader = '';
                }
            });
            return content;
        }

        var createGroupedArray = function (arr, chunkSize) {
            var groups = [], i;
            for (i = 0; i < arr.length; i += chunkSize) {
                groups.push(arr.slice(i, i + chunkSize));
            }
            return groups;
        }

        var save_success = function () {
            if ($scope.btnid == "print") {
                $scope.printloader = '<i class="fa fa-spin fa-spinner"></i>';
                var print_content = $scope.printContent();
                if (print_content.length > 0) {
                    var docDefinition = {
                        header: $scope.printHeader(),
                        footer: $scope.printFooter(),
                        styles: $scope.printStyle(),
                        content: print_content,
                        pageSize: {width: 3.5 * 72, height: 8 * 72},
                        pageOrientation: 'landscape', //portrait
                        pageMargins: [ 10, 0, 2, 0 ],

                    };
                    var pdf_document = pdfMake.createPdf(docDefinition);
                    var doc_content_length = Object.keys(pdf_document).length;
                    if (doc_content_length > 0) {
                        pdf_document.print();
                    }
                }
            } else {
                $state.go($state.current, {}, {reload: true});
            }
        }

        $scope.saleDetail = function (sale_id) {
            $scope.data2 = {};
            $scope.saleItems2 = [];
            $scope.loadbar('show');

            var deferred = $q.defer();
            deferred.notify();

            $http.get($rootScope.IRISOrgServiceUrl + "/pharmacysales/" + sale_id + "?addtfields=sale_print")
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.data2 = response;
                        $scope.data2.patient_name = response.patient_name;
                        $scope.data2.patient_guid = response.patient_uhid;
//                        $scope.getConsultantDetail($scope.data2.consultant_id);
                        $scope.getPaytypeDetail($scope.data2.payment_type);
                        $scope.data2.payment_type_name = $scope.purchase_type_name;

                        $scope.saleItems2 = response.items;
                        angular.forEach($scope.saleItems2, function (item, key) {
                            angular.extend($scope.saleItems2[key], {
                                full_name: item.product.full_name,
                                batch_no: item.batch.batch_no,
                                batch_details: item.batch.batch_details,
                                expiry_date: item.batch.expiry_date,
                                quantity: item.quantity,
                            });
                        });
                        deferred.resolve();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading sale!";
                        deferred.reject();
                    });

            return deferred.promise;
        };

        $scope.printSaleBill = function (sale_id) {
            $scope.saleDetail(sale_id).then(function () {
                delete $scope.data2.items;
                $scope.btnid = 'print';
                save_success();
            });
        }

//        // Get Patient Name
//        var changeTimer = false;
//        $scope.$watch('data.patient_name', function (newValue, oldValue) {
//            if (newValue != '') {
//                if (changeTimer !== false)
//                    clearTimeout(changeTimer);
//
//                $scope.loadbar('show');
//                changeTimer = setTimeout(function () {
//                    $http({
//                        method: 'POST',
//                        url: $rootScope.IRISOrgServiceUrl + '/patient/search',
//                        data: {'search': newValue},
//                    }).success(
//                            function (response) {
//                                $scope.patients = [];
//                                angular.forEach(response.patients, function (list) {
//                                    $scope.patients.push(list.Patient);
//                                });
//                                $scope.loadbar('hide');
//                            }
//                    );
//                    changeTimer = false;
//                }, 300);
//            }
//        }, true);
        //Get the products
//        var changeTimer = false;
//        $scope.productFilter = function (product, key) {
//            return product.product_id != $scope.saleItems[key].product_id;
//        }

//        $scope.getProduct = function (saleitem) {
//            var name = saleitem.full_name.$viewValue;
//            if (changeTimer !== false)
//                clearTimeout(changeTimer);
//
//            changeTimer = setTimeout(function () {
//                $scope.loadbar('show');
//                $rootScope.commonService.GetProductListByName(name, function (response) {
//                    if (response.productList.length > 0)
//                        $scope.products = response.productList;
//                    $scope.loadbar('hide');
//                });
//                changeTimer = false;
//            }, 300);
//        }

//        $scope.setFutureInternalCode = function (code, col) {
//            $rootScope.commonService.GetInternalCodeList('', code, '1', false, function (response) {
//                if (col == 'bill_no' && response.code)
//                    $scope.data.bill_no = response.code.next_fullcode;
//            });
//        }

        //Hide by Nad.
//        $scope.addRowWhenFocus = function (key) {
//            //Add New Row when focus Quantity
//            if (key + 1 == $scope.saleItems.length) {
//                $scope.addRow(false);
//            }
//        }

        //Get selected patient mobile no.
//        $scope.getPatientMobileNo = function (id) {
//            var patient_id = id;
//            var patient_mobile_no = $.grep($scope.patients, function (patient) {
//                return patient.Patient.patient_id == patient_id;
//            })[0].Patient.patient_mobile;
//            $scope.data.mobile_no = patient_mobile_no;
//        }
    }]);