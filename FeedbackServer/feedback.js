var express = require('express');
var fs = require('fs');

var app = express();

// raw POST data
app.use(function(req, res, next) {
  req.rawBody = '';
  req.setEncoding('utf8');

  req.on('data', function(chunk) { 
    req.rawBody += chunk;
  });

  req.on('end', function() {
    next();
  });
});

app.get('/feedback', function (req, res) {
  res.status(405).send('This endpoint only supports POST requests!');
});

app.post('/feedback', function (req, res) {

  fs.appendFile('feedback.txt', req.rawBody + '\n\r', function (err) {
    if (err) {
      res.status(500).send('Operation failed: ' + err);
    } else {
      res.status(201).send('Feedback accepted!');
    }
  });

});

app.listen(80, function () {
  console.log('Feedback server listening on port 80!');
});