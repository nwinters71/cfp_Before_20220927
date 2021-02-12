<script>
$("#signout").on("click", function() {

  var tmp = $.ajax({url:"api/user.cfm?action=logout"})
              .done(function(data) {
                window.location.href = "/cfp";
              });

});
</script>


<div class="dropdown show">
  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Hi <cfoutput>#Session.user.firstname#</cfoutput>!
  </a>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <a class="dropdown-item" href="#">My Schools</a>
    <a class="dropdown-item" href="#">My Info</a>
    <hr />
    <a id="signout" class="dropdown-item" href="#">Sign Out</a>
  </div>
</div>

