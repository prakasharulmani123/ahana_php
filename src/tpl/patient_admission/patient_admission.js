app.controller('PatientAdmissionController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        
        //Index Page
        $scope.loadPatientDetail = function () {
            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patients/' + $state.params.patient_id)
                    .success(function (patient) {
                        $scope.app.patientDetail.patientTitleCode = patient.patient_title_code;
                        $scope.app.patientDetail.patientName = patient.patient_firstname;
                        $scope.app.patientDetail.patientId = patient.patient_id;
                        $scope.app.patientDetail.patientSex = patient.patient_gender;
                        $scope.app.patientDetail.patientDOA = patient.patient_reg_date;
                        $scope.app.patientDetail.patientOrg = patient.tenant_id;
                        $scope.data = patient;
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading patient!";
                    });
        };

        $scope.initForm = function () {
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });

            $rootScope.commonService.GetFloorList('', '1', false, function (response) {
                $scope.floors = response.floorList;
            });

            $rootScope.commonService.GetWardList('', '1', false, function (response) {
                $scope.wards = response.wardList;
            });
            
            $rootScope.commonService.GetRoomList('', '1', false, function (response) {
                $scope.rooms = response.roomList;
            });

            $rootScope.commonService.GetRoomTypeList('', '1', false, function (response) {
                $scope.roomTypes = response.roomtypeList;
            });
        }
        
        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
            }
        };

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.updateWard = function () {
            $scope.availableWards = [];
            $scope.availableRooms = [];

            _that = this;
            angular.forEach($scope.wards, function (value) {
                if (value.floor_id == _that.data.PatAdmission.floor_id) {
                    var obj = {
                        ward_id: value.ward_id,
                        ward_name: value.ward_name
                    };
                    $scope.availableWards.push(obj);
                }
            });
        }

        $scope.updateRoom = function () {
            $scope.availableRooms = [];

            _that = this;
            angular.forEach($scope.rooms, function (value) {
                if (value.ward_id == _that.data.PatAdmission.ward_id) {
                    var obj = {
                        room_id: value.room_id,
                        bed_name: value.bed_name
                    };
                    $scope.availableRooms.push(obj);
                }
            });
        }
        
        //Save Both Add Data
        $scope.saveForm = function (mode) {
            _that = this;
            
            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/encounter/createadmission';
            method = 'POST';
            succ_msg = 'Admission saved successfully';
            angular.extend(_that.data.PatAdmission, {patient_id: $scope.app.patientDetail.patientId});
            angular.extend(_that.data.PatEncounter, {patient_id: $scope.app.patientDetail.patientId});

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
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

        

    }]);