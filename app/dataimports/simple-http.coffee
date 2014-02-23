'use strict'

http = require 'http'

exports.request = (options, callback) ->
  
  returnError = (err) ->
    callback err

  req = http.request options, (res) ->
    return returnError(res) if (res.statusCode != 200)
    res.setEncoding 'utf8'
    html = ''
    res.on('data', (chunk) ->
      html += chunk
    )
    res.on('end', ->
      callback null, html
    )

  req.on 'error', returnError
  req.end()  