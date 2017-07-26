app.controller('PrescriptionController', ['$rootScope', '$scope', '$anchorScroll', '$http', '$state', '$filter', '$modal', '$log', '$timeout', 'IO_BARCODE_TYPES', 'toaster', 'PrescriptionService', '$q', function ($rootScope, $scope, $anchorScroll, $http, $state, $filter, $modal, $log, $timeout, IO_BARCODE_TYPES, toaster, PrescriptionService, $q) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';
        $scope.today = new Date();

        //Start Init Variables, Objects, Arrays
        $scope.pres_status = 'current';
        $scope.enc = {};
        $scope.drugs = {};
        $scope.routes = {};
        $scope.frequencies = {};
        //Stop Init

        //Start Watch Functions
        $scope.$watch('patientObj.patient_id', function (newValue, oldValue) {
            $scope.spinnerbar('show');
            if (typeof newValue !== 'undefined' && newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;
                    if (response != null) {
                        $scope.spinnerbar('hide');
                        $scope.enc.selected = $scope.encounters[0];
                        if ($scope.encounters[0].encounter_type == 'IP') {
                            $scope.data.consultant_id = $scope.encounters[0].liveAdmission.consultant_id;
                            $scope.getConsultantFreq();
                        } else if ($scope.encounters[0].encounter_type == 'OP') {
                            $scope.data.consultant_id = $scope.encounters[0].liveAppointmentBooking.consultant_id;
                            $scope.getConsultantFreq();
                        }
                        var actEnc = $filter('filter')($scope.encounters, {status: '1'});
                        $scope.all_encounters = actEnc;
                        $scope.data.encounter_id = $scope.enc.selected.encounter_id;
                        $scope.default_encounter_id = $scope.data.encounter_id;
                    }
                }, 'prescription');
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            $scope.spinnerbar('show');
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.spinnerbar('hide');
                PrescriptionService.setPatientId($scope.patientObj.patient_id);
                $scope.loadPrevPrescriptionsList();
                $scope.loadSideMenu();
                $scope.$emit('encounter_id', newValue);
            }
        }, true);

        //Always Form visible
        $scope.$watch('tableform.$visible', function () {
            $scope.tableform.$show();
        });
        //Stop Watch Functions

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.clearPrescription = function () {
//            $scope.data.consultant_id = '';
            $scope.prescription = '';
            $scope.data.prescriptionItems = [];
            PrescriptionService.deleteAllPrescriptionItem();
        };

        $scope.priceTotal = function () {
            total = 0;
            angular.forEach($scope.data.prescriptionItems, function (item) {
                total = total + parseFloat(item.total);
            });
            return total;
        }

        $scope.numberDaysChange = function (days, item, key, tableform) {
            if (typeof days != 'undefined') {
//                $scope.data.prescriptionItems[key].frequency = $('#freq_' + key + '_' + item.freqType + ' input').val();
                $scope.data.prescriptionItems[key].frequency = item.frequency;
                $scope.data.prescriptionItems[key].number_of_days = days;
                $scope.data.prescriptionItems[key].qty = $scope.calculate_qty($scope.data.prescriptionItems[key].frequency, days, item.product_description_id, item.description_name);
                $scope.data.prescriptionItems[key].total = $scope.calculate_price($scope.data.prescriptionItems[key].qty, item.price);
                $scope.data.prescriptionItems[key].in_stock = (parseInt(item.available_quantity) > parseInt($scope.data.prescriptionItems[key].qty));
            } else {
                $scope.data.prescriptionItems[key].number_of_days = '';
            }

            if (days == 0) {
                $scope.data.prescriptionItems[key].available_quantity = 0;
            }

            //Number of days update in the editable form 
            angular.forEach(tableform.$editables, function (editableValue, editableKey) {
                if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'number_of_days') {
                    editableValue.scope.$data = $scope.data.prescriptionItems[key].number_of_days;
                }
            });

            //Qty update in the editable form 
            angular.forEach(tableform.$editables, function (editableValue, editableKey) {
                if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'qty') {
                    editableValue.scope.$data = $scope.data.prescriptionItems[key].qty;
                }
            });
        };

        $scope.qtyChange = function (qty, item, key, tableform) {
            if (typeof qty != 'undefined') {
                $scope.data.prescriptionItems[key].total = $scope.calculate_price(qty, item.price);
                $scope.data.prescriptionItems[key].in_stock = (parseInt(item.available_quantity) > parseInt(qty));
            }
        };

        $scope.loadSideMenu = function () {
            //Get Notes
            $http.get($rootScope.IRISOrgServiceUrl + '/patientnotes/getpatientnotes?patient_id=' + $state.params.id)
                    .success(function (notes) {

                        $scope.child.notes = [];
                        angular.forEach(notes.result, function (result) {
                            angular.forEach(result.all, function (note) {
                                $scope.child.notes.push(note);
                            });
                        });

//                        var unseen = $filter('filter')($scope.child.notes, {seen_by: 0});
//                        $scope.unseen_notes = unseen.length;
                        $scope.unseen_notes = notes.usernotes;
                        $scope.unseen_notes_count = notes.usernotes.length;

                        angular.forEach($scope.child.notes, function (note) {
                            note.seen_by = 1;
                        });

                        angular.forEach(notes.usernotes, function (note) {
                            seen_filter_note = $filter('filter')($scope.child.notes, {pat_note_id: note.note_id});

                            if (seen_filter_note.length > 0) {
                                seen_filter_note[0].seen_by = 0;
                            }
                        });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientnote!";
                    });

            //Get Vitals
            $http.get($rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?addtfields=eprvitals&patient_id=' + $state.params.id)
                    .success(function (vitals) {
                        $scope.child.vitals = [];
                        angular.forEach(vitals.result, function (result) {
                            angular.forEach(result.all, function (vital) {
                                $scope.child.vitals.push(vital);
                            });
                        });

                        $scope.unseen_vitals = vitals.uservitals;
                        $scope.unseen_vitals_count = vitals.uservitals.length;

                        angular.forEach($scope.child.vitals, function (vital) {
                            vital.seen_by = 1;
                        });

                        angular.forEach(vitals.uservitals, function (vital) {
                            seen_filter_vital = $filter('filter')($scope.child.vitals, {vital_id: vital.vital_id});

                            if (seen_filter_vital.length > 0) {
                                seen_filter_vital[0].seen_by = 0;
                            }
                        });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientvitals!";
                    });

            //Get Fav
            $scope.getFav();
        }

        $scope.getFav = function () {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientprescriptionfavourite/getpatientprescriptionfavourite?patient_id=' + $state.params.id)
                    .success(function (favourites) {
                        $scope.child.favourites = favourites.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientvitals!";
                    });
        }

        //For Form
        $scope.initForm = function () {
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacydrugclass')
                    .success(function (response) {
                        $scope.drugs = response;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading drugclass!";
                    });

            $http.get($rootScope.IRISOrgServiceUrl + '/genericname')
                    .success(function (response) {
                        $scope.allgenerics = response;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading generics!";
                    });

            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
//            $rootScope.commonService.GetPatientRoute('', '1', false, function (response) {
//                $scope.routes = response.routelist;
//            });
            $rootScope.commonService.GetPatientFrequency('', '1', false, function (response) {
                $scope.frequencies = response.frequencylist;
            });

            $scope.data.next_visit = moment().format('YYYY-MM-DD');
            $scope.getDays();

            $("#current_prescription").focus();
        }

        $scope.generics = [];
        $scope.products = [];
        $scope.getGeneric = function ($item, $model, $label) {
//            &full_name_with_stock=1
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getgenericlistbydrugclass?drug_class_id=' + $item.drug_class_id + '&addtfields=presc_search')
                    .success(function (response) {
                        $scope.generics = response.genericList;
                        $scope.products = $scope.allproducts = response.productList;
                    }, function (x) {
                        $scope.errorData = "An Error has occured while loading generic!";
                    });
        }

        $scope.getDrugProduct = function ($item, $model, $label) {
//            &full_name_with_stock=1
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getdrugproductbygeneric?generic_id=' + $item.generic_id + '&addtfields=presc_search')
                    .success(function (response) {
                        $scope.addData = {};
                        $scope.addData = {
                            drug_class: response.drug,
                            generic: $item,
                        };
                        $scope.products = $scope.allproducts = response.productList;
                    }, function (x) {
                        $scope.errorData = "An Error has occured while loading generic!";
                    });
        }

        $scope.getRelatedProducts = function (generic_id) {
            var deferred = $q.defer();
            deferred.notify();

            $scope.errorData = "";
//            &full_name_with_stock=1
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbygeneric?generic_id=' + generic_id + '&addtfields=presc_search')
                    .success(function (response) {
                        $scope.products = $scope.allproducts = response.productList;
                        deferred.resolve();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading related products!";
                        deferred.reject();
                    });

            return deferred.promise;
        }

        $scope.watchDrug = function (search_form, selector) {
            if (search_form) {
                if (selector.addData.drug_class == '') {
                    $scope.reset();
                }
            }
        }

        $scope.reset = function () {
            $('#advanceSearchForm')[0].reset();
            $scope.addData = {};
            $scope.generics = [];
            $scope.products = [];
            $scope.routes = {};
        }

        $scope.setGeneric = function () {
            result = $filter('filter')($scope.generics, {generic_id: $scope.addData.product.generic_id});
            if (result.length > 0)
                $scope.addData.generic = result[0];
        }

        $scope.setProductId = function ($data, key, tableform) {
            result = $filter('filter')($scope.data.prescriptionItems[key].all_products, {full_name: $data});
            if (result.length > 0) {
                qty_count = $scope.calculate_qty($scope.data.prescriptionItems[key].frequency, $scope.data.prescriptionItems[key].number_of_days, result[0].product_description_id, result[0].description_name);
                if (qty_count > 0) {
                    $scope.data.prescriptionItems[key].product_id = result[0].product_id;
                    $scope.data.prescriptionItems[key].description_routes = [];
                    $scope.data.prescriptionItems[key].description_routes = result[0].description_routes;
                    $scope.data.prescriptionItems[key].available_quantity = result[0].availableQuantity;
                    $scope.data.prescriptionItems[key].in_stock = (parseInt(result[0].availableQuantity) > parseInt(qty_count));
                    $scope.data.prescriptionItems[key].price = result[0].latest_price;
                    $scope.data.prescriptionItems[key].product_description_id = result[0].product_description_id;
                    $scope.data.prescriptionItems[key].description_name = result[0].description_name;
                    $scope.data.prescriptionItems[key].qty = qty_count;
                    $scope.data.prescriptionItems[key].total = $scope.calculate_price(qty_count, result[0].latest_price);

                    angular.forEach(tableform.$editables, function (editableValue, editableKey) {
                        if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'qty') {
                            editableValue.scope.$data = $scope.data.prescriptionItems[key].qty;
                        }
                    });
                }
            }
        }

        $scope.setRouteId = function ($data, key) {
            result = $filter('filter')($scope.data.prescriptionItems[key].description_routes, {route_name: $data});
            if (result.length > 0) {
                $scope.data.prescriptionItems[key].route_id = result[0].route_id;
            }
        }

        $scope.showProduct = function (item) {
            var selected = [];
            if (item.product_id) {
                selected = $filter('filter')($scope.all_products, {product_id: item.product_id});
            }
            return selected.length ? selected[0].full_name : 'Not set';
        }

        $scope.showRoute = function (item) {
            var selected = [];
            if (item.route_id) {
                selected = $filter('filter')($scope.all_products, {product_id: item.product_id});
            }
            return selected.length ? selected[0].full_name : 'Not set';
        }

        $scope.getProduct = function ($item, $model, $label) {
            if (!$item)
                $item = $scope.addData.generic;

            result = $filter('filter')($scope.allproducts, {generic_id: $item.generic_id});
            if (result.length > 0)
                $scope.products = result;

//            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbygeneric?generic_id=' + $item.generic_id)
//                    .success(function (response) {
//                        $scope.products = response.productList;
//                    }, function (x) {
//                        $scope.errorData = "An Error has occured while loading generic!";
//                    });
        }

        $scope.getRoutes = function ($item, $model, $label) {
            if (!$item)
                $item = $scope.addData.product;

            $scope.routes = $item.description_routes;
        }

        $scope.data = {};
        $scope.data.prescriptionItems = [];
        $scope.addForm = function () {
            $scope.searchForm.DrugClass.$setValidity('required', true);
            if ($scope.searchForm.$valid) {
                var result = $filter('filter')($scope.data.prescriptionItems, {product_id: $scope.addData.product.product_id}, true);
                if (result.length > 0) {
                    alert('This Product already added');
                } else {
                    if (!angular.isObject($scope.addData.drug_class)) {
                        $scope.searchForm.DrugClass.$setValidity('required', false);
                        return false;
                    } else {
                        $scope.searchForm.DrugClass.$setValidity('required', true);
                    }

                    $scope.addData.frequency = $scope.addData.frequency_3_0 + '-' + $scope.addData.frequency_3_1 + '-' + $scope.addData.frequency_3_2;
                    qty_count = $scope.calculate_qty($scope.addData.frequency, $scope.addData.number_of_days, $scope.addData.product.product_description_id, $scope.addData.product.description_name);
                    if (qty_count > 0) {
                        items = {
                            'product_id': $scope.addData.product.product_id,
                            'product_name': $scope.addData.product.full_name,
                            'generic_id': $scope.addData.generic.generic_id,
                            'generic_name': $scope.addData.generic.generic_name,
                            'drug_class_id': $scope.addData.drug_class.drug_class_id,
                            'drug_name': $scope.addData.drug_class.drug_name,
                            'route_id': $scope.addData.route.route_id,
                            'route': $scope.addData.route.route_name,
                            'frequency': $scope.addData.frequency,
                            'number_of_days': $scope.addData.number_of_days,
                            'is_favourite': 0,
                            'description_routes': $scope.addData.product.description_routes,
                            'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                            'price': $scope.addData.product.latest_price,
                            'total': $scope.calculate_price(qty_count, $scope.addData.product.latest_price),
                            'freqMask': '9-9-9-9',
                            'freqMaskCount': 4,
                            'available_quantity': $scope.addData.product.availableQuantity,
                            'item_key': $scope.data.prescriptionItems.length,
                            'all_products': $scope.products,
                            'qty': qty_count,
                            'product_description_id': $scope.addData.product.product_description_id,
                            'description_name': $scope.addData.product.description_name,
                            'in_stock': (parseInt($scope.addData.product.availableQuantity) > parseInt(qty_count)),
                            'freqType': '3'
                        };
                        var fav = $filter('filter')($scope.child.favourites, {product_id: $scope.addData.product.product_id});

                        if (fav.length > 0) {
                            angular.extend(items, {is_favourite: 1});
                        }

                        PrescriptionService.addPrescriptionItem(items);
                        //Delay For Trigger Frequency click event
                        $timeout(function () {
                            $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
                        }, 1000);
                        $timeout(function () {
                            $scope.showOrhideFrequency();
                        }, 2000);

                        $scope.addData = {};
                        $scope.reset();

                        $timeout(function () {
                            $("#search-form-div").removeClass('open');
                            $scope.setFocus('number_of_days', $scope.data.prescriptionItems.length - 1);
                        });
                    }
                }
            }
        }

        $scope.addToCurrentPrescription = function () {
            if ($scope.previousPresSelected > 0) {
                var loop_total = $scope.previousPresSelectedItems.length;
                var loop_start = 0;
                angular.forEach($scope.previousPresSelectedItems, function (value, key) {
                    var result = $filter('filter')($scope.data.prescriptionItems, {product_id: value.product_id, route_id: value.route_id});
                    if (result.length == 0) {
                        $scope.getRelatedProducts(value.generic_id).then(function () {
                            qty_count = $scope.calculate_qty(value.frequency_name, value.number_of_days, value.product.product_description_id, value.product.description_name);
                            items = {
                                'product_id': value.product_id,
                                'product_name': value.product.full_name,
                                'generic_id': value.generic_id,
                                'generic_name': value.generic_name,
                                'drug_class_id': value.drug_class_id,
                                'drug_name': value.drug_name,
                                'route': value.route_name,
                                'frequency': value.frequency_name,
                                'number_of_days': value.number_of_days,
                                'is_favourite': 0,
                                'route_id': value.route_id,
                                'description_routes': value.product.description_routes,
                                'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                                'price': value.product.latest_price,
                                'total': $scope.calculate_price(qty_count, value.product.latest_price),
                                'freqMask': '9-9-9-9',
                                'freqMaskCount': 4,
                                'available_quantity': value.product.availableQuantity,
                                'item_key': $scope.data.prescriptionItems.length,
                                'all_products': $scope.products,
                                'qty': qty_count,
                                'product_description_id': value.product.product_description_id,
                                'description_name': value.product.description_name,
                                'in_stock': (parseInt(value.product.availableQuantity) > parseInt(qty_count)),
                                'freqType': value.freqType
                            };
                            var fav = $filter('filter')($scope.child.favourites, {product_id: value.product_id});

                            if (fav.length > 0) {
                                angular.extend(items, {is_favourite: 1});
                            }
                            PrescriptionService.addPrescriptionItem(items);
                        });
                    }

                    loop_start = parseFloat(loop_start) + parseFloat(1);
                    if (loop_total == loop_start) {
                        $timeout(function () {
                            $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
                        }, 1000);
                        $timeout(function () {
                            $scope.showOrhideFrequency();
                        }, 2000);
                    }
                });

                $scope.pres_status = 'current';
                $("#current_prescription").focus();
                toaster.clear();
                toaster.pop('success', '', 'Medicine has been added to the current prescription');
            }
        }

        $scope.addGlobalSearch = function (prescription) {
            var result = $filter('filter')($scope.data.prescriptionItems, {product_id: parseInt(prescription.product_id)}, true);

            if (result.length > 0) {
                alert('This Product already added');
                $scope.prescription_lists = {};
                $scope.lastSelected = {};
                $scope.prescription = '';
            } else {
                var fav = $filter('filter')($scope.child.favourites, {product_id: prescription.product_id});

                if (fav.length > 0) {
                    angular.extend(prescription, {is_favourite: 1});
                }

                var fiter = $filter('filter')($scope.all_products, {product_id: parseInt(prescription.product_id)}, true);
                var product = fiter[0];
                var Fields = 'full_name,description_routes,latest_price,availableQuantity,product_description_id,description_name';
//                + '&full_name_with_stock=1'
                $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproducts/' + product.product_id + '?fields=' + Fields)
                        .success(function (product) {
                            $scope.getRelatedProducts(prescription.generic_id).then(function () {
                                qty_count = $scope.calculate_qty(prescription.frequency, 1, product.product_description_id, product.description_name);
                                if (qty_count > 0) {
                                    if (prescription.route) {
                                        route = prescription.route;
                                    } else {
                                        route = (product.description_routes) ? product.description_routes[0].route_name : '';
                                    }
                                    items = {
                                        'product_id': prescription.product_id,
                                        'product_name': product.full_name,
                                        'generic_id': parseInt(prescription.generic_id),
                                        'generic_name': prescription.generic_name,
                                        'drug_class_id': prescription.drug_class_id,
                                        'drug_name': prescription.drug_name,
                                        'route': route,
                                        'frequency': prescription.frequency,
                                        'number_of_days': 1,
                                        'is_favourite': prescription.is_favourite,
                                        'route_id': prescription.route_id,
                                        'description_routes': product.description_routes,
                                        'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                                        'price': product.latest_price,
                                        'total': $scope.calculate_price(qty_count, product.latest_price),
                                        'freqMask': '9-9-9-9',
                                        'freqMaskCount': 4,
                                        'available_quantity': product.availableQuantity,
                                        'item_key': $scope.data.prescriptionItems.length,
                                        'all_products': $scope.products,
                                        'qty': qty_count,
                                        'product_description_id': product.product_description_id,
                                        'description_name': product.description_name,
                                        'in_stock': (parseInt(product.availableQuantity) > parseInt(qty_count)),
                                        'freqType': '3'
                                    };

                                    //Multiple entries created, Check duplicate once again 
                                    var chkDuplicate = $filter('filter')($scope.data.prescriptionItems, {product_id: items.product_id}, true);
                                    if (chkDuplicate.length == 0) {
                                        PrescriptionService.addPrescriptionItem(items);
                                    }

                                    $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();

                                    $timeout(function () {
                                        $("#prescriptioncont-header.search-patientcont-header").hide();
                                        if (!prescription.hasOwnProperty('route')) {
                                            $scope.setFocus('route', $scope.data.prescriptionItems.length - 1);
                                        } else if (!prescription.hasOwnProperty('frequency')) {
                                            $scope.setFocus('frequency', $scope.data.prescriptionItems.length - 1);
                                        } else {
                                            $scope.setFocus('number_of_days', $scope.data.prescriptionItems.length - 1);
                                        }

                                        if (typeof prescription.frequency != 'undefined')
                                            $scope.showOrhideFrequency();
                                    });
                                    $scope.prescription_lists = {};
                                    $scope.lastSelected = {};
                                    $scope.prescription = '';
                                }
                            });
                        });
            }
        }

        $scope.showOrhideFrequency = function () {
            angular.forEach($scope.data.prescriptionItems, function (item, key) {
                if (typeof item.frequency != 'undefined') {
                    $scope.curPrescFreqSele(item.frequency, item.freqType, item, key);
//                    var len = item.frequency.length;
//                    if (len == 5) {
//                        $('#change_mask_' + key + '_3').trigger('click');
//                    } else if (len == 7) {
//                        $('#change_mask_' + key + '_4').trigger('click');
//                    } else if (len == 9) {
//                        $('#change_mask_' + key + '_5').trigger('click');
//                    }
                }
            });

            var dropdownMenu;
            $('body').on('show.bs.dropdown', '.dropdown', function (e) {
                // grab the menu        
                dropdownMenu = $(e.target).find('ul.dropdown-menu.curPrescFreq');

                // detach it and append it to the body
                $('body').append(dropdownMenu.detach());

                // grab the new offset position
                var eOffset = $(e.target).offset();

                // make sure to place it where it would normally go (this could be improved)
                dropdownMenu.css({
                    'display': 'block',
                    'top': eOffset.top + $(e.target).outerHeight(),
                    'left': eOffset.left - 133.5
                });
            });

            $('body').on('hide.bs.dropdown', '.dropdown', function (e) {
                $(e.target).append(dropdownMenu.detach());
                dropdownMenu.hide();
            });
        }

        //Get the value from main.js
        $scope.$on('presc_fav', function (event, args) {
            var result = $filter('filter')($scope.data.prescriptionItems, {product_id: args.product_id});
            if (result.length > 0) {
                alert('This Product already added');
            } else {
                $scope.getRelatedProducts(args.generic_id).then(function () {
                    items = {
                        'product_id': args.product_id,
                        'product_name': args.product_name,
                        'generic_id': args.generic_id,
                        'generic_name': args.generic_name,
                        'drug_class_id': args.drug_class_id,
                        'drug_name': args.drug_name,
                        'route_id': '',
                        'route': '',
                        'frequency': '',
                        'number_of_days': 0,
                        'is_favourite': 1,
                        'description_routes': args.description_routes,
                        'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                        'price': args.product_price,
                        'total': 0,
                        'freqMask': '9-9-9-9',
                        'freqMaskCount': 4,
                        'available_quantity': args.availableQuantity,
                        'item_key': $scope.data.prescriptionItems.length,
                        'all_products': $scope.products,
                        'qty': 1,
                    };
                    $scope.data.prescriptionItems.push(items);

                    $timeout(function () {
                        $scope.setFocus('route', $scope.data.prescriptionItems.length - 1);
                    });

                    toaster.clear();
                    toaster.pop('success', 'Favourite', 'Medicine has been added to the current prescription');
                });
            }
        });

        $scope.setFocus = function (id, index) {
            angular.element(document.querySelectorAll("#" + id))[index].focus();
        };

        $scope.updateFavourite = function (val, id) {
            angular.forEach($scope.data.prescriptionItems, function (item, key) {
                if (item.product_id == id) {
                    item.is_favourite = val;
                }
            });
        }

        $scope.minDate = $scope.minDate ? null : new Date();

        $scope.concatFrequency = function (item, freqType) {
            if (freqType == 3) {
                return item.frequency_3_0 + '-' + item.frequency_3_1 + '-' + item.frequency_3_2;
            } else if (freqType == 4) {
                return item.frequency_4_0 + '-' + item.frequency_4_1 + '-' + item.frequency_4_2 + '-' + item.frequency_4_3;
            } else {
                return item.frequency
            }
        }

        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patientprescription/saveprescription';
            method = 'POST';
            succ_msg = 'Prescription saved successfully';

            $scope.data.next_visit = moment($scope.data.next_visit).format('YYYY-MM-DD');

            angular.extend($scope.data, {
//                encounter_id: $scope.enc.selected.encounter_id,
                patient_id: $scope.patientObj.patient_id,
                pres_date: _that.data.prescriptionItems[0].presc_date,
            });

            angular.forEach(_that.data.prescriptionItems, function (prescriptionItem, key) {
                if (angular.isObject(prescriptionItem.product_name)) {
                    _that.data.prescriptionItems[key].product_name = prescriptionItem.product_name.full_name;
                } else if (typeof prescriptionItem.product_name == 'undefined') {
                    _that.data.prescriptionItems[key].product_name = '';
                }

                _that.data.prescriptionItems[key].frequency = $scope.concatFrequency(prescriptionItem, _that.data.prescriptionItems[key].freqType);
                qty_count = $scope.calculate_qty(_that.data.prescriptionItems[key].frequency, prescriptionItem.number_of_days, prescriptionItem.product_description_id, prescriptionItem.description_name);
                _that.data.prescriptionItems[key].qty = qty_count;
                _that.data.prescriptionItems[key].total = $scope.calculate_price(qty_count, prescriptionItem.price);
                _that.data.prescriptionItems[key].in_stock = (parseInt(prescriptionItem.available_quantity) > parseInt(qty_count));
            });

            /* For print bill */
            $scope.data2 = _that.data;
            $scope.prescriptionItems2 = $scope.data.prescriptionItems;

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        $scope.loadbar('hide');

                        if (response.success) {
                            $scope.current_time = response.date;
                            $scope.msg.successMessage = succ_msg;
                            $scope.data = {prescriptionItems: []};
                            $scope.data.encounter_id = $scope.default_encounter_id;
                            $scope.data.consultant_id = response.model.consultant_id;
                            $scope.consultant_name = response.model.consultant_name;
                            $scope.getConsultantFreq();

                            $timeout(function () {
                                $scope.getFav();
                                save_success(true, response);

//                                $state.go('patient.prescription', {id: $state.params.id});
                            }, 1000)
                        } else {
                            $scope.errorData = response.message;
                        }
                    }
            ).error(function (data, status) {
                $anchorScroll();
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.getBtnId = function (btnid) {
            $scope.btnid = btnid;
        }

        $scope.getFrequencyExists = function (freq, key) {
            if (typeof freq != 'undefined') {
                var result = freq.split('-');
                if (result[key] == "0" || typeof result[key] == 'undefined')
                {
                    return "-";
                } else {
                    return result[key];
                }
            }

        }

        $scope.removeItem = function (item) {
            PrescriptionService.deletePrescriptionItem(item);
            $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
//            var index = $scope.data.prescriptionItems.indexOf(item);
//            $scope.data.prescriptionItems.splice(index, 1);
        }

        $scope.loadRecurringPrescription = function (enc_id) {
            $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/encounter/getrecurringprescription?encounter_id=' + enc_id,
            }).success(
                    function (response) {
                        $scope.recurring_charges = null;

                        if (typeof response.recurring != 'undefined')
                            $scope.recurring_charges = response.recurring;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.setDayEmpty = function () {
            $scope.data.number_of_days = '';
        }

        $scope.getDays = function () {
            var newValue = moment(this.data.next_visit).format('YYYY-MM-DD');
            if (newValue != '') {
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patient/getnextvisitdaysfromdate',
                    data: {'date': newValue},
                }).success(
                        function (response) {
                            $scope.data.number_of_days = response.days;
                            //Update all the No.of Days column in prescription form 
                            angular.forEach($scope.data.prescriptionItems, function (item, key) {
                                $scope.numberDaysChange(response.days, item, key, $scope.tableform);
                            });
                        }
                );
            }
        }

        $scope.setDateEmpty = function () {
            $scope.data.next_visit = '';
        }

        $scope.getVisit = function () {
            var newValue = this.data.number_of_days;
            if (parseInt(newValue) && !isNaN(newValue)) {
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patient/getdatefromdays',
                    data: {'days': newValue},
                }).success(
                        function (response) {
                            $scope.data.next_visit = response.date;
                        }
                );

                //Update all the No.of Days column in prescription form 
                angular.forEach($scope.data.prescriptionItems, function (item, key) {
                    $scope.numberDaysChange(newValue, item, key, $scope.tableform);
                });
            }
        }

        $scope.checkInput = function (data) {
            if (!data) {
                return "Not empty.";
            }
        };

        $scope.checkFrequency = function (data, item, key, freqType, freqPosition) {
            var validFractionFreq = ['0.5', '0.25'];
            if (item.freqType == freqType) {
                if (freqType == 'txt')
                    var freqVal = $('input#frequency_' + key + '_' + item.freqType).val();
                else
                    var freqVal = $('input#frequency_' + key + '_' + item.freqType + '_' + freqPosition).val();
                
                if (typeof freqVal == 'undefined' || freqVal == '') {
                    return "Wrong";
                } 
                
                if (freqType != 'txt' && data != Math.floor(data)) {
                        var decimalFreq = data.split('.');
                        if ($.inArray('0.' + decimalFreq[1], validFractionFreq) === -1)
                            return "Wrong";
                }
            }
        };

        $scope.prescription = '';

        var changeTimer = false;

        $scope.prescription_lists = {};

        $scope.$watch('prescription', function (newValue, oldValue) {
            if (newValue != '' && newValue.length > 1) {
                if (changeTimer !== false)
                    clearTimeout(changeTimer);

                changeTimer = setTimeout(function () {
                    _data = {};
                    _data['search'] = newValue;

                    if ($scope.lastSelected) {
                        _data['product_id'] = $scope.lastSelected.product_id;

                        if (typeof $scope.lastSelected.route_id != 'undefined')
                            _data['route_id'] = $scope.lastSelected.route_id;
                    }

                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getprescription',
                        data: _data,
                    }).success(
                            function (response) {
                                $scope.prescription_lists = response.prescription;

                                if ($scope.lastSelected) {
                                    var result = $filter('filter')($scope.prescription_lists, {prescription: $scope.lastSelected.prescription});
                                    if (result.length > 0)
                                        result[0].selected = 'selected';
                                }
                            }
                    );
                    changeTimer = false;
                }, 300);
            } else {
                $scope.prescription_lists = {};
            }
        }, true);


        $scope.disabled = function (date, mode) {
            date = moment(date).format('YYYY-MM-DD');
            return $.inArray(date, $scope.enabled_dates) === -1;
        };

        //Checkbox initialize
        $scope.checkboxes = {'checked': false, items: []};
        $scope.previousPresSelectedItems = [];
        $scope.previousPresSelected = 0;

        $scope.enabled_dates = [];
        $scope.loadPrevPrescriptionsList = function (date) {
            $scope.isLoading = true;
            $scope.spinnerbar('show');
            // pagination set up

            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

//            &full_name_with_stock=1
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct?fields=product_id,full_name,generic_id')
                    .success(function (products) {
                        $scope.all_products = products;

                        if (typeof date == 'undefined') {
//                            &full_name_with_stock=1
                            url = $rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $state.params.id + '&addtfields=prev_presc';
                        } else {
                            date = moment(date).format('YYYY-MM-DD');
//                            &full_name_with_stock=1
                            url = $rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $state.params.id + '&date=' + date + '&addtfields=prev_presc';
                        }

                        // Get data's from service
                        $http.get(url)
                                .success(function (prescriptionList) {
                                    $scope.isLoading = false;
                                    $scope.spinnerbar('hide');
                                    $scope.rowCollection = prescriptionList.prescriptions;

                                    if ($scope.rowCollection.length > 0) {
                                        angular.forEach($scope.rowCollection, function (row) {

                                            /* Visible only existing presc dates in datepicker */
                                            var result = $filter('filter')($scope.enabled_dates, moment(row.pres_date).format('YYYY-MM-DD'));
                                            if (result.length == 0)
                                                $scope.enabled_dates.push(moment(row.pres_date).format('YYYY-MM-DD'));

                                            angular.forEach(row.items, function (item) {
                                                item.selected = '0';
                                            });
                                            row.selected = '0';
                                        });

                                        if (typeof date == 'undefined') {
                                            var typed_prescription = PrescriptionService.getPrescriptionItems();
                                            if (typed_prescription.length > 0) {
                                                $scope.data.prescriptionItems = typed_prescription;
                                            } else {
                                                var loop_total = $scope.rowCollection[0].items.length;
                                                var loop_start = 0;
                                                angular.forEach($scope.rowCollection[0].items, function (item, k) {
                                                    $scope.getRelatedProducts(item.generic_id).then(function () {
                                                        qty_count = $scope.calculate_qty(item.frequency_name, item.number_of_days, item.product.product_description_id, item.product.description_name);
                                                        items = {
                                                            'product_id': item.product_id,
                                                            'product_name': item.product.full_name,
                                                            'generic_id': item.generic_id,
                                                            'generic_name': item.generic_name,
                                                            'drug_class_id': item.drug_class_id,
                                                            'drug_name': item.drug_name,
                                                            'route': item.route_name,
                                                            'frequency': item.frequency_name,
                                                            'number_of_days': item.number_of_days,
                                                            'is_favourite': 0,
                                                            'route_id': item.route_id,
                                                            'description_routes': item.product.description_routes,
                                                            'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                                                            'price': item.product.latest_price,
                                                            'total': $scope.calculate_price(qty_count, item.product.latest_price),
                                                            'freqMask': '9-9-9-9',
                                                            'freqMaskCount': 4,
                                                            'available_quantity': item.product.availableQuantity,
                                                            'item_key': k,
                                                            'all_products': $scope.products,
                                                            'qty': qty_count,
                                                            'product_description_id': item.product.product_description_id,
                                                            'description_name': item.product.description_name,
                                                            'in_stock': (parseInt(item.product.availableQuantity) > parseInt(qty_count)),
                                                            'freqType': item.freqType
                                                        };

                                                        var fav = $filter('filter')($scope.child.favourites, {product_id: item.product_id});

                                                        if (fav.length > 0) {
                                                            angular.extend(items, {is_favourite: 1});
                                                        }

                                                        PrescriptionService.addPrescriptionItem(items);
                                                        loop_start = parseFloat(loop_start) + parseFloat(1);
                                                        if (loop_total == loop_start) {
                                                            $timeout(function () {
                                                                $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
                                                            }, 1000);
                                                            $timeout(function () {
                                                                $scope.showOrhideFrequency();
                                                            }, 2000);
                                                        }
                                                    });
                                                });
                                            }
                                        }
                                    } else {
                                        if (typeof date == 'undefined') {
                                            var typed_prescription = PrescriptionService.getPrescriptionItems();
                                            if (typed_prescription.length > 0) {
                                                $scope.data.prescriptionItems = typed_prescription;
                                            }
                                        }
                                    }
                                    $timeout(function () {
                                        $scope.showOrhideFrequency();
                                    }, 2000);
                                    $scope.displayedCollection = [].concat($scope.rowCollection);

                                    //Checkbox initialize
                                    $scope.checkboxes = {'checked': false, items: []};
                                    $scope.previousPresSelectedItems = [];
                                    $scope.previousPresSelected = 0;

                                    $scope.$broadcast('refreshDatepickers');

                                })
                                .error(function () {
                                    $scope.errorData = "An Error has occured while loading list!";
                                });
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading brand!";
                    });

            $scope.$broadcast('refreshDatepickers');
        };

        $scope.calculate_qty = function (freq, days, product_description_id, description_name) {
            if (typeof freq != 'undefined') {
                var freq_count = 0;
                $.each(freq.split('-'), function (key, item) {
                    freq_count = freq_count + parseFloat(item);
                });
                var qtyCalcDescNames = ["tablet", "capsule", "tablets", "capsules"];
                if ($.inArray(description_name.toLowerCase(), qtyCalcDescNames) >= 0 &&
                        !isNaN(freq_count) && angular.isNumber(freq_count)) {
                    //Tablets
                    return (parseFloat(days) * parseFloat(freq_count));
                } else {
                    return 1;
                }
            }
            return 1;
        }

        $scope.calculate_price = function (qty, price) {
            if (typeof qty != 'undefined') {
                return (parseFloat(qty) * parseFloat(price));
            }
            return 0;
        }

        $scope.seen_notes = function () {
            $scope.scrollBottom();
            if ($scope.unseen_notes_count > 0) {
                unseen_filter_note = $filter('filter')($scope.child.notes, {seen_by: 0});
                note_ids = [];
                angular.forEach(unseen_filter_note, function (unseen, key) {
                    note_ids.push(unseen.pat_note_id);
                });

                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patientnotes/seennotes',
                    data: {'ids': note_ids, 'patient_guid': $state.params.id},
                }).success(
                        function (response) {
                            $timeout(function () {
                                angular.forEach($scope.child.notes, function (note, key) {
                                    note.seen_by = 1;
                                });
                                $scope.unseen_notes_count = 0;
                            }, 5000);
                        }
                );
            }
        }

        $scope.seen_vitals = function () {
//            $scope.scrollBottom();
            if ($scope.unseen_vitals_count > 0) {
                unseen_filter_vital = $filter('filter')($scope.child.vitals, {seen_by: 0});
                vital_ids = [];
                angular.forEach(unseen_filter_vital, function (unseen, key) {
                    vital_ids.push(unseen.vital_id);
                });

                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patientvitals/seenvitals',
                    data: {'ids': vital_ids, 'patient_guid': $state.params.id},
                }).success(
                        function (response) {
                            $timeout(function () {
                                angular.forEach($scope.child.vitals, function (vital, key) {
                                    vital.seen_by = 1;
                                });
                                $scope.unseen_vitals_count = 0;
                            }, 5000);
                        }
                );
            }
        }

        $scope.scrollBottom = function () {
            if ($(".vbox .row-row .cell").is(':visible')) {
                elem = $(".vbox .row-row .cell:visible");
                elem.animate({scrollTop: elem.prop("scrollHeight")}, 1000);
            }
        }

        $scope.types = IO_BARCODE_TYPES;
        $scope.code = '1234567890128';
        $scope.type = 'CODE128B';

        $scope.barcodeOptions = {
            displayValue: true,
            textAlign: 'center',
            fontSize: 18,
            height: 70,
            width: 1.2,
        }

        $scope.presSelected = {items: []};

        $scope.updateCheckbox = function (parent, parent_key) {
            angular.forEach($scope.displayedCollection, function (value, pres_key) {
                value.selected = '0';

                if (parent_key == pres_key)
                    value.selected = parent.selected;

                angular.forEach(value.items, function (row, key) {
                    row.selected = '0';

                    if (parent_key == pres_key)
                        row.selected = parent.selected;
                });
            });

            $timeout(function () {
                angular.forEach($scope.displayedCollection, function (value, pres_key) {
                    angular.forEach(value.items, function (row, key) {
                        $scope.moreOptions(pres_key, key, row);
                    });
                });
            }, 1000);
        }

        $scope.moreOptions = function (pres_key, key, row) {
            product_exists = $filter('filter')($scope.checkboxes.items, {product_id: row.product_id}, true);
            pres_exists = $filter('filter')($scope.checkboxes.items, {pres_id: row.pres_id}, true);
            if ($('#prevpres_' + pres_key + '_' + key).is(':checked')) {
                $('#prevpres_' + pres_key + '_' + key).closest('tr').addClass('selected_row');

                $('.tr_prevprescheckbox').not('.tr_prevprescheckbox_' + pres_key).each(function () {
                    $(this).removeClass('selected_row');
                });

                if (pres_exists.length == 0) {
                    $('.prevprescheckbox').not('.prevprescheckbox_' + pres_key).attr('checked', false);
                    $scope.checkboxes.items = [];
                    $scope.checkboxes.items.push({
                        pres_id: row.pres_id,
                        product_id: row.product_id,
                        row: row
                    });
                } else {
                    if (product_exists.length == 0) {
                        $scope.checkboxes.items.push({
                            pres_id: row.pres_id,
                            product_id: row.product_id,
                            row: row
                        });
                    }
                }
            } else {
                $('#prevpres_' + pres_key + '_' + key).closest('tr').removeClass('selected_row');
                if (product_exists.length > 0 && pres_exists.length > 0) {
                    $scope.checkboxes.items.splice($scope.checkboxes.items.indexOf(product_exists[0]), 1);
                }
            }
            $scope.prepareMoreOptions();
        }

        $scope.prepareMoreOptions = function () {
            $scope.previousPresSelectedItems = [];
            angular.forEach($scope.checkboxes.items, function (item) {
                $scope.previousPresSelectedItems.push(item.row);
            });
            $scope.previousPresSelected = $scope.previousPresSelectedItems.length;
        }

        $scope.lastSelected = {};

        $("body").on('keydown', '#prescription_global_search', function (e) {
            var selected = $("#prescriptioncont-header .selected");
            var li_count = $("#prescriptioncont-header li").length;

            if (e.keyCode == 40 || e.keyCode == 38) {
                $("#prescriptioncont-header li").removeClass("selected");
                if (selected.length == 0) {
                    var selected = $("#prescriptioncont-header li:last");
                }

                if (li_count == 1) {
                    var selected = $("#prescriptioncont-header li:first");
                    selected.addClass('selected');
                }

                if (e.keyCode == 38) { // up
                    if (selected.prev().length == 0) {
                        selected.siblings().last().addClass("selected");
                    } else {
                        selected.prev().addClass("selected");
                    }
                }

                if (e.keyCode == 40) { // down
                    if (selected.next().length == 0) {
                        selected.siblings().first().addClass("selected");
                    } else {
                        selected.next().addClass("selected");
                    }
                }

                var a = $("#prescriptioncont-header .selected a");
                if (a.length > 0) {
                    $scope.lastSelected = $scope.prescription_lists[a.data('key')];
                    $(this).val($scope.lastSelected.prescription);
                }
            }

            //While Backspace
            if (e.keyCode == 8 || e.keyCode == 46) {
                $scope.lastSelected = {};
            }

            if ($(this).val() == '') {
                $scope.lastSelected = {};
            }

            if (e.keyCode == 13) { // enter
                if ($("#prescriptioncont-header").is(":visible")) {
                    $scope.selectOption();
                }
            }
        });

        $("body").on("mouseover", "#prescriptioncont-header li", function () {
            $("#prescriptioncont-header li").removeClass("selected");
            $(this).addClass("selected");
            var Selected = $scope.prescription_lists[$(this).find("a").data('key')];
            $('#prescription_global_search').val(Selected.prescription);
        });

        $scope.selectOption = function () {
            var link_tag = $("#prescriptioncont-header .selected").find("a");

            var Selected = $scope.prescription_lists[link_tag.data('key')];
            $('#prescription_global_search').val(Selected.prescription);

            if (link_tag.length > 0) {
                $(link_tag).trigger("click");
            } else {
                $(".selected button").trigger("click");
            }
            return false;
        }

        var save_success = function (prev_refresh, response) {
//            if ($scope.btnid == "print") {
//                $scope.printloader = '<i class="fa fa-spin fa-spinner"></i>';
//                $timeout(function () {
//                    var print_content = $scope.printContent();
//                    if (print_content.length > 0) {
//                        var docDefinition = {
//                            header: $scope.printHeader(),
//                            footer: $scope.printFooter(),
//                            styles: $scope.printStyle(),
//                            content: print_content,
//                            pageMargins: ($scope.deviceDetector.browser == 'firefox' ? 75 : 50),
//                            pageSize: 'A4',
//                        };
//                        var pdf_document = pdfMake.createPdf(docDefinition);
//                        var doc_content_length = Object.keys(pdf_document).length;
//                        if (doc_content_length > 0) {
//                            pdf_document.print();
//                        }
//                    }
//                }, 1000);
//            }
            if ($scope.btnid == "print") {
                $scope.printPres(response.pres_id);
            }

            if (prev_refresh) {
                $scope.pres_status = 'prev';
                $("#prev_prescription").focus();
                $scope.filterdate = '';
                $scope.loadPrevPrescriptionsList();
            }

        }

        $scope.imgExport = function (imgID) {
            var img = document.getElementById(imgID);
            var canvas = document.createElement("canvas");
            canvas.width = img.width;
            canvas.height = img.height;

            // Copy the image contents to the canvas
            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0);

            // Get the data-URL formatted image
            // Firefox supports PNG and JPEG. You could check img.src to
            // guess the original format, but be aware the using "image/jpg"
            // will re-encode the image.
            var dataURL = canvas.toDataURL("image/png");
            return dataURL;
        }

        $scope.presDetail = function (pres_id) {
            $scope.data2 = {};
            $scope.prescriptionItems2 = [];
            $scope.loadbar('show');

            var deferred = $q.defer();
            deferred.notify();

            $http.get($rootScope.IRISOrgServiceUrl + "/patientprescriptions/" + pres_id + "?addtfields=presc_search")
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.data2 = response;
                        $scope.vital = response.encounter;
                        $scope.prescriptionItems2 = response.items;
                        angular.forEach($scope.prescriptionItems2, function (item, key) {
                            angular.extend($scope.prescriptionItems2[key], {
                                frequency: item.frequency_name,
                            });
                        });
                        deferred.resolve();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading prescription!";
                        deferred.reject();
                    });

            return deferred.promise;
        }

        $scope.printPres = function (pres_id) {
            $scope.presDetail(pres_id).then(function () {
                delete $scope.data2.items;
                $('#print_previous_pres').printThis({
                    pageTitle: "Ahana",
                    debug: false,
                    importCSS: false,
                    importStyle: false,
                    loadCSS: [$rootScope.IRISOrgUrl + "/css/prescription_print.css"],
                });
            });
        }

        $scope.freqChange = function (freq, freq_type, item, key, tableform, freqPosition) {
            if (typeof freq == 'undefined')
                freq = '';
            if (typeof freq != 'undefined') {
                var result = item.frequency.split('-');
                result[freqPosition] = freq;
                org_freq = result.join('-');
//                org_freq = chunk(freq, 1).join('-');
                $scope.curPrescFreqSele(org_freq, freq_type, item, key);
            }
        };

        $scope.curPrescFreqSele = function (freq, ftype, item, key, method) {
            if (typeof freq != 'undefined') {
                $('.freq_div_' + key).addClass('hide');
                $('#freq_' + key + '_' + ftype).removeClass('hide');
                $scope.data.prescriptionItems[key].frequency = freq;
                $scope.data.prescriptionItems[key].freqType = ftype;
                $scope.data.prescriptionItems[key].qty = $scope.calculate_qty(freq, item.number_of_days, item.product_description_id, item.description_name);
                $scope.data.prescriptionItems[key].total = $scope.calculate_price($scope.data.prescriptionItems[key].qty, item.price);
                $scope.data.prescriptionItems[key].in_stock = (parseInt(item.available_quantity) > parseInt($scope.data.prescriptionItems[key].qty));
            }
            angular.forEach($scope.tableform.$editables, function (editableValue, editableKey) {
                if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'qty') {
                    editableValue.scope.$data = $scope.data.prescriptionItems[key].qty
                }
                if (editableValue.attrs.eIndex == key && editableValue.attrs.eName == 'masked') {
                    editableValue.scope.$data = '';
                }

                if (ftype == 'txt') {
                    if (editableValue.attrs.eIndex == key && editableValue.attrs.eId == 'frequency_' + key + '_' + ftype) {
                        editableValue.scope.$data = $scope.data.prescriptionItems[key].frequency;
                    }
                } else {
                    var result = $scope.data.prescriptionItems[key].frequency.split('-');
                    if (result.length > 0) {
                        angular.forEach(result, function (freqvalue, freqkey) {
                            if (editableValue.attrs.eIndex == key && editableValue.attrs.eId == 'frequency_' + key + '_' + ftype + '_' + freqkey) {
                                editableValue.scope.$data = freqvalue;
                            }
                        });
                    }
                }
            });

            if (method == 'select') {
                $('div.editable-error').html(''); //clear all error msg
                if (ftype == 'txt') {
                    angular.element(document.querySelectorAll('#frequency_' + key + '_' + ftype))[0].focus();
                } else {
                    angular.element(document.querySelectorAll('#frequency_' + key + '_' + ftype + '_0'))[0].focus();
                }
            }

        }

        $scope.defaultMask3 = {
            'freq_name': '1-1-1',
            'freq_type': '3'
        };
        $scope.defaultMask4 = {
            'freq_name': '1-1-1-1',
            'freq_type': '4'
        };
        $scope.defaultMaskTxt = {
            'freq_name': 'Custom',
            'freq_type': 'txt'
        };
        $scope.consultantFreq = [];
        $scope.getConsultantFreq = function () {
            $scope.consultantFreq = [];
            $http.get($rootScope.IRISOrgServiceUrl + '/patientprescription/getconsultantfreq?consultant_id=' + $scope.data.consultant_id)
                    .success(function (response) {
                        if (response.freq.length > 0)
                            $scope.consultantFreq = response.freq;
                        else {
                            $scope.consultantFreq.push($scope.defaultMask3);
                            $scope.consultantFreq.push($scope.defaultMask4);
                            $scope.consultantFreq.push($scope.defaultMaskTxt);
                        }
                        $scope.prepareCurrPresFreq();
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                    });
        }

        $scope.currPresMask3 = [];
        $scope.currPresMask4 = [];
        $scope.currPresMaskTxt = [];
        $scope.prepareCurrPresFreq = function () {
            $scope.currPresMask3 = [];
            $scope.currPresMask4 = [];
            $scope.currPresMaskTxt = [];
            if ($scope.consultantFreq.length > 0) {
                //check mask3 is exist, otherswise push default set
                var mask3 = $filter('filter')($scope.consultantFreq, {freq_type: '3'});
                if (mask3.length == 0) {
                    $scope.currPresMask3.push($scope.defaultMask3);
                } else {
                    $scope.currPresMask3 = mask3;
                }

                //check mask4 is exist, otherswise push default set
                var mask4 = $filter('filter')($scope.consultantFreq, {freq_type: '4'});
                if (mask4.length == 0) {
                    $scope.currPresMask4.push($scope.defaultMask4);
                } else {
                    $scope.currPresMask4 = mask4;
                }

                //check maskTxt is exist, otherswise push default set
                var maskTxt = $filter('filter')($scope.consultantFreq, {freq_type: 'txt'});
                if (maskTxt.length == 0) {
                    $scope.currPresMaskTxt.push($scope.defaultMaskTxt);
                } else {
                    $scope.currPresMaskTxt = maskTxt;
                }

                //Make "Custom" is a first option in the array. 
                var maskCustomTxt = $filter('filter')($scope.currPresMaskTxt, {freq_name: 'Custom'});
                if (maskCustomTxt.length == 0) {
                    $scope.currPresMaskTxt.unshift($scope.defaultMaskTxt);
                }
            }
        }

        $scope.removeRow = function (pres_id) {
            //console.log(sale_id);
            var conf = confirm('Are you sure to delete ?');
            if (conf)
            {
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientprescription/remove",
                    method: "POST",
                    data: {id: pres_id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.pres_status = 'prev';
                                $("#prev_prescription").focus();
                                $scope.filterdate = '';
                                $scope.loadPrevPrescriptionsList();
                            } else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        }

        $scope.selectFreq = function (freqType, freqPosition, item, key) {
            var result = item.frequency.split('-');
            return result[freqPosition];
        }



        //Not Used
//        $scope.changeFreqMask = function (key, freq) {
//            $('.freq_div_' + key).addClass('hide');
//            $('.change_mask_' + key).addClass('hide');
//            $('#freq_' + key + '_' + freq).removeClass('hide');
//            $('.change_mask_' + key + ':not("#change_mask_' + key + '_' + freq + '")').removeClass('hide');
//            $scope.data.prescriptionItems[key].frequency = $('#freq_' + key + '_' + freq + ' input').val();
//            $scope.data.prescriptionItems[key].freqMaskCount = freq;
//            $scope.data.prescriptionItems[key].qty = $scope.calculate_qty($scope.data.prescriptionItems[key].frequency, $scope.data.prescriptionItems[key].number_of_days, $scope.data.prescriptionItems[key].product_description_id);
//            $('#qty_div_' + key + ' input').val($scope.data.prescriptionItems[key].qty);
//            $scope.data.prescriptionItems[key].total = $scope.calculate_price($scope.data.prescriptionItems[key].qty, $scope.data.prescriptionItems[key].price);
//            $scope.data.prescriptionItems[key].in_stock = (parseInt($scope.data.prescriptionItems[key].available_quantity) > parseInt($scope.data.prescriptionItems[key].qty));
//        }

//        $scope.greaterThan = function (prop, val) {
//            return function (item) {
//                return item[prop] > val;
//            }
//        }
//
//        $scope.lesserThan = function (prop, val) {
//            return function (item) {
//                return item[prop] <= val;
//            }
//        }

        //PRINT Prescription
//        $scope.printHeader = function () {
//            return {
//                text: "Prescription",
//                margin: 5,
//                alignment: 'center'
//            };
//        }
//
//        $scope.printFooter = function () {
//            return {
//                text: "Printed Date : " + moment($scope.current_time).format('DD-MM-YYYY HH:mm'),
//                margin: 5,
//                alignment: 'center'
//            };
//        }
//
//        $scope.printStyle = function () {
//            return {
//                header: {
//                    bold: true,
//                    color: '#000',
//                    fontSize: 11,
//                    margin: [0, 5, 0, 0]
//                },
//                demoTable: {
//                    color: '#000',
//                    fontSize: 10
//                },
//                tableRows: {
//                    margin: [0, 10, 0, 10]
//                }
//            };
//        }
//
//        $scope.printloader = '';
//        $scope.printContent = function () {
//            var content = [];
//            var prescInfo = [];
//            var prescItems = [];
//
//            var items = $scope.prescriptionItems2;
//            prescItems.push([
//                {
//                    text: 'Description',
//                    style: 'header'
//                },
//                {
//                    image: $scope.imgExport('weather1'),
//                    width: 25
//                },
//                {
//                    image: $scope.imgExport('weather2'),
//                    width: 25
//                },
//                {
//                    image: $scope.imgExport('weather3'),
//                    width: 25
//                },
//                {
//                    image: $scope.imgExport('weather4'),
//                    width: 25
//                },
//                {
//                    image: $scope.imgExport('weather4'),
//                    width: 25
//                },
//                {
//                    text: 'Remarks',
//                    style: 'header'
//                },
//            ]);
//
//            angular.forEach(items, function (item, key) {
//                var freq_0 = $scope.getFrequencyExists(item.frequency, 0);
//                var freq_1 = $scope.getFrequencyExists(item.frequency, 1);
//                var freq_2 = $scope.getFrequencyExists(item.frequency, 2);
//                var freq_3 = $scope.getFrequencyExists(item.frequency, 3);
//                var freq_4 = $scope.getFrequencyExists(item.frequency, 4);
//                prescItems.push([
//                    {
//                        text: item.product_name + "(" + item.number_of_days + " days)",
//                        style: "tableRows"
//                    },
//                    {
//                        alignment: 'center',
//                        text: freq_0,
//                        style: "tableRows"
//                    },
//                    {
//                        alignment: 'center',
//                        text: freq_1,
//                        style: "tableRows"
//                    },
//                    {
//                        alignment: 'center',
//                        text: freq_2,
//                        style: "tableRows"
//                    },
//                    {
//                        alignment: 'center',
//                        text: freq_3,
//                        style: "tableRows"
//                    },
//                    {
//                        alignment: 'center',
//                        text: freq_4,
//                        style: "tableRows"
//                    },
//                    {
//                        text: (item.remarks ? item.remarks : '-'),
//                        style: "tableRows"
//                    }
//                ]);
//            });
//
//            prescInfo.push({
//                columns: [
//                    {},
//                    {
//                        image: $("#patient_barcode").attr('src'),
//                        width: 180,
//                        margin: [20, 20, 20, 20]
//                    }
//                ]
//            }, {
//                columns: [
//                    {
//                        text: [
//                            {text: $scope.patientObj.fullname + "(" + $scope.patientObj.patient_age + " yrs)", bold: true},
//                        ],
//                        margin: [0, 0, 0, 30]
//                    },
//                    {
//                        alignment: 'right',
//                        text: [
//                            {text: ' Date :', bold: true},
//                            moment($scope.data2.pres_date).format('DD-MM-YYYY HH:mm')
//
//                        ],
//                        margin: [0, 0, 0, 30]
//                    }
//                ]
//            }, {
//                style: 'demoTable',
//                table: {
//                    headerRows: 1,
//                    widths: ['*', 'auto', 'auto', 'auto', 'auto', 'auto', '*'],
//                    body: prescItems,
//                }
//            }, {
//                columns: [
//                    {},
//                    {
//                        alignment: 'right',
//                        text: [
//                            {text: ' Next Review :', bold: true},
//                            moment($scope.data2.next_visit).format('DD-MM-YYYY')
//                        ],
//                        margin: [0, 20, 0, 0]
//                    }
//                ]
//            });
//            content.push(prescInfo);
//            return content;
//        }

    }]);
