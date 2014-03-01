'use strict'

fs = require 'fs'

pointsRetriever = require './points-retriever'
pointRetriever = require './point-retriever'
phantomEval = require './phantomjs-evaluator'
helpers = require './helpers'

save = (outputPath, data, callback) ->
  data = JSON.stringify(data, null, '\t') if typeof data isnt 'string'
  fs.writeFile outputPath, data, callback

pointListFromLocal = (callback) ->
  fs.readFile './data/points-list.json', (err, data) ->
    return callback err if err
    callback null, JSON.parse(data)


readPoints = (points, current, next) ->
  return next() if current is points.length
  point = points[current]
  pointFilePath = "./data/point-#{point.code}.json"

  fs.exists pointFilePath, (exist) ->
    return readPoints points, ++current, next if exist
    console.log pointFilePath
    pointRetriever.getPoint point, (err, pointDetail) ->
      if err
        console.log err
        return readPoints points, ++current, next

      helpers.extend point, pointDetail
      save pointFilePath, point, (err) ->
        console.log err if err
      readPoints points, ++current, next

pointListFromLocal (err, points) ->
  return console.log err if err
  save './data/points-list.json', points, (err) ->
    return console.log err if err
    readPoints points, 0, ->
      phantomEval.exit()