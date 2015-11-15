express     = require('express')
bodyParser  = require('body-parser')
tingodb     = require('tingodb')().Db
exec        = require('child_process').exec

port        = process.env.npm_package_config_port | 80
app         = express()
app.listen port

db          = new tingodb './data',
                nativeObjectID: true
messages    = db.collection "messages"

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
###app.get '/messages', (req, res)->

    return


messages.insert [{mail:'world_safe1', hello:'world_safe2', time: Date.now()}]
    ,
        (err, result)->
            console.log err if err?
            #console.log result


messages.find({}).toArray ( err, items )=>
    console.log err if err?
    console.log items
###

###messages.remove {}, (err, result)-> # remove all
    console.log err if err?
    console.log result if result?
###
console.log "starting on #{ port }"
process.on 'uncaughtException', (err) ->

  console.log 'Caught exception: ' + err
  return
