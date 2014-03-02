do ->
  'use strict'

  logCtrl = ($scope, pointsService) ->
    console.log pointsService.all()
    $scope.airports = ['lfpz', 'lfyr', 'lyjh']
    $scope.steps = [
      { airport: 'lfpz', comment: '' }
      { airport: 'lfyr', comment: 'stop here' }
    ]
    $scope.$watch 'airport', (airport) ->
      console.log airport
  
  logCtrl.$inject = ['$scope', 'pointsService']


  angular.module('flightPlanApp').controller 'LogCtrl', logCtrl