HEIGHT = 0

$ window
.resize ->
    cadre()

$ window
.load ->
    $ '.svg-loader'
    .slideUp 'slow'

$ document
.ready ->

    cadre()
    
    # APPEAR ON SCROLL
    # http://jjcosgrove.github.io/jquery-aniview/
    $ '.zoo'
    .AniView
        animateThreshold:   HEIGHT / 2
        scrollPollInterval: 10
    

    # GO TO NEXT SLIDE BUTTON
    $ '.next'
    .click ->

        nextSlide = $(this).parent('article').next()
        scrollTo nextSlide


    scrollTo = (el)->

        $ 'body'
        .animate
            scrollTop: el.offset().top
        , 700
        , 'easeOutBack' # http://easings.net/fr
    
cadre = ->

    # TAILLE DES SLIDES
    $ 'article'
    .height $( window ).height()
    HEIGHT = $( window ).height()
