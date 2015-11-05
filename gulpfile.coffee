gulp                = require 'gulp'
gulpLoadPlugins     = require 'gulp-load-plugins'
gutil               = require 'gutil'
fs                  = require 'fs'
path                = require 'path'
exec                = require('child_process').exec

P                   = gulpLoadPlugins()

gulp.task 'default', [ 'watch' ]

gulp.task 'html', ->

    gulp.src 'src/index.jade' 
    .pipe P.plumber()
    .pipe P.jade
        debug: false
    #.pipe P.inject( gulp.src(['build/**.css', 'build/**.js']) )
    .pipe gulp.dest 'build/'

gulp.task 'css', ->

    gulp.src [
        'src/css/*.css'
        'src/css/*.sass'
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

gulp.task 'css-vendor', ->

    gulp.src 'src/css/vendor/**.css'
    .pipe P.autoprefixer
        browsers: [ 'last 2 version' ]
        remove: true
    .pipe P.minifyCss()
    .on 'error', (e) ->
        gutil.log "[minifyCss ERROR] #{e}"
    .pipe P.concat( 'vendor.css' )
    .pipe gulp.dest( 'build/css/' )
    .pipe P.livereload()


gulp.task 'js-vendor', ->

    gulp.src [
        'src/js/vendor/angular.min.js'
        'src/js/vendor/jquery.js'
        'src/js/vendor/**.js'
    ]
    .pipe P.concat('vendor.js')
    .pipe P.jsmin()
    .pipe gulp.dest('build/')
    .pipe P.livereload()

gulp.task 'js', ->

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
    'js'
    'js-vendor'
    'css'
    'css-vendor'
    'html'
    'img'
], ->
    server = P.livereload.listen
        start: true

    gulp.watch 'src/**/**.jade', ['html']
    .on 'change', (e) ->

        gutil.log "[JADE #{e.type}]: #{e.path}"
        return

    gulp.watch 'src/js/**/**.coffee', [ 'js' ]
    .on 'change', (e) ->
        gutil.log "[JS #{e.type}]: #{e.path}"
        return


    gulp.watch 'src/js/vendor/**.js', [ 'js-vendor' ]
    .on 'change', (event) ->
        gutil.log "[JS-vendor #{event.type}]: #{event.path}"
        return

    gulp.watch [ 'src/css/*.css', 'src/css/*.sass'], [ 'css' ]
    .on 'change', (e)->
        gutil.log "[SASS #{e.type}]: #{e.path}"

    gulp.watch 'src/css/vendor/**.css', [ 'css-vendor' ]
    .on 'change', (e)->
        gutil.log "[CSS #{e.type}]: #{e.path}"

    gulp.watch 'src/img/**/**'
    .on 'change', (e)->
        gulp.src e.path
        .pipe gulp.dest('build/img')
        gutil.log "[LESS #{e.type}]: #{e.path}"
    return
