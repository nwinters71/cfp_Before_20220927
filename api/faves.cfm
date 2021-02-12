<cfset response = {} />


<cfif isDefined("Session.User.UUID") AND Session.User.UUID NEQ "">
	<cfset UserUUID = Session.User.UUID />
<cfelse>
	<cfset UserUUID = cookie.CFID />
</cfif>
 

<cfswitch expression="#form.type#">

	<cfcase value="SCHOOL">

		<cfswitch expression="#Form.Action#">

			<cfcase value="ADD">
				<cfquery name="getSChool" datasource="CFP">
					SELECT	*
					FROM 	tblUserSchools
					WHERE	UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.User.UUID#" />
					AND 	SchoolCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.SchoolCode#" />
				</cfquery>
				<cfif getSchool.recordCount EQ 0>
					<cfquery name="getSChool" datasource="CFP">
						INSERT 	INTO tblUserSchools
								(UserUUID, SchoolCode, Notes, Status, Classification, Rating, SortOrder, ActiveFlag)
						VALUES	(<cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.User.UUID#" />, <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.SchoolCode#" />, '', '', '', 1, 1, 1)
					</cfquery>
				</cfif>
			</cfcase>
			<cfcase value="REMOVE">
				<cfquery name="getSChool" datasource="CFP">
					DELETE
					FROM 	tblUserSchools
					WHERE	UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UserUUID#" />
					AND 	SchoolCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.SchoolCode#" />
				</cfquery>
			</cfcase>

			<cfdefaultcase></cfdefaultcase>

		</cfswitch>

	</cfcase>

</cfswitch>


<cfset response.status = "Success" />

<cfcontent reset="true"><cfoutput>#serializeJSON(response)#</cfoutput>