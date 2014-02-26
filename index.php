<!DOCTYPE HTML>
<?php
	if(	isset($_GET['lang']) AND ($_GET['lang'] == 'en')){	include('langues/lang-en.php');	}
	else{	include('langues/lang-fr.php');	}
?>
<html lang="fr">
	<head>
		<?php include('inclusion/head.php'); ?>
	</head>
	<body ng-app>
		<div id="chargement"><?php echo load; ?><span id="chargement-infos"></span></div> <!-- % de chargement  -->
		<div id="header">
			<nav id="menu">
				<ul>
					<!--a href="#" ><li><?php echo t1; ?></li></a-->
					<a href="#img1" ><li><?php echo t2; ?></li></a>
					<a href="#img2" ><li><?php echo t3; ?></li></a>
					<a href="#img3" ><li><?php echo t4; ?></li></a>
					<a href="#img5" ><li><?php echo t6;?></li></a>
					<a href="#img4" ><li><?php echo t5; ?></li></a>
					<li id="lang">
						<select onchange="charge(this.value)">
							<option disabled selected>--Langue--</option>
							<option value="fr" >Francais</option>
							<option value="en" >English</option>
							<option value="en" disabled>Español</option>
						</select>
					</li>
				</ul>
				<img src= <?php echo lang;?> />
			</nav><!-- menu -->
		</div><!-- header -->

		<div id="container" >
			
<!-- page PRESENTATION -->
			<div id="img1"></div>
			<div id="premierepage" class="image-ombre" >
				<h2><?php echo t2; ?></h2>
				<h1><?php echo text1; ?></h1>
				<img id="photo_profil" src="img/profil.jpg" alt="photo de l'auteur" title="photo de l'auteur" />
				<div id="dl_zone">
					<a target="_TOP" href="https://drive.google.com/file/d/0B0TZ5YI9m3UTb241NktZMWZTSkk/edit?usp=sharing">
						<img id="ficher" src="img/fichier.png" alt="Accès à mon C.V. téléchargeable " title="CV stocké sur google drive" /><!--
				--></a><!--
				--><p><?php echo text2; ?></p>
				</div>
				<p id="parag1" ><?php echo text3; ?></p>
			</div><!-- premiere page -->

<!-- page PROJET -->
		    <style>

		    </style>
			<div id="img2"></div>
			<div id="forma" class="image-ombre">
				<h2><?php echo t3; ?></h2>
			<ul class="grid cs-style-3">
				<li>
					<figure>
						<img src="img/projet/olivier-min.jpg" alt="site web de l'oliver" title="le site web d'un restaurant">
						<figcaption>
							<h3><?php echo o2; ?></h3>
							<span><?php echo site; ?></span>
							<a href="#projet1" class="Projet" ><?php echo lien_projet; ?></a>
							<div id="projet1" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o2; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p5; ?></p>
						            <img src="img/projet/olivier.jpg" alt="site-olivier" title="site-olivier"/>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/minecraft-logo.jpg" alt="image minecraft" title="logo minecraft">
						<figcaption>
							<h3><?php echo o1; ?></h3>
							<span><?php echo jeu;?></span>
							<a href="#projet2" class="Projet"><?php echo lien_projet; ?></a>
							<div id="projet2" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o1; ?></h4>
						        </div>
						        <div class="modal-example-body">
						        <a href="http://www.mumble.com/" target="_TOP">Serveur vocal utilisé</a>
						        <a href="https://minecraft.net/" target="_TOP">Le jeu: minecraft </a>
						            <p><?php echo p4; ?></p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/film1.jpg" alt="image du film" title="photo du film">
						<figcaption>
							<h3><?php echo o3; ?></h3>
							<span><?php echo film; ?></span>
							<a href="#projet3" class="Projet" ><?php echo lien_projet; ?></a>
							<div id="projet3" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o3; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p12; ?>
						            	<iframe src="//www.youtube.com/embed/u2sJgJHDuWY?rel=0" frameborder="0" allowfullscreen></iframe>
						            </p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/leap.jpg" alt="photo leapMotion" title="photo leapMotion">
						<figcaption>
							<h3><?php echo o4; ?></h3>
							<span><?php echo jeu; ?></span>
							<a href="#projet4" class="Projet"><?php echo lien_projet; ?></a>
							<div id="projet4" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o4; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p9; ?></p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/ds.jpg" alt="image d archives projet annales cir" title="">
						<figcaption>
							<h3><?php echo o5; ?></h3>
							<span><?php echo site; ?></span>
							<a href="#projet5" class="Projet"><?php echo lien_projet; ?></a>
							<div id="projet5" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o5; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p10; ?></p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/film2.jpg" alt="" title="">
						<figcaption>
							<h3><?php echo o6; ?></h3>
							<span><?php echo film; ?></span>
							<a href="#projet6" class="Projet"><?php echo lien_projet; ?></a>
							<div id="projet6" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o6; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p11; ?></p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
				<li>
					<figure>
						<img src="img/projet/genero.jpg" alt="" title="">
						<figcaption>
							<h3><?php echo o8; ?></h3>
							<span><?php echo site; ?></span>
							<a href="#projet7" class="Projet"><?php echo lien_projet; ?></a>
							<div id="projet7" style="display: none;" class="modal-example-content">

						        <div class="modal-example-header"><!-- light box -->
						            <button type="button" class="close" onclick="$.fn.custombox('close');">&times;</button>
						            <h4><?php echo o8; ?></h4>
						        </div>
						        <div class="modal-example-body">
						            <p><?php echo p13; ?></p>
						        </div>
						    </div>
						</figcaption>
					</figure>
				</li>
			</ul>
			<h2><?php echo "projets Github:"; ?></h2>
				<div ng-show="reposFound" ng-controller="affiche" >
        			<p><strong>Repos List:</strong></p>
        			<ul >
            			<li clas="git" ng-repeat="repo in repos">
            				<span><a href="{{repo.html_url}}" target="_TOP"><img src="img/github.png" /></a>{{repo.created_at}} </span>
            				<p>{{repo.description}}</p>

            			</li>
       				</ul>
    			</div>
			</div><!-- page projet: image-ombre -->		

