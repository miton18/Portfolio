express     = require 'express'
bodyParser  = require 'body-parser'
auth        = require 'basic-auth'
tingodb     = require('tingodb')().Db
exec        = require('child_process').exec

port        = process.env.npm_package_config_port | 80
app         = express()

app.listen  port
console.log "starting on #{ port }"

db          = new tingodb './data',
                nativeObjectID: true
messages    = db.collection "messages"

#---------------------------------------------------------------
#               Authentification function
#---------------------------------------------------------------

authCheck = (req, res, next)->

    unauthorized = (res)->
        res.set 'WWW-Authenticate', 'Basic realm=Authentification requise'
        res.sendStatus 401

    user = auth req

    unless user and user.name and user.pass
        unauthorized res

    if user.name == 'miton' && user.pass == 'notim'
        next()
    else
        unauthorized res


#---------------------------------------------------------------
#               middlewares
#---------------------------------------------------------------
app.use bodyParser.urlencoded
    extended: true

app.use bodyParser.json()

#---------------------------------------------------------------
#               static troutes
#---------------------------------------------------------------

app.use '/', express.static( "#{__dirname}/build" )

#---------------------------------------------------------------
#               dynamic routes
#---------------------------------------------------------------

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

app.get '/messages', authCheck, (req, res)->

    messages.find({}).toArray (err, items)->

        unless err
            res.json items
        res.json err

app.post '/messages', (req, res)->

    email   = req.body.email    if req.body.email?
    content = req.body.content  if req.body.content?
    name    = req.body.name     if req.body.name?

    unless email? and content? and name?
        res.json error: 'bad request'
        return

    regEmail = /^[0-9a-z._-]+@{1}[0-9a-z.-]{2,}[.]{1}[a-z]{2,5}$/i

    unless regEmail.test( email )
        res.json error: 'bad email'
        return

    messages.insert
        email:      email
        content:    content
        time:       Date.now()
    ,
        (err, result)->
            if err?
                res.json error: err
            else
                res.json id: (result[0])._id

app.delete '/messages', (req, res)->

    messages.remove {}, (err, result)-> # remove all
        if err?
            res.json error: err
        else
            res.json result

process.on 'uncaughtException', (err) ->

  console.log 'Caught exception: ' + err
  return
