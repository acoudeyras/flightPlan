// Generated by CoffeeScript 1.6.2
'use strict';
var cleanFields, getRows, getTable, isEnd, jsdom, transformRow,
  __slice = [].slice;

jsdom = require('jsdom');

getTable = function(html, selector) {
  var parts;

  selector = selector || '<table';
  parts = html.split(selector);
  if (parts.length > 2) {
    throw 'Multiples result for the selector';
  }
  return parts[1];
};

getRows = function(htmlTable) {
  return htmlTable.split('</tr');
};

isEnd = function(htmlRow) {
  return htmlRow.indexOf('</table') !== -1;
};

cleanFields = function(fields) {
  var asItCome, field, name, rest, result, transformFn, _i, _len, _ref;

  asItCome = function(data) {
    return data;
  };
  result = [];
  for (_i = 0, _len = fields.length; _i < _len; _i++) {
    field = fields[_i];
    _ref = Object.keys(field), name = _ref[0], rest = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
    if (rest.length > 0) {
      throw 'Invalid field definition';
    }
    transformFn = field[name];
    if (typeof transformFn !== 'function') {
      transformFn = asItCome;
    }
    result.push({
      name: name,
      fn: transformFn
    });
  }
  return result;
};

transformRow = function(htmlRow, fields) {
  var column, current, field, row, _i, _len, _ref;

  row = {};
  current = 0;
  _ref = htmlRow.split('<td');
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    column = _ref[_i];
    field = fields[current];
    if (!field) {
      break;
    }
    if (!field) {
      console.log(current, column);
    }
    row[field.name] = field.fn(column);
    current++;
  }
  return row;
};

exports.transform = function(html, options) {
  var current, fields, htmlRow, htmlTable, jsonRow, results, skip, _i, _len, _ref;

  jsdom["return"];
  skip = options.skip || 0;
  fields = cleanFields(options.fields);
  results = [];
  htmlTable = getTable(html, options.selector);
  current = -1;
  _ref = getRows(htmlTable);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    htmlRow = _ref[_i];
    current++;
    if (current < skip) {
      continue;
    }
    if (isEnd(htmlRow)) {
      break;
    }
    jsonRow = transformRow(htmlRow, fields);
    console.log(jsonRow);
    break;
    results.push(jsonRow);
  }
  return results;
};
