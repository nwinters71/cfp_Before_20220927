
<cfif 1 eq 1>

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
    <span id="account" class="w3-bar-item w3-right"><a onclick="document.getElementById('login_form').style.display='block';" class="w3-bar-item w3-right w3-text-gray" style="color:#FFF" href="#">Sign In</a></span>
    <span class="w3-bar-item w3-right"><a href="index.html" class="w3-bar-item w3-text-yellow">Research</a></span>
    <span class="w3-bar-item w3-right"><a href="table.html" class="w3-bar-item">Analyze</a></span>
    <span class="w3-bar-item w3-right"><a href="vueSearch.html" class="w3-bar-item">Schools</a></span>
    <span class="w3-bar-item w3-right"><a href="dump.cfm" class="w3-bar-item">Dump</a></span>
                <!--- <div class="dropdown show">
                  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Additional Resources
                  </a>
                  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <!-- <a class="dropdown-item" ><div><input type="text" name="searchterm" size="30" /><input type="submit" name="Submit" value="Go" /></div></a> -->
                    <a class="dropdown-item" href="#">College Test Prep</a>
                    <a class="dropdown-item" href="#">Application Essay Writing</a>
                    <a class="dropdown-item" href="#">Selecting a Major</a>
                    <a class="dropdown-item" href="#">Financial Aid</a>
                    <a class="dropdown-item" href="#">Scholarships</a>
                    <a class="dropdown-item" href="#">Internships</a>
                    <a class="dropdown-item" href="#">Summer Programs</a>
                    <a class="dropdown-item" href="#">Study Abroad</a>
                    <a class="dropdown-item" href="#">International</a>
                    <a class="dropdown-item" href="#">Transfer</a>
                  </div>
                </div> --->
  </div>
<cfelse>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="index.html"><img src="/cfpimages/golden-ticket.png" height="36" />&nbsp; <span style="font-family:courier new; font-weight:bold">College Fast Pass</span></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <!--- <button onclick="$('#rightsidebar').html('Hello World')">Say Hi!</button> --->
        <!--- <button onclick="getRightSidebar();">Say Hi!</button> --->

        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="dump.cfm" target="_blank">Dump</a></li>
            <li class="nav-item"><a class="nav-link" href="search.html">Schools</a></li>
            <li class="nav-item"><a class="nav-link" href="table.html">Analyze</a></li>
            <li class="nav-item"><a class="nav-link" href="index.html">Research</a></li>
              <!--- <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Additional Resources
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                  <!-- <a class="dropdown-item" ><div><input type="text" name="searchterm" size="30" /><input type="submit" name="Submit" value="Go" /></div></a> -->
                  <a class="dropdown-item" href="#">College Test Prep</a>
                  <a class="dropdown-item" href="#">Application Essay Writing</a>
                  <a class="dropdown-item" href="#">Selecting a Major</a>
                  <a class="dropdown-item" href="#">Financial Aid</a>
                  <a class="dropdown-item" href="#">Scholarships</a>
                  <a class="dropdown-item" href="#">Internships</a>
                  <a class="dropdown-item" href="#">Summer Programs</a>
                  <a class="dropdown-item" href="#">Study Abroad</a>
                  <a class="dropdown-item" href="#">International</a>
                  <a class="dropdown-item" href="#">Transfer</a>
                </div>
              </div> --->
             <!--- &nbsp; --->
            <li id="account" class="nav-item"><a onclick="document.getElementById('login_form').style.display='block';" class="nav-link" href="#">Sign In1</a></li>
          </ul>
        </div>
      </div>
    </nav>
</cfif>

<!-- The Modal -->

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

      <div class="w3-center"><br>
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
        <!--- <form class="w3-container" action="/action_page.php"> --->
        <div class="w3-container">
          <div class="w3-section">
            <label><b>Password:</b></label>
            <input class="w3-input w3-border" type="password" placeholder="Enter Password" id="login_password" required>
            <input class="w3-check w3-margin-top" type="checkbox" id="rm_login" value="rememberme" /> Remember me
            <button class="w3-button w3-block w3-green w3-section w3-padding" onclick="loginDialog('login')">Login</button>
          </div>
        </div>
        <!--- </form> --->
        <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
          <button  onclick="navDialog('loginScreens', 'LoginForm');" type="button" class="w3-button w3-red"><< Back</button>
          <span class="w3-right w3-padding w3-hide-small"><a href="#" onclick="loginDialog('resetpw')">Reset Password?</a></span>
        </div>
      </div>

      <div id="SignupForm" class="loginScreens" style="display:none">
        <!--- <form class="w3-container" action="/action_page.php"> --->
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
        <!--- </form> --->
<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
  <button  onclick="navDialog('loginScreens', 'LoginForm');" type="button" class="w3-button w3-red"><< Back</button>
</div>
      </div>

    </div>
  </div>



<script>
  
function loginDialog(action) {
    let reqObj = {};
    switch (action) {
      case "gotoLoginScreen" :
          navDialog("loginScreens", "LoginForm");
          break;

      case "checkEmail" :
          // do validation here
          reqObj = {"action":"checkEmail", "email": document.getElementById("email").value}
          $.ajax({
              data: reqObj,
              method: "post",
              url:"api/user.cfm?action=checkemail",
              dataType: "json",
              success: function(response) {
                // console.log(response);
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
          reqObj = {"action":"login",
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
                // console.log("Action: " + action);
                // console.log(response);
                // alert(response.MESSAGE);
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

          reqObj = {"action":"signup", 
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
        // console.log(document.getElementById("email").value);
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

// function applyVue() {

//   var testComponent = new Vue({
//     el: '#Area51',
//     data: {
//       Name: "Bob",
//     }, // end data
//     computed: {
//       sayGoodbye: function() {
//         return "Goodbye";
//       }
//     },
//     methods: {
//       sayHello: function() {
//         return "Hello";
//       },

//     },  // end methods

//     mounted: function() {
//       // console.log('Level3 component has been mounted!');
//     },
//   });

//   return testComponent;
// }

//   var x = applyVue();

</script>
