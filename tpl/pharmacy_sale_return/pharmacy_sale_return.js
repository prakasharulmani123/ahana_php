app.controller('SaleReturnController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', '$q', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout, $q) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Expand table in Index page
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //Index Page
        $scope.loadSaleReturnItemList = function () {
            $rootScope.commonService.GetDay(function (response) {
                $scope.days = response;
            });
            $rootScope.commonService.GetMonth(function (response) {
                $scope.months = response;
            });
            $rootScope.commonService.GetYear(function (response) {
                $scope.years = response;
            });
            $scope.errorData = $scope.msg.successMessage = '';
            $scope.isLoading = true;

            $scope.maxSize = 5; // Limit number for pagination display number.  
            $scope.totalCount = 0; // Total number of items in all pages. initialize as a zero  
            $scope.pageIndex = 1; // Current page number. First page is 1.-->  
            $scope.pageSizeSelected = 10; // Maximum number of items per page.

            // pagination set up
            $scope.rowCollection = [];  // base collection
            //$scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $scope.getSaleReturnList();
        };

        $scope.getSaleReturnList = function () {
            var pageURL = $rootScope.IRISOrgServiceUrl + '/pharmacysalereturn/getsalereturn?addtfields=sale_return_list&pageIndex=' + $scope.pageIndex + '&pageSize=' + $scope.pageSizeSelected;

            if (typeof $scope.form_filter != 'undefined' && $scope.form_filter != '') {
                pageURL += '&s=' + $scope.form_filter;
            }
            if (typeof $scope.day != 'undefined' && $scope.day != '' && typeof $scope.month != 'undefined' && $scope.month != '' && typeof $scope.year != 'undefined' && $scope.year != '') {
                pageURL += '&dt=' + $scope.year + '-' + $scope.month + '-' + $scope.day;
            }
            $http.get(pageURL)
                    .success(function (saleReturnList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = saleReturnList.result;
                        $scope.totalCount = saleReturnList.totalCount;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading saleList!";
                    });
        }

        $scope.pageChanged = function () {
            $scope.getSaleReturnList();
        };
        //This method is calling from dropDown  
        $scope.changePageSize = function () {
            $scope.pageIndex = 1;
            $scope.getSaleReturnList();
        };
        //For Form
        $scope.formtype = '';
        $scope.initForm = function () {
            //Patients List
//            $rootScope.commonService.GetPatientList('', '1', false, function (response) {
//                $scope.patients = response.patientlist;
//            });
//            Above code hide for slow response.
            $scope.patients = [];
            $scope.sale_return_sales = false;
            $scope.allow_sale = '0';

            //Payment types
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
            });

            if ($scope.data.formtype == 'update') {
                $scope.formtype = 'update';
                $scope.loadForm();
            } else {
                $scope.SRdata = {};
                $scope.data.sale_id = '';
                $scope.data.sale_return_date = moment().format('YYYY-MM-DD');
                $scope.addRow();
                $scope.addSaleRow();
                $scope.formtype = 'add';
            }

            $scope.products = [];
            $scope.batches = [];

            $scope.productloader = '<i class="fa fa-spin fa-spinner"></i>';
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct?fields=product_id,full_name&not_expired=1&full_name_with_stock=1')
                    .success(function (products) {
                        $scope.saleproducts = products;
                        $scope.productloader = '';
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });

            $rootScope.commonService.GetHsnCode('1', false, function (response) {
                $scope.hsncodes = response.hsncodeList;
            });

        }

        $scope.getSaleReturnItems = function ($item, $model, $label) {
            $scope.data.sale_id = $item.sale_id;
            $scope.saleItems = [];
            var sale_id = $scope.data.sale_id;
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysales/' + sale_id + "?addtfields=sale_return")
                    .success(function (result) {
                        $scope.data.sale_date = result.sale_date;
                        $scope.data.patient_id = result.patient_id;
                        $scope.data.patient_name = result.patient_name ? result.patient_name : '-';
                        $scope.data.mobile_no = result.mobile_no ? result.mobile_no : '-';
                        $scope.data.bill_payment = result.bill_payment ? result.bill_payment : '-';
                        $scope.data.patient_group_name = result.patient_group_name ? result.patient_group_name : '-';
                        if (($scope.data.bill_payment == 'Cash')) {
                            $scope.allow_sale = '1';
                        } else {
                            $scope.totalsalepaidamount = result.billings_total_paid_amount;
                            $scope.totalbillamount = result.bill_amount;
                            $scope.totalsalebalanceamount = result.billings_total_balance_amount;
                            $scope.allow_sale = '0';
                        }

                        angular.forEach(result.items, function (item, key) {
                            $scope.inserted = {
                                product_id: item.product_id,
                                full_name: item.product.full_name,
                                batch_details: item.batch.batch_details,
                                batch_no: item.batch.batch_no,
                                batch_id: item.batch.batch_id,
                                available_qty: item.batch.available_qty,
                                expiry_date: item.batch.expiry_date,
                                sale_quantity: item.quantity,
                                quantity: 0,
                                free_quantity: item.free_quantity,
                                free_quantity_unit: item.free_quantity_unit,
                                sale_ret_rate: item.sale_rate,
                                discount_percent: item.discount_percent,
                                discount_amount: item.discount_amount,
                                vat_percent: item.vat_percent,
                                vat_amount: item.vat_amount,
                                total_amount: item.total_amount,
                                sale_ret_amount: item.sale_amount,
                                mrp: item.mrp,
                                sale_item_id: item.sale_item_id,
                                package_name: item.package_name,
                                package_unit: item.package_unit,
                                total_returned_quantity: item.total_returned_quantity,

                                hsn_no: item.hsn_no,
                                cgst_amount: item.cgst_amount,
                                cgst_percent: item.cgst_percent,
                                sgst_amount: item.sgst_amount,
                                sgst_percent: item.sgst_percent,
                                taxable_value: item.taxable_value,
                            };
                            $scope.saleItems.push($scope.inserted);

                            $scope.updateRow(key);
                        });
                    });
        }

        $scope.checkReturnQuantity = function (quantity, key) {
            if ($scope.formtype == 'update') {
                old = $scope.saleItems[key].old_quantity;
                if (old < quantity) {
                    sale_quantity = $scope.saleItems[key].sale_quantity; // Sale quantities
                    total_returned_quantity = $scope.saleItems[key].total_returned_quantity; // Prior returned quantities
                    total = parseFloat(quantity) + parseFloat(total_returned_quantity);

                    if (total > sale_quantity) {
                        return 'Qty Mismatch';
                    }
                } else {
                    stock = $scope.saleItems[key].available_qty; //Stock
                    package_unit = $scope.saleItems[key].package_unit;
                    current_qty = (old - quantity) * package_unit;

                    if (current_qty > stock) {
                        return 'No stock';
                    }
                }
            } else {
                sale_quantity = $scope.saleItems[key].sale_quantity; // Sale quantities
                total_returned_quantity = $scope.saleItems[key].total_returned_quantity; // Prior returned quantities
                total = parseFloat(quantity) + parseFloat(total_returned_quantity);

                if (total > sale_quantity) {
                    return 'Qty Exceed';
                }
            }
        };

        //Get selected patient mobile no.
        $scope.getPatientMobileNo = function (id) {
            var patient_id = id;
            var patient_mobile_no = $.grep($scope.patients, function (patient) {
                return patient.patient_id == patient_id;
            })[0].patient_mobile;
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
        $scope.addRow = function () {
            $scope.inserted = {
                full_name: '',
                batch_details: '',
                product_id: '',
                product_name: '',
                batch_no: '',
                expiry_date: '',
                mrp: '0',
                quantity: '0',
                item_amount: '0',
                discount_percent: '0',
                discount_amount: '0',
            };
            $scope.saleItems.push($scope.inserted);

            if ($scope.saleItems.length > 1) {
                $timeout(function () {
                    $scope.setFocus('full_name', $scope.saleItems.length - 1);
                });
            }
        };

        // Remove Sale Item
        $scope.removeSaleItem = function (index) {
            if ($scope.saleItems.length == 1) {
                alert('Can\'t Delete. New Sale Item must be atleast one.');
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

            $scope.loadbar('show');
            $scope.updateRow(key);
            $rootScope.commonService.GetBatchListByProduct(item.product_id, function (response) {
                $scope.batches = response.batchList;
                $scope.loadbar('hide');

                $scope.saleItems[key].batch_no = '';
                $scope.saleItems[key].expiry_date = '';
                $scope.saleItems[key].mrp = 0;
                $scope.saleItems[key].quantity = 0;
            });
        }

        //After barch choosed, then update some values in the row.
        $scope.updateBatchRow = function (item, model, label, key) {
//            alert(item.expiry_date);
            $scope.saleItems[key].batch_no = item.batch_no;
            $scope.saleItems[key].expiry_date = item.expiry_date;
            $scope.saleItems[key].mrp = item.mrp;
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
            var disc_perc = parseFloat($scope.saleItems[key].discount_percentage);
            var vat_perc = parseFloat($scope.saleItems[key].vat_percent);
            var cgst_perc = parseFloat($scope.saleItems[key].cgst_percent);
            var sgst_perc = parseFloat($scope.saleItems[key].sgst_percent);

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            var disc_amount = disc_perc > 0 ? (item_amount * (disc_perc / 100)).toFixed(2) : 0;
            var total_amount = (item_amount - disc_amount).toFixed(2);

            var item_amount = (qty * mrp).toFixed(2);
            var disc_amount = disc_perc > 0 ? (item_amount * (disc_perc / 100)).toFixed(2) : 0;
            var total_amount = (item_amount - disc_amount).toFixed(2);

//            var vat_amount = (item_amount * (vat_perc / 100)).toFixed(2); // Exculding vat
            var vat_amount = ((total_amount * vat_perc) / (100 + vat_perc)).toFixed(2); // Including vat
            var cgst_amount = ((total_amount * cgst_perc) / (100 + cgst_perc)).toFixed(2); // Including vat
            var sgst_amount = ((total_amount * sgst_perc) / (100 + sgst_perc)).toFixed(2); // Including vat

            $scope.saleItems[key].item_amount = item_amount;
            $scope.saleItems[key].discount_amount = disc_amount;
            $scope.saleItems[key].total_amount = total_amount;
            $scope.saleItems[key].vat_amount = vat_amount;

            $scope.saleItems[key].cgst_amount = cgst_amount;
            $scope.saleItems[key].sgst_amount = sgst_amount;
            $scope.saleItems[key].taxable_value = parseFloat(cgst_amount) + parseFloat(sgst_amount);

            $scope.updateSaleRate();
        }

        $scope.updateSaleRate = function () {

            var roundoff_amount = bill_amount = total_item_discount_amount = total_item_amount = 0;

            //Get Total Sale, VAT, Discount Amount
            var total_item_vat_amount = total_item_sale_amount = 0;
            angular.forEach($scope.saleItems, function (item) {
//                total_item_vat_amount = total_item_vat_amount + parseFloat(item.vat_amount);
                total_item_vat_amount = total_item_vat_amount + parseFloat(item.taxable_value);
                total_item_sale_amount = total_item_sale_amount + parseFloat(item.total_amount);
            });

            $scope.data.total_item_sale_amount = total_item_sale_amount.toFixed(2);
            $scope.data.total_item_vat_amount = total_item_vat_amount.toFixed(2);

            //Get Before Discount Amount (Total Sale Amount + Total VAT)
            var before_discount_total = (total_item_sale_amount).toFixed(2);

            //Get Discount Amount
            var disc_perc = parseFloat($scope.data.total_item_discount_percent);
            disc_perc = !isNaN(disc_perc) ? (disc_perc).toFixed(2) : 0;

            var disc_amount = disc_perc > 0 ? (total_item_sale_amount * (disc_perc / 100)).toFixed(2) : 0;
            $scope.data.total_item_discount_amount = disc_amount;

            var after_discount_item_amount = (parseFloat(before_discount_total) - parseFloat(disc_amount));
            $scope.data.total_item_amount = after_discount_item_amount;

            // Bill Amount = (Total Amount - Discount Amount) +- RoundOff
            var total_bill_amount = parseFloat(after_discount_item_amount);
            bill_amount = Math.round(total_bill_amount);
            roundoff_amount = Math.abs(bill_amount - total_bill_amount);

            $scope.data.roundoff_amount = roundoff_amount.toFixed(2);
            $scope.data.bill_amount = bill_amount.toFixed(2);
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";
            angular.extend(_that.data, {sale_items: ''});
            angular.extend(_that.data, {sale_items_bill: ''});

            $scope.data.sale_date = moment($scope.data.sale_date).format('YYYY-MM-DD');
            $scope.data.sale_return_date = moment($scope.data.sale_return_date).format('YYYY-MM-DD');

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
            });

            angular.extend(_that.data, {product_items: $scope.saleItems});

            //New Sales in sale return 
            angular.forEach($scope.SRsaleItems, function (SRsaleitem, key) {
                $scope.SRsaleItems[key].expiry_date = moment(SRsaleitem.expiry_date).format('YYYY-MM-DD');

                if (angular.isObject(SRsaleitem.full_name)) {
                    $scope.SRsaleItems[key].full_name = SRsaleitem.full_name.full_name;
                } else if (typeof SRsaleitem.full_name == 'undefined') {
                    $scope.SRsaleItems[key].product_id = '';
                }

                if (SRsaleitem.temp_hsn_no) {
                    $scope.SRsaleItems[key].hsn_no = SRsaleitem.temp_hsn_no;
                }

                if (angular.isObject(SRsaleitem.batch_details)) {
                    $scope.SRsaleItems[key].batch_details = SRsaleitem.batch_details.batch_details;
                } else if (typeof SRsaleitem.batch_details == 'undefined') {
                    $scope.SRsaleItems[key].batch_no = '';
                } else if ((SRsaleitem.batch_no == '0' || SRsaleitem.batch_no == '') && typeof SRsaleitem.batch_details !== 'undefined') {
                    $scope.SRsaleItems[key].batch_no = SRsaleitem.batch_details;
                }

                //Unset unwanted columns 
                delete SRsaleitem.alternate_product;
                delete SRsaleitem.alternateproducts;
//                delete saleitem.product_batches; // Need product batches if form success false.
            });
            if ($scope.sale_return_sales) {
                if ($scope.data.bill_payment == 'Cash') {
                    if (parseInt($scope.data.bill_amount) > parseInt($scope.SRdata.bill_amount)) {
                        $scope.Errormessage = 'Sale Return amount must be less than sale amount';
                        $timeout(function () {
                            $("#edit_products").trigger("click");
                        }, 100);
                        return false;
                    }
                } else {
                    $scope.credit_bill_pending_amount = parseInt($scope.data.bill_amount) - parseInt($scope.totalsalebalanceamount);
                    if (parseInt($scope.credit_bill_pending_amount) > parseInt($scope.SRdata.bill_amount)) {
                        $scope.Errormessage = 'Sale Return amount must be less than sale amount';
                        $timeout(function () {
                            $("#edit_products").trigger("click");
                        }, 100);
                        return false;
                    } else {
                        $scope.data.creditbillamount = $scope.totalsalebalanceamount;
                    }
                }
                angular.extend(_that.data, {sale_items: $scope.SRsaleItems});
                angular.extend(_that.data, {sale_items_bill: $scope.SRdata});
            }

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacysalereturn/savesalereturn',
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        if (response.success == true) {
                            $scope.loadbar('hide');
                            $scope.msg.successMessage = 'Sale added successfully';
                            $scope.data = {};
                            $timeout(function () {
                                $state.go('pharmacy.saleReturn');
                            }, 1000)
                        } else {
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

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/pharmacysalereturns/" + $state.params.id + "?addtfields=sale_return",
                method: "GET"
            }).success(
                    function (response) {
//                        $rootScope.commonService.GetProductList('', '1', false, function (response2) {
                        $scope.loadbar('hide');

                        $scope.data = response;
//                            $scope.products = response2.productList;

                        $scope.saleItems = response.items;
                        angular.forEach($scope.saleItems, function (item, key) {
                            angular.extend($scope.saleItems[key], {
                                full_name: item.product.full_name,
                                batch_no: item.batch.batch_no,
                                batch_details: item.batch.batch_details,
                                expiry_date: item.batch.expiry_date,
                                available_qty: item.batch.available_qty,
                                old_quantity: item.quantity,
                            });
                            $timeout(function () {
                                $scope.showOrHideProductBatch('hide', key);
                            });
                        });

                        $timeout(function () {
                            delete $scope.data.items;
                        }, 3000);
//                        });
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.saleReturnDetail = function (sale_return_id) {
            $scope.loadbar('show');
            var deferred = $q.defer();
            deferred.notify();

            $scope.errorData = "";
            $http.get($rootScope.IRISOrgServiceUrl + "/pharmacysalereturns/" + sale_return_id + "?addtfields=sale_return")
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.data2 = response;
                        $scope.saleItems2 = response.items;
                        angular.forEach($scope.saleItems2, function (item, key) {
                            angular.extend($scope.saleItems2[key], {
                                full_name: item.product.full_name,
                                batch_no: item.batch.batch_no,
                                batch_details: item.batch.batch_details,
                                expiry_date: item.batch.expiry_date,
                                available_qty: item.batch.available_qty,
                                old_quantity: item.quantity,
                            });
                        });
                        deferred.resolve();
                    })
                    .error(function () {
                        $scope.loadbar('hide');
                        $scope.errorData = "An Error has occured while loading sale return!";
                        deferred.reject();
                    });

            return deferred.promise;
        }

        $scope.printSaleReturn = function (sale_return_id) {
            $scope.saleReturnDetail(sale_return_id).then(function () {
                delete $scope.data2.items;
                $scope.btnid = 'print';
                save_success();
            });
        }

        /*PRINT BILL*/
        $scope.printHeader = function () {
            return {
                text: "Sale Return Bill",
                margin: 5,
                alignment: 'center'
            };
        }

        $scope.printFooter = function () {
//            return true;
        }

        $scope.printStyle = function () {
            return {
                header: {
                    bold: true,
                    color: '#000',
                    fontSize: 11
                },
                demoTable: {
                    color: '#000',
                    fontSize: 10
                }
            };
        }

        $scope.printloader = '';
        $scope.printContent = function () {
            var generated_by = $scope.app.username;

            var content = [];
            var saleReturnInfo = [];
            var saleReturnItems = [];

            var result_count = Object.keys($scope.saleItems2).length;
            var index = 1;
            var loop_count = 0;
            var sale = $scope.data2;

            saleReturnItems.push([
                {text: 'S.No', style: 'header'},
                {text: 'Product Name', style: 'header'},
                {text: 'Batch No', style: 'header'},
                {text: 'Exp Date', style: 'header'},
                {text: 'Qty', style: 'header'},
                {text: 'MRP', style: 'header'},
                {text: 'Line Total', style: 'header'},
                {text: 'Dis %', style: 'header'},
                {text: 'Dis Amt', style: 'header'},
                {text: 'P.Vat%', style: 'header'},
                {text: 'Vat Amt', style: 'header'},
                {text: 'Total Amt', style: 'header'},
            ]);

            angular.forEach($scope.saleItems2, function (row, key) {
                saleReturnItems.push([
                    index.toString(),
                    row.full_name,
                    row.batch_no,
                    moment(row.expiry_date).format('MM/YY'),
                    row.quantity.toString(),
                    row.mrp,
                    row.item_amount,
                    (row.discount_percent ? row.discount_percent : '-'),
                    row.discount_amount,
                    row.vat_percent,
                    row.vat_amount,
                    row.total_amount,
                ]);
                index++;
                loop_count++;
            });

            saleReturnInfo.push({
                columns: [
                    {
                        text: [
                            {text: 'Invoice No: ', bold: true},
                            sale.bill_no
                        ],
                        margin: [0, 0, 0, 10]
                    },
                    {
                        text: [
                            {text: 'Patient Name: ', bold: true},
                            sale.patient_name
                        ],
                        margin: [0, 0, 0, 10]
                    }
                ]
            }, {
                columns: [
                    {
                        text: [
                            {text: 'Invoice Date: ', bold: true},
                            moment(sale.created_at).format('YYYY-MM-DD'),
                        ],
                        margin: [0, 0, 0, 10]
                    },
                    {
                        text: [
                            {text: 'Sale Type: ', bold: true},
                            sale.sale_payment_type,
                        ],
                        margin: [0, 0, 0, 10]
                    },
                ]
            }, {
                style: 'demoTable',
                margin: [0, 0, 0, 20],
                table: {
                    headerRows: 1,
                    widths: [30, '*', 'auto', 50, 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto'],
                    body: saleReturnItems,
                },
//                pageBreak: (loop_count === result_count ? '' : 'after'),
            }, {
                columns: [
                    {
                        alignment: 'right',
                        text: [
                            {text: 'Total Vat Amount: ', bold: true},
                            sale.total_item_vat_amount + '\n\n',
                            {text: 'Total Item Sale Return Amount: ', bold: true},
                            sale.total_item_sale_amount + '\n\n',
                            {text: 'Disc(' + sale.total_item_discount_percent + ') %: ', bold: true},
                            sale.total_item_discount_amount + '\n\n',
                            {text: 'Total Return Amount: ', bold: true},
                            sale.total_item_amount + '\n\n',
                            {text: 'Round Off: ', bold: true},
                            sale.roundoff_amount + '\n\n',
                            {text: 'Bill Amount: ', bold: true},
                            sale.bill_amount + '\n\n',
                        ],
                    }
                ]
            });
            content.push(saleReturnInfo);
            if (index == result_count) {
                $scope.printloader = '';
            }
            return content;
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
                        pageSize: 'A4',
                        pageOrientation: 'landscape',
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

        var canceler;
        $scope.getSaleinvoices = function (bill_no) {
            if (canceler)
                canceler.resolve();
            canceler = $q.defer();

            $scope.show_patient_loader = true;

            return $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/pharmacysale/getsalebillno?bill_no=' + bill_no + '&addtfields=sale_bill_search',
                timeout: canceler.promise,
            }).then(
                    function (response) {
                        $scope.saleinvoice = [];
                        $scope.saleinvoice = response.data;
                        $scope.loadbar('hide');
                        $scope.show_patient_loader = false;
                        return $scope.saleinvoice;
                    }
            );
        };
