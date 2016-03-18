angular.module('app').factory('APIInterceptor', function ($localStorage, $rootScope, $q, $window, $timeout) {
    return {
        request: function (config) {
            config.params = config.params || {};

            var is_api = config.url.indexOf($rootScope.IRISOrgServiceUrl);
            if (is_api >= 0) {
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
        responseError: function (rejection) {
            // do something on error
            if (rejection.status === 401) {
                $rootScope.$broadcast('unauthorized');
            }
            return $q.reject(rejection);
        }
    };
});