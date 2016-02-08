express     = require 'express'
bodyParser  = require 'body-parser'
auth        = require 'basic-auth'
compression = require 'compression'
mongoose    = require 'mongoose'

env = process.env

port        = env.npm_package_config_port | 80
app         = express()

messageModel = require './message'
logModel     = require './log'

app.listen  port
console.log "starting on #{ port }"


db = mongoose.connect 'mongodb://u80kgqmkrdvdt4g:GlMiU5fqL16rJZJg4ydo@b4rrhixa0ttqdr0-mongodb.services.clever-cloud.com:27017/b4rrhixa0ttqdr0', (err)->
    if err? then console.log err
    else
        console.log 'db connected'

#---------------------------------------------------------------
#               middlewares
#---------------------------------------------------------------
app.use bodyParser.urlencoded
    extended: true

app.use bodyParser.json()

app.use compression()

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

app.get '/messages', (req, res)->

    messageModel.find null, (err, messages)->
        console.log err if err?
        res.json messages

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
    unless messageModel?
        res.json error: 'Database not ready'
        return
    
    message = new messageModel
        email:      email
        content:    content
        ip:         ip
        date:       new Date()
        
    message.save (err)->
        if err?
            res.json error: 'Problem'
        else
            res.json error: null
                  
###app.delete '/messages', (req, res)->
    
    messageModel.remove null, (err)->
        res.json error: 'not deleted' if err?
        res.json error: null
###

process.on 'uncaughtException', (err) ->

  console.log 'Caught exception: ' + err
  return
