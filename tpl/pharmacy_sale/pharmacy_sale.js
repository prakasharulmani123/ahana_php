app.controller('SaleController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', '$modal', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout, $modal) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Expand table in Index page
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Index Page
        $scope.loadSaleItemList = function (payment_type) {
            $scope.errorData = $scope.successMessage = '';
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
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysale/getsales?payment_type=' + payment_type)
                    .success(function (saleList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = saleList.sales;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        $scope.form_filter = null;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading saleList!";
                    });
        };

        $scope.$watch('form_filter', function (newValue, oldValue) {
            if (typeof newValue != 'undefined' && newValue != '' && newValue != null) {
                var footableFilter = $('table').data('footable-filter');
                footableFilter.clearFilter();
                footableFilter.filter(newValue);
            }

            if (newValue == '') {
                $scope.loadSaleItemList($scope.sale_payment_type);
            }
        }, true);

        //For Form
        $scope.initForm = function () {
            //Patients List
            $rootScope.commonService.GetPatientList('', '1', false, function (response) {
                $scope.patients = [];
                angular.forEach(response.patientlist, function (list) {
                    $scope.patients.push({'Patient': list});
                });
            });
//            $scope.data.patient_name = undefined;
//            $scope.patients = [];
            $scope.encounters = [];

            //Consultant List
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });

            //Payment types
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
                $scope.paymentTypes.push({value: 'COD', label: 'Cash On Delivery'});
            });

            if ($scope.data.formtype == 'update') {
                $scope.loadForm();
            } else {
                $scope.data.sale_date = moment().format('YYYY-MM-DD');
                $scope.addRow();
            }

            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct')
                    .success(function (products) {
                        $scope.products = products;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading brand!";
                    });
            $scope.batches = [];
        }

        $scope.showExpiryDate = function (saleitem) {
            if (saleitem.expiry_date) {
                return moment(saleitem.expiry_date).format('MMM YYYY');
            } else {
                return 'empty';
            }
        };

        $scope.formatPatient = function ($item, $model, $label) {
            id = $item.Patient.patient_id;
            $scope.data.patient_id = id;
            $scope.data.patient_guid = $item.Patient.patient_guid;
            $scope.data.patient_name = $item.Patient.patient_firstname;
            $scope.data.consultant_id = $item.Patient.last_consultant_id;

            $scope.getEncounter(id, 'add', '');
            //Hided the below one 
//            $scope.getPatientMobileNo(id);
        }

        $scope.getEncounter = function (patient_id, mode, encounter_id) {
            $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, patient_id, function (response) {
                angular.forEach(response, function (resp) {
                    resp.encounter_id = resp.encounter_id.toString();
                });
                $scope.encounters = response;

                if (response != null && mode == 'add') {
                    $scope.data.encounter_id = response[0].encounter_id;
                    $scope.getPrescription();
                } else if (mode == 'edit') {
                    $scope.data.encounter_id = encounter_id.toString();
                }
            });
        }

        //Get selected patient mobile no.
        $scope.getPatientMobileNo = function (id) {
            var patient_id = id;
            var patient_mobile_no = $.grep($scope.patients, function (patient) {
                return patient.Patient.patient_id == patient_id;
            })[0].Patient.patient_mobile;
            $scope.data.mobile_no = patient_mobile_no;
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
                full_name: '',
                batch_details: '',
                product_id: '',
                product_name: '',
                package_name: '',
                vat_percent: '0',
                batch_no: '',
                expiry_date: '',
                mrp: '0',
                quantity: '0',
                vat_amount: '0',
                item_amount: '0',
            };
            $scope.saleItems.push($scope.inserted);

            if (focus) {
                if ($scope.saleItems.length > 1) {
                    $timeout(function () {
                        $scope.setFocus('full_name', $scope.saleItems.length - 1);
                    });
                }
            }
        };

        //Hide by Nad.
