'use strict'

angular.module('flightPlanApp').controller('LogCtrl', ($scope) ->

  $scope.airports = ['world', 'a']

  $scope.$watch 'airport', (airport) ->
    console.log airport


  $scope.comment = ''
  $scope.editing = true
  $scope.toggleEdit = -> $scope.editing = !$scope.editing
)