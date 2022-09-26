<!--- <cfquery name="getURL" datasource="CFP">
	SELECT 	if(BaseURL='', Slug, Replace(BaseURL, '^', Slug)) URL
	FROM	tblSchoolSlug SS
			JOIN tblSite W ON SS.SiteCode = W.SiteCode
			JOIN tblLink L ON L.SiteCode = W.SiteCode
	WHERE	linkCode = <cfqueryparam cfsqltype="cf_sql_char" maxlength="4" value="#url.l#">
	AND		ssCode = <cfqueryparam cfsqltype="cf_sql_char" maxlength="6" value="#url.s#">
</cfquery> --->

<!--- <cfoutput><a href="#getURL.URL#">#getURL.URL#</a></cfoutput><cfabort /> --->

<!--- Get Link --->
<cfquery name="getURL" datasource="CFP">
	select 	if(BaseURL='', Slug, Replace(BaseURL, '^', Slug)) URL, SS.SiteCode
	from 	tblLink L
			JOIN tblSite S ON L.SiteCode = S.SiteCode
			JOIN tblSchoolSlug SS ON S.SiteCode = SS.SiteCode
	where 	L.LinkCode = <cfqueryparam cfsqltype="cf_sql_char" maxlength="6" value="#url.l#">
	and  	SS.SchoolCode = <cfqueryparam cfsqltype="cf_sql_char" maxlength="6" value="#url.s#">
</cfquery>


<!--- <cfdump var="#getURL#"><cfabort> --->

<cftry>
	<!--- Log Click --->
	<cfquery name="logClick" datasource="CFP">
		INSERT	INTO tblClickLog
				(UserUUID, SchoolCode, SiteCode, LinkCode, ClickTime)  <!--- , UserLocation, LinkLocation --->
		VALUES  (	
					<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="36" value="#session.user.uuid#">,
					<cfqueryparam cfsqltype="cf_sql_char" maxlength="5" value="#url.s#">,
					<cfqueryparam cfsqltype="cf_sql_char" maxlength="4" value="#getURL.SiteCode#">,
					<cfqueryparam cfsqltype="cf_sql_char" maxlength="4" value="#url.l#">,
					SysDate()
					<!--- <cfqueryparam cfsqltype="cf_sql_char" maxlength="6" value="#userlocation#">,
					<cfqueryparam cfsqltype="cf_sql_char" maxlength="6" value="#linklocation#"> --->
				)
	</cfquery>
	<cfcatch>
		<!--- <cfdump var="#session#">
		<cfabort> --->
	</cfcatch>

</cftry>


<!--- <cfdump var="#getURL#" /><cfabort> --->


<cflocation url="#getURL.URL#" addtoken="false" />

