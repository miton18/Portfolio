gulp                = require 'gulp'
gulpLoadPlugins     = require 'gulp-load-plugins'
gutil               = require 'gutil'
fs                  = require 'fs'
path                = require 'path'
exec                = require('child_process').exec

P                   = gulpLoadPlugins()

gulp.task 'default', [ 'watch' ]

gulp.task 'html', ->

    gulp.src( 'src/**.jade' )
    .pipe P.jade
        debug: false
    .pipe gulp.dest 'build/'

gulp.task 'css', ->

    gulp.src [
        'src/css/**/**.css'
        'src/css/main.less'
    ]
    .pipe P.plumber()
    .pipe P.less {}
    .on   'error', (err) ->
        gutil.log "[Less ERROR] #{err}"
    .pipe P.autoprefixer
        browsers: [ 'last 2 version' ]
        remove: true
    .pipe P.minifyCss()
    .on 'error', (e) ->
        gutil.log "[minifyCss ERROR] #{e}"
    .pipe P.concat( 'all.css' )
    .pipe gulp.dest( 'build/' )
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

gulp.task 'webserver', ->

    gulp.src 'build'
    .pipe P.webserver
        livereload: true
        directoryListing: false
        open: true
        host: '127.0.0.1'
        port: 80

gulp.task 'watch', [
    'webserver'
    'js'
    'js-vendor'
    'html'
    'css'
], ->
    server = P.livereload.listen
        start: true

    gulp.watch 'src/**/**.jade'
    .on 'change', (e) ->

        gutil.log "[JADE #{e.type}]: #{e.path}"
        gulp.src e.path
        .pipe P.plumber()
        .pipe P.jade
            debug: false
        .pipe gulp.dest('build/')
        return

    gulp.watch 'src/js/**/**.coffee', [ 'js' ]
    .on 'change', (e) ->
        gutil.log "[JS #{e.type}]: #{e.path}"
        return


    gulp.watch 'src/js/vendor/**.js', [ 'js-vendor' ]
    .on 'change', (event) ->
        gutil.log "[JS-vendor #{event.type}]: #{event.path}"
        return

    gulp.watch [ 'style_dev/**.less', 'style_dev/*.css'], [ 'css' ]
    .on 'change', (e)->
        gutil.log "[LESS #{e.type}]: #{e.path}"
    return
