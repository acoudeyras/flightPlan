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
      .when('/log',
        templateUrl: 'views/log.html'
        controller: 'LogCtrl'
      )
      .otherwise(
        redirectTo: '/'
      )
  )
