var HEIGHT, app, cadre, etude, scrollTo;

app = angular.module('app', ['ngAnimate']);

HEIGHT = 0;

cadre = function() {
  $('article').height($(window).height());
  return HEIGHT = $(window).height();
};

$(window).resize(function() {
  return cadre();
});

$(window).load(function() {
  return $('.load').slideUp('slow');
});

$(document).ready(function() {
  cadre();
  $('.zoo').AniView({
    animateThreshold: HEIGHT / 5,
    scrollPollInterval: 10
  });
  $('.next').click(function() {
    var nextSlide;
    nextSlide = $(this).parent('article').next();
    return scrollTo(nextSlide);
  });
  $('.plax-head-img').plaxify({
    "xRange": 15,
    "yRange": 0,
    "invert": true
  });
  $.plax.enable();
  $('#progression').progress({
    percent: etude(),
    text: {
      active: 'Formation à {percent}%',
      success: 'Formation achevée',
      ratio: '{percent}%'
    }
  });
  return $('form div input, form div textarea').focusout(function() {
    var that;
    that = $(this);
    that.removeClass('notEmpty');
    if (that.val() !== "") {
      return that.addClass('notEmpty');
    }
  });
});

scrollTo = function(el) {
  return $('body').animate({
    scrollTop: el.offset().top
  }, 700, 'easeOutBack');
};

etude = function() {
  var date, depart, fin, now;
  now = Date.now();
  depart = (new Date("02/10/2012")).getTime();
  fin = (new Date("02/10/2017")).getTime();
  date = ((now - depart) / (fin - depart)) * 100;
  return date;
};

app.controller('formCtrl', [
  '$scope', '$http', function($scope, $http) {
    var emailReg;
    $scope.isRobot = true;
    $scope.wait = false;
    $scope.infos = [];
    emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    $scope.robot = function(state) {
      return $scope.isRobot = state;
    };
    return $scope.send = function() {
      $scope.wait = true;
      $scope.infos = [];
      if (!emailReg.test($scope.email)) {
        $scope.infos.push({
          type: 'error',
          txt: 'Vérifiez votre E-mail'
        });
        $scope.wait = false;
        return;
      }
      if ($scope.isRobot) {
        $scope.infos.push({
          type: 'error',
          txt: 'Cliquez sur "Non", pour vérifier que vous n\'etes pas un robot'
        });
        $scope.wait = false;
        return;
      }
      $scope.host = window.location.host === "localhost" ? 'localhost' : 'remi.rcdinfo.fr';
      return $http({
        method: 'POST',
        url: "http://" + $scope.host + "/messages",
        data: {
          email: $scope.email,
          content: $scope.content,
          name: $scope.name
        }
      }).then(function(rep) {
        if (rep.data.error != null) {
          $scope.infos.push({
            type: 'error',
            txt: "Votre message n'a pas été accepté: " + rep.data.error
          });
        } else {
          $scope.infos.push({
            type: 'success',
            txt: 'Votre message a bien été transmit.'
          });
        }
        return $scope.wait = false;
      }, function(rep) {
        $scope.infos.push({
          type: 'error',
          txt: 'Impossible de déposer le message sur le serveur.... Vous pouvez utiliser contact@rcoll.fr'
        });
        return $scope.wait = false;
      });
    };
  }
]);

