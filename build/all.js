var HEIGHT,cadre,etude,scrollTo;HEIGHT=0,cadre=function(){return $("article").height($(window).height()),HEIGHT=$(window).height()},$(window).resize(function(){return cadre()}),$(window).load(function(){return $(".load").slideUp("slow")}),$(document).ready(function(){return cadre(),$(".zoo").AniView({animateThreshold:HEIGHT/5,scrollPollInterval:10}),$(".next").click(function(){var o;return o=$(this).parent("article").next(),scrollTo(o)}),$(".plax-head-img").plaxify({xRange:15,yRange:0,invert:!0}),$.plax.enable(),$("#progression").progress({percent:etude(),text:{active:"Formation à {percent}%",success:"Formation achevée",ratio:"{percent}%"}}),$("form div input, form div textarea").focusout(function(){var o;return o=$(this),o.removeClass("notEmpty"),""!==o.val()?o.addClass("notEmpty"):void 0})}),scrollTo=function(o){return $("body").animate({scrollTop:o.offset().top},700,"easeOutBack")},etude=function(){var o,n,a,e;return e=Date.now(),n=new Date("02/10/2012").getTime(),a=new Date("02/10/2017").getTime(),o=(e-n)/(a-n)*100};var app;app=angular.module("app",[]),app.controller("formCtrl",["$scope","$http",function(o,n){var a;return o.isRobot=!0,o.wait=!1,o.infos=[],a=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i,o.robot=function(n){return o.isRobot=n},o.send=function(){return o.wait=!0,o.infos=[],a.test(o.mail)?void(o.isRobot&&(o.infos.push({type:"error",txt:'Cliquez sur "Non", pour vérifier que vous netes pas un robot'}),o.wait=!1)):(o.infos.push({type:"error",txt:"Vérifiez votre E-mail"}),void(o.wait=!1))}}]),app.controller("langCtrl",["$scope",function(o){return o.competences=[{logo:"sql.png",name:"SQL",cat:"lang"},{logo:"angularjs.png",name:"AngularJs",cat:"fram"},{logo:"mysql.png",name:"MySQL",cat:"logi"},{logo:"apache.png",name:"Apache",cat:"logi"},{logo:"arch.png",name:"ArchLinux",cat:"os"},{logo:"backbonejs.jpeg",name:"BackboneJs",cat:"fram"},{logo:"bootstrap.png",name:"Bootstrap",cat:"fram"},{logo:"c.png",name:"C",cat:"lang"},{logo:"cisco.png",name:"Cisco",cat:"logi"},{logo:"coffeescript.png",name:"Coffee Script",cat:"lang"},{logo:"couchdb.png",name:"CouchDB",cat:"logi"},{logo:"cplusplus.png",name:"C++",cat:"lang"},{logo:"css.png",name:"CSS",cat:"lang"},{logo:"dart.png",name:"Dart",cat:"lang"},{logo:"debian.png",name:"Débian",cat:"os"},{logo:"gulp.png",name:"Gulp",cat:"fram"},{logo:"html.png",name:"HTML",cat:"lang"},{logo:"ionic.png",name:"Ionic",cat:"fram"},{logo:"jade.svg",name:"Jade",cat:"lang"},{logo:"java.png",name:"Java",cat:"lang"},{logo:"jquery.png",name:"Jquery",cat:"fram"},{logo:"js.png",name:"Javascript",cat:"lang"},{logo:"less.png",name:"Less",cat:"lang"},{logo:"limonade.png",name:"Limonade",cat:"fram"},{logo:"linux.png",name:"Linux",cat:"os"},{logo:"mongodb.png",name:"MongoDB",cat:"logi"},{logo:"node.png",name:"Node",cat:"logi"},{logo:"office.png",name:"Office",cat:"logi"},{logo:"PHP.png",name:"PHP",cat:"lang"},{logo:"python.png",name:"Python",cat:"lang"},{logo:"qt.png",name:"QT",cat:"fram"},{logo:"sass.png",name:"SASS",cat:"lang"},{logo:"SDL.png",name:"SDL",cat:"fram"},{logo:"ubuntu.png",name:"Ubuntu",cat:"os"},{logo:"vhdl.png",name:"VHDL",cat:"lang"},{logo:"windows.png",name:"Windows",cat:"os"}]}]);
