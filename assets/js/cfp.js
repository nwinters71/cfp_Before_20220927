var loggedIn = false;

$(document).ready(function() {

	// GET NAV AND FOOTER
	$.ajax({url:"nav.cfm", 
		success: function(data) {
			$("#nav").html(data);
		}
	});
	$.ajax({url:"footer.html", 
		success: function(data) {
			$("#footer").html(data);
		}
	});

	// setLoginLink();

});

function enableTabs() {
	console.log("Enabling tabs");
	$(".tablink").on("click", function() {
		// console.log("Tab Clicked");
		let tabclass = $(this).attr("tabclass");
		let tabid = $(this).attr("id");
		// console.log("tabclass: " + tabclass + " :: tabid: " + tabid);
		$("div[tabclass="+tabclass+"]").css("display", "none");
		$("button[tabclass="+tabclass+"]").css("color", "#2196F3");
		$("button[tabclass="+tabclass+"]").css("background-color", "white");
		$("#" + tabid).css("color", "#000");
		$("#" + tabid).css("background-color", "gray");
		$("#" + tabid.replace("tab", "content")).css("display", "block");
	});
}


function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
/*
function setLoginLink() {
	console.log("setLoginLink1");
	$.ajax({url:"api/user.cfm?action=check"})
	.done(function(data) {
		if (data == "true") {
			loggedIn = true;
			$.ajax({
				url:"ddAccount.cfm", 
				success: function(data) {
					$("#account").html(data);
				}
			});
		} else {
			loggedIn = false;
		}
	});
}
*/
