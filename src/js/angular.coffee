app = angular.module 'app', ['ngAnimate']


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
                txt:  'Cliquez sur "Non", pour vérifier que vous n\etes pas un robot'
            }
            $scope.wait = false
            return
        # on est bon en envoi

        $http
            method: 'POST'
            #url:    'http://remi.rcdinfo.fr/messages'
            url:    'http://127.0.0.1/messages'
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


app.filter 'unique', ->
    return (collection, keyname)->
        output  = []
        keys    = []

        angular.forEach collection, (item)->
            key = item[keyname]
            if keys.indexOf(key) == -1
                keys.push key
                output.push item
        return output

app.controller 'langCtrl', ['$scope', ($scope)->

    $scope.switchFilter = (cat)->
        $scope.catFilter = cat

    $scope.competences = [

            logo: 'sql.png'
            name: 'SQL'
            cat:  'Langage'
         ,

            logo: 'angularjs.png'
            name: 'AngularJs'
            cat:  'Framework'
         ,
            logo: 'mysql.png'
            name: 'MySQL'
            cat:  'Logiciel'
         ,
            logo: 'apache.png'
            name: 'Apache'
            cat:  'Logiciel'
         ,
            logo: 'arch.png'
            name: 'ArchLinux'
            cat:  'OS'
         ,
            logo: 'backbonejs.png'
            name: 'BackboneJs'
            cat:  'Framework'
         ,
            logo: 'bootstrap.png'
            name: 'Bootstrap'
            cat:  'Framework'
         ,
            logo: 'c.png'
            name: 'C'
            cat:  'Langage'
         ,
            logo: 'cisco.png'
            name: 'Cisco'
            cat:  'Logiciel'
         ,
            logo: 'coffeescript.png'
            name: 'Coffee Script'
            cat:  'Langage'
         ,
            logo: 'couchdb.png'
            name: 'CouchDB'
            cat:  'Logiciel'
         ,
            logo: 'cplusplus.png'
            name: 'C++'
            cat:  'Langage'
         ,
            logo: 'css.png'
            name: 'CSS'
            cat:  'Langage'
         ,
            logo: 'dart.png'
            name: 'Dart'
            cat:  'Langage'
         ,
            logo: 'debian.png'
            name: 'Débian'
            cat:  'OS'
         ,
            logo: 'gulp.png'
            name: 'Gulp'
            cat:  'Framework'
         ,
            logo: 'html.png'
            name: 'HTML'
            cat:  'Langage'
         ,
            logo: 'ionic.png'
            name: 'Ionic'
            cat:  'Framework'
         ,
            logo: 'jade.svg'
            name: 'Jade'
            cat:  'Langage'
         ,
            logo: 'java.png'
            name: 'Java'
            cat:  'Langage'
         ,
            logo: 'jquery.png'
            name: 'Jquery'
            cat:  'Framework'
         ,
            logo: 'js.png'
            name: 'Javascript'
            cat:  'Langage'
         ,
            logo: 'less.png'
            name: 'Less'
            cat:  'Langage'
         ,
            logo: 'limonade.png'
            name: 'Limonade'
            cat:  'Framework'
         ,
            logo: 'linux.png'
            name: 'Linux'
            cat:  'OS'
         ,
            logo: 'mongodb.png'
            name: 'MongoDB'
            cat:  'Logiciel'
        ,
            logo: 'node.png'
            name: 'Node'
            cat:  'Logiciel'
        ,
            logo: 'office.png'
            name: 'Office'
            cat:  'Logiciel'
        ,
            logo: 'PHP.png'
            name: 'PHP'
            cat:  'Langage'
        ,
            logo: 'python.png'
            name: 'Python'
            cat:  'Langage'
        ,
            logo: 'qt.png'
            name: 'QT'
            cat:  'Framework'
        ,
            logo: 'sass.png'
            name: 'SASS'
            cat:  'Langage'
        ,
            logo: 'SDL.png'
            name: 'SDL'
            cat:  'Framework'
        ,
            logo: 'ubuntu.png'
            name: 'Ubuntu'
            cat:  'OS'
        ,
            logo: 'vhdl.png'
            name: 'VHDL'
            cat:  'Langage'
        ,
            logo: 'windows.png'
            name: 'Windows'
            cat:  'OS'
    ]
]
