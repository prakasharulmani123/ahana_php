'use strict';
angular.module('app').directive('autocomplete', function () {
    return {
        restrict: 'A',
        scope: {
            autocompleteconfig: '='
        },
        link: function (scope, elem, attr, ctrl) {
            scope.$watch('autocompleteconfig', function (value) {
                elem.autocomplete(value);
            });
        }
    };
});