app.directive 'pointbackground', ->

    return {
        restrict: 'EAC'
        template: '<aside id="large-header" class="large-header">
					<canvas id="demo-canvas"></canvas>
                    </aside>'

        link: (scope, element)->

            element.css
                position: 'fixed'
                width: '100%'
                padding: 0
                left: 0
                top: 0
                height: HEIGHT
                background: '#fff'
                #overflow: 'hidden'
                'background-size': 'cover'
                'background-position': 'center center'

            (->
                #COLOR = "rgba(255,255,255,0.3)"
                COLOR = "rgba(51, 51, 55, 0.2)"
                width = undefined
                height = undefined
                largeHeader = undefined
                canvas = undefined
                ctx = undefined
                points = undefined
                target = undefined
                # Main
                initHeader = ->
                    width = window.innerWidth
                    height = window.innerHeight
                    target =
                        x: width / 2
                        y: height / 2

                    largeHeader = document.getElementById("large-header")
                    largeHeader.style.height = height + "px"
                    canvas = document.getElementById("demo-canvas")
                    canvas.width = width
                    canvas.height = height
                    ctx = canvas.getContext("2d")

                    # create points
                    points = []
                    x = 0

                    while x < width
                        y = 0

                        while y < height
                            px = x + Math.random() * width / 20
                            py = y + Math.random() * height / 20
                            p =
                                x: px
                                originX: px
                                y: py
                                originY: py

                            points.push p
                            y = y + height / 20
                        x = x + width / 20

                    # for each point find the 5 closest points
                    i = 0

                    while i < points.length
                        closest = []
                        p1 = points[i]
                        j = 0

                        while j < points.length
                            p2 = points[j]
                            unless p1 is p2
                                placed = false
                                k = 0

                                while k < 5
                                    unless placed
                                        if closest[k] is `undefined`
                                            closest[k] = p2
                                            placed = true
                                    k++
                                k = 0

                                while k < 5
                                    unless placed
                                        if getDistance(p1, p2) < getDistance(p1, closest[k])
                                            closest[k] = p2
                                            placed = true
                                    k++
                            j++
                        p1.closest = closest
                        i++

                    # assign a circle to each point
                    for i of points
                        c = new Circle(points[i], 2 + Math.random() * 2, COLOR)
                        points[i].circle = c
                    return

                # Event handling
                addListeners = ->
                    window.addEventListener "mousemove", mouseMove  unless "ontouchstart" of window
                    window.addEventListener "scroll", scrollCheck
                    window.addEventListener "resize", resize
                    return
                mouseMove = (e) ->
                    posx = posy = 0
                    if e.pageX or e.pageY
                        posx = e.pageX
                        posy = e.pageY
                    else if e.clientX or e.clientY
                        posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
                        posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
                    target.x = posx
                    target.y = posy
                    return
                scrollCheck = ->
                    if document.body.scrollTop > height
                        animateHeader = false
                    else
                        animateHeader = true
                    return
                resize = ->
                    width = window.innerWidth
                    height = window.innerHeight
                    largeHeader.style.height = height + "px"
                    canvas.width = width
                    canvas.height = height
                    return

                # animation
                initAnimation = ->
                    animate()
                    for i of points
                        shiftPoint points[i]
                    return


                animate = ->
                    if animateHeader
                        ctx.clearRect 0, 0, width, height
                        for i of points

                            # detect points in range
                            if Math.abs(getDistance(target, points[i])) < 4000
                                points[i].active = 0.3
                                points[i].circle.active = 0.6
                            else if Math.abs(getDistance(target, points[i])) < 20000
                                points[i].active = 0.1
                                points[i].circle.active = 0.3
                            else if Math.abs(getDistance(target, points[i])) < 40000
                                points[i].active = 0.02
                                points[i].circle.active = 0.1
                            else
                                points[i].active = 0
                                points[i].circle.active = 0
                            drawLines points[i]
                            points[i].circle.draw()
                    requestAnimationFrame animate
                    return
                shiftPoint = (p) ->
                    TweenLite.to p, 1 + 1 * Math.random(),
                        x: p.originX - 50 + Math.random() * 100
                        y: p.originY - 50 + Math.random() * 100
                        ease: Circ.easeInOut
                        onComplete: ->
                            shiftPoint p
                            return

                    return

                # Canvas manipulation
                drawLines = (p) ->
                    return  unless p.active
                    for i of p.closest
                        ctx.beginPath()
                        ctx.moveTo p.x, p.y
                        ctx.lineTo p.closest[i].x, p.closest[i].y
                        #ctx.strokeStyle = "rgba(156,217,249," + p.active + ")"
                        ctx.strokeStyle = COLOR
                        ctx.stroke()
                    return
                Circle = (pos, rad, color) ->
                    _this = this

                    # constructor
                    (->
                        _this.pos = pos or null
                        _this.radius = rad or null
                        _this.color = color or null
                        return
                    )()
                    @draw = ->
                        return  unless _this.active
                        ctx.beginPath()
                        ctx.arc _this.pos.x, _this.pos.y, _this.radius, 0, 2 * Math.PI, false
                        #ctx.fillStyle = "rgba(156,217,249," + _this.active + ")"
                        ctx.fillStyle = COLOR
                        ctx.fill()
                        return

                    return

                # Util
                getDistance = (p1, p2) ->
                    Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2)
                animateHeader = true

                initHeader()
                initAnimation()
                addListeners()
            )()
    }
