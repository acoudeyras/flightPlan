deb = null

do ->
  'use strict'

  logCtrl = ($scope, pointsService) ->
    deb = $scope.airports = pointsService.all()
    $scope.steps = [
      { airport: 'lfpz', comment: '' }
      { airport: 'lfyr', comment: 'stop here' }
    ]
    $scope.$watch 'airport', (airport) ->
      console.log airport
  
  logCtrl.$inject = ['$scope', 'pointsService']


  angular.module('flightPlanApp').controller 'LogCtrl', logCtrl