//        $scope.addRowWhenFocus = function (key) {
//            //Add New Row when focus Quantity
//            if (key + 1 == $scope.saleItems.length) {
//                $scope.addRow(false);
//            }
//        }

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

        //Get the products
        var changeTimer = false;
        $scope.getProduct = function (saleitem) {
            var name = saleitem.full_name.$viewValue;
            if (changeTimer !== false)
                clearTimeout(changeTimer);

            changeTimer = setTimeout(function () {
                $scope.loadbar('show');
                $rootScope.commonService.GetProductListByName(name, function (response) {
                    if (response.productList.length > 0)
                        $scope.products = response.productList;
                    $scope.loadbar('hide');
                });
                changeTimer = false;
            }, 300);
        }

        //After product choosed, then some values in the row.
        $scope.updateProductRow = function (item, model, label, key) {
            $scope.saleItems[key].product_id = item.product_id;
            $scope.saleItems[key].product_name = item.product_name;
            $scope.saleItems[key].vat_percent = item.salesVat.vat;
            $scope.saleItems[key].package_name = item.salesPackageName;

            $scope.loadbar('show');
            $scope.updateRow(key);

            ids = [];
            angular.forEach($scope.saleItems, function (item) {
                ids.push(item.product_id);
            });

            $rootScope.commonService.GetBatchListByProduct(ids, function (response) {
                $scope.loadbar('hide');

                angular.forEach(response.batchList, function (item) {
                    selected = $filter('filter')($scope.batches, {batch_no: item.batch_no});
                    if (selected.length == 0) {
                        $scope.batches.push(item);
                    }
                });

//                $scope.saleItems[key].batch_details = response.batchList[0].batch_details;
//                $scope.saleItems[key].batch_no = response.batchList[0].batch_no;
                $scope.saleItems[key].batch_no = '';
                $scope.saleItems[key].expiry_date = '';
                $scope.saleItems[key].mrp = 0;
                $scope.saleItems[key].quantity = 0;
            });
        }
        
        $scope.updateDisplayCollection = function(enc_id, resp){
            selected = $filter('filter')($scope.displayedCollection, {encounter_id: enc_id});
            var index = $scope.displayedCollection.indexOf(selected[0]);
            $scope.displayedCollection.splice(index, 1);
            $scope.displayedCollection.push(resp);
        }

        $scope.showBatch = function (batch) {
            var selected = [];
            if (batch.batch_no) {
                selected = $filter('filter')($scope.batches, {batch_no: batch.batch_no});
            }
            return selected.length ? selected[0].batch_details : 'Not set';
        };

        //After barch choosed, then update some values in the row.
        $scope.updateBatchRow = function (item, key) {
            $scope.saleItems[key].batch_details = item.batch_details;
            $scope.saleItems[key].batch_no = item.batch_no;
            $scope.saleItems[key].expiry_date = item.expiry_date;
            $scope.saleItems[key].mrp = item.mrp;

            $scope.setFocus('quantity', key);
//            $scope.addRowWhenFocus(key);
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

        $scope.updateColumn = function ($data, key, column) {
            $scope.saleItems[key][column] = $data;
            $scope.updateRow(key);
        }

        //Update other informations in the row
        $scope.updateRow = function (key) {
            //Get Data
            var qty = parseFloat($scope.saleItems[key].quantity);
            var mrp = parseFloat($scope.saleItems[key].mrp);
            var vat_perc = parseFloat($scope.saleItems[key].vat_percent);

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            vat_perc = !isNaN(vat_perc) ? vat_perc : 0;

            var item_amount = (qty * mrp).toFixed(2);
            var vat_amount = (item_amount * (vat_perc / 100)).toFixed(2);

            $scope.saleItems[key].item_amount = item_amount;
            $scope.saleItems[key].vat_amount = vat_amount;
            $scope.updateSaleRate();
        }

        $scope.updateSaleRate = function () {

            var roundoff_amount = bill_amount = total_item_discount_amount = total_item_amount = 0;

            //Get Total Sale, VAT, Discount Amount
            var total_item_vat_amount = total_item_sale_amount = 0;
            angular.forEach($scope.saleItems, function (item) {
                total_item_vat_amount = total_item_vat_amount + parseFloat(item.vat_amount);
                total_item_sale_amount = total_item_sale_amount + parseFloat(item.item_amount);
            });

            $scope.data.total_item_sale_amount = total_item_sale_amount.toFixed(2);
            $scope.data.total_item_vat_amount = total_item_vat_amount.toFixed(2);

            //Get Before Discount Amount (Total Sale Amount + Total VAT)
            var before_discount_total = (total_item_sale_amount + total_item_vat_amount).toFixed(2);

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
            $scope.successMessage = "";

            $scope.data.sale_date = moment($scope.data.sale_date).format('YYYY-MM-DD');

            angular.forEach($scope.saleItems, function (saleitem, key) {
//                alert(saleitem.expiry_date);
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
            });

            /* For print bill */
            $scope.data2 = _that.data;
            $scope.saleItems2 = $scope.saleItems;
            $scope.getConsultantDetail(_that.data.consultant_id);
            $scope.getPaytypeDetail(_that.data.payment_type);

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
                                msg = 'New bill generated ' + response.model.bill_no;
                                $scope.data = {};
                                $scope.data.sale_date = moment().format('YYYY-MM-DD');
                                $scope.data.formtype = 'add';
                                $scope.data.payment_type = 'CA';
                                $scope.getPaytypeDetail(_that.data.payment_type);
                                $scope.saleItems = [];
                                $scope.addRow();
                                $scope.tableform.$show();
                                $scope.data2.bill_no = response.model.bill_no;
                            } else {
                                msg = 'Bill updated successfully';
                            }
                            $scope.successMessage = msg;
                            $timeout(function () {
                                //                                $state.go('pharmacy.sales');
                                save_success();
                            }, 1000)
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

        var save_success = function () {
            if ($scope.btnid == "print")
            {
                var innerContents = document.getElementById("Getprintval").innerHTML;
                var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
                popupWinindow.document.open();
                popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
                popupWinindow.document.close();
            }
        }

        $scope.changeGetConsultant = function () {
            _that = this;
            $scope.getConsultantDetail(_that.data.consultant_id);
        }

        $scope.getConsultantDetail = function (consultant_id) {
            consultant_details = $filter('filter')($scope.doctors, {user_id: consultant_id});
            $scope.consultant_name_taken = consultant_details.length > 0 ? consultant_details[0].name : '';
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
                url: $rootScope.IRISOrgServiceUrl + "/pharmacysales/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
//                        $rootScope.commonService.GetProductList('', '1', false, function (response2) {
//                            
//                        });
                        $scope.loadbar('hide');

                        $scope.data = response;
//                        $scope.data.patient_name = response.patient.fullname;
                        $scope.data.patient_guid = response.patient.patient_guid;
                        $scope.getConsultantDetail($scope.data.consultant_id);
                        $scope.getPaytypeDetail($scope.data.payment_type);
                        $scope.products = [];
//                        $scope.products = response2.productList;

                        $scope.saleItems = response.items;
//                        console.log($scope.saleItems);
                        angular.forEach($scope.saleItems, function (item, key) {
                            angular.extend($scope.saleItems[key], {
                                full_name: item.product.full_name,
                                batch_no: item.batch.batch_no,
                                batch_details: item.batch.batch_details,
                                expiry_date: item.batch.expiry_date
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
            sale = $filter('filter')($scope.displayedCollection, {sale_id: sale_id});

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

//        var changeTimer = false;
//
//        $scope.$watch('data.patient_name', function (newValue, oldValue) {
//            if (newValue != '') {
//
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
//                                $scope.patients = response.patients;
//                                $scope.loadbar('hide');
//                            }
//                    );
//                    changeTimer = false;
//                }, 300);
//            }
//        }, true);

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

                                exists = $filter('filter')($scope.saleItems, {product_id: item.product_id});
                                if (exists.length == 0) {
                                    $scope.saleItems.push($scope.inserted);
                                    ids.push(item.product_id);
                                }
                            });
                        });

                        $rootScope.commonService.GetBatchListByProduct(ids, function (response) {
                            $scope.batches = response.batchList;
                        });

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
    }]);