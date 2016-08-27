angular.module('app').factory('APIInterceptor', function ($localStorage, $rootScope, $q, $window, $timeout) {
    return {
        request: function (config) {
            config.params = config.params || {};

            var is_api = config.url.indexOf($rootScope.IRISOrgServiceUrl);
            if (is_api >= 0) {
                if(typeof config.headers['x-domain-path'] == 'undefined' || config.headers['x-domain-path'] == '')
                    config.headers['x-domain-path'] = $rootScope.clientUrl;
            }

            if (typeof $localStorage.user != 'undefined') {
                var token = $localStorage.user.access_token;
                if (token && is_api >= 0) {
                    config.params['access-token'] = token;
                }
            }
            return config;
        },
        response: function(response) {
            $('.selectpicker').selectpicker('refresh');
            $timeout(function () {
                $('.selectpicker').selectpicker('refresh');
            }, 3000);
            return response;
        },
        responseError: function (rejection) {
            // do something on error
            if (rejection.status === 401) {
                $rootScope.$broadcast('unauthorized');
            } else if (rejection.status === 500) {
                $rootScope.$broadcast('internalerror');
            }
            return $q.reject(rejection);
        }
    };
});