do ->
  'use strict'

  parseHelpers =
    eq: (field, val) ->
      """{"#{field}":#{val}}"""
    like: (field, val) ->
      @eq field, """{"$regex":"#{val}"}"""
    beginWith: (field, val) ->
      @eq field, """{"$regex":"^#{val}"}"""
    ftsearch: (field, val) ->
      val = val.trim().toLowerCase()
      beginVal = """{"$regex":"^#{val}"}"""
      #beginVal = '"' + val + '"'
      beginVal = '"' + val + '"'
      @eq field, """{"$all":[#{beginVal}]}"""

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
    query: (term) ->
      return @Point.query() if term.trim() is ''
      whereClause = parseHelpers.ftsearch 'words', term
      alert whereClause
      @Point.query where: whereClause
    get: (code) ->

  PointsService.$inject = ['$resource']

  angular.module('flightPlanApp').service('pointsService', PointsService)