app.controller('langCtrl', [
  '$scope', function($scope) {
    $scope.switchFilter = function(cat) {
      return $scope.catFilter = cat;
    };
    return $scope.competences = [
      {
        logo: 'sql.png',
        name: 'SQL',
        cat: 'Langage'
      }, {
        logo: 'angularjs.png',
        name: 'AngularJs',
        cat: 'Framework'
      }, {
        logo: 'mysql.png',
        name: 'MySQL',
        cat: 'Logiciel'
      }, {
        logo: 'apache.png',
        name: 'Apache',
        cat: 'Logiciel'
      }, {
        logo: 'arch.png',
        name: 'ArchLinux',
        cat: 'OS'
      }, {
        logo: 'backbonejs.png',
        name: 'BackboneJs',
        cat: 'Framework'
      }, {
        logo: 'bootstrap.png',
        name: 'Bootstrap',
        cat: 'Framework'
      }, {
        logo: 'c.png',
        name: 'C',
        cat: 'Langage'
      }, {
        logo: 'cisco.png',
        name: 'Cisco',
        cat: 'Logiciel'
      }, {
        logo: 'coffeescript.png',
        name: 'Coffee Script',
        cat: 'Langage'
      }, {
        logo: 'couchdb.png',
        name: 'CouchDB',
        cat: 'Logiciel'
      }, {
        logo: 'cplusplus.png',
        name: 'C++',
        cat: 'Langage'
      }, {
        logo: 'css.png',
        name: 'CSS',
        cat: 'Langage'
      }, {
        logo: 'dart.png',
        name: 'Dart',
        cat: 'Langage'
      }, {
        logo: 'debian.png',
        name: 'Débian',
        cat: 'OS'
      }, {
        logo: 'gulp.jpg ',
        name: 'Gulp',
        cat: 'Framework'
      }, {
        logo: 'html.png',
        name: 'HTML',
        cat: 'Langage'
      }, {
        logo: 'ionic.png',
        name: 'Ionic',
        cat: 'Framework'
      }, {
        logo: 'jade.svg',
        name: 'Jade',
        cat: 'Langage'
      }, {
        logo: 'java.png',
        name: 'Java',
        cat: 'Langage'
      }, {
        logo: 'jquery.png',
        name: 'Jquery',
        cat: 'Framework'
      }, {
        logo: 'js.png',
        name: 'Javascript',
        cat: 'Langage'
      }, {
        logo: 'less.png',
        name: 'Less',
        cat: 'Langage'
      }, {
        logo: 'limonade.png',
        name: 'Limonade',
        cat: 'Framework'
      }, {
        logo: 'linux.png',
        name: 'Linux',
        cat: 'OS'
      }, {
        logo: 'mongodb.png',
        name: 'MongoDB',
        cat: 'Logiciel'
      }, {
        logo: 'node.png',
        name: 'Node',
        cat: 'Logiciel'
      }, {
        logo: 'office.png',
        name: 'Office',
        cat: 'Logiciel'
      }, {
        logo: 'PHP.png',
        name: 'PHP',
        cat: 'Langage'
      }, {
        logo: 'python.png',
        name: 'Python',
        cat: 'Langage'
      }, {
        logo: 'qt.png',
        name: 'QT',
        cat: 'Framework'
      }, {
        logo: 'sass.png',
        name: 'SASS',
        cat: 'Langage'
      }, {
        logo: 'SDL.png',
        name: 'SDL',
        cat: 'Framework'
      }, {
        logo: 'ubuntu.png',
        name: 'Ubuntu',
        cat: 'OS'
      }, {
        logo: 'vhdl.png',
        name: 'VHDL',
        cat: 'Langage'
      }, {
        logo: 'windows.png',
        name: 'Windows',
        cat: 'OS'
      }
    ];
  }
]);

