'use strict'

fs = require 'fs'

dataRetriever = require './points-retriever'

save = (outputPath, data, callback) ->
  data = JSON.stringify(data, null, '\t') if typeof data isnt 'string'
  fs.writeFile outputPath, data, callback

dataRetriever.pointList ((err, points) ->
  save './data/points-list.json', points, (err) ->
    console.log ('done')

)

