do ->
  'use strict'

  pointsSelectCtrl = ($scope, pointsService) ->
    $scope.selectOptions =
      query: (query) ->
        pointsService.query(query.term).$promise.then (results) ->
          delete results.$promise
          delete results.$resolved
          results.forEach (result) ->
            result.text = result.fullName
          console.log results
          query.callback
            results: results

    $scope.pointsList = pointsService.all()
    $scope.$watch 'pointsSelected', (point) ->
      console.log point
  
  pointsSelectCtrl.$inject = ['$scope', 'pointsService']

  angular.module('flightPlanApp').controller 'PointSelectionCtrl',
    pointsSelectCtrl