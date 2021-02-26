
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.w3-bar-item {
	color: #ccc;
	font-size: 15px;
	margin: 0px -10px;
}
.w3-bar-item:hover {
	color: white;
	text-decoration: none;
}
div.sticky {
	position: -webkit-sticky; /* Safari */
	position: fixed;
	top: 0;
	z-index: 1030;
}
</style>

<div class="w3-bar sticky" style="background-color: #343a40; padding: 2px 200px; overflow: visible;">
	<a class="w3-bar-item" href="index.html"><img src="/cfpimages/golden-ticket.png" height="36" />&nbsp; <span style="font-family:courier new; font-weight:bold; color:white">College Fast Pass</span></a>

	<span id="account" class="w3-bar-item w3-right">
		<cfif isDefined("session.user.loggedIn") AND session.user.loggedIn>
			<a id="signout" class="w3-bar-item w3-right" href="#">Sign Out</a>
		<cfelse>
			<a id="signin" class="w3-bar-item w3-right" href="#" onclick="$('#login_form').css('display','block')">Sign In</a>
		</cfif>
	</span>

	<span class="w3-bar-item w3-right"><a href="index.html" class="w3-bar-item">Research</a></span>
	<!--- <span class="w3-bar-item w3-right"><a href="table.html" class="w3-bar-item">Analyze</a></span> --->
	<span class="w3-bar-item w3-right"><a href="vueSearch.html" class="w3-bar-item">Schools</a></span>
</div>

<!-- LOGIN MODAL -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fredoka+One">
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fredoka+One">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet"> -->

<style>
.w3-FredokaOne {
	font-family: Courier New, Fredoka One;
	font-size:24px;
	font-weight: bold;
	margin-left: 10px;
}
</style>


<div id="login_form" class="w3-modal">
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:480px">

		<div class="w3-center">
			<br>
			<span onclick="navDialog('loginScreens', 'LoginForm'); document.getElementById('login_form').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Login Window">&times;</span>
			<table border="0" width="90%" style="margin-left:20px;">
				<tr>
					<td><img src="/cfpimages/golden-ticket.png" style="height: 100px"></td>
					<td width="100%" style="text-align: left"><div id="welcome" class="w3-FredokaOne" style="margin-left:20px;">Welcome to<br />College Fast Pass</div></td>
				</tr>
			</table>
		</div>

		<div id="LoginForm" class="loginScreens">
			<div class="w3-container">
				<div class="w3-section">
					<label><b>&nbsp;Email Address:</b></label>
					<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter email address" id="email" required>
					<button class="w3-button w3-block w3-green w3-section w3-padding" onclick="loginDialog('checkEmail')">Next >></button>
				</div>
			</div>
		</div>

		<div id="PasswordForm" class="loginScreens" style="display:none">
			<div class="w3-container">
				<div class="w3-section">
					<label><b>Password:</b></label>
					<input class="w3-input w3-border" type="password" placeholder="Enter Password" id="login_password" required>
					<input class="w3-check w3-margin-top" type="checkbox" id="rm_login" value="rememberme" /> Remember me
					<button class="w3-button w3-block w3-green w3-section w3-padding" onclick="loginDialog('login')">Login</button>
				</div>
			</div>
			<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
				<button  onclick="navDialog('loginScreens', 'LoginForm');" type="button" class="w3-button w3-red"><< Back</button>
				<span class="w3-right w3-padding w3-hide-small"><a href="#" onclick="loginDialog('resetpw')">Reset Password?</a></span>
			</div>
		</div>

		<div id="SignupForm" class="loginScreens" style="display:none">
			<div class="w3-container">
				<div class="w3-section">
					<label><b>&nbsp;First Name or Nickname:</b></label>
					<input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter first name" id="firstname" required>
					<label><b>Password:</b></label>
					<input class="w3-input w3-border" type="password" placeholder="Enter password" id="signup_password" required>
					<input class="w3-check w3-margin-top" type="checkbox" id="rm_signup" value="signup" /> Remember me
					<button class="w3-button w3-block w3-green w3-section w3-padding" onclick="loginDialog('signup')">Join</button>
				</div>
			</div>
			<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
				<button  onclick="navDialog('loginScreens', 'LoginForm');" type="button" class="w3-button w3-red"><< Back</button>
			</div>
		</div>

	</div>
</div>



<script>
 
$("#signout").on("click", function() {
	$.ajax({url:"api/user.cfm?action=logout"})
		.done(function(data) {
			window.location.href = "/cfp";
		});
});

function loginDialog(action) {
	let reqObj = {};
	
	switch (action) {
		case "gotoLoginScreen" :
			navDialog("loginScreens", "LoginForm");
			break;

		case "checkEmail" :
			// do validation here
			reqObj = {
				"action":"checkEmail", 
				"email": document.getElementById("email").value
			}
			$.ajax({
				data: reqObj,
				method: "post",
				url:"api/user.cfm?action=checkemail",
				dataType: "json",
				success: function(response) {
					if (response.STATUS == 'Success') {
						$("#welcome").html("Welcome back <br />" + response.DATA)
						navDialog("loginScreens", "PasswordForm");
					} else {
						navDialog("loginScreens", "SignupForm");
					}
				}
			});
			break;

		case "login" :
			// do validation here
			reqObj = {
				"action":"login",
				"email": document.getElementById("email").value, 
				"password": document.getElementById("login_password").value,
				"enablerememberme": document.getElementById("rm_login").checked
			}
			$.ajax({
				data: reqObj,
				method: "post",
				url:"api/user.cfm?action=login",
				dataType: "json",
				success: function(response) {
					if (response.STATUS == 'Success') {
						document.location.reload();
					} else {
						if (response.STATUS == "FailPassword") {
							navDialog("loginScreens", "SignupForm");
						} else {
							navDialog("loginScreens", "LoginForm");
						}
					}
				}
			});
          break;

		case "signup" :

			// do validation here

			reqObj = {
				"action":"signup", 
				"email": document.getElementById("email").value, 
				"firstname": document.getElementById("firstname").value, 
				"password": document.getElementById("signup_password").value,
				"enablerememberme": document.getElementById("rm_signup").checked
			}
			$.ajax({
				data: reqObj,
				method: "post",
				url:"api/user.cfm?action=signup",
				dataType: "json",
				success: function(response) {
					alert(response.MESSAGE);
					if (response.STATUS == 'Success') {
						document.location.reload();
					} else {
						navDialog("loginScreens", "SignupForm");
					}
				}
			});
			break;

		case "gotoPasswordScreen" :
			navDialog("loginScreens", "LoginForm");
			break;
		
		default:
			console.log("~~ Default ~~");
			console.log(action);
    }
}

function navDialog(dialog, screen) {
	var x = document.getElementsByClassName(dialog);
	for (i = 0; i < x.length; i++) {
		x[i].style.display = "none";
	}
	document.getElementById(screen).style.display = "block";
}

function navDialog(dialog, screen) {
	var x = document.getElementsByClassName(dialog);
	for (i = 0; i < x.length; i++) {
		x[i].style.display = "none";
	}
	document.getElementById(screen).style.display = "block";
}
</script>
