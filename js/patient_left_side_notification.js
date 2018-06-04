angular.module('app').controller('PatientLeftSideNotificationCtrl', ['$rootScope', '$scope', '$http', '$state', '$filter', '$timeout', function ($rootScope, $scope, $http, $state, $filter, $timeout) {
        $scope.loadPatientDetail();

        $scope.assignNotifications = function () {
            //Assign Notes
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/patientnotes/assignnotes',
                data: {'patient_guid': $state.params.id},
            }).success(
                    function (response) {
                        if (response.success) {
                            if (typeof $state.params.id != 'undefined') {
                                //Get Notes
                                $http.get($rootScope.IRISOrgServiceUrl + '/patientnotes/getpatientnotes?patient_id=' + $state.params.id)
                                        .success(function (notes) {
                                            angular.forEach(notes.result, function (result) {
                                                angular.forEach(result.all, function (note) {
                                                    $scope.leftNotificationNotes.push(note);
                                                });
                                            });
                                            $scope.unseen_notes = notes.usernotes;
                                            $scope.app.patientDetail.patientUnseenNotesCount = notes.usernotes.length;

                                            angular.forEach($scope.leftNotificationNotes, function (note) {
                                                note.seen_by = 1;
                                            });

                                            angular.forEach(notes.usernotes, function (note) {
                                                var seen_filter_note = $filter('filter')($scope.leftNotificationNotes, {pat_note_id: note.note_id});

                                                if (seen_filter_note.length > 0) {
                                                    seen_filter_note[0].seen_by = 0;
                                                }
                                            });
                                        })
                                        .error(function () {
                                            $scope.errorData = "An Error has occured while loading patientnote!";
                                        });
                            }

                        }
                    }
            );

            //Assign Vitals
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/patientvitals/assignvitals',
                data: {'patient_guid': $state.params.id},
            }).success(
                    function (response) {
                        if (response.success) {
                            if (typeof $state.params.id != 'undefined') {
                                // Get Vitals
                                $http.get($rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?addtfields=eprvitals&patient_id=' + $state.params.id)
                                        .success(function (vitals) {
                                            angular.forEach(vitals.result, function (result) {
                                                angular.forEach(result.all, function (vital) {
                                                    $scope.leftNotificationVitals.push(vital);
                                                });
                                            });
                                            $scope.unseen_vitals = vitals.uservitals;
                                            $scope.app.patientDetail.patientUnseenVitalsCount = vitals.uservitals.length;

                                            angular.forEach($scope.leftNotificationVitals, function (vital) {
                                                vital.seen_by = 1;
                                            });

                                            angular.forEach(vitals.uservitals, function (vital) {
                                                var seen_filter_vital = $filter('filter')($scope.leftNotificationVitals, {vital_id: vital.vital_id});
                                                if (seen_filter_vital.length > 0) {
                                                    seen_filter_vital[0].seen_by = 0;
                                                }
                                            });
                                        })
                                        .error(function () {
                                            $scope.errorData = "An Error has occured while loading patientvitals!";
                                        });
                            }
                        }
                    }
            );
        };
        $scope.$on('$viewContentLoaded', function (event) {
            $scope.assignNotifications();
        });


        $scope.seen_notes_left_notification = function () {
            if ($scope.app.patientDetail.patientUnseenNotesCount > 0) {
                var unseen_filter_note = $filter('filter')($scope.leftNotificationNotes, {seen_by: 0});
                var note_ids = [];
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
                                angular.forEach($scope.leftNotificationNotes, function (note, key) {
                                    note.seen_by = 1;
                                });
                                $scope.app.patientDetail.patientUnseenNotesCount = 0;
                            }, 5000);
                        }
                );
            }
        }

        $scope.seen_vitals_left_notification = function () {
            if ($scope.app.patientDetail.patientUnseenVitalsCount > 0) {
                var unseen_filter_vital = $filter('filter')($scope.leftNotificationVitals, {seen_by: 0});
                var vital_ids = [];
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
                                angular.forEach($scope.leftNotificationVitals, function (vital, key) {
                                    vital.seen_by = 1;
                                });
                                $scope.app.patientDetail.patientUnseenVitalsCount = 0;
                            }, 5000);
                        }
                );
            }
        }
        Array.prototype.max = function () {
            return Math.max.apply(null, this);
        };
        Array.prototype.min = function () {
            return Math.min.apply(null, this);
        };
        $scope.setvitalgraph = function () {
            var url = $rootScope.IRISOrgServiceUrl + '/patientvitals/getvitalsgraph?addtfields=eprvitals&patient_id=' + $state.params.id;
            $http.get(url)
                    .success(function (vitals) {

                        //Temperature chart data
                        $scope.tem_graph_data = [];
                        $scope.tem_graph_tick = [];
                        var tem = vitals.temperature.length;
                        angular.forEach(vitals.temperature, function (row) {
                            if (row.temperature) {
                                $scope.tem_graph_data.push([tem, row.temperature]);
                                $scope.tem_graph_tick.push([tem, moment(row.vital_time).format('DD-MM-YY')]);
                                tem--;
                            }
                        });
                        //Weight chart data
                        $scope.weight_graph_data = [];
                        $scope.weight_graph_tick = [];
                        var weight_max_min = [];
                        var wht = vitals.weight.length;
                        angular.forEach(vitals.weight, function (row) {
                            if (row.weight) {
                                weight_max_min.push(row.weight);
                                $scope.weight_graph_data.push([wht, row.weight]);
                                $scope.weight_graph_tick.push([wht, moment(row.vital_time).format('DD-MM-YY')]);
                                wht--;
                            }
                        });
                        $scope.min_weight = weight_max_min.min() - 5;
                        $scope.max_weight = weight_max_min.max() + 5;
                        //Height chart data
                        $scope.height_graph_data = [];
                        $scope.height_graph_tick = [];
                        var hgt = vitals.height.length;
                        angular.forEach(vitals.height, function (row) {
                            if (row.height) {
                                $scope.height_graph_data.push([hgt, row.height]);
                                $scope.height_graph_tick.push([hgt, moment(row.vital_time).format('DD-MM-YY')]);
                                hgt--;
                            }
                        });
                        //Pulse chart data
                        $scope.pulse_graph_data = [];
                        $scope.pulse_graph_tick = [];
                        var pul = vitals.pulse.length;
                        angular.forEach(vitals.pulse, function (row) {
                            if (row.pulse_rate) {
                                $scope.pulse_graph_data.push([pul, row.pulse_rate]);
                                $scope.pulse_graph_tick.push([pul, moment(row.vital_time).format('DD-MM-YY')]);
                                pul--;
                            }
                        });
                        //Sp02 chart data
                        $scope.sp02_graph_data = [];
                        $scope.sp02_graph_tick = [];
                        var sp = vitals.sp02.length;
                        angular.forEach(vitals.sp02, function (row) {
                            if (row.sp02) {
                                $scope.sp02_graph_data.push([sp, row.sp02]);
                                $scope.sp02_graph_tick.push([sp, moment(row.vital_time).format('DD-MM-YY')]);
                                sp--;
                            }
                        });
                        //Pain Score chart data
                        $scope.pain_graph_data = [];
                        $scope.pain_graph_tick = [];
                        var pain = vitals.painScore.length;
                        angular.forEach(vitals.painScore, function (row) {
                            if (row.pain_score) {
                                $scope.pain_graph_data.push([pain, row.pain_score]);
                                $scope.pain_graph_tick.push([pain, moment(row.vital_time).format('DD-MM-YY')]);
                                pain--;
                            }
                        });
                        //Blood pressure chart data
                        $scope.bps_graph_data = [];
                        $scope.bpd_graph_data = [];
                        $scope.bp_graph_tick = [];
                        var bp = vitals.bp.length;
                        angular.forEach(vitals.bp, function (row) {
                            if ((row.blood_pressure_systolic) || (row.blood_pressure_diastolic)) {
                                if (row.blood_pressure_systolic)
                                    $scope.bps_graph_data.push([bp, row.blood_pressure_systolic]);
                                if (row.blood_pressure_diastolic)
                                    $scope.bpd_graph_data.push([bp, row.blood_pressure_diastolic]);
                                $scope.bp_graph_tick.push([bp, moment(row.vital_time).format('DD-MM-YY')]);
                                bp--;
                            }
                        });
                        
                        //BMI chart data
                        $scope.bmi_graph_data = [];
                        $scope.bmi_graph_tick = [];
                        var bmi = vitals.bmi.length;
                        angular.forEach(vitals.bmi, function (row) {
                            if (row.bmi) {
                                $scope.bmi_graph_data.push([bmi, row.bmi]);
                                $scope.bmi_graph_tick.push([bmi, moment(row.vital_time).format('DD-MM-YY')]);
                                bmi--;
                            }
                        });
                    })
        }
    }]);
