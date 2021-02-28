<cfif isDefined("Session.User.UUID") AND Session.User.UUID NEQ "">
  <cfset UserUUID = Session.User.UUID />
<cfelse>
  <cfset UserUUID = cookie.CFID />
</cfif>

<cfset schoolList = "'Adelphi University','Vassar College','Amherst College','Swarthmore College','Cornell University','Dartmouth College','Columbia University','Brown University','Case Western Reserve University','University of Michigan','Massachusetts Institute of Technology','Clemson University','Rollins College','Emory University','Macalester College','University of Chicago','Johns Hopkins University','University of Notre Dame','University of Georgia','Bucknell University','Carnegie Mellon University','Georgia State University','Davidson College','Williams College','harvard university','stanford university','emory university','Georgia Institute of Technology','Auburn University','Duke University','Berry College','Vanderbilt University'" />

<cfquery name="getSchools" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
  SELECT  S.shortName, S.Icon schoolIcon, S.schoolCode
  FROM    tblSchool S
          JOIN tblUserSchools U ON S.schoolCode = U.schoolCode
  WHERE   U.UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UserUUID#" />
  ORDER   BY S.shortName
</cfquery>

<cfif getSchools.recordCount LT 8>

	<cfquery name="getSchools" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#" maxrows="8">
		SELECT  S.shortName, S.Icon schoolIcon, S.schoolCode, 1 Rank
		FROM    tblSchool S
		JOIN 	tblUserSchools U ON S.schoolCode = U.schoolCode
		WHERE   U.UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UserUUID#" />
		AND     S.ActiveFlag = 1

		UNION

		SELECT  shortName, S.Icon schoolIcon, schoolCode, 2 Rank
		FROM    tblSchool S
		WHERE   S.ActiveFlag = 1
		AND     FullName IN (#PreserveSingleQuotes(schoolList)#)
		AND     S.ActiveFlag = 1

	</cfquery>
</cfif>

<cfset schoolList = quotedValueList(getSchools.shortName) />

<cfquery name="getLinks" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
	SELECT  SortOrder, LL.Type, LL.LinkID, LL.linkCode, LL.parentCode, W.siteName, W.SiteCode, W.Icon, LL.Title LinkTitle
			, (SELECT Count(1) FROM tblLayoutLinks WHERE ParentCode = LL.LinkCode and LL.LinkCode <> '') hasSublinks
	FROM    tblLayout Y
			JOIN tblLayoutLinks LL ON Y.LayoutUUID = LL.LayoutUUID 
			LEFT JOIN tblLink L ON LL.LinkCode = L.LinkCode AND L.ActiveFlag = 1
			LEFT JOIN tblSite W ON W.SiteCode = L.SiteCode AND W.ActiveFlag = 1
	WHERE   LL.ActiveFlag = 1
	-- AND 	L.ParentCode = ''
	AND     LL.Type = 'Link'
	ORDER   BY LL.SortOrder, L.LinkID
</cfquery>


<cfquery name="getMissingSlugs2" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
	select  * 
	from    view_MissingSchoolSlugs 
	where   SchoolCode IN (#QuotedValueList(getSchools.schoolCode)#)
	and     SiteCode IN (#QuotedValueList(GetLinks.SiteCode)#)
	order   by schoolCode, siteCode
</cfquery>

<cfset missing2 = {} />
<cfset currSchool = "" />
<cfloop query="#getMissingSlugs2#">
	<cfif currSchool NEQ schoolCode>
		<cfset currSchool = schoolCode />
		<cfset missing2[currSchool] = "" />
	</cfif>
	<cfset missing2[currSchool] = listAppend(missing2[currSchool], siteCode) />
</cfloop>


<cfif isDefined("url.dump")>
  <cfdump var="#getSchools#">
  <cfabort>
<cfelse>
  <cfset resp = {} />
  <cfset resp.schools = getSchools />
  <cfset resp.schoolcodes = quotedvalueList(getSchools.SchoolCode) />
  <cfset resp.sites = getLinks />
  <!--- <cfset resp.missingslugs = missing /> --->
  <cfset resp.missingslugs2 = missing2 />
  <cfcontent reset="true" type="text/plain"><cfoutput>#serializeJSON(resp)#</cfoutput><cfabort />
</cfif>

<!--- 

********************************************
All that's needed is schoolCode and linkCode
********************************************
select *
from tblLink L
  JOIN tblSite S ON L.SiteCode = S.SiteCode
  JOIN tblSchoolSlug SS ON S.SiteCode = SS.SiteCode
where L.LinkCode = '6bua'
and  SS.SchoolCode = 'ukbfe' 
--->

<!---     <cfset left_offset = 260 />
    <cfoutput>
        <cfset firstLinkCode = rs.LinkCode[1] />
        <cfloop query="rs">
          <cfif linkCode NEQ firstLinkCode>
            <cfbreak />
          <cfelse>
            <cfset left_offset = left_offset + 50 />
            <div class="widget-header2" style="background-color:##eee; border-collapse:collapse; border-top:thin silver solid;">
              <div class="header-content" style="margin-left:#left_offset#px;">
               <img class="SchoolIcon" height="30px" src="assets/images/schools/icons/batch/#replace(schoolIcon, "jpg", "png")#" /> <span class="SchoolName">#shortName#</span>
              </div>
            </div>
          </cfif>
        </cfloop>
      </cfoutput>
</div>  --->


<cfset cfpData = arrayNew(1) />

<cfloop query="rs">
    <cfset i = currentRow />
    <cfset cfpData[i] = "#sitecode#-#parentcode#-#linkcode#-#sscode#" />
 </cfloop>

<cfset jsonGridData = serializeJSON(cfpData) />

<cfcontent reset="true" type="text/plain"><cfoutput>#jsonGridData#</cfoutput><cfabort />
