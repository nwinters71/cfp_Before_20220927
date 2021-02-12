<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>College Fast Pass</title>

    <!-- Bootstrap core CSS -->
    <link href="./assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="./assets/css/portfolio-item.css" rel="stylesheet">

<script src="./assets/vendor/jquery/jquery.min.js" language="JavaScript" type="text/javascript"></script>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js" language="JavaScript" type="text/javascript"></script> -->
<script src="./assets/js/cfp.js" language="JavaScript" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="./assets/css/cfp.css">


<script>

function toggle(id) {
  $("#"+id).slideToggle();  
}
function allToggle(id) {  
  if ($("#"+id).css("height") == "104px") {
    $("#"+id).css("height", "auto");
  } else {    
    $("#"+id).css("height", "104px");
  }
}

function doSearch() {
  var tmp = $.ajax({url:"ap/search.cfm/loginCrud.cfm?action=check"})
              .done(function(data) {                
                if (data == "false") {
                  loggedIn = false;
                  $("#login").html("Sign In");
                } else {
                  loggedIn = true;
                  $("#login").html("Log Out");
                }
              });
}



</script>

<style>
  #demo-frame > div.demo { padding: 10px !important; } 

</style>



<script>
$( function() {
    $( "#sliderSATcomp" ).slider({
      range: true,
      min: 400,
      max: 1600,
      step: 10,
      values: [ 800, 1200 ]
      ,slide: function( event, ui ) {
        $("#satcomp").val( ui.values[0] + " - " + ui.values[1] );
      }
    });
    $("#satcomp").val( $("#sliderSATcomp").slider("values", 0) + " - " + $("#sliderSATcomp").slider("values", 1));
    $( "#sliderSATmath" ).slider({
      range: true,
      min: 200,
      max: 800,
      step: 10,
      values: [ 400, 600 ],
      slide: function( event, ui ) {
        $("#satmath").val( ui.values[0] + " - " + ui.values[1] );
      }
    });
    $("#satmath").val( $("#sliderSATmath").slider("values", 0) + " - " + $("#sliderSATmath").slider("values", 1));
    $( "#sliderSATebrw" ).slider({
      range: true,
      min: 200,
      max: 800,
      step: 10,
      values: [ 400, 600 ],
      slide: function( event, ui ) {
        $("#satebrw").val( ui.values[0] + " - " + ui.values[1] );
      }
    });
    $("#satebrw").val( $("#sliderSATebrw").slider("values", 0) + " - " + $("#sliderSATebrw").slider("values", 1));
    $( "#sliderACTcomp" ).slider({
      range: true,
      min: 1,
      max: 36,
      step: 1,
      values: [ 18, 24 ],
      slide: function( event, ui ) {
        $("#actcomp").val( ui.values[0] + " - " + ui.values[1] );
      }
    });
    $("#actcomp").val( $("#sliderACTcomp").slider("values", 0) + " - " + $("#sliderACTcomp").slider("values", 1));

    $(".sliderText").attr("disabled", "disabled");


    $(".testscores").click(function(id) { 
      console.log(id.target.value);
      if( $("#" + id.target.value).hasClass("ui-state-disabled")) {
        console.log("break1");
      $("#" + id.target.value).removeClass("ui-state-disabled");
      } else {
        console.log("break2");
        $("#" + id.target.value).addClass("ui-state-disabled")
      }
     });

 });

function toggle(id) {
  $("#"+id).slideToggle();  
}
function allToggle(id) {  
  if ($("#"+id).css("height") == "104px") {
    $("#"+id).css("height", "auto");
  } else {    
    $("#"+id).css("height", "104px");
  }
}

</script>

<style>
  #demo-frame > div.demo { padding: 10px !important; } 

  #searchOptions {
    font-family: Lato,Helvetica,Arial,sans-serif;
    font-size: 13px;
    width: 332px;
    background-color: #eee;
    border: thin gray solid;
    padding: 14px;
  }
  #searchResults {
    font-family: Lato,Helvetica,Arial,sans-serif;
    font-size: 13px;
    padding: 14px;
    margin-top: 90px;
  }
  .section {
    margin: 18px 0px 10px 2px;    
    font-weight: bold;
    white-space: nowrap;
    font-size:14px;
  }
  .label {
    margin: 14px 0px 3px 2px;   
    font-weight: normal;
    white-space: nowrap;
  }
  .searchcontainer {
    background-color: white;
    border: thin gray solid;
    height: 104px;
    overflow-y: auto;
    width: 300px;
    padding: 4px;
    box-sizing: border-box;
  }
  .searchInput {
    width: 300px;
  }
  .label:first-child {
    margin-top: 0px;
  }
  .sliderText {
    font-size: 13px; 
    text-align: center; 
    border:0; 
    width:160px; 
    background-color:#fff
  }
