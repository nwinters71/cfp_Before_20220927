/*
  $("#tblDatatr:has(td)").click(function(e) {
  $("#tblData td").removeClass("highlight");
  var clickedCell= $(e.target).closest("td");
  clickedCell.addClass("highlight");
  $("#spnText").html(
    'Clicked table cell value is: <b> ' + clickedCell.text() + '</b>');
  });
*/

var origGrid = "";
var GridData = "";
var GridPos = 0;
var schoolCount = 8;
var loggedIn = false;

$(document).ready(function() {
  //alert("Loaded!");
  
  // console.log($("#idWidget2:nth-child(3)").html());
  //jsonTest();
  // colleges = jsonColleges();


  // Get Nav
  $.ajax({
    url:"nav.cfm", 
    success: function(data) {
      $("#nav").html(data);
    }
  });

  $.ajax({
      url:"footer.html", 
      success: function(data) {
        $("#footer").html(data);
      }
    });

  origGrid = $(".thegrid").html();
  
  $.getJSON( "api/getDataMin.cfm", function( data ) {

    GridData = data;

    GridPos = 0;

    renderGrid(GridPos);


    $(".vertical").mouseover(function(e) {
      $(this).css("cursor", "pointer");   
    });
    $("#tblDatatr:has(.jump)").mouseover(function(e) {
      $(this).css("cursor", "pointer");   
    });

    $('.size').styleddropdown();
  });

  $(window).on("scroll", function() {
    var scrollPos = Math.round($(window).scrollTop(), 2);
    // $(".msg").html(scrollPos);
    if (scrollPos < 248) {
      // $(".SchoolName").css("display", "inline");              // school name disappears without this line
      $(".widget2").css("height", (300 - scrollPos) + "px");
      $(".firstRow").css("margin-top", (scrollPos + 58) + "px");  // + 58 sets the position of the firstrow so that it isn't hidden or a gap between it and the headers
    } else {
      $(".widget2").css("height", "52px");                    // 52px is minimum height to show just school icon
      // $(".SchoolName").css("display", "none");
    }
  });
  
  $('.browse').on("mouseover", function() {
      this.style.backgroundColor='yellow';
      this.style.cursor='pointer';
      // $("img", this).attr("src", "/cfpimages/external.svg");
  });
  $('.browse').on("mouseout", function() {
      this.style.backgroundColor='white';
      this.style.cursor='cursor';
  });

  setLoginLink();          

  // var tmp = $.ajax({url:"api/user.cfm?action=check"})
  //             .done(function(data) {
  //               setLoginLink();          
  //             });

  // console.log("LoginLink Set");


  $("#zzzzlogin").on("click", function() {
    if (loggedIn == true) {
      // loggedIn = false;
      var tmp = $.ajax({url:"api/user.cfm?action=logout"})
                  .done(function(data) {

                    setLoginLink();
                  });
    } else {
      // alert("Please log in"); 
      window.location.href = 'login_form.cfm';
      // loggedIn = true;
    }
    // formObj = {};
    // var tmp = $.ajax({url:"login/loginCrud.cfm?action=check"}).done(function(data) {console.log(data);});
    // console.log(tmp);
    // alert("Login Link Clicked");    
    return false;
  });

});


