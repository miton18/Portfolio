app.controller 'formCtrl', ['$scope', '$http', ($scope, $http)->

    $scope.wait     = false
    $scope.infos     = []
    emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i

    $scope.send = ->

        $scope.wait = true
        $scope.infos = []

        unless emailReg.test($scope.email)
            $scope.infos.push {
                type: 'error'
                txt:  'Vérifiez votre E-mail'
            }
            $scope.wait = false
            return

        if false #$scope.isRobot
            $scope.infos.push {
                type: 'error'
                txt:  'Cliquez sur "Non", pour vérifier que vous n\'etes pas un robot'
            }
            $scope.wait = false
            return


        # on est bon en envoi
        $scope.host = 'remi.rcdinfo.fr'
        if document.domain == '127.0.0.1'
            $scope.host = '127.0.0.1'

        $http
            method: 'POST'
            url:    "https://#{$scope.host}/messages"
            data:
                email:      $scope.email
                content:    $scope.content
                name:       $scope.name

        .then (rep)->
            if rep.data.error?
                $scope.infos.push
                    type: 'error'
                    txt:  "Votre message n'a pas été accepté: #{rep.data.error}"
            else
                $scope.infos.push
                    type: 'success'
                    txt:  'Votre message a bien été transmit.'
            $scope.wait = false

        , (rep)->
            $scope.infos.push
                type: 'error'
                txt:  'Impossible de déposer le message sur le serveur.... Vous pouvez utiliser contact@rcoll.fr'
            $scope.wait = false

    ###$scope.captchaOptions =
        imgPath: 'img/'
        captcha:
            numberOfImages: 5
            autoRefresh: true
            callbacks:
                #loading: ->
                loaded: (captcha) ->
                    # Binds an element to callback on click
                    # @param element object like document.getElementById() (has to be a single element)
                    # @param callback function to run when the element is clicked

                    _bindClick = ( element, callback )->
                        if  element.addEventListener
                            element.addEventListener( 'click', callback, false );
                        else
                            element.attachEvent( 'onclick', callback );
                        return

                    # Avoid adding the hashtag to the URL when clicking/selecting visualCaptcha options
                    anchorOptions = document.getElementById('mainCaptcha').getElementsByTagName('a')
                    anchorList = Array::slice.call(anchorOptions)
                    # .getElementsByTagName does not return an actual array
                    anchorList.forEach (anchorItem) ->
                        _bindClick anchorItem, (event) ->
                            event.preventDefault()
                            return
                        return
                    return
        init: (captcha) ->
            $scope.captcha = captcha
            return

    $scope.isVisualCaptchaFilled = ->
        if  $scope.captcha.getCaptchaData().valid
            window.alert 'visualCaptcha is filled!'
        else
            window.alert 'visualCaptcha is NOT filled!'

    ###
]
