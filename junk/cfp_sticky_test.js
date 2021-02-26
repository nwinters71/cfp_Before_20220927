var origGrid = "";
var GridData = "";
var GridPos = 0;
var schoolCount = 8;
var loggedIn = false;
var sideBarData = '';
var sideBarType = "";
var sideBarId = "";

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

	origGrid = $("#thegrid").html();
	$.getJSON("api/getDataMin.cfm", function( data ) {
		GridData = data;
		GridPos = 0;
		renderGrid(GridPos);
	});

	$(window).on("scroll", function() {
		let scrollPos = Math.round($(window).scrollTop(), 2);
  //			$("#rightsidebar").css("margin-top", (scrollPos + 58) + "px");  // + 58 sets the position of the firstrow so that it isn't hidden or a gap between it and the headers

		if (scrollPos < 248) {
			// $(".SchoolName").css("display", "inline");              // school name disappears without this line
			// $(".widget2").css("height", (300 - scrollPos) + "px");
			$("#idWidget2").css("height", (300 - scrollPos) + "px");
//			$(".firstRow").css("margin-top", (scrollPos + 58) + "px");  // + 58 sets the position of the firstrow so that it isn't hidden or a gap between it and the headers
		} else {
			// $(".widget2").css("height", "52px");                    // 52px is minimum height to show just school icon
			$("#idWidget2").css("height", "52px");                    // 52px is minimum height to show just school icon			
  //			$("#rightsidebar").css("margin-top", "72px");                    // 52px is minimum height to show just school icon			
  //			$("#rightsidebar").css("top", "72px");                    // 52px is minimum height to show just school icon			
  //			$("#rightsidebar").css("border", "thick red dotted");                    // 52px is minimum height to show just school icon			
			// $(".SchoolName").css("display", "none");
		}
	});

	$('.browse').on("mouseover", function() {
		this.style.backgroundColor='yellow';
		this.style.cursor='pointer';
	});
	$('.browse').on("mouseout", function() {
		this.style.backgroundColor='white';
		this.style.cursor='cursor';
	});

	setLoginLink();

	// setTimeout(function(){
	// 	getRightSidebar();
	// 	setSideBar('school', GridData.SCHOOLS.DATA[0][2]); // initiate sidebar to first school in dataset;
	// }, 400);


});


function getRightSidebar() {
	if (sideBarData == '') {
		var params = {"action":"getSchools", "id":GridData.SCHOOLCODES};
		console.log("getRightSidebar");
		// console.log(params);
		$.ajax({
			url:"api/school.cfm", 
			data: params,
			dataType: "json",
			success: function(data) {
				sideBarData = data.getSchool;
				// console.log("Data");
				console.log(sideBarData[0]);
			}
		});		
	}
	$.ajax({
		url:"rightsidebar.html", 
		success: function(data) {
			$("#rightsidebar").html(data);
			setSideBar(sideBarData[0]);
			// document.getElementById("Admissions").style.display = "block";
		}
	});
}

function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

var getSchool_StillWaiting = false;

function setSideBar(type, id) {


	// console.log("Type/ID: " + sideBarType + "::" + sideBarId);

	switch(type) {

		case "school":

		if (!getSchool_StillWaiting) {

			getSchool_StillWaiting = true;

			setTimeout(function () {
				let params = {};
				params.url = "api/school.cfm?id=" + id;
				params.dataType = "json";

				// console.log(sideBarData);
				for (x in sideBarData) {
					data = sideBarData[x];
					// console.log(data);
					if (data.schoolCode == id) {
						// console.log("Get school info");
						// console.log(data.schoolCode + " :: " + id);
						// $.ajax(params)
							// .done(function(data) {
								// console.log("data");
								// console.log(data);
								// console.log(data);
								// data = data.getSchool[0];
								// console.log("~~~~~~~~~~~~~");
								// console.log(data);

								if (data.image.length > 0) {
									$("#sb_image").attr("src", "/cfpimages/school/images/" + data.image);
									$("#sb_image").css("display", "block");
								} else {
									$("#sb_image").attr("src", "");
									$("#sb_image").css("display", "none");
								}
								$("#sb_icon").attr("src", "/cfpimages/schools/icons/batch/" + data.icon.replace("jpg", "png"));

								$("#sb_icon").attr("src", "/cfpimages/schools/icons/batch/" + data.icon.replace("jpg", "png"));
								$("#sb_schoolname").html(data.shortname);
								$("#sb_phone").html(data.phone);

								if(data.address1.length > 0) {
									$("#sb_address_line1").html(data.address1 + "<br />");
								}
								$("#sb_address_line2").html(data.city + ", " + data.state + " &nbsp;" + data.zip);
								$("#sb_map").html('<div class="mapouter" style="margin-top:10px"><div class="gmap_canvas" style="border: thick #bbb solid"><iframe width="340" height="320" id="gmap_canvas" src="https://maps.google.com/maps?q=' + escape(data.shortname) + '&t=&z=5&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></div></div>');

								$("#sb_address_line1").html(data.address1);
								$("#applcn").html(numberWithCommas(data.applcn));
								$("#applcnm").html(numberWithCommas(data.applcnm));
								$("#applcnw").html(numberWithCommas(data.applcnw));
								$("#admssn").html(numberWithCommas(data.admssn));
								$("#admssnm").html(numberWithCommas(data.admssnm));
								$("#admssnw").html(numberWithCommas(data.admssnw));
								$("#enrlt").html(numberWithCommas(data.enrlt));
								$("#enrlm").html(numberWithCommas(data.enrlm));
								$("#enrlw").html(numberWithCommas(data.enrlw));
								$("#enrlft").html(numberWithCommas(data.enrlft));
								$("#satmt25").html(data.satmt25);
								$("#satmt75").html(data.satmt75);
								$("#satvr25").html(data.satvr25);
								$("#satvr75").html(data.satvr75);
								$("#actcm25").html(data.actcm25);
								$("#actcm75").html(data.actcm75);
								$("#actmt25").html(data.actmt25);
								$("#actmt75").html(data.actmt75);
								$("#acten25").html(data.acten25);
								$("#acten75").html(data.acten75);
							
								getSchool_StillWaiting = false;
							// });
					}
				}
			}, 100);
		}

		break;

		default:
			break;
		
	}
}


