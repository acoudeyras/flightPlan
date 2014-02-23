'use strict'

jsdom = require 'jsdom'

getTable = (html, selector) ->
  selector = selector || '<table'
  parts = html.split selector
  throw 'Multiples result for the selector' if parts.length > 2
  parts[1]

getRows = (htmlTable) -> htmlTable.split '</tr'

isEnd = (htmlRow) -> htmlRow.indexOf('</table') != -1

cleanFields = (fields) ->
  asItCome = (data) -> data

  result = []
  for field in fields
    [name, rest...] = Object.keys(field)
    throw 'Invalid field definition' if rest.length > 0
    transformFn = field[name]
    if typeof transformFn isnt 'function'
      transformFn = asItCome
    result.push
      name: name
      fn: transformFn
  result

transformRow = (htmlRow, fields) ->
  row = {}
  current = 0

  for column in htmlRow.split('<td')
    field = fields[current]
    break if not field
    console.log current, column if not field
    row[field.name] = field.fn column
    current++
  row

exports.transform = (html, options) ->
  jsdom.


  return
  skip = options.skip || 0
  fields = cleanFields options.fields

  results = []
  htmlTable = getTable html, options.selector
  current = -1
  for htmlRow in getRows(htmlTable)
    current++
    continue if current < skip
    break if isEnd htmlRow
    jsonRow = transformRow htmlRow, fields
    console.log(jsonRow)
    break
    results.push jsonRow
  results
