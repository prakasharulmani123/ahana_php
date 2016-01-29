app.controller('PatientAdmissionController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';

        $scope.initCanCreateAdmission = function () {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        if(response.success == true){
                            alert("This patient already have an active admission. You can't create a new admission");
                            $state.go("patient.view", {id: $state.params.id});
                        }
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                    });
        }

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

            $rootScope.commonService.GetRoomList('', '1', false, '0', function (response) {
                $scope.rooms = response.roomList;
            });

            $rootScope.commonService.GetRoomTypeList('', '1', false, function (response) {
                $scope.roomTypes = response.roomtypeList;
            });
            
            $rootScope.commonService.GetRoomTypesRoomsList('', function (response) {
                $scope.roomTypesRoomsList = response.roomtypesroomsList;
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
            $scope.availableRoomtypes = [];

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
            $scope.availableRoomtypes = [];

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
        
        $scope.updateRoomType = function () {
            $scope.availableRoomtypes = [];

            _that = this;
            angular.forEach($scope.roomTypesRoomsList, function (value) {
                if (value.room_id == _that.data.PatAdmission.room_id) {
                    var obj = {
                        room_type_id: value.room_type_id,
                        room_type_name: value.room_type_name
                    };
                    $scope.availableRoomtypes.push(obj);
                }
            });
        }

        //Save Both Add Data
        $scope.saveForm = function () {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/encounter/createadmission';
            method = 'POST';
            succ_msg = 'Admission saved successfully';

            if (typeof (_that.data) != "undefined") {
                if (_that.data.hasOwnProperty('PatAdmission')) {
                    angular.extend(_that.data.PatAdmission, {patient_id: $scope.app.patientDetail.patientId});
                }

                if (_that.data.hasOwnProperty('PatEncounter')) {
                    angular.extend(_that.data.PatEncounter, {patient_id: $scope.app.patientDetail.patientId});
                }
            }

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