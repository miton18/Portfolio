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
        animateThreshold:   HEIGHT / 2
        scrollPollInterval: 10
    

    # GO TO NEXT SLIDE BUTTON
    $ '.next'
    .click ->
        nextSlide = $(this).parent('article').next()
        scrollTo nextSlide

    #$ '#demiSlide'
    #.height HEIGHT


scrollTo = (el)->

    $ 'body'
    .animate
        scrollTop: el.offset().top
    , 700
    , 'easeOutBack' # http://easings.net/fr
