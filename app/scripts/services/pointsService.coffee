do ->
  'use strict'

  class PointsService
    constructor: ($resource) ->
      @Point = $resource 'https://api.parse.com/1/classes/Point', {},
        query:
          method: 'GET'
          isArray: true
          headers:
            'X-Parse-Application-Id':'IKEiwnzgURrngabC1gxIZFF5O0jPfz0D1DzWjsHO'
            'X-Parse-REST-API-Key':'dCHVZQBmSm1FcYLI3KSHC4YwRSWoT5sh6I33wfD4'
          transformResponse: (data) ->
            data = JSON.parse data
            data.results
      @Point.property 'fullName',
        get: -> "#{@name} (#{@code})"

    all: -> @Point.query()
    get: (code) ->

  PointsService.$inject = ['$resource']

  angular.module('flightPlanApp').service('pointsService', PointsService)
