app.controller('PatientMergeController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', '$q', function ($rootScope, $scope, $timeout, $http, $state, $filter, $q) {

        $scope.patient = '';
        $scope.patient_search_result = [];
        $scope.selected_patients = [];
        $scope.show_loader = false;
        var canceler;

        var changeTimer = false;
        $scope.$watch('patient', function (newValue, oldValue) {
            if (newValue != '') {
                if (canceler)
                    canceler.resolve();
                canceler = $q.defer();

                if (changeTimer !== false)
                    clearTimeout(changeTimer);

                $scope.show_loader = true;
                changeTimer = setTimeout(function () {
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patient/search?addtfields=search',
                        timeout: canceler.promise,
                        data: {'search': newValue},
                    }).success(
                            function (response) {
                                $scope.patient_search_result = response.patients;
                                $scope.show_loader = false;
                            }
                    );
                    changeTimer = false;
                }, 300);
            }
        }, true);

        $scope.filterFn = function (item) {
//            return !item.Patient.have_encounter && item.Patient.childrens_count == '0';
            return item.Patient.childrens_count == '0';
        };

        $("#patient-search").keydown(function (e) {
            var parent_div = "#patient-merge-result";
            if (e.keyCode == 13) { // enter
                if ($(parent_div).is(":visible")) {
                    $scope.selectOption(parent_div);
                }
            }

            if (e.keyCode == 38) { // up
                var selected = $(parent_div + " .selected");
                $(parent_div + " li").removeClass("selected");
                if (selected.prev().length == 0) {
                    selected.siblings().last().addClass("selected");
                } else {
                    selected.prev().addClass("selected");
                }
            }

            if (e.keyCode == 40) { // down
                var selected = $(parent_div + " .selected");
                $(parent_div + " li").removeClass("selected");
                if (selected.next().length == 0) {
                    selected.siblings().first().addClass("selected");
                } else {
                    selected.next().addClass("selected");
                }
            }
        });

        $("body").on("mouseover", ".result-patient-merge li", function () {
            $(".result-patient-merge li").removeClass("selected");
            $(this).addClass("selected");
        });

        $scope.selectOption = function (parent_selector) {
            var link_tag = $(parent_selector + " .selected").find("a");
            if (link_tag.length > 0) {
                $(link_tag).trigger("click");
            }
            return false;
        }

        $scope.displayPatient = function (id) {
            $(".merge-patientcont").hide();
            var filteredResult = $filter('filter')($scope.patient_search_result, {Patient: {patient_global_guid: id}});
            if (filteredResult.length > 0) {
                if (filteredResult[0].Patient.have_encounter) {
                    alert('This patient have an active encounter, so you can not merge now');
                } else {
                    if ($scope.selected_patients.length < 3) {
                        $scope.inserted = {
                            'Patient': filteredResult[0].Patient,
                            'is_primary': false
                        };
                        $scope.selected_patients.push($scope.inserted);
                    } else {
                        alert('Only 3 patients are allowed');
                    }
                }

                $scope.patient_search_result = [];
                $scope.patient = '';
            }
        }

        $scope.choosePrimary = function (key) {
            angular.forEach($scope.selected_patients, function (selectedPatientValue, selectedPatientKey) {
                if (selectedPatientKey == key) {
                    selectedPatientValue.is_primary = true;
                } else {
                    selectedPatientValue.is_primary = false;
                }
            });
        }

        $scope.saveForm = function () {
            var conf = confirm('Are you sure to Merge these patients ?');
            if (conf) {
                $scope.loadbar('show');
                post_url = $rootScope.IRISOrgServiceUrl + '/patient/mergepatients';
                method = 'POST';
                $http({
                    method: method,
                    url: post_url,
                    data: $scope.selected_patients,
                }).success(
                        function (response) {
                            if (response.success) {
                                $scope.msg.successMessage = response.message;
                            } else {
                                $scope.msg.errorMessage = response.message;
                            }
                            $scope.loadbar('hide');
                            $scope.patient_search_result = [];
                            $scope.selected_patients = [];
                            $scope.patient = '';
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            }
        }

        $scope.removeMergePatient = function (index) {
            $scope.selected_patients.splice(index, 1);
        }

    }]);