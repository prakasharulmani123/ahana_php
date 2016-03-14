'use strict';

/* Controllers */
// signin controller
app.controller('SigninFormController', SignInForm);

SignInForm.$inject = ['$scope', '$state', 'AuthenticationService', '$http', '$rootScope', '$location', '$timeout'];
function SignInForm($scope, $state, AuthenticationService, $http, $rootScope, $location, $timeout) {
    $scope.user = {};
    $scope.authError = null;
    $scope.loginButtonText = 'Log in';
    $scope.forgotpasswordButtonText = 'Send Request';
    $scope.forgotpasswordButtonClass = 'primary';

    $rootScope.commonService.GetTenantList(function (response) {
        $scope.tenants = response.tenantList;
    });
    $scope.login = function () {
        $scope.authError = null;
        $scope.loginButtonText = 'Logging in...Please Wait ....';
        $('#login_btn').attr('disabled', true);
        // Try to login
        AuthenticationService.Login($scope.user.username, $scope.user.password, $scope.user.tenant_id, function (response) {
            if (response.success) {
                AuthenticationService.setCurrentUser(response);
                $state.go('configuration.roles');
            } else {
                $scope.loginButtonText = 'Log in';
                $('#login_btn').attr('disabled', false);
                $scope.authError = response.message;
            }
        });
    };


    $scope.passwordrequest = function () {
        $scope.errorData = $scope.successMessage = '';
        $scope.forgotpasswordButtonText = 'Please Wait ....';
        $('#forgot_btn').attr('disabled', true);

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
                        $scope.forgotpasswordButtonText = 'Request Sent';
                        $('#forgot_btn').attr('disabled', true);
                        $scope.forgotpasswordButtonClass = 'success';
                    } else {
                        $scope.forgotpasswordButtonText = 'Send';
                        $('#forgot_btn').attr('disabled', false);
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