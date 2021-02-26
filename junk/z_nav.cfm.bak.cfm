

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
             &nbsp;
            <li id="account" class="nav-item"><a id="loginLink" class="nav-link" href="#">Sign In</a></li>
          </ul>
        </div>
      </div>
    </nav>


<!-- The Modal -->
<div id="login_form" class="login_modal">


  <!-- Modal content -->
  <div class="login_modal-content" style="border:thin solid magenta;">

  <!--- <form action="api/login.cfm" method="post" /> --->
  <!-- Trigger/Open The Modal -->
  <!--- <button id="myBtn">Open Modal</button> --->

    <span class="login_tablink" onclick="openPage('LoginForm', this, 'red')" id="defaultOpen">Login</span>
    <span class="login_tablink" onclick="openPage('SignupForm', this)">Sign Up</span>

    <div id="LoginForm" class="login_tabcontent">
      <!--- <h3>Login</h3> --->
      <div style="border:thin black solid; padding: 20px; margin-top: 30px;">
        <div style="font-size:18px; font-weight:bold;">Login</div>
        <cfoutput>
        <input type="hidden" name="token" value="#CSRFGenerateToken()#" />
        <input type="hidden" name="action" value="login" />
        </cfoutput>
        <p /><div style="width: 200px; display: inline-block;">Email:</div><input type="text" name="email" value="" style="width:360px;" />
        <p /><div style="width: 200px; display: inline-block;">Password:</div><input type="text" name="password" value="" style="width:360px;" />
        <p /><input type="checkbox" value="StayLoggedIn" /> Keep me logged in
         &nbsp;::&nbsp;  <a href="api/login.cfm?forgot">Forgot Password</a> 
        <p /><input type="submit" value="Login" />
      </div>
    </div>

    <div id="SignupForm" class="login_tabcontent">
      <!--- <h3>Sign Up</h3> --->
      <div style="border:thin black solid; padding: 20px; margin-top: 30px;">
        <div style="font-size:18px; font-weight:bold;">Sign Up</div>
        <cfoutput>
        <input type="hidden" name="token" value="#CSRFGenerateToken()#" />
        <input type="hidden" name="action" value="signup" />
        </cfoutput>
        <p /><div style="width: 200px; display:inline-block">Email:</div> <input type="text" name="email" value="" style="width:360px;" />
        <p /><div style="width: 200px; display: inline-block;">Password:</div> <input type="password" name="password" style="width:360px;" />
        <!--- <p /><div style="width: 200px; display: inline-block;">Confirm Password:</div> <input type="password" name="password2" value="" size="50" /> --->
        <p /><input type="checkbox" value="StayLoggedIn" /> I agree to <a href="terms.html" />College Fast Pass Terms</a>
        <p /><input type="submit" value="Signup" />
      </div>
    </div>

  <!--- </form> --->

  </div>

</div>


<style>

/* MODAL LOGIN FORM*/
/* The Modal (background) */
.login_modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 9999; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.login_modal-content {
  background-color: #fefefe;
  margin: 5% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 600px; /* Could be more or less, depending on screen size */
  height:500px;
}

/* The Close Button */
.login_close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}





/* Style tab links */
.login_tablink {
  display: block;
  background-color: #555;
  color: cyan;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 17px;
  width: 50%
}

.login_tablink:hover {
  background-color: #777;
}

/* Style the tab content (and add height:100% for full page content) */
.login_tabcontent {
  /*color: white;*/
  display: none;
  padding: 10px;
  height: 100%;
}

/*#LoginForm {background-color: red;}*/
/*#SignupForm {background-color: green;}*/
</style>

<script>
  function openPage(pageName, elmnt) {
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("login_tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }

    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("login_tablink");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].style.backgroundColor = "";
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
  }

  // Get the element with id="defaultOpen" and click on it
  document.getElementById("defaultOpen").click();
</script>

<script src="./assets/js/login.js" language="JavaScript" type="text/javascript"></script>
