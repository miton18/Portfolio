(function() {
  var app, auth, authCheck, bodyParser, db, exec, express, messages, port, tingodb;

  express = require('express');

  bodyParser = require('body-parser');

  auth = require('basic-auth');

  tingodb = require('tingodb')().Db;

  exec = require('child_process').exec;

  port = process.env.npm_package_config_port | 80;

  app = express();

  app.listen(port);

  console.log("starting on " + port);

  db = new tingodb('./data', {
    nativeObjectID: true
  });

  messages = db.collection("messages");

  authCheck = function(req, res, next) {
    var unauthorized, user;
    unauthorized = function(res) {
      res.set('WWW-Authenticate', 'Basic realm=Authentification requise');
      return res.sendStatus(401);
    };
    user = auth(req);
    if (!(user && user.name && user.pass)) {
      unauthorized(res);
    }
    if (user.name === 'miton' && user.pass === 'notim') {
      return next();
    } else {
      return unauthorized(res);
    }
  };

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

  app.get('/messages', authCheck, function(req, res) {
    return messages.find({}).toArray(function(err, items) {
      if (!err) {
        res.json(items);
      }
      return res.json(err);
    });
  });

  app.post('/messages', function(req, res) {
    var content, email, name, regEmail;
    if (req.body.email != null) {
      email = req.body.email;
    }
    if (req.body.content != null) {
      content = req.body.content;
    }
    if (req.body.name != null) {
      name = req.body.name;
    }
    if (!((email != null) && (content != null) && (name != null))) {
      res.json({
        error: 'bad request'
      });
      return;
    }
    regEmail = /^[0-9a-z._-]+@{1}[0-9a-z.-]{2,}[.]{1}[a-z]{2,5}$/i;
    if (!regEmail.test(email)) {
      res.json({
        error: 'bad email'
      });
      return;
    }
    return messages.insert({
      email: email,
      content: content,
      time: Date.now()
    }, function(err, result) {
      if (err != null) {
        return res.json({
          error: err
        });
      } else {
        return res.json({
          id: result[0]._id
        });
      }
    });
  });

  app["delete"]('/messages', function(req, res) {
    return messages.remove({}, function(err, result) {
      if (err != null) {
        return res.json({
          error: err
        });
      } else {
        return res.json(result);
      }
    });
  });

  process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
  });

}).call(this);
