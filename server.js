(function() {
  var app, auth, bodyParser, compression, db, env, express, logModel, messageModel, mongoose, port;

  express = require('express');

  bodyParser = require('body-parser');

  auth = require('basic-auth');

  compression = require('compression');

  mongoose = require('mongoose');

  env = process.env;

  port = env.npm_package_config_port | 80;

  app = express();

  messageModel = require('./message');

  logModel = require('./log');

  app.listen(port);

  console.log("starting on " + port);

  db = mongoose.connect('mongodb://u80kgqmkrdvdt4g:GlMiU5fqL16rJZJg4ydo@b4rrhixa0ttqdr0-mongodb.services.clever-cloud.com:27017/b4rrhixa0ttqdr0', function(err) {
    if (err != null) {
      return console.log(err);
    } else {
      return console.log('db connected');
    }
  });

  app.use(bodyParser.urlencoded({
    extended: true
  }));

  app.use(bodyParser.json());

  app.use(compression());

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

  app.get('/messages', function(req, res) {
    return messageModel.find(null, function(err, messages) {
      if (err != null) {
        console.log(err);
      }
      return res.json(messages);
    });
  });

  app.post('/messages', function(req, res) {
    var content, email, ip, message, name, regEmail;
    if (req.body.email != null) {
      email = req.body.email;
    }
    if (req.body.content != null) {
      content = req.body.content;
    }
    if (req.body.name != null) {
      name = req.body.name;
    }
    ip = req.headers["X-Forwarded-For"] || req.headers["x-forwarded-for"] || req.client.remoteAddress;
    if (!((email != null) && (content != null) && (name != null))) {
      res.json({
        error: 'bad form input'
      });
      return;
    }
    regEmail = /^[0-9a-z._-]+@{1}[0-9a-z.-]{2,}[.]{1}[a-z]{2,5}$/i;
    if (!regEmail.test(email)) {
      res.json({
        error: 'Bad email format'
      });
      return;
    }
    if (messageModel == null) {
      res.json({
        error: 'Database not ready'
      });
      return;
    }
    message = new messageModel({
      email: email,
      content: content,
      ip: ip,
      date: new Date()
    });
    return message.save(function(err) {
      if (err != null) {
        return res.json({
          error: 'Problem'
        });
      } else {
        return res.json({
          error: null
        });
      }
    });
  });


  /*app.delete '/messages', (req, res)->
      
      messageModel.remove null, (err)->
          res.json error: 'not deleted' if err?
          res.json error: null
   */

  process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
  });

}).call(this);