app.directive('pointbackground', function() {
  return {
    restrict: 'EAC',
    template: '<aside id="large-header" class="large-header"> <canvas id="demo-canvas"></canvas> </aside>',
    link: function(scope, element) {
      element.css({
        position: 'fixed',
        width: '100%',
        padding: 0,
        left: 0,
        top: 0,
        height: HEIGHT,
        background: '#fff',
        'background-size': 'cover',
        'background-position': 'center center'
      });
      return (function() {
        var COLOR, Circle, addListeners, animate, animateHeader, canvas, ctx, drawLines, getDistance, height, initAnimation, initHeader, largeHeader, mouseMove, points, resize, scrollCheck, shiftPoint, target, width;
        COLOR = "rgba(51, 51, 55, 0.2)";
        width = void 0;
        height = void 0;
        largeHeader = void 0;
        canvas = void 0;
        ctx = void 0;
        points = void 0;
        target = void 0;
        initHeader = function() {
          var c, closest, i, j, k, p, p1, p2, placed, px, py, x, y;
          width = window.innerWidth;
          height = window.innerHeight;
          target = {
            x: width / 2,
            y: height / 2
          };
          largeHeader = document.getElementById("large-header");
          largeHeader.style.height = height + "px";
          canvas = document.getElementById("demo-canvas");
          canvas.width = width;
          canvas.height = height;
          ctx = canvas.getContext("2d");
          points = [];
          x = 0;
          while (x < width) {
            y = 0;
            while (y < height) {
              px = x + Math.random() * width / 20;
              py = y + Math.random() * height / 20;
              p = {
                x: px,
                originX: px,
                y: py,
                originY: py
              };
              points.push(p);
              y = y + height / 20;
            }
            x = x + width / 20;
          }
          i = 0;
          while (i < points.length) {
            closest = [];
            p1 = points[i];
            j = 0;
            while (j < points.length) {
              p2 = points[j];
              if (p1 !== p2) {
                placed = false;
                k = 0;
                while (k < 5) {
                  if (!placed) {
                    if (closest[k] === undefined) {
                      closest[k] = p2;
                      placed = true;
                    }
                  }
                  k++;
                }
                k = 0;
                while (k < 5) {
                  if (!placed) {
                    if (getDistance(p1, p2) < getDistance(p1, closest[k])) {
                      closest[k] = p2;
                      placed = true;
                    }
                  }
                  k++;
                }
              }
              j++;
            }
            p1.closest = closest;
            i++;
          }
          for (i in points) {
            c = new Circle(points[i], 2 + Math.random() * 2, COLOR);
            points[i].circle = c;
          }
        };
        addListeners = function() {
          if (!("ontouchstart" in window)) {
            window.addEventListener("mousemove", mouseMove);
          }
          window.addEventListener("scroll", scrollCheck);
          window.addEventListener("resize", resize);
        };
        mouseMove = function(e) {
          var posx, posy;
          posx = posy = 0;
          if (e.pageX || e.pageY) {
            posx = e.pageX;
            posy = e.pageY;
          } else if (e.clientX || e.clientY) {
            posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
            posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
          }
          target.x = posx;
          target.y = posy;
        };
        scrollCheck = function() {
          var animateHeader;
          if (document.body.scrollTop > height) {
            animateHeader = false;
          } else {
            animateHeader = true;
          }
        };
        resize = function() {
          width = window.innerWidth;
          height = window.innerHeight;
          largeHeader.style.height = height + "px";
          canvas.width = width;
          canvas.height = height;
        };
        initAnimation = function() {
          var i;
          animate();
          for (i in points) {
            shiftPoint(points[i]);
          }
        };
        animate = function() {
          var i;
          if (animateHeader) {
            ctx.clearRect(0, 0, width, height);
            for (i in points) {
              if (Math.abs(getDistance(target, points[i])) < 4000) {
                points[i].active = 0.3;
                points[i].circle.active = 0.6;
              } else if (Math.abs(getDistance(target, points[i])) < 20000) {
                points[i].active = 0.1;
                points[i].circle.active = 0.3;
              } else if (Math.abs(getDistance(target, points[i])) < 40000) {
                points[i].active = 0.02;
                points[i].circle.active = 0.1;
              } else {
                points[i].active = 0;
                points[i].circle.active = 0;
              }
              drawLines(points[i]);
              points[i].circle.draw();
            }
          }
          requestAnimationFrame(animate);
        };
        shiftPoint = function(p) {
          TweenLite.to(p, 1 + 1 * Math.random(), {
            x: p.originX - 50 + Math.random() * 100,
            y: p.originY - 50 + Math.random() * 100,
            ease: Circ.easeInOut,
            onComplete: function() {
              shiftPoint(p);
            }
          });
        };
        drawLines = function(p) {
          var i;
          if (!p.active) {
            return;
          }
          for (i in p.closest) {
            ctx.beginPath();
            ctx.moveTo(p.x, p.y);
            ctx.lineTo(p.closest[i].x, p.closest[i].y);
            ctx.strokeStyle = COLOR;
            ctx.stroke();
          }
        };
        Circle = function(pos, rad, color) {
          var _this;
          _this = this;
          (function() {
            _this.pos = pos || null;
            _this.radius = rad || null;
            _this.color = color || null;
          })();
          this.draw = function() {
            if (!_this.active) {
              return;
            }
            ctx.beginPath();
            ctx.arc(_this.pos.x, _this.pos.y, _this.radius, 0, 2 * Math.PI, false);
            ctx.fillStyle = COLOR;
            ctx.fill();
          };
        };
        getDistance = function(p1, p2) {
          return Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2);
        };
        animateHeader = true;
        initHeader();
        initAnimation();
        return addListeners();
      })();
    }
  };
});

app.filter('unique', function() {
  return function(collection, keyname) {
    var keys, output;
    output = [];
    keys = [];
    angular.forEach(collection, function(item) {
      var key;
      key = item[keyname];
      if (keys.indexOf(key) === -1) {
        keys.push(key);
        return output.push(item);
      }
    });
    return output;
  };
});
