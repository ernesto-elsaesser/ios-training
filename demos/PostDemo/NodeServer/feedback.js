var express = require('express');

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

app.post('/feedback', function (req, res) {
  console.log('Received feedback: ' + req.rawBody + '\n\r')
  res.status(201).send('Feedback accepted!');
});

app.listen(80, function () {
  console.log('Feedback server listening on port 80!');
});
