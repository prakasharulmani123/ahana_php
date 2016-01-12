angular.module('app').directive('expand', function () {
    return {
        restrict: 'A',
        controller: ['$scope', function ($scope) {
                $scope.$on('onExpandAll', function (event, args) {
                    $scope.expanded = args.expanded;
                });
            }]
    };
});

angular.module('app').directive('chosen', function() {
    var linker = function (scope, element, attrs) {
        var list = attrs['chosen'];

        scope.$watch(list, function () {
            element.trigger('chosen:updated');
        });

        scope.$watch(attrs['ngModel'], function() {
            element.trigger('chosen:updated');
        });

//        element.chosen({ width: '350px'});
    };

    return {
        restrict: 'A',
        link: linker
    };
});