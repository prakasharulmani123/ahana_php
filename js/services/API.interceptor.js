angular.module('app').factory('APIInterceptor', function ($localStorage, $rootScope) {
    return {
        request: function (config) {
            config.params = config.params || {};
            
            if (typeof $localStorage.user != 'undefined') {
                var token = $localStorage.user.access_token;
                var is_api = config.url.startsWith($rootScope.IRISOrgServiceUrl);

                if (token && is_api) {
                    config.params['access-token'] = token;
                    config.headers['x-domain-path'] = $rootScope.clientUrl;
                }
            }
            return config;
        }
    };
});