angular.module('app').directive('checkAccess', function() {
    return {
        link: function(scope, element, attrs) {
            element.addClass('hide');
            console.log(element.attr('ui-sref'));
        }
    }
});