</style>





</head>

<body>

    <!-- Navigation -->
    <div id="nav"></div>

    <!-- Page Content -->
    <div class="container">


      <!-- Portfolio Item Row -->
      <div class="row">



<!-- <div id="leftsidenav" class="col-md-4"> -->
<div class="col-md-4">
<div id="searchOptions">

  <div class="label"><strong>School Name:</strong></div>
  <div><input class="searchInput" id="schoolname" type="text" size="20" /></div>

  
  <div class="section" onclick="toggle('admissions')">Admissions Criteria</div>
    <div id="admissions">
      <div class="label">Acceptance Rate:</div>
      <div class="searchcontainer" style="height: auto;">
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> <10%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 40%-50%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 10%-20%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 50%-60%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 20%-30%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 60%-80%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 30%-40%</span>
        <span style="float:left; width: 140px"><input id="population" type="checkbox" value="AL" /> 80%+</span>
      </div>    
    
      <div class="label">Test Scores:</div>
      <div class="searchcontainer" style="height:auto">
        <div class="label">SAT</div>
        <table border="0" cellspacing="0" cellpadding="8" width="100%">
          <tr valign="top">
            <td width="110px"><div class="label" style="margin: -4px 0px 0px -5px;"><input class="testscores" type="checkbox" value="sliderSATcomp" /> Composite:</div><div id="amount" /></div></td>
            <td width="100%" align="center"><div id="sliderSATcomp" class="ui-state-disabled"></div>
              <div style="margin-top:4px;"><input type="input" id="satcomp" class="sliderText" /></div></td>
          </tr>
          <tr valign="top">
            <td><div class="label" style="margin: -4px 0px 0px -5px;"><input class="testscores" type="checkbox" value="sliderSATmath" /> Math:</div><div id="amount" /></div></td>
            <td width="100%" align="center"><div id="sliderSATmath" class="ui-state-disabled"></div>
              <div style="margin-top:4px;"><input type="input" id="satmath" class="sliderText" /></div></td>
          </tr>
          <tr valign="top">
            <td><div class="label" style="margin: -4px 0px 0px -5px;"><input class="testscores" type="checkbox" value="sliderSATebrw" /> EBRW:</div><div id="amount" /></div></td>
            <td width="100%" align="center"><div id="sliderSATebrw" class="ui-state-disabled"></div>
              <div style="margin-top:4px;"><input type="input" id="satebrw" class="sliderText" /></div></td>
          </tr>
        </table>
        <div class="label">ACT</div>
        <table border="0" cellspacing="0" cellpadding="8" width="100%">
          <tr valign="top">
            <td width="110px"><div class="label" style="margin: -4px 0px 0px -5px;"><input class="testscores" type="checkbox" value="sliderACTcomp" /> Composite:</div><div id="amount" /></div></td>
            <td width="100%" align="center"><div id="sliderACTcomp" class="ui-state-disabled"></div>
              <div style="margin-top:4px;"><input type="input" id="actcomp" class="sliderText" /></div></td>
          </tr>
        </table>
      </div>
    </div>


  <div class="section" onclick="toggle('community')">Community</div>
  <div id="community">
    <div class="label">School Size:</div>
    <div class="searchcontainer" style="height: auto;">
        <input id="population" type="checkbox" value="AL" /> Very Small (<1,000 students)
      <br /><input id="population" type="checkbox" value="AL" /> Small (1,000-2,000 students)
      <br /><input id="population" type="checkbox" value="AL" /> Medium (2,000-5,000 students)
      <br /><input id="population" type="checkbox" value="AL" /> Large (5,000-10,000 students)
      <br /><input id="population" type="checkbox" value="AL" /> Very Large (10,000+ students)
    </div>
    <div class="label">School Setting:</div>
    <div class="searchcontainer" style="height: auto;">
        <input id="population" type="checkbox" value="AL" /> Urban
      <br /><input id="population" type="checkbox" value="AL" /> Suburban
      <br /><input id="population" type="checkbox" value="AL" /> Rural
    </div>
  </div>

  <div class="section" onclick="toggle('location')">Location</div>
  <div id="location">
    <div class="label">State(s):</div>
    <div id="conState" class="searchcontainer">
      <input id="state" type="checkbox" value="AL" /> Alabama
      <br /><input id="state" type="checkbox" value="AK" /> Alaska
      <br /><input id="state" type="checkbox" value="AK" /> Arkansas
      <br /><input id="state" type="checkbox" value="CA" /> California
      <br /><input id="state" type="checkbox" value="CO" /> Colorado
      <br /><input id="state" type="checkbox" value="DE" /> Delaware
      <br /><input id="state" type="checkbox" value="FL" /> Florida
      <br /><input id="state" type="checkbox" value="GA" /> Georgia
      <br /><input id="state" type="checkbox" value="HI" /> Hawaii
      <br /><input id="state" type="checkbox" value="IL" /> Illinois
      <br /><input id="state" type="checkbox" value="IN" /> Indiana
      <br /><input id="state" type="checkbox" value="KS" /> Kansas
      <br /><input id="state" type="checkbox" value="KY" /> Kentucky
    </div> <div style="float:right" onclick="allToggle('conState')">Show all states</div>
    <div class="label">Region(s):</div>
    <div class="searchcontainer">
      <input id="region" type="checkbox" value="AL" /> Northeast
      <br /><input id="region" type="checkbox" value="AK" /> Mid-Atlantic
      <br /><input id="region" type="checkbox" value="AK" /> Southeast
      <br /><input id="region" type="checkbox" value="CA" /> Midwest
      <br /><input id="region" type="checkbox" value="CO" /> Southwest
      <br /><input id="region" type="checkbox" value="DE" /> Northwest
      <br /><input id="region" type="checkbox" value="FL" /> Pacific
    </div>
  </div>
  <div class="label">Designation(s):</div>
  <div class="searchcontainer" style="height: auto;">
      <input id="designation" type="checkbox" value="AL" /> Liberal Arts Colleges (LAC)
    <br /><input id="designation" type="checkbox" value="AL" /> Annapolis Group of LAC
    <br /><input id="designation" type="checkbox" value="AL" /> Women's Only Colleges 
    <br /><input id="designation" type="checkbox" value="AL" /> HBCU
    <br /><input id="designation" type="checkbox" value="AL" /> Ivy League Schools 
    <br /><input id="designation" type="checkbox" value="AL" /> Public Ivies 
    <br /><input id="designation" type="checkbox" value="AL" /> Schools with Honors Colleges/Programs 
    <br /><input id="designation" type="checkbox" value="AL" /> State Flagship Schools 
    <br /><input id="designation" type="checkbox" value="AL" /> CTCL (Colleges That Change Lives)
    <br /><input id="designation" type="checkbox" value="AL" /> Stamps Scholarship Schools 
    <br /><input id="designation" type="checkbox" value="AL" /> Questbridge Schools 
  </div>
