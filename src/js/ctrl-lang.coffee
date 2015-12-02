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
            logo: 'gulp.jpg '
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
