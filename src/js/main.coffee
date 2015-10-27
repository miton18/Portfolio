

# GO TO NEXT SLIDE
$ '.next'
.click ->
    
    nextSlide = $(this).parent('article').next()
    scrollTo nextSlide
    
# TAILLE DES SLIDES
$ 'article'
.height $( window ).height() 

scrollTo = (el)->
    
    $ 'body'
    .animate
        scrollTop: el.offset().top
    , 500