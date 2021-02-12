<cfquery name="getUsers" datasource="CFP">
	SELECT	*
	FROM 	tblUser
	WHERE	IfNull(UserUUID, '') = ''
</cfquery>

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


