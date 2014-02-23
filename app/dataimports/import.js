// Generated by CoffeeScript 1.6.2
'use strict';
var fs, phantomEval, pointRetriever, pointsRetriever, save;

fs = require('fs');

pointsRetriever = require('./points-retriever');

pointRetriever = require('./point-retriever');

phantomEval = require('./phantomjs-evaluator');

save = function(outputPath, data, callback) {
  if (typeof data !== 'string') {
    data = JSON.stringify(data, null, '\t');
  }
  return fs.writeFile(outputPath, data, callback);
};

pointsRetriever.pointList((function(err, points) {
  return save('./data/points-list.json', points, function(err) {
    var point, _i, _len;

    for (_i = 0, _len = points.length; _i < _len; _i++) {
      point = points[_i];
      pointRetriever.getPoint(point, function(err, point) {
        if (err) {
          console.log(err);
        }
        return save("./data/point-" + point.code + ".json", point, function(err) {
          if (err) {
            return console.log(err);
          }
        });
      });
    }
    return phantomEval.exit();
  });
}));
