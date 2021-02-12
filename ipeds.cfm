<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0">
	<title>IPEDS Explorer</title>
</head>
<script src="./assets/vendor/Framework7/v5/js/framework7.bundle.min.js"></script>

<script src="./assets/js/cfp-routes.js"></script>
<script src="./assets/js/cfp-app.js"></script>

<script src="https://unpkg.com/vue"></script>

<script src="assets/js/ipeds.js"></script>

</head>

<body>
<div id="app">
	<!--- <div class="view view-main view-init safe-areas">			 --->
		<div class="page" data-name="home">
			<div class="page-content">
				<div id="vueNavIPEDS">
					HELLO WORLD
				</div>
			</div>
		</div>
	<!--- </div> --->
</div>


<script>		
	var ipeds = {};

	loadComponents();

	function loadComponents() {	
		Framework7.request.get("content/nav_ipeds.html", function(data) {			
			$$("#vueNavIPEDS").html(data);
			ipeds = vueNavIPEDS();
		});
	}

</script>
</body>
</html>