//Sale and Sale Return Concept
        $scope.SRsaleItems = [];
        // Add first row in sale item table.
        $scope.addSaleRow = function (focus) {
            $scope.sale_item_error = '';
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
            if ($scope.SRsaleItems.length > 0) {
                if ((!$scope.SRsaleItems[$scope.SRsaleItems.length - 1].product_id) || (!$scope.SRsaleItems[$scope.SRsaleItems.length - 1].batch_no)) {
                    $scope.sale_item_error = "Kindly fill the items details";
                } else {
                    $scope.SRsaleItems.push($scope.inserted);
                }
            } else {
                $scope.SRsaleItems.push($scope.inserted);
            }

            if (focus) {
                if ($scope.SRsaleItems.length > 1) {
                    $timeout(function () {
                        $scope.setFocus('full_name', $scope.saleItems.length - 1);
                    });
                }
            }

            if ($scope.SRsaleItems.length > 6) {
                $scope.css = {
                    'style': 'height:360px; overflow-y: auto; overflow-x: hidden;',
                };
            }
        };

        $scope.SRupdateProductRow = function (item, model, label, key) {
            var selectedObj = $filter('filter')($scope.saleproducts, {product_id: item.product_id}, true)[0];
            $scope.productDetail(item.product_id, selectedObj).then(function () {
                $scope.SRsaleItems[key].product_id = selectedObj.product_id;
                $scope.SRsaleItems[key].product_name = selectedObj.product_name;
                $scope.SRsaleItems[key].product_location = selectedObj.product_location;
                $scope.SRsaleItems[key].full_name = selectedObj.full_name;
                $scope.SRsaleItems[key].vat_percent = selectedObj.salesVat.vat;
                $scope.SRsaleItems[key].package_name = selectedObj.salesPackageName;
                $scope.SRsaleItems[key].generic_id = selectedObj.generic_id;
                $scope.SRsaleItems[key].product_batches = selectedObj.product_batches;
                if (selectedObj.gst != '-') {
                    $scope.SRsaleItems[key].sgst_percent = (parseFloat(selectedObj.gst) / 2).toFixed(2);
                    $scope.SRsaleItems[key].cgst_percent = (parseFloat(selectedObj.gst) / 2).toFixed(2);
                } else {
                    $scope.SRsaleItems[key].sgst_percent = 2.5;
                    $scope.SRsaleItems[key].cgst_percent = 2.5;
                }
                $scope.SRsaleItems[key].temp_hsn_no = selectedObj.hsnCode;

                $scope.getreadyBatch(selectedObj, key);
                $scope.productInlineAlert(selectedObj, key);
                if (selectedObj.hsnCode)
                    $scope.showOrHideRowEdit('hide', key);

                $scope.SRupdateRow(key);
            });
        }

        $scope.productDetail = function (product_id, product_obj) {
            var deferred = $q.defer();
            deferred.notify();
            var Fields = 'product_name,product_location,product_reorder_min,full_name,salesVat,salesPackageName,availableQuantity,generic_id,product_batches,hsnCode,originalQuantity,gst';

            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproducts/' + product_id + '?fields=' + Fields + '&addtfields=pharm_sale_prod_json&full_name_with_stock=1')
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

        $scope.getreadyBatch = function (item, key) {
            $scope.SRsaleItems[key].batch_details = '';
            $scope.SRsaleItems[key].batch_no = '';
            $scope.SRsaleItems[key].expiry_date = '';
            $scope.SRsaleItems[key].mrp = 0;
            $scope.SRsaleItems[key].quantity = 0;
            if (item.availableQuantity <= 0) {
                $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbygeneric?generic_id=' + item.generic_id + '&addtfields=pharm_sale_alternateprod')
                        .success(function (product) {
                            //For alternate medicines
                            item.alternateproducts = product.productList.filter(function (n) {
                                return (n.product_id != item.product_id && n.product_batches_count > '0')
                            });
                            $scope.SRsaleItems[key].alternateproducts = item.alternateproducts;
                            if ($scope.SRsaleItems[key].alternateproducts.length) {
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
            $scope.SRsaleItems[key].min_reorder_msg = '';
            $scope.SRsaleItems[key].out_of_stock_msg = '';

            if (item.availableQuantity == 0) {
                $scope.SRsaleItems[key].out_of_stock_msg = 'Out of stock';
            } else if (item.availableQuantity <= item.product_reorder_min) {
                $scope.SRsaleItems[key].min_reorder_msg = 'reached min order level (' + item.product_reorder_min + ')';
            }
        }

        $scope.showOrHideRowEdit = function (mode, key) {
            if (mode == 'hide') {
                i_addclass = t_removeclass = 'hide';
                i_removeclass = t_addclass = '';
            } else {
                i_addclass = t_removeclass = '';
                i_removeclass = t_addclass = 'hide';
            }
            $('#i_hsn_no_' + key).addClass(i_addclass).removeClass(i_removeclass);

            $('#t_hsn_no_' + key).addClass(t_addclass).removeClass(t_removeclass);
        }

        $scope.SRupdateRow = function (key, column, tableform) {
            //Get Data
            var qty = parseFloat($scope.SRsaleItems[key].quantity);
            var mrp = parseFloat($scope.SRsaleItems[key].mrp);
            var disc_perc = parseFloat($scope.SRsaleItems[key].discount_percentage);
            var disc_amount = parseFloat($scope.SRsaleItems[key].discount_amount);
            var vat_perc = parseFloat($scope.SRsaleItems[key].vat_percent);
            var cgst_perc = parseFloat($scope.SRsaleItems[key].cgst_percent);
            var sgst_perc = parseFloat($scope.SRsaleItems[key].sgst_percent);

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            disc_perc = !isNaN(disc_perc) ? disc_perc : 0;
            disc_amount = !isNaN(disc_amount) ? disc_amount : 0;
            vat_perc = !isNaN(vat_perc) ? vat_perc : 0;

            var item_amount = (qty * mrp).toFixed(2);
            if (column && column == 'discount_amount')
                var disc_perc = disc_amount > 0 ? ((disc_amount / item_amount) * 100).toFixed(2) : 0;
            if (column && column == 'discount_percentage')
                var disc_amount = disc_perc > 0 ? (item_amount * (disc_perc / 100)).toFixed(2) : 0;
            var total_amount = (item_amount - disc_amount).toFixed(2);
//            var vat_amount = (item_amount * (vat_perc / 100)).toFixed(2); // Exculding vat
            var vat_amount = ((total_amount * vat_perc) / (100 + vat_perc)).toFixed(2);

            var taxable_value = ((mrp / (100 + sgst_perc + cgst_perc)) * 100).toFixed(2);

            //var cgst_amount = ((total_amount * cgst_perc) / (100 + cgst_perc)).toFixed(2); // Including vat
            //var sgst_amount = ((total_amount * sgst_perc) / (100 + sgst_perc)).toFixed(2); // Including vat
            var cgst_amount = (((taxable_value * cgst_perc) / 100) * qty).toFixed(2); // Including vat
            var sgst_amount = (((taxable_value * sgst_perc) / 100) * qty).toFixed(2); // Including vat

            $scope.SRsaleItems[key].item_amount = item_amount;
            $scope.SRsaleItems[key].discount_percentage = disc_perc;
            $scope.SRsaleItems[key].discount_amount = disc_amount;
            $scope.SRsaleItems[key].total_amount = total_amount;
            $scope.SRsaleItems[key].vat_amount = vat_amount;

            $scope.SRsaleItems[key].cgst_amount = cgst_amount;
            $scope.SRsaleItems[key].sgst_amount = sgst_amount;
            $scope.SRsaleItems[key].taxable_value = taxable_value;

            if (tableform) {
                angular.forEach(tableform.$editables, function (editableValue, editableKey) {
                    if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'discount_percentage') {
                        editableValue.scope.$data = $scope.SRsaleItems[key].discount_percentage;
                    }
                });

                angular.forEach(tableform.$editables, function (editableValue, editableKey) {
                    if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'discount_amount') {
                        editableValue.scope.$data = $scope.SRsaleItems[key].discount_amount;
                    }
                });
            }
            $scope.SRupdateSaleRate();
        }

        $scope.SRupdateSaleRate = function (column) {

            var roundoff_amount = bill_amount = total_item_discount_amount = total_item_amount = 0;

            //Get Total Sale, VAT, Discount Amount
            var total_item_vat_amount = total_item_sale_amount = 0;
            angular.forEach($scope.SRsaleItems, function (item) {
                total_item_vat_amount = total_item_vat_amount + parseFloat(item.taxable_value);
                total_item_sale_amount = total_item_sale_amount + parseFloat(item.total_amount);
            });

            $scope.SRdata.total_item_sale_amount = total_item_sale_amount.toFixed(2);
            $scope.SRdata.total_item_vat_amount = total_item_vat_amount.toFixed(2);

            //Get Before Discount Amount (Total Sale Amount + Total VAT)
//            var before_discount_total = (total_item_sale_amount + total_item_vat_amount).toFixed(2); // Exculding vat
            var before_discount_total = (total_item_sale_amount).toFixed(2); // Inculding vat

            if (column && column == 'amount')
            {
                var disc_amount = parseFloat($scope.SRdata.total_item_discount_amount);
                disc_amount = !isNaN(disc_amount) ? (disc_amount).toFixed(2) : 0;

                var disc_perc = disc_amount > 0 ? ((disc_amount / before_discount_total) * 100).toFixed(2) : 0;
                $scope.SRdata.total_item_discount_percent = disc_perc;
            } else {
                var disc_perc = parseFloat($scope.SRdata.total_item_discount_percent);
                disc_perc = !isNaN(disc_perc) ? (disc_perc).toFixed(2) : 0;

                var disc_amount = disc_perc > 0 ? (total_item_sale_amount * (disc_perc / 100)).toFixed(2) : 0;
                $scope.SRdata.total_item_discount_amount = disc_amount;
            }

            var after_discount_item_amount = (parseFloat(before_discount_total) - parseFloat(disc_amount));
            $scope.SRdata.total_item_amount = after_discount_item_amount.toFixed(2);

            //Get Welfare Amount
            var welfare = 0;
            if ($scope.data.welfare_amount) {
                var welfare = parseFloat($scope.SRdata.welfare_amount).toFixed(2);
            }

            // Bill Amount = (Total Amount - Discount Amount) +- RoundOff
            var total_bill_amount = parseFloat(after_discount_item_amount) + parseFloat(welfare);
            bill_amount = Math.round(total_bill_amount);
            roundoff_amount = Math.abs(bill_amount - total_bill_amount);

            $scope.SRdata.roundoff_amount = roundoff_amount.toFixed(2);
            $scope.SRdata.bill_amount = bill_amount.toFixed(2);
            $scope.SRdata.amount_received = bill_amount;
            $scope.updateBalance();
            $scope.updateBatch('update');
        }

        $scope.updateBalance = function () {
            $scope.SRdata.balance = $scope.SRdata.amount_received - $scope.SRdata.bill_amount;
        }

        $scope.updateBatch = function (action) {
            angular.forEach($scope.SRsaleItems, function (item, key) {
                var item_product_id = item.product_id;
                var item_expiry_date = item.expiry_date;
                var item_batch_no = item.batch_no;
                var item_batch_details = item.batch_details;
                var item_quantity = item.quantity;

                angular.forEach($scope.SRsaleItems, function (item1, key1) {
                    if (key != key1) {
                        if (item_product_id == item1.product_id) {
                            angular.forEach(item1.product_batches, function (batch) {
                                if ((batch.batch_no == item_batch_no) && (batch.expiry_date == item_expiry_date)) {
                                    if (action == 'update') {
                                        batch.available_qty = batch.originalQuantity - item_quantity;
                                        var batch_qty = batch.batch_details.split(" / ");
                                        batch_qty[1] = batch.originalQuantity - item_quantity;
                                        batch.batch_details = batch_qty[0] + ' / ' + batch_qty[1];
                                    } else {
                                        batch.available_qty = batch.originalQuantity;
                                        var batch_qty = batch.batch_details.split(" / ");
                                        batch_qty[1] = batch.originalQuantity;
                                        batch.batch_details = batch_qty[0] + ' / ' + batch_qty[1];
                                    }

                                }
                            });
                        }
                    }
                });
            });
        }

        $scope.SRupdateBatchRow = function (batch, key) {
            var prod_batches = $scope.SRsaleItems[key].product_batches;
            var selected = $filter('filter')(prod_batches, {batch_details: batch}, true);
            if (selected.length > 0) {
                item = selected[0];
                $scope.SRsaleItems[key].batch_details = item.batch_details;
                $scope.SRsaleItems[key].batch_no = item.batch_no;
                $scope.SRsaleItems[key].expiry_date = item.expiry_date;
//            $scope.saleItems[key].mrp = item.mrp;
                $scope.SRsaleItems[key].mrp = item.per_unit_price;

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
                $scope.SRsaleItems[key].exp_warning = 'short expiry drug';
            } else {
                $scope.SRsaleItems[key].exp_warning = '';
            }
        };

        $scope.SRupdateColumn = function ($data, key, column, tableform) {
            $scope.SRsaleItems[key][column] = $data;
            $scope.SRupdateRow(key, column, tableform);
        }

        $scope.SRremoveSaleItem = function (index) {
            if ($scope.SRsaleItems.length == 1) {
                alert('Can\'t Delete. Sale Item must be atleast one.');
                return false;
            }
            $scope.SRremoveSaleRow(index);
        };

        $scope.SRremoveSaleRow = function (index) {
            $scope.updateBatch('delete');
            $scope.SRsaleItems.splice(index, 1);
            $scope.SRupdateSaleRate();
            $timeout(function () {
                $scope.setFocus('full_name', $scope.SRsaleItems.length - 1);
            });

            if ($scope.SRsaleItems.length <= 6) {
                $scope.css = {
                    'style': '',
                };
            }
        };

        $scope.$watch('data.bill_amount', function (newValue, oldValue) {
            if (typeof newValue !== 'undefined' && newValue != '') {
                if (($scope.data.bill_payment != 'Cash')) {
                    if (parseInt(newValue) > parseInt($scope.totalsalebalanceamount)) {
                        $scope.allow_sale = '1';
                        $scope.data.new_sale_amount = parseInt($scope.data.bill_amount) - parseInt($scope.totalsalebalanceamount);
                    } else {
                        $scope.allow_sale = '0';
                        $scope.data.new_sale_amount = '0.00';
                    }
                } else {
                    $scope.data.new_sale_amount = $scope.data.bill_amount;
                }
            }
        });
        
        $scope.$watch('allow_sale', function (newValue, oldValue) {
            if (typeof newValue !== 'undefined' && newValue != '') {
                if(newValue == '0') {
                    $scope.sale_return_sales = false;
                }
            }
        });

        $scope.showExpiryDate = function (saleitem) {
            if (saleitem.expiry_date) {
                return moment(saleitem.expiry_date).format('MMM YYYY');
            } else {
                return 'empty';
            }
        };

        $scope.checkInput = function (data, key, index) {
            if ($scope.sale_return_sales) {
                item = $scope.SRsaleItems[key];
                if (typeof item != 'undefined') {
                    if (key > 0 && item.product_name == '' && item.batch_no == '' && item.quantity == 0) {
                        $scope.removeSaleItem(index);
                    } else {
                        if (!data) {
                            return "Not empty";
                        }
                    }
                }
            }
        };

        $scope.checkHsn = function (data, key, index) {
            if ($scope.sale_return_sales) {
                item = $scope.SRsaleItems[key];
                if (typeof item != 'undefined') {
                    if (key > 0 && item.product_name == '' && item.batch_no == '' && item.quantity == 0) {

                    } else {
                        if (!data && !item.hsn_no && !item.temp_hsn_no) {
                            return "Not empty";
                        }
                    }
                }
            }
        };
        
        $scope.checkNewSale = function (a) {
            if(a) {
                $scope.sale_return_sales = true;
            } else {
                $scope.sale_return_sales = false;
            }
        }

    }]);