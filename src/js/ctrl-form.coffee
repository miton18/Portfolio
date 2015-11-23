app.controller 'formCtrl', ['$scope', '$http', ($scope, $http)->

    $scope.isRobot  = true
    $scope.wait     = false
    $scope.infos     = []
    emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i

    $scope.robot = (state)->
        $scope.isRobot = state

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

        if $scope.isRobot
            $scope.infos.push {
                type: 'error'
                txt:  'Cliquez sur "Non", pour vérifier que vous n\'etes pas un robot'
            }
            $scope.wait = false
            return


        # on est bon en envoi
        $scope.host = if (window.location.host == "localhost") then 'localhost' else 'remi.rcdinfo.fr'

        $http
            method: 'POST'
            url:    "http://#{$scope.host}/messages"
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


]