</div>
</div>




<!-- </div> -->   <!-- leftsidenav -->

<style>
  .postcard {
    margin-top:14px;
    border: thin gray solid;
    background-color: #eee;
    padding: 10px;
  }
  .postcard:first-child {
    margin-top:-14px;    
  }

</style>


<div class="col-md-8" style="clear:both; border: thick red solid">
<div id="searchResults">

  <table cellspacing="0" cellpadding="8" border="1" width="100%" id="tblSearchResults">
    <!-- <thead> -->
      <tr>
        <th width="100%">School</th>
        <th nowrap align="center">City</th>
        <th nowrap align="center"># of Undergrads</th>
        <th>SAT Range</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><input type="checkbox" id="schools" value="1" /> Harvard University</td>
        <td nowrap>Cambridge, MA</td>
        <td align="center">6,244</td>
        <td nowrap align="center">1480 - 1600</td>
      </tr>
      <tr>
        <td><input type="checkbox" id="schools" value="1" /> Yale University</td>
        <td nowrap>New Haven, CT</td>
        <td align="center">6,075</td>
        <td nowrap align="center">1460 - 1580</td>
      </tr>
      <tr>
        <td><input type="checkbox" id="schools" value="1" /> Princeton University</td>
        <td>Princeton, NJ</td>
        <td align="center">5,424</td>
        <td nowrap align="center">1460 - 1560</td>
      </tr>
    </tbody>
  </table>
  <!--div class="postcard">
    Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
  </div>
  <div class="postcard">
    Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
  </div>
  <div class="postcard">
    Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
  </div>
  <div class="postcard">
    Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
    <br />Hello World
  </div-->

</div>  
</div>

  </div> <!-- /.row -->

</div> <!-- /.container -->


<!-- Footer -->
<div id="footer"></div>


</body>
</html>
