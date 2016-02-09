(function() {
  var _getAudio, _getImage, _startRoute, _trySubmission, app, bodyParser, compression, directmail, env, express, mail, port, sessions;

  express = require('express');

  bodyParser = require('body-parser');

  compression = require('compression');

  directmail = require('directmail');

  sessions = require('client-sessions');

  env = process.env;

  port = env.npm_package_config_port | 80;

  app = express();

  app.listen(port);

  mail = directmail({
    debug: true
  });

  console.log("starting on " + port);

  app.use(bodyParser.urlencoded({
    extended: true
  }));

  app.use(bodyParser.json());

  app.use(compression());

  app.use(sessions({
    cookieName: 'session',
    secret: 'DoNotTouchThis',
    duration: 24 * 60 * 60 * 1000,
    activeDuration: 1000 * 60 * 5
  }));

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

  app.post('/messages', function(req, res) {
    var content, email, ip, name, regEmail;
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
    mail.send({
      from: "portfolio@rcdinfo.fr",
      recipients: ["rcd18@hotmail.fr"],
      message: "Subject: contact\r\n\r\n" + email + " " + name + " " + ip + "\r\n " + content
    });
    return res.json({
      error: null
    });
  });

  _getAudio = function(req, res, next) {
    var visualCaptcha;
    if (req.params.type !== 'ogg') {
      req.params.type = 'mp3';
    }
    visualCaptcha = require('visualcaptcha')(req.session, req.query.namespace);
    return visualCaptcha.streamAudio(res, req.params.type);
  };

  _getImage = function(req, res, next) {
    var isRetina, visualCaptcha;
    isRetina = false;
    visualCaptcha = require('visualcaptcha')(req.session, req.query.namespace);
    if (req.query.retina) {
      isRetina = true;
    }
    return visualCaptcha.streamImage(req.params.index, res, isRetina);
  };

  _startRoute = function(req, res, next) {
    var visualCaptcha;
    visualCaptcha = require('visualcaptcha')(req.session, req.query.namespace);
    visualCaptcha.generate(req.params.howmany);
    return res.status(200).send(visualCaptcha.getFrontendData());
  };

  _trySubmission = function(req, res, next) {
    var audioAnswer, frontendData, imageAnswer, namespace, responseObject, responseStatus, visualCaptcha;
    namespace = req.query.namespace;
    visualCaptcha = require('visualcaptcha')(req.session, req.query.namespace);
    frontendData = visualCaptcha.getFrontendData();
    if (!(namespace || namespace.length === 0)) {
      queryParams.push('namespace=' + namespace);
    }
    if (typeof frontendData === 'undefined') {
      queryParams.push('status=noCaptcha');
      responseStatus = 404;
      responseObject = 'Not Found';
    } else {
      if (imageAnswer = req.body[frontendData.imageFieldName]) {
        if (visualCaptcha.validateImage(imageAnswer)) {
          queryParams.push('status=validImage');
          responseStatus = 200;
        } else {
          queryParams.push('status=failedImage');
          responseStatus = 403;
        }
      } else if (audioAnswer = req.body[frontendData.audioFieldName]) {
        if (visualCaptcha.validateAudio(audioAnswer.toLowerCase())) {
          queryParams.push('status=validAudio');
          responseStatus = 200;
        } else {
          queryParams.push('status=failedAudio');
          responseStatus = 403;
        }
      } else {
        queryParams.push('status=failedPost');
        responseStatus = 500;
      }
    }
    if (req.accepts('html') !== void 0) {
      return res.redirect('/?' + queryParams.join('&'));
    } else {
      return res.status(responseStatus);
    }
  };

  app.post('/try', _trySubmission);

  app.get('/audio', _getAudio);

  app.get('/audio/:type', _getAudio);

  app.get('/image/:index', _getImage);

  app.get('/start/:howmany', _startRoute);

  process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
  });

}).call(this);
