// Generated by CoffeeScript 1.6.2
var deb;

deb = null;

(function() {
  'use strict';
  var logCtrl;

  logCtrl = function($scope, pointsService) {
    deb = $scope.airports = pointsService.all();
    $scope.steps = [
      {
        airport: 'lfpz',
        comment: ''
      }, {
        airport: 'lfyr',
        comment: 'stop here'
      }
    ];
    return $scope.$watch('airport', function(airport) {
      return console.log(airport);
    });
  };
  logCtrl.$inject = ['$scope', 'pointsService'];
  return angular.module('flightPlanApp').controller('LogCtrl', logCtrl);
})();
