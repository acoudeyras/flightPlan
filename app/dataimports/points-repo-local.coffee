'use strict'

fs = require 'fs'

exports.pointList = (callback) ->
  fs.readFile './data/points-list.json', (err, data) ->
    return callback err if err
    callback null, JSON.parse(data)