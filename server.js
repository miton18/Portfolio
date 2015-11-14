(function() {
  var app, bodyParser, db, exec, express, messages, port, tingodb;

  express = require('express');

  bodyParser = require('body-parser');

  tingodb = require('tingodb')().Db;

  exec = require('child_process').exec;

  port = process.env.npm_package_config_port | 80;

  app = express();

  app.listen(port);

  db = new tingodb('./data', {
    nativeObjectID: true
  });

  messages = db.collection("messages");

  app.use(bodyParser.urlencoded({
    extended: true
  }));

  app.use(bodyParser.json());

  app.use('/', express["static"](__dirname + "/build"));

  app.post('/update', function(req, res) {
    var e, error1, rep, tag;
    if (req.body.ref) {
      tag = req.body.ref;
      rep = '';
      try {
        exec('git pull origin V3', function(error, stdout, stderr) {
          if (error) {
            rep += error;
          }
          if (stdout) {
            rep += stdout;
          }
          if (stderr) {
            rep += stderr;
          }
        });
      } catch (error1) {
        e = error1;
        rep += e;
      }
      res.send("Update to: " + tag + " " + rep);
    }
  });

  app.get('/messages', function(req, res) {});

  messages.insert([
    {
      mail: 'world_safe1',
      hello: 'world_safe2',
      time: Date.now()
    }
  ], function(err, result) {
    if (err != null) {
      return console.log(err);
    }
  });

  messages.find({}).toArray(function(err, items) {
    if (err != null) {
      return console.log(err);
    }
  });

  console.log("starting on " + port);

  process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
  });

}).call(this);
