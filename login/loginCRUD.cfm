<!--- <cfset BCrypt = createObject("component", "cfc.BCrypt").init() />

<cfset pwhash = BCrypt.hashString("qwer1234", BCrypt.genSalt()) />


<cfquery name="getUser">
	UPDATE 	tblUser
	SET 	Password = <cfqueryparam value="#pwhash#" />
	WHERE 	email = <cfqueryparam value="nelson.winters@gmail.com" />
</cfquery>

<cfabort> --->



<cfparam name="url.action" default="" />
<cfparam name="form.action" default="#url.action#" />

<!--- <cfdump var="#url#" label="url">
<cfdump var="#form#" label="form"> --->


<cftry>

	<!--- Verify CSRF --->
	<cfif NOT StructIsEmpty(form) AND NOT ListFindNoCase("Check,Logout", Form.action)>
		<cfif NOT CSRFverifyToken(form.token)>
			<cfoutput>Invalid Token</cfoutput>
			<cfabort />
		</cfif>
		<cfoutput><p>Hello, #EncodeForHTML(form.email)# #CSRFverifyToken(form.token)#</p></cfoutput>
	</cfif>

	<!--- Instantiate login component --->
	<cfset cfcLogin = createObject("component", "cfc.login") />

	<!--- Process requested action --->
	<cfswitch expression="#Form.Action#">
		<cfcase value="check">
			<cfif isDefined("session.user.loggedIn") AND session.user.loggedIn>
				<cfcontent reset="true"><cfoutput>true</cfoutput><cfabort />
			<cfelse>
				<cfcontent reset="true"><cfoutput>false</cfoutput><cfabort />
			</cfif>
		</cfcase>
		<cfcase value="login">
			<cfif isValid("email", form.email)>
				<cfset qryUser = cfcLogin.AuthUser(form.email, form.password) />

				<cfif qryUser.getUser.recordCount EQ 1>
					<cfdump var="#qryUser#"><cfabort>
					<!--- Set Session Variables --->
					<cfset session.user.loggedIn = true />
					<cfset session.user.loginDateTime = now() />
					<cfset session.user.email = qryUser.getUser.email />
					<cfset session.user.uuid = qryUser.getUser.UserUUID />
					<cfset session.user.type = qryUser.getUser.UserType />
					<cfset session.user.ipaddress = cgi.REMOTE_ADDR />
					
					<!--- Add logic to handle if user wishes to stay logged in --->

					<cflocation url="login_form.cfm" addtoken="true" />

				<cfelse>

					Login Failed<cfabort>
				
				</cfif>
			</cfif>
		</cfcase>
		<cfcase value="logout">
			<cfset structClear(session) />
			<cfset session.user.loggedIn = false />
			<cflocation url="/cfp" addtoken="false" />
		</cfcase>
		<cfcase value="signup">
			<!--- 
				- Validate password strength (digits/numbers/8 characters)
				- Check if email exists in tblUsers
					- If exists: tell user that they already have an account and to request a reset password link to be emailed to them
					- If not exists: Add user and log them in. (Maybe send welcome email)

			 --->
 			<cfif isValid("email", form.email)>
				<cfset addUser = cfcLogin.AddUser(form.email, form.password) />
				<cfif addUser.status>
					<cfset local.

				<cfelse>

					<cfset getUser = cfcLogin.getUser(form.email, form.password) />
					<cfif getUser.exists>
					<!--- User Exists --->
					<cfset qryUser = cfcLogin.AuthUser(form.email, form.password) />

				<cfelse>
					<!--- New User --->

				</cfif>
			</cfif>
		</cfcase>
		<cfdefaultcase>
			<cfdump var="#form#">
			<cfabort>
		</cfdefaultcase>
	</cfswitch>

	<cfcatch>
		<cfdump var="#cfcatch#" label="test">
		<cfdump var="#form#" label="myform">
	</cfcatch>

</cftry>


