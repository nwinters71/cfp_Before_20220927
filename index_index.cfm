index.cm<cfabort>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" type="image/ico"  href="/cfpimages/golden-ticket.png" />
  <title>College Fast Pass</title>

	<!-- Vendor -->
	<script src="./assets/vendor/jquery/jquery.min.js" language="JavaScript" type="text/javascript"></script>
	<script src="https://unpkg.com/vue@2.6.12/dist/vue.js"></script>
	<script src="https://unpkg.com/vuex@3.6.2/dist/vuex.js"></script>
	<script src="./assets/js/datastore.js" language="JavaScript" type="text/javascript"></script>

	<link rel="stylesheet" href="assets/vendor/w3schools/w3.css">

	<link rel="stylesheet" type="text/css" href="./assets/css/cfp.css">
</head>


<body>

<!-- Navigation -->
<div id="nav"></div>

<!-- Page Content -->
<div class="grid-container">
	<div class="grid-item"></div>

	<!-- Portfolio Item Row -->
	<div id="thegrid" class="grid-item">
		<div>
			<div class="blankrow"><img src="/cfpimages/space.png" width="100%" height="30px" style="margin-top: 30px">
			</div>
			<div id="idWidget2">
				<div id="EmptyBox" class="widget-header2"><!-- <button onclick="test()">Test</button> --></div>
			</div>
		</div>
	</div> <!-- / #thegrid -->

	<div class="grid-item"></div>

	<!-- <div style="display:flex; position:sticky; top: 70px; margin-top: 58px;"><div id="rightsidebar" class="grid-item w3-card"></div></div> -->
	<div id="vueRightSidebar" class="grid-item" style="height: 100%; margin-top:54px;">
		<div class="w3-container w3-white" style="height: 20px; position:sticky; top:54px; z-index:10;"></div>
		<div class="w3-container w3-red" style="height: 40px; position:sticky; top:74px;">Hello World</div>
		<div class="w3-container w3-yellow" style="height:200px;">Photo</div>
		<div class="w3-container w3-green" style="height: 40px; position:sticky; top:104px; z-index:10;">Tabs</div>
		<div class="w3-container w3-orange" style="height:1200px;">Tab Content</div>
	</div>

	<div class="grid-item"></div>

</div> <!-- /.grid-container -->

<!-- Footer -->
<div id="footer" style="text-align: center"></div>

</body>


<!-- CFP -->
<script src="./assets/js/cfp.js" language="JavaScript" type="text/javascript"></script>
<script src="./assets/js/research.js" language="JavaScript" type="text/javascript"></script>
<script src="./assets/js/rightSidebar.js" language="JavaScript" type="text/javascript"></script>  

<script>
	setTimeout(function(){
		console.log("Initial set sideBarType and sideBarId");
		getRightSidebar();
		sideBarType = "school";
		sideBarId = GridData.SCHOOLS.DATA[0][2]
		// setSideBar(sideBarType, sideBarId); // initiate sidebar to first school in dataset;
	}, 500);

	function test() {
		alert("Bonjour!");
	}

</script>

</html>

