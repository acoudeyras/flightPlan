do ->
  'use strict'

  class LogCtrl

    @$inject: ['$scope', 'airportsService']

    constructor: (@scope, @airportsService) ->
      @scope.airports = ['lfpz', 'lfyr', 'lyjh']
      @scope.steps = [
        { airport: 'lfpz', comment: '' }
        { airport: 'lfyr', comment: 'stop here' }
      ]
      @scope.$watch 'airport', (airport) ->
        console.log airport


  angular.module('flightPlanApp').controller 'LogCtrl', LogCtrl