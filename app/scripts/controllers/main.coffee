(->
  'use strict'

  angular.module('flightPlanApp').controller('MainCtrl', ($scope) ->

    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

    $scope.hello = 'world'

  )
)()