(->
  'use strict'

  angular.module('flightPlanApp').directive('logstep', ->
    restrict: 'E'
    scope:
      airports: '='
      airport: '='
      comment: '='
    templateUrl: 'scripts/directives/logstep.html'
    controller: ($scope, $attrs) ->
      $scope.$watch '[comment, editing]', ->
        $scope.showCommentLabel = $scope.comment != '' || $scope.editing
      , true
      $scope.editing = false
      $scope.toggleEdit = -> $scope.editing = !$scope.editing

  )
)()