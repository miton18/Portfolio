gulp                = require 'gulp'
gulpLoadPlugins     = require 'gulp-load-plugins'
gutil               = require 'gutil'
fs                  = require 'fs'
path                = require 'path'
exec                = require('child_process').exec

P                   = gulpLoadPlugins()

server = P.livereload.listen
    start:  true

gulp.task 'default', [
    'build'
    'webserver'
    'watch'
]

gulp.task 'build', [
    'JS:COFFEE'
    'JS:VENDOR'
    'JS:SERVER'
    'CSS:SASS'
    'CSS:VENDOR'
    'HTML:JADE'
    'img'
]


#------------------------------------------------------------
gulp.task 'HTML:JADE', ->

    gulp.src 'src/index.jade' 
        .pipe P.plumber()
        .pipe P.jade
            debug: false
        .pipe gulp.dest 'build/'

#------------------------------------------------------------
gulp.task 'CSS:SASS', ->

    gulp.src [
        'src/css/main.sass'
    ]
        .pipe P.plumber()
        .pipe P.plumberNotifier()
        .pipe P.sass().on('error', gutil.log) #P.sass.logError
        .pipe P.autoprefixer
            browsers: [ 'last 2 version' ]
            remove: true
        #.pipe P.minifyCss()
        .on 'error', (e) ->
            gutil.log "[minifyCss ERROR] #{e}"
        .pipe P.concat( 'all.css' )
        .pipe gulp.dest( 'build/css/' )
        .pipe P.livereload()

#------------------------------------------------------------
gulp.task 'CSS:VENDOR', ->

    gulp.src 'src/css/vendor/*.css'
        .pipe P.plumber()
        .pipe P.plumberNotifier()
        .pipe P.autoprefixer
            browsers: [ 'last 2 version' ]
            remove: true
        #.pipe P.cssnano()
        .on 'error', (e) ->
            gutil.log "[minifyCss ERROR] #{e}"
        .pipe P.concat( 'vendor.css' )
        .pipe gulp.dest( 'build/css/' )
        .pipe P.livereload()

#------------------------------------------------------------
gulp.task 'JS:VENDOR', ->

    gulp.src [
        'src/js/vendor/TweenLite.min.js'
        'src/js/vendor/angular.js'
        'src/js/vendor/angular-animate.js'
        'src/js/vendor/jquery.js'
        'src/js/vendor/*.js'
    ]
        .pipe P.plumber()
        .pipe P.plumberNotifier()
        .pipe P.concat('vendor.js')
        #.pipe P.jsmin()
        #.pipe P.uglify()
        .pipe gulp.dest('build/')
        .pipe P.livereload()

#------------------------------------------------------------
gulp.task 'JS:COFFEE', ->

    gulp.src [
        'src/js/main.coffee'
        'src/js/**/*.coffee'
    ]
        .pipe P.plumber()
        .pipe P.plumberNotifier()
        .pipe( P.coffee
            bare: true
        ).on( 'error', gutil.log)
        #.pipe P.jsmin()
        .pipe P.concat( 'all.js' )
        #.pipe P.uglify()
        .pipe gulp.dest('build/')
        .pipe P.livereload()

#------------------------------------------------------------
gulp.task 'img', ->

    gulp.src [
        'src/img/**/*.jpg'
        'src/img/**/*.png'
        'src/img/**/*.svg'
    ]
    .pipe gulp.dest('build/img')

gulp.task 'JS:SERVER', ->

    gulp.src 'src/*.coffee'
        .pipe P.plumber()
        .pipe P.plumberNotifier()
        .pipe P.coffee()
        #.pipe P.uglify()
        .pipe gulp.dest( './' )

#------------------------------------------------------------
gulp.task 'webserver', ->

    gulp.src 'build'
        .pipe P.webserver
            livereload: true
            directoryListing: false
            open: true
            host: '127.0.0.1'
            port: 8080

#------------------------------------------------------------
gulp.task 'watch', ->

    gulp.watch 'src/**/*.jade', ['HTML:JADE']

    gulp.watch 'src/js/**/*.coffee', [ 'JS:COFFEE' ]
        
    gulp.watch 'src/js/vendor/*.js', [ 'JS:VENDOR' ]
        
    gulp.watch 'src/*.coffee', [ 'JS:SERVER' ]
        
    gulp.watch 'src/css/*.sass', [ 'CSS:SASS' ]
        
    gulp.watch 'src/css/vendor/*.css', [ 'CSS:VENDOR' ]
        
    gulp.watch 'src/img/**/**', [ 'img' ]
        
    return
