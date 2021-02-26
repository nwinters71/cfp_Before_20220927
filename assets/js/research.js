var origGrid = "";
var GridData = "";
var GridPos = 0;
var schoolCount = 8;
var sideBarData = '';
var sideBarType = "";
var sideBarId = "";
var rsbSchoolID = "";

$(document).ready(function() {

	origGrid = $("#thegrid").html();
	$.getJSON("api/getDataMin.cfm", function( data ) {
		console.log(GridData);
		GridData = data;
		GridPos = 0;
		renderGrid(GridPos);
		setJumpBehaviors();
		updateMissingLinks();
	});

	$(window).on("scroll", function() {
		let scrollPos = Math.round($(window).scrollTop(), 2);
  //			$("#rightsidebar").css("margin-top", (scrollPos + 58) + "px");  // + 58 sets the position of the firstrow so that it isn't hidden or a gap between it and the headers

		if (scrollPos < 248) {
			// $(".SchoolName").css("display", "inline");              // school name disappears without this line
			// $(".widget2").css("height", (300 - scrollPos) + "px");
			$("#idWidget2").css("height", (300 - scrollPos) + "px");
			$(".firstRow").css("margin-top", (scrollPos + 58) + "px");  // + 58 sets the position of the firstrow so that it isn't hidden or a gap between it and the headers
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

});


function getRightSidebar() {
	// if (sideBarData == '') {
	// 	var params = {"action":"getSchools", "id":GridData.SCHOOLCODES};
	// 	// console.log("getRightSidebar");
	// 	$.ajax({
	// 		url:"api/school.cfm", 
	// 		data: params,
	// 		dataType: "json",
	// 		success: function(data) {
	// 			sideBarData = data.getSchool;
	// 		}
	// 	});		
	// }
	$.ajax({
		url:"rsb.html", 
		success: function(data) {
			$("#vueRightSidebar").html(data);
			rsb = vueRightSidebar();
			enableTabs();
			setTimeout(function() { $("#tabAdmissions").trigger("click") }, 1);
			// openTab(event, 'Admissions');
		}
	});
}


function setGridBehaviors() {
	$(".browse").on("click", function() {
		let shiftVal = parseInt($(this).attr("value"));
		updateGridHeaders(shiftVal);		
	});

	$('.GridHeader').on("click", function() {
//		sideBarType = "school";
//		sideBarId = $('img', this).attr("schoolid");
//		setSideBar(sideBarType, sideBarId);
	});
	$('.GridHeader').on("mouseover", function() {
		let schoolid = $('img', this).attr("schoolid");
		if (rsbSchoolID != schoolid) {
			rsbSchoolID = schoolid;
			rsb.refreshRightSidebar(schoolid);
//			setSideBar("school", schoolid);
		}
	});
	$('#idWidget2').on("mouseleave", function() {
//		console.log("idWidget2 :: mouseleave")
//		setSideBar(sideBarType, sideBarId);
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



function setJumpBehaviors() {
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
		let vLink = "go.cfm?l=" + $(this).parent().attr("value") + '&s=' + GridData["SCHOOLS"]["DATA"][$(this).index()-1+GridPos][2];  // attr("value");
		window.open(vLink);
	});
}

// function drag(ev) {
// 	console.log(ev.target.id);
//   ev.dataTransfer.setData("text", ev.target.id);
// }
// function drugged(ev) {
// 	console.log(ev.target.id);
// 	ev.preventDefault();
// 	var data = ev.dataTransfer.getData("text");
// 	// console.log(data);
// }

function updateGridHeaders(shiftVal) {

	// Reset jump classes
	target = $(".nojump");
	target.addClass("jump");
	target.removeClass("nojump");
	setJumpBehaviors();

	// Determine GridPos
	let maxSchoolPos = GridData["SCHOOLS"]["DATA"].length - schoolCount;
	if (GridPos == maxSchoolPos && shiftVal > 0) {
		GridPos = 0;
	} else if (GridPos == 0 && shiftVal < 0) {
		GridPos = maxSchoolPos;
	} else {
		GridPos += shiftVal;
		if (GridPos > maxSchoolPos) {
			GridPos = maxSchoolPos;
		} else if (GridPos < 0) {
			GridPos = 0;
		}
	}

	let currSchool = "";
	let vParent = "";
	$(".SchoolName").each(function(index) {
		currSchool = GridData["SCHOOLS"]["DATA"][index+GridPos];
		$(this).text(currSchool[0]);
		vParent = $(this).parent();
		$("img", vParent).attr("src", "/cfpimages/school/icons/batch/" + currSchool[1]);
		$("img", vParent).attr("schoolid", currSchool[2]);
	});

	updateMissingLinks();
}


function updateMissingLinks() {
	let schoolID = "";
	let siteID = "";
	$(".SchoolName").each(function(index) {
		schoolID = GridData["SCHOOLS"]["DATA"][index+GridPos][2];
		if (GridData["MISSINGSLUGS2"].hasOwnProperty(schoolID)) {
			msSites = GridData["MISSINGSLUGS2"][schoolID].split(',');
			for (let siteIdx in msSites) {
				siteID = msSites[siteIdx];
				disableJump(schoolID, siteID);
			}
		}
	});

}

function disableJump(school, site) {
	let target = "";
	let colPos = $("img[schoolid="+school+"]").parent().parent().index();
	// console.log(colPos);
	if (colPos > -1) {
		target = $("div[site="+site+"]");
		// console.log(target);
		target = $("div", target).eq(colPos);
		target.removeClass("jump");
		target.addClass("nojump");
		target.prop("onclick", null).off("click");
		target.prop("onmouseover", null).off("mouseover");
	}
}


function renderGrid(schoolStart) {
	let start = new Date().getTime();
	let headerOutput = "";
	let gridOutput = "";
	let browseOutput = "";
	let left_offset = 260;
	let scrollPos = Math.round($(window).scrollTop(), 2);

	// BROWSE ROW
	browseOutput += '<div id="RowBrowse" class="GridRow GridRowHeader"><div class="GridCell"></div>';
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
		headerOutput += '<div class="GridHeader widget-header2" value="' + school[2] + '"><div class="header-content" style="margin-left:' + left_offset + 'px;"><img class="SchoolIcon" src="/cfpimages/school/icons/batch/' + school[1] + '" title="" schoolid="' + school[2] + '" /> <span class="SchoolName">' + school[0] + '</span></div></div>';
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
						// gridOutput += ' <div ondragstart="drag(event)" ondragover="drugged(event)" draggable="true" id="Row' + link[3] + '" value="' + link[3] + '" class="GridRow ' + firstPass + '"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfpimages/collapse.jpg" title="Collapse subsections" /> &nbsp; ';
						gridOutput += ' <div id="Row' + link[3] + '" value="' + link[3] + '" site="' + link[6] + '" class="GridRow ' + firstPass + '"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfpimages/collapse.jpg" title="Collapse subsections" /> &nbsp; ';
					} else {
						// No Sublinks
						gridOutput += ' <div value="' + link[3] + '" site="' + link[6] + '" class="GridRow ' + firstPass + '"><div class="GridCell nosublink"> <p> <img src="" />';
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
					gridOutput += '<div value="' + link[3] + '" site="' + link[6] + '" class="GridRow ' + firstPass + ' sublink subrow' + link[4] + '"><div class="GridCell sublink2"><span class="SublinkName">' + link[8] + '</span></div>';
				}

				// for (let x = 0; x < 8; x++) {
				// 	gridOutput += '<div class="jump"><img /></div>'
				// }
				gridOutput += '<div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div><div class="jump"><img /></div>'
// JUMP/NOJUMP SQUARES
/*
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
*/
// END JUMP/NOJUMP SQUARES


				gridOutput += '</div>';
			} else {
				gridOutput += ' <div id="Row' + link[0] + '" class="GridRow ' + firstPass + ' GridRowHeader"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" height="12" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfp`images/collapse.jpg" title="Collapse subsections" height="12" /> &nbsp; <span class="SiteName">' + link[8] + '</span></p></div></div>';
			}
			// $(window).scrollTop(scrollPos);
		}
	} // end if

	$("#thegrid").html(origGrid);
	$(".blankrow").after(browseOutput);
	$("#idWidget2").append(headerOutput).after(gridOutput);

	setGridBehaviors();
	
	var elapsed = new Date().getTime() - start;
	console.log("Elapsed time: " + elapsed);

}

// RIGHT SIDEBAR CODE

function xopenTab(evt, cityName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-yellow", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " w3-yellow";
}
