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
            $scope.errorData = $scope.msg.successMessage = '';
            $scope.isLoading = true;

            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysalereturn?addtfields=sale_return_list')
                    .success(function (saleList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = saleList;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading saleList!";
                    });
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

            //Payment types
            $rootScope.commonService.GetPaymentType(function (response) {
                $scope.paymentTypes = response;
            });

            if ($scope.data.formtype == 'update') {
                $scope.formtype = 'update';
                $scope.loadForm();
            } else {
                $scope.data.sale_date = moment().format('YYYY-MM-DD');
                $scope.addRow();
                $scope.formtype = 'add';
            }

            $scope.products = [];
            $scope.batches = [];

            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysale?fields=sale_id,bill_no,bill_no_with_patient')
                    .success(function (saleList) {
                        $scope.saleinvoice = saleList;
                        $timeout(function () {
                            $('.selectpicker').selectpicker('refresh');
                        }, 1000);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading saleList!";
                    });
        }

        $scope.getSaleReturnItems = function () {
            $scope.saleItems = [];
            var sale_id = $scope.data.sale_id;
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysales/' + sale_id + "?addtfields=sale_return")
                    .success(function (result) {
                        $scope.data.sale_date = result.sale_date;
                        $scope.data.patient_id = result.patient_id;
                        $scope.data.patient_name = result.patient_name ? result.patient_name : '-';
                        $scope.data.mobile_no = result.mobile_no ? result.mobile_no : '-';

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
                                total_returned_quantity: item.total_returned_quantity
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

            //Validate isNumer
            qty = !isNaN(qty) ? qty : 0;
            var disc_amount = disc_perc > 0 ? (item_amount * (disc_perc / 100)).toFixed(2) : 0;
            var total_amount = (item_amount - disc_amount).toFixed(2);

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
            });

            angular.extend(_that.data, {product_items: $scope.saleItems});
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
            return true;
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
                            sale.sale_date
                        ],
                        margin: [0, 0, 0, 10]
                    }
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

    }]);