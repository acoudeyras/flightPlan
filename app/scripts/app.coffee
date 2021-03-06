do ->
  'use strict'

  angular.module('flightPlanApp', [
    'ngCookies'
    'ngResource'
    'ngSanitize'
    'ngRoute'
    'ui.select2'
    'btford.markdown'
  ])
    .config( ($routeProvider) ->
      $routeProvider
        .when('/',
          templateUrl: 'views/main.html'
          controller: 'MainCtrl'
        )
        .when('/points-selection',
          templateUrl: 'views/points-selection.html'
          controller: 'PointSelectionCtrl'
        )
        .otherwise(
          redirectTo: '/'
        )
    )
