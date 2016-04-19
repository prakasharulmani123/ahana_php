Array.prototype.indexOfObjectWithProperty = function (propertyName, propertyValue) {
    for (var i = 0, len = this.length; i < len; i++) {
        if (this[i][propertyName] === propertyValue)
            return i;
    }
    return -1;
};

Array.prototype.containsObjectWithProperty = function (propertyName, propertyValue) {
    return this.indexOfObjectWithProperty(propertyName, propertyValue) != -1;
};

'use strict';
/* Controllers */
app.controller('RoomTypesRoomsController', ['$scope', '$http', '$filter', '$state', '$rootScope', '$timeout', function ($scope, $http, $filter, $state, $rootScope, $timeout) {

        //Index Page
        $scope.loadList = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/room/getrooms')
                    .success(function (rooms) {
                        $scope.isLoading = false;
                        $scope.rowCollection = rooms;
                        
                         //Avoid pagination problem, when come from other pages.
                        $scope.footable_redraw();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading roomtypes!";
                    });
        };

        //Get Organization bed types
        $scope.selectedRoomandRoomTypes = [];
        $scope.selectedRoom = [];
        $scope.roomTypes = [];

        $scope.toggleSelection = function toggleSelection(roomtype) {
            var index = $scope.selectedRoomandRoomTypes.indexOfObjectWithProperty('room_type_id', roomtype.room_type_id);
            if (index > -1) {
                // Is currently selected, so remove it
                $scope.selectedRoomandRoomTypes.splice(index, 1);
            }
            else {
                // Is currently unselected, so add it
                $scope.selectedRoomandRoomTypes.push(roomtype);
            }
        };

        $scope.getRoomandRoomTypes = function () {
            $scope.errorData = "";
            $scope.successMessage = "";

            $rootScope.commonService.GetRoomTypeList('', '1', false, function (response) {
                $scope.roomtypes = response.roomtypeList;
            });

            $http({
                url: $rootScope.IRISOrgServiceUrl + '/room/getroomandroomtypes?id=' + $state.params.room_id,
                method: "GET",
            }).then(
                    function (response) {
                        $scope.data = {room_id: response.data.room.room_id};
                        $scope.selectedRoom = response.data.room;
                        $scope.selectedRoomandRoomTypes = response.data.room_types;
                    }
            );
        }

        //Save Data
        $scope.saveForm = function () {
            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.roomTypeList = [];

            angular.forEach($scope.selectedRoomandRoomTypes, function (parent) {
                $scope.roomTypeList.push(parent.room_type_id);
            });

            if (typeof this.data != "undefined") {
                this.data.room_type_ids = [];
                this.data.room_type_ids = $scope.roomTypeList;
            }

            var _that = this;
            $scope.loadbar('show');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/room/assignroomtypes',
                data: _that.data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {
                            $scope.successMessage = "Bed Types assigned successfully";
                            $timeout(function () {
                                $state.go("configuration.roomTypeRoom");
                            }, 1000);
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

    }]);
