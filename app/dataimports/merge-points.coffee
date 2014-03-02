'use strict'

fs = require 'fs'

pointsRetriever = require './points-repo-local'
pointRetriever = require './point-repo-local'
helpers = require './helpers'

readPoints = (points, current, next) ->
  return next() if current is points.length
  point = points[current]

  pointRetriever.getPoint point, (err, pointDetail) ->
    if err
      console.log err
      return readPoints points, ++current, next

    helpers.extend point, pointDetail
    readPoints points, ++current, next

save = (points, callback) ->
  data = JSON.stringify(points, null, '\t') if typeof points isnt 'string'
  fs.writeFile './data/points-merged.json', data, callback

pointsRetriever.pointList (err, points) ->
  return console.log err if err
  readPoints points, 0, ->
    return console.log err if err
    save points, ->
      return console.log err if err
      console.log 'success'