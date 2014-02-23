'use strict'

fs = require 'fs'

pointsRetriever = require './points-retriever'
pointRetriever = require './point-retriever'
phantomEval = require './phantomjs-evaluator'

save = (outputPath, data, callback) ->
  data = JSON.stringify(data, null, '\t') if typeof data isnt 'string'
  fs.writeFile outputPath, data, callback

pointsRetriever.pointList ((err, points) ->
  save './data/points-list.json', points, (err) ->
    for point in points
      pointRetriever.getPoint point, (err, point) ->
        console.log err if err
        save "./data/point-#{point.code}.json", point, (err) ->
          console.log err if err

    phantomEval.exit()

)

