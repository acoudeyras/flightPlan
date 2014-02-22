'use strict'

angular.module('flightPlanApp', []).directive('logstep', ->
  alert 'ok'
  restrict: 'E'
  scope: {}
  templateUrl: '/Scripts/app/partials/CategoryComponent.html'
  controller: ($scope, $attrs) ->
    alert('ok')
    $scope.airports = ['world', 'a']

    $scope.$watch 'airport', (airport) ->
      console.log airport

    $scope.comment = ''
    $scope.editing = true
    $scope.toggleEdit = -> $scope.editing = !$scope.editing

)