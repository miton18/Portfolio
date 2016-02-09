express     = require 'express'
bodyParser  = require 'body-parser'
compression = require 'compression'
directmail  = require 'directmail'
sessions    = require 'client-sessions'

env = process.env

port        = env.npm_package_config_port | 80
app         = express()
app.listen  port

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

app.use sessions(
    cookieName: 'session',
    secret: 'DoNotTouchThis',
    duration: 24 * 60 * 60 * 1000,
    activeDuration: 1000 * 60 * 5
)

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


#---------------------------------------------------------------
#               Capcha Routes
#---------------------------------------------------------------

# Fetches and streams an audio file
_getAudio = ( req, res, next )->

    # Default file type is mp3, but we need to support ogg as well
    unless req.params.type == 'ogg'
        req.params.type = 'mp3'

    # Initialize visualCaptcha
    visualCaptcha = require( 'visualcaptcha' )( req.session, req.query.namespace )

    visualCaptcha.streamAudio res, req.params.type

# Fetches and streams an image file
_getImage = ( req, res, next )->
    isRetina = false

    # Initialize visualCaptcha
    visualCaptcha = require( 'visualcaptcha' )( req.session, req.query.namespace )

    # Default is non-retina
    if req.query.retina
        isRetina = true

    visualCaptcha.streamImage req.params.index, res, isRetina

# Start and refresh captcha options
_startRoute = ( req, res, next )->

    # Initialize visualCaptcha
    visualCaptcha = require( 'visualcaptcha' )( req.session, req.query.namespace )

    visualCaptcha.generate req.params.howmany

    # We have to send the frontend data to use on POST.
    res.status( 200 ).send( visualCaptcha.getFrontendData() )

_trySubmission = ( req, res, next )->

    namespace = req.query.namespace

    # Initialize visualCaptcha
    visualCaptcha = require( 'visualcaptcha' )( req.session, req.query.namespace )

    frontendData = visualCaptcha.getFrontendData()

    # Add namespace to query params, if present
    unless namespace || namespace.length == 0
      queryParams.push 'namespace=' + namespace

    # It's not impossible this method is called before visualCaptcha is initialized, so we have to send a 404
    if typeof frontendData == 'undefined'
        queryParams.push 'status=noCaptcha'

        responseStatus = 404
        responseObject = 'Not Found'
    else
    # If an image field name was submitted, try to validate it
        if imageAnswer = req.body[ frontendData.imageFieldName ]
            if visualCaptcha.validateImage( imageAnswer )
                queryParams.push 'status=validImage'

                responseStatus = 200
            else
                queryParams.push 'status=failedImage'

                responseStatus = 403

        else if audioAnswer = req.body[ frontendData.audioFieldName ]
        # We set lowercase to allow case-insensitivity, but it's actually optional
            if visualCaptcha.validateAudio( audioAnswer.toLowerCase() )
                queryParams.push 'status=validAudio'

                responseStatus = 200
            else
                queryParams.push 'status=failedAudio'

                responseStatus = 403
        else
            queryParams.push 'status=failedPost'

            responseStatus = 500

    unless req.accepts( 'html' ) == undefined
        res.redirect '/?' + queryParams.join( '&' )
    else
        res.status responseStatus

app.post '/try', _trySubmission
app.get  '/audio', _getAudio
app.get  '/audio/:type', _getAudio
app.get  '/image/:index', _getImage
app.get  '/start/:howmany', _startRoute

process.on 'uncaughtException', (err) ->

  console.log 'Caught exception: ' + err
  return
