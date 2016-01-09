'use strict';
/* Controllers */
app.controller('RolesRightsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //sanitize all the variables
        $scope.sanitizeVariable = function (data) {
            var result = {};
            angular.forEach(data, function (value, key) {
                if (typeof value == "undefined") {
                    result[key] = '';
                } else {
                    result[key] = value;
                }
            }, result);
            return result;
        }

        //Get my organization details with all modules
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
                        $scope.errorData = response.data.message;
                    }
                }
        );

        //Get Organization active roles
        $http({
            url: $rootScope.IRISOrgServiceUrl + '/role/getactiverolesbytenant',
            method: "GET"
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.roles = response.data.roles;
                    }
                    else {
                        $scope.errorData = response.data.message;
                    }
                }
        );

        //Get Rolewise rights
        $scope.getSavedRights = function () {
            $scope.errorData = "";
            $scope.successMessage = "";
            $scope.loadbar('show');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/organization/getorgmodulesbyrole',
                data: this.data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {
                            $scope.modules = response.data.modules;
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        }

        // Assign Role rights 
        $scope.saveRoleRights = function () {
            $scope.errorData = "";
            $scope.successMessage = "";
            $scope.moduleList = [];

            angular.forEach($scope.modules, function (parent) {
                if (parent.selected == true || parent.__ivhTreeviewIndeterminate == true) {
                    $scope.moduleList.push(parent.value);
                    angular.forEach(parent.children, function (child) {
                        if (child.selected == true)
                            $scope.moduleList.push(child.value);
                    });
                }
            });

            if (typeof this.data != "undefined") {
                this.data.Module = [];
                this.data.Module = {'resource_ids': $scope.moduleList};
            }

            this.data.Module['role_id'] = this.data.role_id;
            this.data.Module['tenant_id'] = this.data.tenant_id;

            var post_data = {Module: $scope.sanitizeVariable(this.data.Module)};

            $scope.loadbar('show');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/organization/updaterolerights',
                data: post_data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {
                            $scope.successMessage = "Organization saved successfully";
                            $scope.data = {};
                            $timeout(function () {
                                $state.go('configuration.roleRights');
                            }, 1000)
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };
        
    }]);
