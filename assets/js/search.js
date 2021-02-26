
var flgBehaviorAdded = false;

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

function mySchools() {

	var params = {};
	console.log("myschools");
	params.action = "myschools";
	$.ajax({
				url:"api/search.cfm",
				dataType: "json",
				type: "post",
				data: params
			})
			.done(function(data) {
				console.log(data);
				results = "";
				for (let school of data) {
					if (school.UserUUID.length > 0) {
						results = results + '<tr><td><input type="checkbox" checked class="cbSchoolID" id="schools" value="' + school.SchoolCode + '" /> ' + school.FullName + '</td><td nowrap>' + school.City + ', ' + school.State + '</td><td align="center">' + school.enrlt + '</td><td nowrap align="center">' + school.satmt25 + ' - ' + school.satmt75 + '</td></tr>'
					} else {
						results = results + '<tr><td><input type="checkbox" class="cbSchoolID" id="schools" value="' + school.SchoolCode + '" /> ' + school.FullName + '</td><td nowrap>' + school.City + ', ' + school.State + '</td><td align="center">' + school.enrlt + '</td><td nowrap align="center">' + school.satmt25 + ' - ' + school.satmt75 + '</td></tr>'
					}
				}
				$("#tblSearchResults>tbody").html(results);
				if (data == "false") {
					loggedIn = false;
					$("#login").html("Sign In");
				} else {
					loggedIn = true;
					$("#login").html("Log Out");
				}
				console.log(typeof addBehavior);
				if (!flgBehaviorAdded) {
					addBehavior();
				}
			});
}


function doSearch() {
	var params = {};
	params.action = "search";
	params.keyword = $("#keyword").val();
	params.state = "GA";
	// console.log(params);
	$.ajax({
			url:"api/search.cfm",
			dataType: "json",
			type: "post",
			data: params
	})
	.done(function(data) {
		// console.log(data);
		results = "";
		for (let school of data) {
			if (school.UserUUID ==  1) {
				results = results + '<tr><td><input type="checkbox" checked class="cbSchoolID" id="schools" value="' + school.SchoolCode + '" /> ' + school.FullName + '</td><td nowrap>' + school.City + ', ' + school.State + '</td><td align="center">' + school.enrlt + '</td><td nowrap align="center">' + school.satmt25 + ' - ' + school.satmt75 + '</td></tr>'
			} else {
				results = results + '<tr><td><input type="checkbox" class="cbSchoolID" id="schools" value="' + school.SchoolCode + '" /> ' + school.FullName + '</td><td nowrap>' + school.City + ', ' + school.State + '</td><td align="center">' + school.enrlt + '</td><td nowrap align="center">' + school.satmt25 + ' - ' + school.satmt75 + '</td></tr>'
			}
		}
		// console.log(results);
		$("#tblSearchResults>tbody").html(results);
		if (data == "false") {
			loggedIn = false;
			$("#login").html("Sign In");
		} else {
			loggedIn = true;
			$("#login").html("Log Out");
		}

		console.log(typeof addBehavior);

		if (!flgBehaviorAdded) {
			addBehavior();
		}
	});
}

function addBehavior() {
	$("table#tblSearchResults").on("click", ".cbSchoolID", function(){
		let params = {};
		params.type = "school";
		params.action = ((this.checked == true) ? 'add' : 'remove');
		params.schoolcode = this.value;
		$.ajax({
			url:"api/faves.cfm",
			data:params,
			type:"post",
			success: function(data) {}          
		});
	});

	flgBehaviorAdded = true;

/*
  console.log(document.cookie);
  console.log($.cookie("LUCEE_ADMIN_LANG"));
  for (c in document.cookie) {
      console.log(c);
  }
  alert($(this).text());
*/

}





$( function() {

    $( "#sliderSATcomp" ).slider({
      range: true,
      min: 400,
      max: 1600,
      step: 10,
      values: [ 800, 1600 ]
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
      values: [ 400, 800 ],
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
      values: [ 400, 800 ],
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
      values: [ 18, 36 ],
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

    mySchools();
    console.log("All done");

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


