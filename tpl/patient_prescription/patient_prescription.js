app.controller('PrescriptionController', ['$rootScope', '$scope', '$anchorScroll', '$http', '$state', '$filter', '$modal', '$log', '$timeout', function ($rootScope, $scope, $anchorScroll, $http, $state, $filter, $modal, $log, $timeout) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.enc = {};
        $scope.drugs = {};
        $scope.routes = {};
        $scope.frequencies = {};

        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;
                    if (response != null) {
                        $scope.enc.selected = $scope.encounters[0];
                    }
                });
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.loadSideMenu();
                $scope.$emit('encounter_id', newValue);
            }
        }, true);

        $scope.loadSideMenu = function () {
            //Get Notes
            $http.get($rootScope.IRISOrgServiceUrl + '/patientnotes/getpatientnotes?patient_id=' + $state.params.id)
                    .success(function (notes) {
                        $scope.child.notes = notes.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientnote!";
                    });
            //Get Vitals
            $http.get($rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?patient_id=' + $state.params.id)
                    .success(function (vitals) {
                        $scope.child.vitals = vitals.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientvitals!";
                    });
            //Get Fav
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
            $rootScope.commonService.GetPatientRoute('', '1', false, function (response) {
                $scope.routes = response.routelist;
            });
            $rootScope.commonService.GetPatientFrequency('', '1', false, function (response) {
                $scope.frequencies = response.frequencylist;
            });
        }

        $scope.getGeneric = function ($item, $model, $label) {
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getgenericlistbydrugclass?drug_class_id=' + $item.drug_class_id)
                    .success(function (response) {
                        $scope.generics = response.genericList;
                    }, function (x) {
                        $scope.errorData = "An Error has occured while loading generic!";
                    });
        }

        $scope.getProduct = function ($item, $model, $label) {
            $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbygeneric?generic_id=' + $item.generic_id)
                    .success(function (response) {
                        $scope.products = response.productList;
                    }, function (x) {
                        $scope.errorData = "An Error has occured while loading generic!";
                    });
        }

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
                        'route': $scope.addData.route,
                        'frequency': $scope.addData.frequency,
                        'number_of_days': $scope.addData.number_of_days,
                        'is_favourite': 0,
                    };
                    var fav = $filter('filter')($scope.child.favourites, {product_id: $scope.addData.product.product_id});

                    if (fav.length > 0) {
                        angular.extend(items, {is_favourite: 1});
                    }
                    
                    $scope.data.prescriptionItems.push(items);
                    $scope.addData = {};

                    $timeout(function () {
                        $("#search-form-div").removeClass('open');
                        $scope.setFocus('number_of_days', $scope.data.prescriptionItems.length - 1);
                    });
                }
            }
        }

        $scope.addPres = function (prescription) {
            var result = $filter('filter')($scope.data.prescriptionItems, {product_id: prescription.product_id});

            if (result.length > 0) {
                alert('This Product already added');
            } else {
                var fav = $filter('filter')($scope.child.favourites, {product_id: prescription.product_id});

                if (fav.length > 0) {
                    angular.extend(prescription, {is_favourite: 1});
                }

                $scope.data.prescriptionItems.push(prescription);

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

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };
        $scope.minDate = $scope.minDate ? null : new Date();

        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patientprescription/saveprescription';
            method = 'POST';
            succ_msg = 'Prescription saved successfully';

            $scope.data.next_visit = moment($scope.data.next_visit).format('YYYY-MM-DD');

            angular.extend($scope.data, {
                encounter_id: $scope.enc.selected.encounter_id,
                patient_id: $scope.app.patientDetail.patientId,
                pres_date: moment().format('YYYY-MM-DD HH:mm:ss'),
            });

            angular.forEach(_that.data.prescriptionItems, function (prescriptionItem, key) {
                if (angular.isObject(prescriptionItem.product_name)) {
                    _that.data.prescriptionItems[key].product_name = prescriptionItem.product_name.full_name;
                } else if (typeof prescriptionItem.product_name == 'undefined') {
                    _that.data.prescriptionItems[key].product_name = '';
                }
            });

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
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
//                            $timeout(function () {
//                                $state.go('patient.prescription', {id: $state.params.id});
//                            }, 1000)
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

        $scope.removeItem = function (item) {
            var index = $scope.data.prescriptionItems.indexOf(item);
            $scope.data.prescriptionItems.splice(index, 1);
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
            if (newValue != '') {
                if (changeTimer !== false)
                    clearTimeout(changeTimer);

                changeTimer = setTimeout(function () {
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getprescription',
                        data: {'search': newValue},
                    }).success(
                            function (response) {
                                $scope.prescription_lists = response.prescription;
                            }
                    );
                    changeTimer = false;
                }, 300);
            } else {
                $scope.prescription_lists = {};
            }
        }, true);

        $scope.prev_pre = '0';
        $scope.prescriptionStauts = function (status) {
            if (status == '0') {
                $scope.prev_pre = '1';
            } else {
                $scope.prev_pre = '0';
            }
        }

        $scope.loadPrevPrescriptionsList = function (encounter_id) {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patientprescription/getpreviousprescription?patient_id=' + $state.params.id + '&encounter_id=' + encounter_id)
                    .success(function (prescriptionList) {
                        $scope.isLoading = false;
                        $scope.rowCollection = prescriptionList.prescriptions;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading list!";
                    });
        };
    }]);
