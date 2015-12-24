(function () {
    'use strict';

    angular
            .module('app')
            .factory('AuthenticationService', AuthenticationService);

    AuthenticationService.$inject = ['$http', '$cookieStore', '$rootScope', '$window'];
    function AuthenticationService($http, $cookieStore, $rootScope, $window) {
        var service = {};

        service.Login = Login;
        service.SetCredentials = SetCredentials;
        service.ClearCredentials = ClearCredentials;

        return service;

        function Login(username, password, callback) {
            var response;
            $http.post($rootScope.IRISAdminServiceUrl + '/user/login', {username: username, password: password})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        function SetCredentials(secToken) {
            $window.sessionStorage.access_token = secToken;
            $http.defaults.headers.common['Authorization'] = 'Basic ' + secToken; // jshint ignore:line
        }

        function ClearCredentials() {
            $rootScope.globals = {};
            $cookieStore.remove('globals');
            delete $window.sessionStorage.access_token;
            $http.defaults.headers.common.Authorization = 'Basic';
        }
    }

})();