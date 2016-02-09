app = angular.module 'app', ['ngAnimate', 'visualCaptcha']

HEIGHT = 0

cadre = ->
    # TAILLE DES SLIDES
    $ 'article'
    .height $( window ).height()
    HEIGHT = $( window ).height()

$ window
.resize ->
    cadre()

$ window
.load ->
    $ '.load'
    .slideUp 'slow'


$ document
.ready ->

    cadre()
    
    # APPEAR ON SCROLL
    # http://jjcosgrove.github.io/jquery-aniview/
    $ '.zoo'
    .AniView
        animateThreshold:   HEIGHT / 5
        scrollPollInterval: 10 

    # GO TO NEXT SLIDE BUTTON
    $ '.next'
    .click ->
        nextSlide = $(this).parent('article').next()
        scrollTo nextSlide

    $('#progression').progress
        percent: etude()
        text:
            active:  'Formation à {percent}%'
            success: 'Formation achevée'
            ratio:  '{percent}%'

    $('form div input, form div textarea').focusout ->

        that = $(this)
        that.removeClass 'notEmpty'
        that.addClass     'notEmpty' if that.val() != ""

    $('.visualCaptcha-possibilities .img a').on('click', (e)->
        e.preventDefault()
        e.stopImmediatePropagation()
    )


###scrollTo = (el)->

    $ 'body'
    .animate
        scrollTop: el.offset().top
    , 700
    , 'easeOutBack' # http://easings.net/fr
###
etude = ->
    now     = Date.now()
    depart  = (new Date "02/10/2012").getTime()
    fin     = (new Date "02/10/2017").getTime()
    date = ((now - depart) / ( fin - depart )) *100
    return date
