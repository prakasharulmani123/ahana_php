angular.module('app').directive('checkAccess', function() {
    return {
        link: function(scope, element, attrs) {
            element.addClass('hide');
            if(scope.checkAccess(element.attr('ui-sref'))){
                element.addClass('show');
            }
        }
    }
});
