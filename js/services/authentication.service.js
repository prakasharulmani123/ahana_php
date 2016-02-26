(function () {
    'use strict';

    angular
            .module('app')
            .factory('AuthenticationService', AuthenticationService);

    AuthenticationService.$inject = ['$http', '$cookieStore', '$rootScope', '$window', '$localStorage'];
    function AuthenticationService($http, $cookieStore, $rootScope, $window, $localStorage) {
        var service = {};
        var currentUser = null;

        service.Login = Login;
//        service.SetCredentials = SetCredentials;
        service.ClearCredentials = ClearCredentials;
        service.setCurrentUser = setCurrentUser;
        service.getCurrentUser = getCurrentUser;

        return service;

        function Login(username, password, tenant_id, callback) {
            var response;
            $http.post($rootScope.IRISOrgServiceUrl + '/user/login', {username: username, password: password, tenant_id: tenant_id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

//        function SetCredentials(secToken, resources, credentials) {
//            $rootScope.globals = {
//                currentUser: {
//                    authdata: secToken
//                }
//            };
//
//            $localStorage.$default({user_resources: resources, user_credentials: credentials});
//
//            $cookieStore.put('globals', $rootScope.globals);
//            $http.defaults.headers.common['Authorization'] = 'Bearer ' + secToken; // jshint ignore:line
//        }

        function ClearCredentials() {
            $localStorage.$reset();
            return true;

//            $rootScope.globals = {};
//            $cookieStore.remove('globals');
//            $http.defaults.headers.common.Authorization = 'Basic';
        }

        function setCurrentUser(user) {
            currentUser = user;
            $localStorage.$default({'user':user});
            return currentUser;
        };

        function getCurrentUser() {
            if (!currentUser) {
                currentUser = $localStorage.user;
            }
            return currentUser;
        };
    }

})();