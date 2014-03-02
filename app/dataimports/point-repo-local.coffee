'use strict'

fs = require 'fs'

exports.getPoint = (point, callback) ->
  fs.readFile "./data/point-#{point.code}.json", (err, data) ->
    return callback err if err
    callback null, JSON.parse(data)