function setLoginLink() {
	console.log("setLoginLink1");
	let tmp = $.ajax({url:"api/user.cfm?action=check"})
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


function setGridBehaviors() {
	$(".browse").on("click", function() {
		GridPos += parseInt($(this).attr("value"));
		if (GridPos-1 > GridData["SCHOOLS"]["DATA"].length - schoolCount - 1) {
			GridPos = 0;
		} else {
			if (GridPos < 0 || GridPos > GridData["SCHOOLS"]["DATA"].length - schoolCount) {
				GridPos = GridData["SCHOOLS"]["DATA"].length - schoolCount;
			}
		}

		renderGrid(GridPos);

//		setTimeout(function() {
//			getRightSidebar();

			// setSideBar('school', GridData.SCHOOLS.DATA[GridPos][2]); // initiate sidebar to first school in dataset;

			// console.log("Initial set sideBarType and sideBarId");
		sideBarType = "school";
		sideBarId = GridData.SCHOOLS.DATA[GridPos][2];
		setSideBar(sideBarType, sideBarId);


//		}, 1000);
	});


	$('.jump').on("mouseover", function() {
		if ($(this).hasClass("premium")) {
			$("img", this).attr("src", "/cfpimages/lock2.png");  
		} else {
			$($("#idWidget2 span.SchoolName")[$(this).index()-1]).parent().parent().css("background-color", "lightblue");
			$(".GridCell", $(this).parent()).css("background-color", "lightblue");
			$("img", this).attr("src", "/cfpimages/external.svg");
		}
	});
	$('.jump').on("mouseout", function() {
		$("img", this).attr("src", "/cfpimages/space.png");      
		if ($(".GridCell", $(this).parent()).hasClass("sublink2") == true) {
			$(".GridCell", $(this).parent()).css("background-color", "#efe");
		} else {
			$(".GridCell", $(this).parent()).css("background-color", "White");
		}
		$($("#idWidget2 span.SchoolName")[$(this).index()-1]).parent().parent().css("background-color", "#eee");
	});
	$('.jump').on("click", function() {
		let vLink = "go.cfm?l=" + $(this).parent().attr("value") + '&s=' + $(this).attr("value");
		window.open(vLink);
	});
	$('.header-content').on("click", function() {
		sideBarType = "school";
		sideBarId = $('img', this).attr("schoolid");
		setSideBar(sideBarType, sideBarId);
	});
	$('.header-content').on("mouseover", function() {
		var schoolid = $('img', this).attr("schoolid");
		setSideBar("school", schoolid);
	});
	$('.header-content').on("mouseout", function() {
		// console.log("header-content :: mouseout")
		setSideBar(sideBarType, sideBarId);
	});

	// EXPAND/COLLAPSE SITE SUBLINKS
	$('.sectionExpand').on("click", function() {
		let tmp = this.id.replace("expand_", "");
		$("#expand_" + tmp).toggle();
		$("#collapse_" + tmp).toggle();
		$("." + tmp).slideDown(250);
		$("." + tmp).css("display", "flex");
	});
	$('.sectionCollapse').on("click", function() {
		let tmp = this.id.replace("collapse_", "");
		$("#expand_" + tmp).toggle();
		$("#collapse_" + tmp).toggle();
		$("." + tmp).slideUp(250);
	});

}


function renderGrid(schoolStart) {
	let start = new Date().getTime();
	let headerOutput = "";
	let gridOutput = "";
	let browseOutput = "";
	let left_offset = 260;
	let scrollPos = Math.round($(window).scrollTop(), 2);

	// BROWSE ROW
	browseOutput += ' <div id="RowBrowse" class="GridRow GridRowHeader"><div class="GridCell"></div>';
	browseOutput += '<div class="browse" value="-7"><img height="16px" src="/cfpimages/browse-left-double.png" /></div>';
	browseOutput += '<div class="browse" value="-1"><img height="16px" src="/cfpimages/browse-left-single.png" /></div>';
	browseOutput += '<div class="browseTitle">Browse</div>';
	browseOutput += '<div class="browse" value="1"><img height="16px" src="/cfpimages/browse-right-single.png" /></div>';
	browseOutput += '<div class="browse" value="7"><img height="16px" src="/cfpimages/browse-right-double.png" /></div>';
	browseOutput += '</div>';

	let schools = [];
	for (x = schoolStart; x < schoolStart + schoolCount; x++) {
		schools[x-schoolStart] = GridData["SCHOOLS"]["DATA"][x];
	}

	// SCHOOL NAME HEADER ROW
	for (let school of schools) {
		left_offset += 50;
		headerOutput += '<div class="GridHeader widget-header2" value="' + school[2] + '"><div class="header-content" style="margin-left:' + left_offset + 'px;"><img class="SchoolIcon" src="/cfpimages/schools/icons/batch/' + school[1].replace("jpg", "png") + '" title="" schoolid="' + school[2] + '" /> <span class="SchoolName">' + school[0] + '</span></div></div>';
	}

	// 0-LinkCode, 1-ParentCode, 2-SiteName, 3-SiteCode, 4-SiteIcon, 5-LinkTitle, 6-HasSubLinks
	if (1 == 1) {
		var firstPass = "firstTime";
		for (let link of GridData["SITES"]["DATA"]) {
			if (firstPass == "firstTime") {
				firstPass = "firstRow";
			} else {
				firstPass = "";
			}
			if (link[1] == "Link") {
				if (link[4] == "") {
					// Expander   
					if (link[9] > 0) {
						gridOutput += ' <div id="Row' + link[3] + '" value="' + link[3] + '" class="GridRow ' + firstPass + '"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfpimages/collapse.jpg" title="Collapse subsections" /> &nbsp; ';
					} else {
						// No Sublinks
						gridOutput += ' <div value="' + link[3] + '" class="GridRow ' + firstPass + '"><div class="GridCell nosublink"> <p> <img src="" />';
					}
					// Icon
					if (link[7].length > 0) {
						gridOutput += '<img class="SiteIcon" src="/cfpimages/sites/icons/' + link[7] + '" /> ';
					} else {
						gridOutput += '<img class="SiteIcon" src="/cfpimages/space.png" />';
					}
					gridOutput += '<span class="SiteName">' + link[5] + '</span></p></div>';
				} else {
					// Sublink Row
					gridOutput += '<div value="' + link[3] + '" class="GridRow ' + firstPass + ' sublink subrow' + link[4] + '"><div class="GridCell sublink2"><span class="SublinkName">' + link[8] + '</span></div>';
				}
				for (let school of schools) {
					if (GridData["MISSINGSLUGS"].hasOwnProperty(link[6])) {
						if (GridData["MISSINGSLUGS"][link[6]].indexOf(school[2]) == -1) {
							gridOutput += '<div class="jump" value="' + school[2] + '"><img /></div>';
						} else {
							gridOutput += '<div class="nojump"><img /></div>';
						}
					} else {
						gridOutput += '<div class="jump" value="' + school[2] + '"><img /></div>';
					} 
				}
				gridOutput += '</div>';
			} else {
				gridOutput += ' <div id="Row' + link[0] + '" class="GridRow ' + firstPass + ' GridRowHeader"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" height="12" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfp`images/collapse.jpg" title="Collapse subsections" height="12" /> &nbsp; <span class="SiteName">' + link[8] + '</span></p></div></div>';
			}
			// $(window).scrollTop(scrollPos);
		}
	} // end if

	$("#thegrid").html(origGrid);
	$(".blankrow").after(browseOutput);
//	$("#idWidget2").append(headerOutput).after(gridOutput);

	setGridBehaviors();
	
	var elapsed = new Date().getTime() - start;
	console.log("Elapsed time: " + elapsed);

}


/*
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
Code to hide/show subrows for sections with subrows
function sectionToggle(section) {
	$(".subrow-" + section).toggle();
	$("." + section + "-expand").toggle();
	$("." + section + "-collapse").toggle();  
}
*/

