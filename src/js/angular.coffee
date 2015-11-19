app = angular.module('app', [])


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

        unless emailReg.test($scope.mail)
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

        ###$http
            method: 'POST'
            #url:    'http://remi.rcdinfo.fr/messages'
            url:    'http://127.0.0.1/messages'
            data:
                email:      $scope.email
                content:    $scope.content
                name:       $scope.name
        ###

]

app.controller 'langCtrl', ['$scope', ($scope)->
    $scope.competences = [

            logo: 'sql.png'
            name: 'SQL'
            cat:  'lang'
         ,

            logo: 'angularjs.png'
            name: 'AngularJs'
            cat:  'fram'
         ,
            logo: 'mysql.png'
            name: 'MySQL'
            cat:  'logi'
         ,
            logo: 'apache.png'
            name: 'Apache'
            cat:  'logi'
         ,
            logo: 'arch.png'
            name: 'ArchLinux'
            cat:  'os'
         ,
            logo: 'backbonejs.jpeg'
            name: 'BackboneJs'
            cat:  'fram'
         ,
            logo: 'bootstrap.png'
            name: 'Bootstrap'
            cat:  'fram'
         ,
            logo: 'c.png'
            name: 'C'
            cat:  'lang'
         ,
            logo: 'cisco.png'
            name: 'Cisco'
            cat:  'logi'
         ,
            logo: 'coffeescript.png'
            name: 'Coffee Script'
            cat:  'lang'
         ,
            logo: 'couchdb.png'
            name: 'CouchDB'
            cat:  'logi'
         ,
            logo: 'cplusplus.png'
            name: 'C++'
            cat:  'lang'
         ,
            logo: 'css.png'
            name: 'CSS'
            cat:  'lang'
         ,
            logo: 'dart.png'
            name: 'Dart'
            cat:  'lang'
         ,
            logo: 'debian.png'
            name: 'Débian'
            cat:  'os'
         ,
            logo: 'gulp.png'
            name: 'Gulp'
            cat:  'fram'
         ,
            logo: 'html.png'
            name: 'HTML'
            cat:  'lang'
         ,
            logo: 'ionic.png'
            name: 'Ionic'
            cat:  'fram'
         ,
            logo: 'jade.svg'
            name: 'Jade'
            cat:  'lang'
         ,
            logo: 'java.png'
            name: 'Java'
            cat:  'lang'
         ,
            logo: 'jquery.png'
            name: 'Jquery'
            cat:  'fram'
         ,
            logo: 'js.png'
            name: 'Javascript'
            cat:  'lang'
         ,
            logo: 'less.png'
            name: 'Less'
            cat:  'lang'
         ,
            logo: 'limonade.png'
            name: 'Limonade'
            cat:  'fram'
         ,
            logo: 'linux.png'
            name: 'Linux'
            cat:  'os'
         ,
            logo: 'mongodb.png'
            name: 'MongoDB'
            cat:  'logi'
        ,
            logo: 'node.png'
            name: 'Node'
            cat:  'logi'
        ,
            logo: 'office.png'
            name: 'Office'
            cat:  'logi'
        ,
            logo: 'PHP.png'
            name: 'PHP'
            cat:  'lang'
        ,
            logo: 'python.png'
            name: 'Python'
            cat:  'lang'
        ,
            logo: 'qt.png'
            name: 'QT'
            cat:  'fram'
        ,
            logo: 'sass.png'
            name: 'SASS'
            cat:  'lang'
        ,
            logo: 'SDL.png'
            name: 'SDL'
            cat:  'fram'
        ,
            logo: 'ubuntu.png'
            name: 'Ubuntu'
            cat:  'os'
        ,
            logo: 'vhdl.png'
            name: 'VHDL'
            cat:  'lang'
        ,
            logo: 'windows.png'
            name: 'Windows'
            cat:  'os'
    ]
]