<!-- page 	FORMATION -->
			<div id="img3"></div>
			<div class="image-ombre" >
				<h2><?php echo t4; ?></h2>
				<ul>
					<li>
						<p><?php echo text4; ?><a href="http://www.isen.fr/brest.asp" target="_TOP" title="site de l'école">ISEN</a><?php echo text41; ?></p>
						<p><?php echo titre2; ?></p>
						<div id="progress">
							<?php
								$now   = time();
								$dated = strtotime('2012-09-02 10:00:00');
								$datef = strtotime('2017-09-02 10:00:00');
								$cent = ( ($now - $dated) / ($datef - $dated) ) * 100;
								echo('<p>'.bout1.'<strong>'.round($cent, 0).'%</strong></p>');
								echo('<progress id="aa" value="'.$cent.'" max="100">'.$cent.'</progress>');
							?>
						</div><br/>
					</li>
					<li><?php echo text5; ?></li>
					<li>
						<p><?php echo texte7; ?> <a target="_TOP" href="http://gdgfinistere.org/">finist'gdg</a><?php echo texte71; ?>
						</p>
					</li>
				</ul>
			</div><!-- page Formation: image-ombre -->		

<!-- page COMPETENCES -->
			<div id="img5"></div>
			<div class="image-ombre">
				<h2><?php echo t6; ?></h2>
				<div id="progress2">
					<p><?php echo g1; ?></p>
					<div>
						<p>C</p>
						<progress id="a" value="90" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>C++</p>
						<progress id="b" value="40" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>java</p>
						<progress id="k" value="25" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>SQL</p>
						<progress id="c" value="70" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<p><?php echo g2; ?></p>
					<div>
						<p>HTML</p>
						<progress id="d" value="95" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>CSS</p>
						<progress id="e" value="85" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>JS</p>
						<progress id="f" value="25" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>Git</p>
						<progress id="h" value="70" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>AngularJS</p>
						<progress id="i" value="10" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>Dart</p>
						<progress id="j" value="15" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>PHP</p>
						<progress id="l" value="20" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<p>OS & Resaux</p>
					<div>
						<p>CCNA 1 ok & CCNA 2:</p>
						<progress id="m" value="25" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>Linux ( Ubuntu - Débian )</p>
						<progress id="n" value="25" max="100"></progress><span><?php echo o7; ?></span>
					</div>
					<div>
						<p>Windows ( XP - 7 - 8 - 8.1 )</p>
						<progress id="p" value="25" max="100"></progress><span><?php echo o7; ?></span>
					</div>
				</div>
					<h2>Un rémi c'est quoi? un rémi c'est ca !</h2>
					<div id="tagcloud">
						<ul>
							<li><a>intelligent</a></li>
							<li><a>inventif</a></li>
							<li><a>minutieux</a></li>
							<li><a>attentionné</a></li>
							<li><a>professionnel</a></li>
							<li><a>humain</a></li>
							<li><a>serieux</a></li>
							<li><a>impliqué</a></li>
							<li><a>intelligent</a></li>
							<li><a>inventif</a></li>
							<li><a>minutieux</a></li>
							<li><a>attentionné</a></li>
							<li><a>professionnel</a></li>
							<li><a>humain</a></li>
							<li><a>serieux</a></li>
							<li><a>impliqué</a></li>
							<li><a>intelligent</a></li>
							<li><a>inventif</a></li>
							<li><a>minutieux</a></li>
							<li><a>attentionné</a></li>
							<li><a>professionnel</a></li>
							<li><a>humain</a></li>
							<li><a>serieux</a></li>
							<li><a>impliqué</a></li>
						</ul>
					</div>
			</div>

