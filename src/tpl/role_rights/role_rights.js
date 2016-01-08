'use strict';
/* Controllers */
app.controller('RolesRightsController', ['$scope', '$http', '$filter', '$state', '$rootScope', '$timeout', function ($scope, $http, $filter, $state, $rootScope, $timeout) {

        //Get my organization details
        $http({
            url: $rootScope.IRISOrgServiceUrl + '/organization/getorg',
            method: "GET"
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.organization = response.data.return;
                        $scope.data = {tenant_id: $scope.organization.tenant_id};
                        $scope.modules = response.data.modules;
                    }
                    else {
                        $scope.organizationErrorData = response.data;
                    }
                }
        );

        //Get Organization Roles
        $http({
            url: $rootScope.IRISOrgServiceUrl + '/role/getactiverolesbytenant',
            method: "GET"
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.roles = response.data.roles;
                    }
                    else {
                        $scope.rolesErrorData = response.data;
                    }
                }
        );

        
//        $http({
//            url: path + "rest/secure/common/getAllOrganizationModule",
//            method: "GET"
//        }).then(
//                function (response) {
//                    if (response.data.Status === 'Ok') {
//                        $scope.modules = response.data.organizationModuleDetails;
//                    }
//                    else {
//                        $scope.moduleErrorData = response.data;
//                    }
//                }
//        );
//
//        $scope.getSavedRights = function () {
//            $scope.errorData = "";
//            $scope.successMessage = "";
//            $http.get(path + "rest/secure/user/getSavedRightsByRoleOid?roleOid=" + $scope.data.roleOid).then(
//                    function (response) {
//                        if (response.data.Status === 'Ok') {
//                            $scope.selectedModules = response.data.rightsDetails;
//                        }
//                        else {
//                            $scope.selectedModules = []
//                        }
//                    }
//            )
//        }
//        

//
//        $scope.selectedModules = [];
//        $scope.toggleSelection = function toggleSelection(module) {
//            var index = $scope.selectedModules.indexOfObjectWithProperty('oid', module.oid);
//            if (index > -1) {
//                // Is currently selected, so remove it
//                $scope.selectedModules.splice(index, 1);
//            }
//            else {
//                // Is currently unselected, so add it
//                $scope.selectedModules.push(module);
//            }
//        };
//        
//        $scope.saveRoleRights = function () {
//            $scope.errorData = "";
//            $scope.successMessage = "";
//            var selectedRoleModules = [];
//            angular.forEach($scope.selectedModules, function (value, key) {
//                selectedRoleModules.push(value.oid);
//            }
//            );
//            var data = {
//                'roleOid': $scope.data.roleOid,
//                'organizationOid': $scope.data.organizationOid,
//                'moduleOids': selectedRoleModules.join(",")
//            };
//            if ($scope.roleRightsForm.$valid) {
//                $http({
//                    url: path + "rest/secure/user/saveRoleRights",
//                    method: "POST",
//                    data: data
//                }).then(
//                        function (response) {
//                            if (response.data.Status === 'Ok') {
//                                $scope.successMessage = "Role rights saved successfully";
//                                $scope.selectedModules = [];
//                                $scope.data = {organizationOid: $scope.organization.oid};
//                            }
//                            else {
//                                $scope.errorData = response.data;
//                            }
//                        }
//                )
//            }
//        };
//        
//        $scope.reset = function () {
//            $scope.errorData = "";
//            $scope.selectedModules = [];
//            $scope.data = {organizationOid: $scope.organization.oid};
//        }
    }]);