function getRightSidebar() {
    $.ajax({
      url:"rightsidebar.html", 
      success: function(data) {
        $("#rightsidebar").html(data);
        document.getElementById("Admissions").style.display = "block";
      }
    });
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


function setSideBar(type, id) {

  switch(type) {

    case "school":
      var params = {};
      params.url = "api/school.cfm?id=" + id;
      params.dataType = "json";

      var tmp = $.ajax(params)
              .done(function(data) {
                data = data[0];
                // $("#rightsidenav").html('<h3 style="color:maroon">' + type + '</h2><hr /><h3>' + id + '</h3>');

                console.log(data);
                $("#sb_icon").attr("src", "http://localhost:8888/cfpimages/schools/icons/batch/" + data.icon.replace("jpg", "png"));
                $("#sb_schoolname").html(data.shortname);
                $("#sb_phone").html(data.phone);
                if(data.address1.length > 0) {
                  $("#sb_address_line1").html(data.address1 + "<br />");
                }
                $("#sb_address_line2").html(data.city + ", " + data.state + " &nbsp;" + data.zip);
                $("#sb_map").html('<div class="mapouter" style="margin-top:10px"><div class="gmap_canvas" style="border: thick #bbb solid"><iframe width="340" height="320" id="gmap_canvas" src="https://maps.google.com/maps?q=' + escape(data.shortname) + '&t=&z=5&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></div></div>');

                // test scores
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

              });
      break;
      default:
      break;
  }
}


function setLoginLink() {
  console.log("setLoginLink1");
  let tmp = $.ajax({url:"api/user.cfm?action=check&a=1"})
              .done(function(data) {
                console.log("sll: ");
                console.log("@" + data + "@");
                if (data == "true") {                
                   console.log("data == true");                
                  loggedIn = true;

                  // Get Nav
                  $.ajax({
                      url:"ddAccount.cfm", 
                      success: function(data) {
                        // console.log("setLoginLink");
                        // console.log(data);
                        $("#account").html(data);
                      }
                    });
                } else {
                  console.log("data == false");
                  loggedIn = false;
                  // $("#account").html("Sign In3");
                }
              });
}


function setGridBehaviors() {

  $(".btnToggle").on("click", function() {

  });

  $(".browse").on("click", function() {
    GridPos += parseInt($(this).attr("value"));
    // console.log(GridPos + '==' + GridData["SCHOOLS"]["DATA"].length + '-' + schoolCount + '- 1');
    if (GridPos-1 > GridData["SCHOOLS"]["DATA"].length - schoolCount - 1) {
      GridPos = 0;
    } else {
      console.log(" - GridPos2: " + GridPos);
      if (GridPos < 0 || GridPos > GridData["SCHOOLS"]["DATA"].length - schoolCount) {
        GridPos = GridData["SCHOOLS"]["DATA"].length - schoolCount;
      }
    }

    renderGrid(GridPos);

    setTimeout(function(){
        getRightSidebar();
        setSideBar('school', GridData.SCHOOLS.DATA[GridPos][2]); // initiate sidebar to first school in dataset;
    }, 2000);


  });

  $('.jump').on("mouseover", function() {
      if ($(this).hasClass("premium")) {
        $("img", this).attr("src", "/cfpimages/lock2.png");  
        // highlightHeaders(this, "#9d9", "100%");
        // this.style.backgroundColor='#9d9';
      } else {
        $($("#idWidget2 span.SchoolName")[$(this).index()-1]).parent().parent().css("background-color", "lightblue");
        // console.log($(this).attr("class"));
        $(".GridCell", $(this).parent()).css("background-color", "lightblue");
        $(this).css("background-color", "lightblue");
        this.style.cursor='pointer';
        $("img", this).attr("src", "/cfpimages/external.svg");
      }
  });

  $('.jump').on("mouseout", function() {
      // highlightHeaders(this, "black", "100%");
      this.style.backgroundColor='white';
      $("img", this).attr("src", "/cfpimages/space.png");      
      // $(this).parent().css("background-color", "white");
      if ($(".GridCell", $(this).parent()).hasClass("sublink2") == true) {
        $(".GridCell", $(this).parent()).css("background-color", "#efe");
      } else {
        $(".GridCell", $(this).parent()).css("background-color", "White");
      }
      $($("#idWidget2 span.SchoolName")[$(this).index()-1]).parent().parent().css("background-color", "#eee");
  });
  
  $('.SchoolIcon').on("mouseover", function() {
      // console.log($(this).parent().parent().index());
  });


  $('.header-content').on("mouseover", function() {
    // $('.header-content').css("background-color", "#00ff00");
  });

  $('.header-content').on("click", function() {
    var schoolid = $('img', this).attr("schoolid");
    setSideBar("school", schoolid);
  });


  $('.jump').on("click", function() {
    // console.log($(this).parent().attr("value") + " :: " + $(this).attr("value"));

    // var vLink = "go.cfm?" + $(this).parent().attr("value").replace("^", $(this).attr("value"));
    var vLink = "go.cfm?l=" + $(this).parent().attr("value") + '&s=' + $(this).attr("value");
    // console.log(vLink);

    window.open(vLink);
    return;
      // $(this).css("background-color", "blue");
    // $("#explain").text('Hello World');
      // if($(this).hasClass("premium") === false) {
      //   try {
      //     if ($(this).parent().attr("value").indexOf("^") != -1) {
      //       window.open($(this).parent().attr("value").replace("^", $(this).attr("value")));
      //     }
      //   } catch(err) {
      //     window.open($(this).attr("value"));
      //   }
      // }
    /* else {
        window.open($(this).attr("value") + $(this).parent().attr("value"));        
      }*/      
  });



  $('.sectionExpand').on("click", function() {
      var tmp = this.id.replace("expand_", "");
      $("#expand_" + tmp).toggle();
      $("#collapse_" + tmp).toggle();
      $("." + tmp).slideDown(250);
      $("." + tmp).css("display", "flex");
  });
  $('.sectionCollapse').on("click", function() {
      var tmp = this.id.replace("collapse_", "");
      $("#expand_" + tmp).toggle();
      $("#collapse_" + tmp).toggle();
      // $("." + tmp).css("display", "none");
      $("." + tmp).slideUp(250);
  });

}

function highlightHeaders(TD, color, fs) {
}
  

// Code to hide/show subrows for sections with subrows
function sectionToggle(section) {
  $(".subrow-" + section).toggle();
  $("." + section + "-expand").toggle();
  $("." + section + "-collapse").toggle();  
}


// Pop up menu code
(function($) {
  $.fn.styleddropdown = function() {
    return this.each(function() {
      var obj = $(this)      
      obj.find('.list li').click(function() { //onclick event, change field value with selected 'list' item and fadeout 'list'
        window.open($(this).parent().parent().attr("baseurl") + $(this).attr("value"));        
      });
    });
  };
})(jQuery);  
  
/*
function selectCell(TD) {
		if(TD.hasClass("tdSiteSelected")) {		
			TD.removeClass("tdSiteSelected");      
			$("#usnwrList").hide();
		} else {
			$(".tdSiteSelected").removeClass("tdSiteSelected");
			TD.addClass("tdSiteSelected");
      thisPos = TD.position();
      if(TD.hasClass("usnwr"))
        obj = $("#usnwrList");
      if(TD.hasClass("niche"))
        obj = $("#nicheList");      
      obj.css("left", thisPos.left);
      obj.css("top", thisPos.top);
      obj.find('.list').fadeIn(0);

      $(document).keyup(function(event) { //keypress event, fadeout on 'escape'
        if(event.keyCode == 27) {
          obj.find('.list').fadeOut(0);
        }
      });

      obj.find('.list').hover(function(){ },
      function() {
        $(this).fadeOut(0);
      });     
			$("#usnwrList").show();
		}
}
*/
  

function renderGrid(schoolStart) {

    var headerOutput = "";
    var gridOutput = "";
    var browseOutput = "";

console.log("schoolStart: " + schoolStart);

    browseOutput += ' <div id="RowBrowse" class="GridRow GridRowHeader"><div class="GridCell"> <p> &nbsp; <span class="SiteName"> &nbsp; </span></p></div>';
    browseOutput += '<div class="browse" value="-7"><img height="16px" src="/cfpimages/browse-left-double.png" /></div>';
    browseOutput += '<div class="browse" value="-1"><img height="16px" src="/cfpimages/browse-left-single.png" /></div>';
    browseOutput += '<div class="browse" style="width:200px; text-align:center; font-family:calibri; font-weight: bold; font-size:18px;">Browse</div>';
    browseOutput += '<div class="browse" value="1"><img height="16px" src="/cfpimages/browse-right-single.png" /></div>';
    browseOutput += '<div class="browse" value="7"><img height="16px" src="/cfpimages/browse-right-double.png" /></div>';
    browseOutput += '</div>';

    var left_offset = 260;

    var scrollPos = Math.round($(window).scrollTop(), 2);

console.log(GridData);

    // console.log("schoolStart: " + schoolStart);
    
    // schoolStart = 18;
    schools = [];
    for (x = schoolStart; x < schoolStart + schoolCount; x++) {
      schools[x-schoolStart] = GridData["SCHOOLS"]["DATA"][x];
    }

console.log("schools:");
console.log(schools);

    for (let school of schools) {
      // if (school.lenght != 2) {
      //   break;
      // }
      // school = GridData["SCHOOLS"]["DATA"][x];
      // console.log("Check it:");      
      // console.log(school);
      left_offset += 50;
      headerOutput += '<div class="GridHeader widget-header2" value="' + school[2] + '"><div class="header-content" style="margin-left:' + left_offset + 'px;"><img class="SchoolIcon" width="30px" height="30px" src="/cfpimages/schools/icons/batch/' + school[1].replace("jpg", "png") + '" title="" schoolid="' + school[2] + '" /> <span class="SchoolName">' + school[0] + '</span></div></div>';
    }
    // console.log(headerOutput);


/*
  0-LinkCode, 1-ParentCode, 2-SiteName, 3-SiteCode, 4-SiteIcon, 5-LinkTitle, 6-HasSubLinks 
*/

    if (1 == 1) {
      var firstPass = "firstTime";
      for (let link of GridData["SITES"]["DATA"]) {        
        // console.log(link);
          if (firstPass == "firstTime") {
            firstPass = "firstRow";
          } else {
            firstPass = "";
          }

        if (link[1] == "Link") {
          // console.log("Link");
        // if (link[.type] ==)      
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
              // gridOutput += '<img style="margin-left:10px;" src="" height="16" /> ';
              gridOutput += '<img style="height:16px" src="/cfpimages/space.png" />';
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
          // console.log("Header");
          gridOutput += ' <div id="Row' + link[0] + '" class="GridRow ' + firstPass + ' GridRowHeader"><div class="GridCell"> <p> <img id="expand_subrow' + link[3] + '" class="sectionExpand" src="/cfpimages/expand.jpg" title="Expand to view subsections of this site" height="12" /><img id="collapse_subrow' + link[3] + '" class="sectionCollapse" src="/cfp`images/collapse.jpg" title="Collapse subsections" height="12" /> &nbsp; <span class="SiteName">' + link[8] + '</span></p></div></div>';
        }

        // $(window).scrollTop(scrollPos);

      }
      
    
    }  // end if

    $(".thegrid").html(origGrid);
    $(".blankrow").after(browseOutput);
    $("#idWidget2").append(headerOutput).after(gridOutput);


    setGridBehaviors();

}


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


