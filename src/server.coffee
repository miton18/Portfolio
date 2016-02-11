express       = require 'express'
bodyParser    = require 'body-parser'
compression   = require 'compression'
directmail    = require 'directmail'
#sessions      = require 'client-sessions'
#sweetcaptcha  = require 'sweetcaptcha'

env = process.env

port        = env.npm_package_config_port | 80
app         = express()
app.listen  port

#capt = new sweetcaptcha(env.SC_ID, env.SC_KEY, env.SC_SECRET)

mail = directmail
  debug: true

console.log "starting on #{ port }"

#---------------------------------------------------------------
#               middlewares
#---------------------------------------------------------------
app.use bodyParser.urlencoded
    extended: true

app.use bodyParser.json()

app.use compression()

###app.use sessions(
    cookieName: 'session',
    secret: 'DoNotTouchThis',
    duration: 24 * 60 * 60 * 1000,
    activeDuration: 1000 * 60 * 5
)###

#---------------------------------------------------------------
#               static troutes
#---------------------------------------------------------------

app.use '/', express.static( "#{__dirname}/build" )

#---------------------------------------------------------------
#               dynamic routes
#---------------------------------------------------------------

#
# Mise a jour automatique du site 
#
app.post '/update', (req, res) ->

  if req.body.ref
    tag = req.body.ref
    rep = ''

    try
      exec 'git pull origin V3', (error, stdout, stderr) ->
        if error
          rep += error
        if stdout
          rep += stdout
        if stderr
          rep += stderr
        return
    catch e
      rep += e
    res.send "Update to: #{tag} #{rep}"
  return

app.post '/messages', (req, res)->

    email   = req.body.email    if req.body.email?
    content = req.body.content  if req.body.content?
    name    = req.body.name     if req.body.name?
    ip      = req.headers["X-Forwarded-For"] || req.headers["x-forwarded-for"] || req.client.remoteAddress

    unless email? and content? and name?
        res.json error: 'bad form input'
        return

    regEmail = /^[0-9a-z._-]+@{1}[0-9a-z.-]{2,}[.]{1}[a-z]{2,5}$/i

    unless regEmail.test( email )
        res.json error: 'Bad email format'
        return

    mail.send
        from: "portfolio@rcdinfo.fr"
        recipients: ["rcd18@hotmail.fr"]
        message: "Subject: contact\r\n\r\n" + email + " " + name + " " + ip + "\r\n " + content

    res.json error: null

###app.get '/captcha', (req, res)->
    capt.api 'get_html', (err, html)->
    res.json err: err if err?
    res.html html
###
process.on 'uncaughtException', (err) ->

  console.log 'Caught exception: ' + err
  return
