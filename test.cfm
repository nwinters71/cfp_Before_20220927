<cfquery name="getLinks" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
  SELECT  SortOrder, LL.Type, LL.LinkID, LL.linkCode, LL.parentCode, W.siteName, W.SiteCode, W.Icon, LL.Title LinkTitle
          , (SELECT Count(1) FROM tblLayoutLinks WHERE ParentCode = LL.LinkCode and LL.LinkCode <> '') hasSublinks
  FROM    tblLayout Y
          JOIN tblLayoutLinks LL ON Y.LayoutUUID = LL.LayoutUUID 
          LEFT JOIN tblLink L ON LL.LinkCode = L.LinkCode AND L.ActiveFlag = 1
          LEFT JOIN tblSite W ON W.SiteCode = L.SiteCode AND W.ActiveFlag = 1
  WHERE   LL.ActiveFlag = 1
  AND     LL.Type = 'Link'
  ORDER   BY LL.SortOrder, L.LinkID
  -- LIMIT   3
</cfquery>

<cfquery name="getSchools" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
  SELECT  S.shortName, S.Icon schoolIcon, S.schoolCode
  FROM    tblSchool S
  WHERE   shortName like '%oregon%'
  ORDER   BY S.shortName
</cfquery>

<cfdump var="#getSchools#">

<cfquery name="getMissingSlugs2" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
	select  * 
	from    view_MissingSchoolSlugs 
	<!--- where SchoolCode IN (#PreserveSingleQuotes(schoolList)#) --->
	where	SchoolCode IN (#QuotedValueList(GetSchools.SchoolCode)#)
	AND 	SiteCode IN (#QuotedValueList(GetLinks.SiteCode)#)
	order 	by schoolCode, siteCode
</cfquery>

<cfdump var="#getMissingSlugs2#">
<cfabort>



<cfloop query="getUsers">
	<cfquery name="getUsers" datasource="CFP">
		UPDATE	tblUser
		SET 	UserUUID = '#CreateUUID()#'
		WHERE	UserID = #UserID#
	</cfquery>	
</cfloop>

<cfabort>
<cfdump var="#session#">
<cfdump var="#cookie#">


