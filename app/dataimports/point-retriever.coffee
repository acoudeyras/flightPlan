'use strict'

phantomEval = require './phantomjs-evaluator'


extract = ->

  readColumns = (columns, rowObj) ->
    return if columns.length < 2
    [name, value] = columns
    rowJson[name.innerText] = value.innerText

  readRows = (table, skip) ->
    result = {}
    rows = table.children[0].children

    skip = skip || 0
    currentRow = -1
    for row in rows
      currentRow++
      continue if currentRow < skip
      readColumns row.children, result

    result

  table = document.querySelectorAll('table')[0]
  readRows table, 2


extractVorData = ->
  extract()

extractAirportData = ->
  return 'ok'


exports.getPoint = (point, callback) ->
  getData = (extractor) ->
    phantomEval.loadPage(
      point.url,
      extract,
      callback
    )

  if point.category in ['CAT']
    getData extractVorData
  else if point.category in ['VOR', 'VOR/DME', 'VORTAC']
    getData extractAirportData
  else
    throw "Category #{point.category} not yet supported"  