$(document).ready(function() {

//Projets - lightbox
	$('.Projet').on('click', function ( e ) {
	    $.fn.custombox( this, {
	        effect:     'slide',
	        position:   'left, right',
	        overlay: true,
	        responsive: true,
	    });
	    e.preventDefault();
	});
// Qaptcha
	$.localScroll();
	$('.QapTcha').QapTcha({
		disabledSubmit:true,
		autoRevert:true,
		autoSubmit:false,
		PHPfile : 'QapTcha.jquery.php',
		txtLock:'Bloqué: déplacez vers la droite ',
		txtUnlock: 'Merci: vous pouvez envoyer votre message',
		});

//sphere

	$('#tagcloud').tagoSphere({
			height: 400,
			width: 400,	//width of sphere container
			radius: 170,	//radius of sphere
			speed: 5,	//rotation speed
			slower: 0.9,	//sphere rotations slower
			timer: 2,	//delay between update position
			fontMultiplier: 15,	//dependence of a font size on axis Z
			hoverStyle: {		//tag css stylies on mouse over
				border: 'none',
				color: '#0b2e6f'
			},
			mouseOutStyle: {	//tag css stylies on mouse out
				border: 'red',
				color: 'blue'
			}
	});

//menu des projets

	$(".tabContent").each(function(i){
		this.id = "#" + this.id;
	});
	$(".tabContent:not(:first)").hide();
	$(".tabContent").hide();
	$(".projets li a").click(function() {
		var idTab = $(this).attr("href");
		$(".tabContent").hide(1800);
		$("div[id='" + idTab + "']").slideToggle(1800);
		return false;
	});

// projets
	$('#lprojet1').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});
	$('#example8').on('click', function ( e ) {
    	$.fn.custombox( this, {
        effect:     'slide',
        position:   'left, right'
    });
    e.preventDefault();
	});

});


//google-analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			  ga('create', 'UA-40351381-2', 'rcdinfo.fr');
			  ga('send', 'pageview');

//barre-progression temps école
/* function modifValues(){
	var D1 = new Date(2013,09,02).getTime();
	var D2 = new Date().getTime();
	var D3 = new Date(2017,09,02);
	var dDiff = (((D2-D1)/(D3-D2))*1000).toFixed(0);
	dDiff = 25;
	var val = $('#progress progress').attr('value');
	var txt = dDiff+'%';
	$('#progress progress').attr('value',dDiff).text(txt);
	$('#progress strong').html(txt);
}
setInterval(function(){
	modifValues();
},90); */

// gestion langues
function charge(chx){
	var parametre = gup("lang");
	if( chx == parametre){}
	else if( chx=='fr' && parametre==''){}
	else{
		location.href= 'index.php?lang='+chx;
	}
}
function gup( name ){	//revoi la valeur de lang dans l'url
	name = name.replace(/[\[]/,"\\[").replace(/[\]]/,"\\]");
	var regexS = "[\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( window.location.href );
	if( results == null )		return "";
	else	return results[1];
}