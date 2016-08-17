app.controller('PrescriptionController', ['$rootScope', '$scope', '$anchorScroll', '$http', '$state', '$filter', '$modal', '$log', '$timeout', 'IO_BARCODE_TYPES', 'toaster', 'PrescriptionService', function ($rootScope, $scope, $anchorScroll, $http, $state, $filter, $modal, $log, $timeout, IO_BARCODE_TYPES, toaster, PrescriptionService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.enc = {};
        $scope.drugs = {};
        $scope.routes = {};
        $scope.frequencies = {};

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.$watch('patientObj.patient_id', function (newValue, oldValue) {
            if (typeof newValue !== 'undefined' && newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;
                    if (response != null) {
                        $scope.enc.selected = $scope.encounters[0];
                        if ($scope.encounters[0].encounter_type == 'IP') {
                            $scope.data.consultant_id = $scope.encounters[0].liveAdmission.consultant_id;
                        } else if ($scope.encounters[0].encounter_type == 'OP') {
                            $scope.data.consultant_id = $scope.encounters[0].liveAppointmentBooking.consultant_id;
                        }
                    }
                });
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                PrescriptionService.setPatientId($scope.patientObj.patient_id);
                $scope.loadPrevPrescriptionsList();
                $scope.loadSideMenu();
                $scope.$emit('encounter_id', newValue);
            }
        }, true);

        $scope.clearPrescription = function () {
//            $scope.data.consultant_id = '';
            $scope.prescription = '';
            $scope.data.prescriptionItems = [];
        };

        $scope.priceTotal = function () {
            total = 0;
            angular.forEach($scope.data.prescriptionItems, function (item) {
                total = total + parseFloat(item.total);
            });
            return total;
        }

        $scope.freqChange = function (freq, item, key) {
            if (typeof freq != 'undefined') {
                org_freq = chunk(freq, 1).join('-');
                $scope.data.prescriptionItems[key].frequency = org_freq;
                $scope.data.prescriptionItems[key].total = $scope.calculate_price(org_freq, item.number_of_days, item.price);
            }
        };

        $scope.numberDaysChange = function (days, item, key) {
            if (typeof days != 'undefined') {
                $scope.data.prescriptionItems[key].number_of_days = days;
                $scope.data.prescriptionItems[key].total = $scope.calculate_price(item.frequency, days, item.price);
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
            $http.get($rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?patient_id=' + $state.params.id)
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

        //Always Form visible
        $scope.$watch('tableform.$visible', function () {
            $scope.tableform.$show();
        });

        //For Form
        $scope.initForm = function () {
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacydrugclass')
                    .success(function (response) {
                        $scope.drugs = response;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading drugclass!";
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

            $("#current_prescription").focus();
        }

        $scope.getGeneric = function ($item, $model, $label) {
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getgenericlistbydrugclass?drug_class_id=' + $item.drug_class_id)
                    .success(function (response) {
                        $scope.generics = response.genericList;
                        $scope.products = $scope.allproducts = response.productList;
                    }, function (x) {
                        $scope.errorData = "An Error has occured while loading generic!";
                    });
        }

        $scope.setGeneric = function () {
            result = $filter('filter')($scope.generics, {generic_id: $scope.addData.product.generic_id});
            if (result.length > 0)
                $scope.addData.generic = result[0];
        }

        $scope.setProductId = function ($data, key) {
            result = $filter('filter')($scope.all_products, {full_name: $data});
            if (result.length > 0) {
                $scope.data.prescriptionItems[key].product_id = result[0].product_id;
                $scope.data.prescriptionItems[key].description_routes = [];
                $scope.data.prescriptionItems[key].description_routes = result[0].description_routes;
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

        $scope.pres_status = 'current';
        $scope.data = {};
        $scope.data.prescriptionItems = [];
        $scope.addForm = function () {
            if ($scope.searchForm.$valid) {
                var result = $filter('filter')($scope.data.prescriptionItems, {product_id: $scope.addData.product.product_id});

                if (result.length > 0) {
                    alert('This Product already added');
                } else {
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
                        'total': $scope.calculate_price($scope.addData.frequency, $scope.addData.number_of_days, $scope.addData.product.latest_price),
                        'freqMask': '9-9-9-9',
                        'freqMaskCount': 4
                    };
                    var fav = $filter('filter')($scope.child.favourites, {product_id: $scope.addData.product.product_id});

                    if (fav.length > 0) {
                        angular.extend(items, {is_favourite: 1});
                    }

                    PrescriptionService.addPrescriptionItem(items);
                    $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();

                    $scope.addData = {};

                    $timeout(function () {
                        $("#search-form-div").removeClass('open');
                        $scope.setFocus('number_of_days', $scope.data.prescriptionItems.length - 1);
                    });
                }
            }
        }

        $scope.addToCurrentPrescription = function () {
            if ($scope.previousPresSelected > 0) {
                angular.forEach($scope.previousPresSelectedItems, function (value, key) {
                    var result = $filter('filter')($scope.data.prescriptionItems, {product_id: value.product_id, route_id: value.route_id});

                    if (result.length == 0) {
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
                            'total': $scope.calculate_price(value.frequency_name, value.number_of_days, value.product.latest_price),
                            'freqMask': '9-9-9-9',
                            'freqMaskCount': 4
                        };
                        var fav = $filter('filter')($scope.child.favourites, {product_id: value.product_id});

                        if (fav.length > 0) {
                            angular.extend(items, {is_favourite: 1});
                        }

                        PrescriptionService.addPrescriptionItem(items);
                        $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
                    }
                });

                $scope.pres_status = 'current';
                $("#current_prescription").focus();
                toaster.clear();
                toaster.pop('success', '', 'Medicine has been added to the current prescription');
            }
        }

        $scope.addGlobalSearch = function (prescription) {
            var result = $filter('filter')($scope.data.prescriptionItems, {product_id: prescription.product_id});

            if (result.length > 0) {
                alert('This Product already added');
            } else {
                var fav = $filter('filter')($scope.child.favourites, {product_id: prescription.product_id});

                if (fav.length > 0) {
                    angular.extend(prescription, {is_favourite: 1});
                }

                var fiter = $filter('filter')($scope.all_products, {product_id: prescription.product_id});
                var product = fiter[0];
                
                items = {
                    'product_id': prescription.product_id,
                    'product_name': product.full_name,
                    'generic_id': prescription.generic_id,
                    'generic_name': prescription.generic_name,
                    'drug_class_id': prescription.drug_class_id,
                    'drug_name': prescription.drug_name,
                    'route': prescription.route,
                    'frequency': prescription.frequency,
                    'number_of_days': 0,
                    'is_favourite': prescription.is_favourite,
                    'route_id': prescription.route_id,
                    'description_routes': product.description_routes,
                    'presc_date': moment().format('YYYY-MM-DD HH:mm:ss'),
                    'price': product.latest_price,
                    'total': $scope.calculate_price(prescription.frequency, 0, product.latest_price),
                    'freqMask': '9-9-9-9',
                    'freqMaskCount': 4
                };

                PrescriptionService.addPrescriptionItem(items);
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
                    $scope.prescription = '';
                });
                $scope.prescription_lists = {};
                $scope.lastSelected = {};
            }
        }

        //Get the value from main.js
        $scope.$on('presc_fav', function (event, args) {
            var result = $filter('filter')($scope.data.prescriptionItems, {product_id: args.product_id});
            if (result.length > 0) {
                alert('This Product already added');
            } else {
                items = {
                    'product_id': args.product_id,
                    'product_name': args.product_name,
                    'generic_id': args.generic_id,
                    'generic_name': args.generic_name,
                    'drug_class_id': args.drug_class_id,
                    'drug_name': args.drug_name,
                    'is_favourite': 1,
                };
                $scope.data.prescriptionItems.push(items);

                $timeout(function () {
                    $scope.setFocus('route', $scope.data.prescriptionItems.length - 1);
                });

                toaster.clear();
                toaster.pop('success', 'Favourite', 'Medicine has been added to the current prescription');
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

        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patientprescription/saveprescription';
            method = 'POST';
            succ_msg = 'Prescription saved successfully';

            $scope.data.next_visit = moment($scope.data.next_visit).format('YYYY-MM-DD');

            angular.extend($scope.data, {
                encounter_id: $scope.enc.selected.encounter_id,
                patient_id: $scope.patientObj.patient_id,
                pres_date: _that.data.prescriptionItems[0].presc_date,
            });

            angular.forEach(_that.data.prescriptionItems, function (prescriptionItem, key) {
                if (angular.isObject(prescriptionItem.product_name)) {
                    _that.data.prescriptionItems[key].product_name = prescriptionItem.product_name.full_name;
                } else if (typeof prescriptionItem.product_name == 'undefined') {
                    _that.data.prescriptionItems[key].product_name = '';
                }
                _that.data.prescriptionItems[key].frequency = $('.frequency_' + key +':visible').val();
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

                            $scope.consultant_name = response.model.consultant_name;

                            $timeout(function () {
                                $scope.getFav();
                                save_success();
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

        var save_success = function () {
            if ($scope.btnid == "print")
            {
                var innerContents = document.getElementById("Getprintval").innerHTML;
                var popupWinindow = window.open('', '_blank', 'width=830,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
                popupWinindow.document.open();
                popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
                popupWinindow.document.close();
            } else {
                $scope.pres_status = 'prev';
                $("#prev_prescription").focus();
            }
        }

        $scope.getFrequencyExists = function (freq, key) {
            var result = freq.split('-');
            if (result[key] == "0")
            {
                return "-";
            } else {
                return result[key];
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
            }
        }

        $scope.checkInput = function (data) {
            if (!data) {
                return "Not empty.";
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
                        
                        if(typeof $scope.lastSelected.route_id != 'undefined')
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
            // pagination set up

            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct')
                    .success(function (products) {
                        $scope.all_products = products;

                        if (typeof date == 'undefined') {
                            url = $rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $state.params.id;
                        } else {
                            date = moment(date).format('YYYY-MM-DD');
                            url = $rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $state.params.id + '&date=' + date;
                        }

                        // Get data's from service
                        $http.get(url)
                                .success(function (prescriptionList) {
                                    $scope.isLoading = false;
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
                                                angular.forEach($scope.rowCollection[0].items, function (item) {
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
                                                        'total': $scope.calculate_price(item.frequency_name, item.number_of_days, item.product.latest_price),
                                                        'freqMask': '9-9-9-9',
                                                        'freqMaskCount': 4
                                                    };
                                                    var fav = $filter('filter')($scope.child.favourites, {product_id: item.product_id});

                                                    if (fav.length > 0) {
                                                        angular.extend(items, {is_favourite: 1});
                                                    }

                                                    PrescriptionService.addPrescriptionItem(items);
                                                });
                                                $scope.data.prescriptionItems = PrescriptionService.getPrescriptionItems();
                                            }

                                        }
                                    }

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

        $scope.calculate_price = function (freq, days, price) {
            if(typeof freq != 'undefined'){
                var freq_count = 0;
                $.each(freq.split('-'), function (key, item) {
                    freq_count = freq_count + parseInt(item);
                });
                return (parseFloat(days) * parseFloat(price) * parseFloat(freq_count));
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
            product_exists = $filter('filter')($scope.checkboxes.items, {product_id: row.product_id, route_id: row.route_id});
            pres_exists = $filter('filter')($scope.checkboxes.items, {pres_id: row.pres_id});
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
            if (e.keyCode == 13) { // enter
                if ($("#prescriptioncont-header").is(":visible")) {
                    $scope.selectOption();
                }
            }

            var selected = $("#prescriptioncont-header .selected");
            var li_count = $("#prescriptioncont-header li").length;
            
            if (e.keyCode == 40 || e.keyCode == 38) {
                $("#prescriptioncont-header li").removeClass("selected");
                if (selected.length == 0) {
                    var selected = $("#prescriptioncont-header li:last");
                }
                
                if(li_count == 1){
                    var selected = $("#prescriptioncont-header li:first");
                    selected.addClass('selected');
                }
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

            if (e.keyCode == 40 || e.keyCode == 38) {
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

        $scope.changeFreqMask = function(key, freq){
            $('.freq_div_'+key).addClass('hide');
            $('#freq_'+key+'_'+freq).removeClass('hide');
            
//            switch (freq){
//                case 3:
//                    mask = '9-9-9';
//                    break;
//                case 4:
//                    mask = '9-9-9-9';
//                    break;
//                case 5:
//                    mask = '9-9-9-9-9';
//                    break;
//            }
            $scope.data.prescriptionItems[key].freqMaskCount = freq;
        }
    }]);