<!-- page SUIVI -->
			<div id="img4"></div>
			<div id="suivi" class="image-ombre">
				<h2><?php echo t5; ?></h2>
				<div id="suivi-s">
					<!-- Facebook Badge START -->
						<a href="https://www.facebook.com/remi.collignon.d" target="_TOP" title="R&#xe9;mi Collignon"><img src="https://badge.facebook.com/badge/1579080637.2071.1533905297.png" /><!----></a>
					<!-- Facebook Badge END--><br/>
					<!-- gadget twitter -->
						<a class="twitter-timeline" href="https://twitter.com/miton1810" data-widget-id="381744815064371200">Tweets @miton1810</a>
					<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="js/twetter.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
					<!-- Place this tag in your head or just before your close body tag. -->
					<script type="text/javascript" src="https://apis.google.com/js/platform.js">
						{lang: 'fr', parsetags: 'explicit'}
					</script>
					<!-- Place this tag where you want the widget to render. -->
					<div class="g-person" data-href="//plus.google.com/111049829859311680128" data-theme="dark" data-rel="author"></div>
					<!-- Place this render call where appropriate. -->
					<script type="text/javascript">gapi.person.go();</script>
				</div>
				<div id="form">
				<?php include('inclusion/form.php'); ?>
					<form id="contact" method="post" action="" >
						<fieldset>
							<p><label><?php echo f1; ?></label></p>
							<p>
								<label for="nom"><?php echo f2; ?></label>
								<input placeholder="Jean Hyve"  type="text" id="nom" name="nom" tabindex="1" required />
							</p>
							<p>
								<label for="email"><?php echo f3; ?></label>
								<input placeholder="jeanhyve@contact.fr" type="email" id="email" name="email" tabindex="2" required />
							</p>
							<p>
								<label for="message"><?php echo f4; ?></label>
								<textarea placeholder="bonjour, ..." id="message" name="message" tabindex="4"  rows="8" required></textarea>
							</p>
							<div id="qa">
								<label><?php echo f5; ?></label>
							<div  class="QapTcha"></div>
							</div>
							<input type="submit" name="envoi" value="Envoyer mon message !" />
						</fieldset>
					</form>				
				</div><!-- form  -->
			</div>
	
			<footer id="espace-bas">
				<p><?php echo p8; ?></p>
			</footer>
			
		</div><!-- container -->
	</body>

	<script type="text/javascript" src="js/localscroll/jquery.localscroll.js"></script>
	<script type="text/javascript" src="js/localscroll/jquery.scrollTo.js"></script>
	<script type="text/javascript" src="js/lancement.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.12/angular.min.js"></script>
	<script type="text/javascript" src="js//jquery.ui.touch.js"></script>
	<script type="text/javascript" src="js/QapTcha.jquery.min.js"></script>
	<script type="text/javascript" src="js/tagcloud.jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.custombox.js"></script>
	<script type="text/javascript" src="js/ang.js"></script>

	
	<script src="js/modernizr.custom.js"></script>
	<script src="js/modernizr2.custom.js"></script>
	<script src="js/classie.js"></script>
	<script src="js/toucheffects.js"></script>

</html>