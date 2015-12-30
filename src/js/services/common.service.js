'use strict';

angular.module('app').factory('CommonService', CommonService);

CommonService.$inject = ['$http', '$rootScope', '$window'];
function CommonService($http, $rootScope, $window) {
    var service = {};

    service.ChangeStatus = ChangeStatus;

    return service;

    function ChangeStatus(modelName, primaryKey) {
        var response;
        $http.post($rootScope.IRISAdminServiceUrl + '/default/change-status', {model: modelName, id: primaryKey})
                .success(function (response) {
//                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
//                    callback(response);
                });
    }
}