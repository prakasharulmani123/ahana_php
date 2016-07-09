'use strict';

/* Controllers */
// signin controller
app.controller('SigninFormController', SignInForm);

SignInForm.$inject = ['$scope', '$state', 'AuthenticationService', '$http', '$rootScope', '$location', '$timeout','$localStorage'];
function SignInForm($scope, $state, AuthenticationService, $http, $rootScope, $location, $timeout, $localStorage) {
    $scope.user = {};
    $scope.authError = null;
    $scope.forgotpasswordButtonClass = 'primary';
    
    $scope.showForm = false;
    $scope.showFormError = false;
    $scope.FormErrorMessage = '';
    
    $rootScope.commonService.GetTenantList(function (response) {
        $scope.tenants = response.tenantList;
        
        if(response.org_sts == '1' && $scope.tenants.length > 0){
            $scope.showForm = true;
            
            if(!$localStorage.system_tenant)
                $localStorage.system_tenant = $scope.tenants[0].value;

                $scope.user.tenant_id = $localStorage.system_tenant;
        }else{
            $scope.showFormError = true;
            
            if(response.org_sts == '0'){
                $scope.FormErrorMessage = 'This Organization is in-active. Contact Administrator.';
            }
            if($scope.tenants.length == '0'){
                $scope.FormErrorMessage = 'This Organization has no Branch. Contact Administrator.';
            }
        }
    });
    $scope.login = function () {
        $scope.authError = null;
        $('#login_btn').button('loading');
        // Try to login
        AuthenticationService.Login($scope.user.username, $scope.user.password, $scope.user.tenant_id, function (response) {
            if (response.success) {
                AuthenticationService.setCurrentUser(response);
                $localStorage.system_tenant = $scope.user.tenant_id;
                $state.go('configuration.roles');
            } else {
                $('#login_btn').button('reset');
                $scope.authError = response.message;
            }
        });
    };


    $scope.passwordrequest = function () {
        $scope.errorData = $scope.successMessage = '';
        $('#forgot_btn').button('loading');

        $http({
            method: "POST",
            url: $rootScope.IRISOrgServiceUrl + '/user/request-password-reset',
            data: {email: $scope.email, tenant_id: $scope.tenant_id},
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.successMessage = response.data.message;
                        $scope.errorData = '';
                        $scope.email = '';
//                        $('#forgot_btn').button('reset');
                        $('#forgot_btn').attr('disabled', true).text('Request Sent');
                        $scope.forgotpasswordButtonClass = 'success';
                    } else {
                        $scope.forgotpasswordButtonText = 'Send';
                        $('#forgot_btn').button('reset');
                        $scope.errorData = response.data.message;
                    }
                }
        )
    };

    $scope.resetpassword = function () {
        $http({
            method: "POST",
            url: $rootScope.IRISOrgServiceUrl + '/user/reset-password',
            data: {password: $scope.password, password_reset_token: $location.search().token, repeat_password: $scope.repeat_password},
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.password = $scope.repeat_password = '';
                        $scope.successMessage = response.data.message;
                        $scope.errorData = '';
                        $timeout(function () {
                            $state.go('access.signin');
                        }, 10000)
                    } else {
                        $scope.errorData = response.data.message;
                    }
                }
        )
    };

}