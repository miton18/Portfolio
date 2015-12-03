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
            logo: 'mysql.jpg'
            name: 'MySQL'
            cat:  'Logiciel'
         ,
            logo: 'apache.png'
            name: 'Apache'
            cat:  'Logiciel'
         ,
            logo: 'arch.jpg'
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
            logo: 'c.jpg'
            name: 'C'
            cat:  'Langage'
         ,
            logo: 'cisco.jpg'
            name: 'Cisco'
            cat:  'Logiciel'
         ,
            logo: 'coffeescript.jpg'
            name: 'Coffee Script'
            cat:  'Langage'
         ,
            logo: 'couchdb.jpg'
            name: 'CouchDB'
            cat:  'Logiciel'
         ,
            logo: 'cplusplus.png'
            name: 'C++'
            cat:  'Langage'
         ,
            logo: 'css.jpg'
            name: 'CSS'
            cat:  'Langage'
         ,
            logo: 'dart.png'
            name: 'Dart'
            cat:  'Langage'
         ,
            logo: 'debian.jpg'
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
            logo: 'ionic.jpg'
            name: 'Ionic'
            cat:  'Framework'
         ,
            logo: 'jade.jpg'
            name: 'Jade'
            cat:  'Langage'
         ,
            logo: 'java.png'
            name: 'Java'
            cat:  'Langage'
         ,
            logo: 'jquery.jpg'
            name: 'Jquery'
            cat:  'Framework'
         ,
            logo: 'js.png'
            name: 'Javascript'
            cat:  'Langage'
         ,
            logo: 'less.jpg'
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
            logo: 'mongodb.jpg'
            name: 'MongoDB'
            cat:  'Logiciel'
        ,
            logo: 'node.jpg'
            name: 'Node'
            cat:  'Logiciel'
        ,
            logo: 'office.jpg'
            name: 'Office'
            cat:  'Logiciel'
        ,
            logo: 'PHP.jpg'
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
            logo: 'sass.jpg'
            name: 'SASS'
            cat:  'Langage'
        ,
            logo: 'SDL.jpg'
            name: 'SDL'
            cat:  'Framework'
        ,
            logo: 'ubuntu.jpg'
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
        ,
            logo: 'docker.jpg'
            name: 'Docker'
            cat: 'Framework'
    ]
]
