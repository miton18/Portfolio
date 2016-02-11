(function() {
  var app, bodyParser, compression, directmail, env, express, mail, port;

  express = require('express');

  bodyParser = require('body-parser');

  compression = require('compression');

  directmail = require('directmail');

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


  /*app.use sessions(
      cookieName: 'session',
      secret: 'DoNotTouchThis',
      duration: 24 * 60 * 60 * 1000,
      activeDuration: 1000 * 60 * 5
  )
   */

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


  /*app.get '/captcha', (req, res)->
      capt.api 'get_html', (err, html)->
      res.json err: err if err?
      res.html html
   */

  process.on('uncaughtException', function(err) {
    console.log('Caught exception: ' + err);
  });

}).call(this);
