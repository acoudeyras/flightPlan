'use strict'

phantomEval = require './phantomjs-evaluator'

airportsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=0&CountryCode=LF&Departement=%&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC'
vorsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=5&CountryCode=LF&Departement=NA&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC'

extractRowsFromPage = ->
  readUrl = (columnNode) ->
    link = column.children[0].children[0]
    href = link.outerHTML.split('onclick="window.open(')[1]
    href = href.substring 1, href.length
    href.split("',")[0]

  fields = ['country', 'code', 'category', 'info', 'altitude', 'latitude', 'longitude']

  result = []
  dataTable = document.querySelectorAll('table')[1]
  rows = dataTable.children[0].children

  skip = 2
  currentRow = -1
  for row in rows
    currentRow++
    continue if currentRow < skip

    currentColumn = 0
    rowJson = {}
    for column in row.children
      field = fields[currentColumn]
      rowJson[field] = column.innerText
      if field is 'code'
        rowJson.url = readUrl column
      currentColumn++

    result.push rowJson

  return result

findRows = (url, callback) ->
  phantomEval.loadPage(
    url,
    extractRowsFromPage,
    callback
  )

exports.pointList = (callback) ->
  findRows(airportsUrl, (err, airports) ->
    return callback(err) if err

    findRows(vorsUrl, (err, vors) ->
      return callback(err) if err
      
      callback null, vors.concat airports
    )
  )





