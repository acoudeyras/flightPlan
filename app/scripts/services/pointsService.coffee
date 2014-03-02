do ->
  'use strict'

  class Point
    constructor: (data) ->
      angular.copy data, @


  class PointsService
    constructor: ($resource) ->
      @_res = $resource 'https://api.parse.com/1/classes/Points', {},
        method: 'GET',
        headers:
          'X-Parse-Application-Id':'IKEiwnzgURrngabC1gxIZFF5O0jPfz0D1DzWjsHO'
          'X-Parse-REST-API-Key':'dCHVZQBmSm1FcYLI3KSHC4YwRSWoT5sh6I33wfD4'
    all: -> @_res.query()
    get: (code) ->

  PointsService.$inject = ['$resource']

  angular.module('flightPlanApp').service('pointsService', PointsService)
