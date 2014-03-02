// Generated by CoffeeScript 1.7.1
'use strict';
var isStopWord, stopWords, toLowerCase, _,
  __slice = [].slice;

_ = require('underscore');

toLowerCase = function(word) {
  return word.toLowerCase();
};

stopWords = ['the', 'in', 'and'];

isStopWord = function(word) {
  return word.match(/^\w+$/) && !_.contains(stopWords, word);
};

exports.parseWords = function() {
  var field, fields, found, obj, val, words, _i, _len;
  obj = arguments[0], fields = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
  words = [];
  for (_i = 0, _len = fields.length; _i < _len; _i++) {
    field = fields[_i];
    val = obj.get(field);
    if (val == null) {
      continue;
    }
    found = val.split(/\b/);
    words = words.concat(found);
  }
  return words.map(toLowerCase).filter(isStopWord);
};