'use strict'

phantomEval = require './phantomjs-evaluator'

airportCategories = ['CAP', 'CAP/Mil']
vorsCategories = ['VOR', 'VOR/DME', 'VORTAC']
allCategories = airportCategories.concat vorsCategories

extract =  ->

  airportCategories = ['CAP', 'CAP/Mil']
  vorsCategories = ['VOR', 'VOR/DME', 'VORTAC']

  aiportMapping = 
    'Déclinaison': 'declination'
    'Altitude': 'altitude'
    'CONTACTS Téléphoniques': 'phoneContacts'
    'Code Immat. des appareils': 'codeImmat'
    'Code Pays': 'countryCode'
    'Date carte VAC': 'vacMapCreated'
    'Département': 'departement'
    'Frequence App.': 'approachFrequency'
    'Fréquence principale': 'mainFrequency'
    'Informations Contact CARBURANT': 'fuelInfos'
    'Informations PISTES': 'runwayInfos'
    'Localisation radionav.': 'radionavLocalization'
    'Latitude': 'lat'
    'Longitude': 'long'
    'Nom': 'name'
    'Type': 'typeLng'


  vorMapping =
    'Date MàJ': 'updated'
    'Déclinaison': 'declination'
    'Fréquence principale': 'frequency'
    'Latitude': 'lat'
    'Longitude': 'long'
    'Nom': 'name'
    'Type': 'typeLng'

  typeReader = (columns, rowObj) ->
    return if columns.length < 2
    [name, value] = columns
    colName = name.innerText.trim()
    if colName is 'Catégorie'
      rowObj.type = value.innerText.trim()

  colsReader = (mapping) ->
    (columns, rowObj) ->
      return if columns.length < 2
      [name, value] = columns
      name = name.innerText.trim()
      value = value.innerText.trim()
      colName = mapping[name]

      if not colName
        rowObj['_' + name] = value
      else
        rowObj[colName] = value

  findType = (table) ->
    found = readRows table, 2, typeReader
    found.type

  findReader = (table) ->
    type = findType table
    if vorsCategories.indexOf(type) != -1
      colsReader vorMapping
    else if airportCategories.indexOf(type) != -1
      colsReader aiportMapping
    else null

  readRows = (table, skip, columnsReader) ->
    result = {}
    rows = table.children[0].children
    skip = skip || 0
    currentRow = -1
    for row in rows
      currentRow++
      continue if currentRow < skip
      columnsReader row.children, result
    result

  table = document.querySelectorAll('table')[0]
  reader = findReader table
  return null if not reader
  readRows table, 2, reader


exports.getPoint = (point, callback) ->
  
  if point.category not in allCategories
    return callback("Category #{point.category} not yet supported", null)

  phantomEval.loadPage(
    point.url,
    extract,
    callback
  )
