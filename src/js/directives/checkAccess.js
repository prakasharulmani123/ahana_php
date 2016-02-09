angular.module('app').directive('checkAccess', function () {
    return {
        link: function (scope, element, attrs) {
//            element.addClass('hide');
//            if (scope.checkAccess(element.attr('ui-sref'))) {
//                element.addClass('show');
//            }
        }
    }
});
angular.module('app').directive('checkAccessButton', function () {
    return {
        link: function ($scope, element, attrs) {
//            var url = element.attr('ng-click').match(/'([^']+)'/)[1];
//            element.addClass('hide');
//            if ($scope.checkAccess(url)) {
//                element.addClass('show');
//            }
        }
    }
});

