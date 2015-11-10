gulp                = require 'gulp'
gulpLoadPlugins     = require 'gulp-load-plugins'
gutil               = require 'gutil'
fs                  = require 'fs'
path                = require 'path'
exec                = require('child_process').exec

P                   = gulpLoadPlugins()

gulp.task 'default', [ 'watch' ]

gulp.task 'HTML:JADE', ->

    gulp.src 'src/index.jade' 
    .pipe P.plumber()
    .pipe P.jade
        debug: false
    #.pipe P.inject( gulp.src(['build/**.css', 'build/**.js']) )
    .pipe gulp.dest 'build/'

gulp.task 'CSS:SASS', ->

    gulp.src [
        'src/css/main.sass'
    ]
    .pipe P.plumber()
    .pipe P.sass()
    .on('error', gutil.log) #sass.logError
    .pipe P.autoprefixer
        browsers: [ 'last 2 version' ]
        remove: true
    .pipe P.minifyCss()
    .on 'error', (e) ->
        gutil.log "[minifyCss ERROR] #{e}"
    .pipe P.concat( 'all.css' )
    .pipe gulp.dest( 'build/css/' )
    .pipe P.livereload()

gulp.task 'CSS:VENDOR', ->

    gulp.src 'src/css/vendor/**.css'
    .pipe P.plumber()
    .pipe P.autoprefixer
        browsers: [ 'last 2 version' ]
        remove: true
    .pipe P.minifyCss()
    .on 'error', (e) ->
        gutil.log "[minifyCss ERROR] #{e}"
    .pipe P.concat( 'vendor.css' )
    .pipe gulp.dest( 'build/css/' )
    .pipe P.livereload()


gulp.task 'JS:VENDOR', ->

    gulp.src [
        'src/js/vendor/angular.min.js'
        'src/js/vendor/jquery.js'
        'src/js/vendor/**.js'
    ]
    .pipe P.plumber()
    .pipe P.concat('vendor.js')
    .pipe P.jsmin()
    .pipe gulp.dest('build/')
    .pipe P.livereload()

gulp.task 'JS:COFFEE', ->

    gulp.src [
        'src/js/main.coffee'
        'src/js/**/**.coffee'
    ]
    .pipe P.plumber()
    .pipe P.coffee
        bare: true
    .on 'error', gutil.log
    .pipe P.jsmin()
    .pipe P.concat( 'all.js' )
    .on 'error', (err) ->
        gutil.log "[JSVendor ERROR] #{err}"
    .pipe gulp.dest('build/')
    .pipe P.livereload()

gulp.task 'img', ->

    gulp.src 'src/img/**/**'
    .pipe gulp.dest('build/img')

gulp.task 'webserver', ->

    gulp.src 'build'
    .pipe P.webserver
        livereload: true
        directoryListing: false
        open: true
        host: '127.0.0.1'
        port: 8080

gulp.task 'watch', [
    'webserver'
    'JS:COFFEE'
    'JS:VENDOR'
    'CSS:SASS'
    'CSS:VENDOR'
    'HTML:JADE'
    'img'
], ->
    server = P.livereload.listen
        start: true

    gulp.watch 'src/**/**.jade', ['HTML:JADE']
    .on 'change', (e) ->

        gutil.log "[JADE #{e.type}]: #{e.path}"
        return

    gulp.watch 'src/js/**/**.coffee', [ 'JS:COFFEE' ]
    .on 'change', (e) ->
        gutil.log "[JS #{e.type}]: #{e.path}"
        return


    gulp.watch 'src/js/vendor/**.js', [ 'JS:VENDOR' ]
    .on 'change', (event) ->
        gutil.log "[JS-vendor #{event.type}]: #{event.path}"
        return

    gulp.watch [ 'src/css/**.css', 'src/css/**.sass'], [ 'CSS:SASS' ]
    .on 'change', (e)->
        gutil.log "[SASS #{e.type}]: #{e.path}"

    gulp.watch 'src/css/vendor/**.css', [ 'CSS:VENDOR' ]
    .on 'change', (e)->
        gutil.log "[CSS #{e.type}]: #{e.path}"

    gulp.watch 'src/img/**/**'
    .on 'change', (e)->
        gulp.src e.path
        .pipe gulp.dest('build/img')
        gutil.log "[LESS #{e.type}]: #{e.path}"
    return
