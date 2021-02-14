<a id="signout" href="#" class="w3-bar-item">Sign Out</a>

<cfabort>

<script>
$("#signout").on("click", function() {

  var tmp = $.ajax({url:"api/user.cfm?action=logout"})
              .done(function(data) {
                window.location.href = "/cfp";
              });

});
</script>


<div class="w3-bar-item w3-dropdown-hover" style="z-index: 1200">
  <!--- <button class="w3-button"> --->
    Hello <cfoutput>#Session.user.firstname#</cfoutput>! <i class="fa fa-caret-down"></i>
  <!--- </button> --->
  <div class="w3-dropdown-content w3-bar-block w3-blue w3-card-4">
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-text-black">My Schools</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-text-black">My Info</a>
    <a id="signout" href="javascript:void(0)" class="w3-bar-item w3-button w3-text-black">Sign Out</a>
  </div>
</div>

