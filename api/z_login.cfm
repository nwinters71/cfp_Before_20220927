<cfparam name="url.action" default="" />
<cfparam name="form.action" default="#url.action#" />


<cftry>

	<!--- Verify CSRF --->
	<cfif NOT StructIsEmpty(form) AND NOT ListFindNoCase("Check,CheckEmail,Logout", Form.action)>
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
		<cfcase value="checkEmail">
			<cfquery name="checkEmail" datasource="CFP">
				SELECT	UserID
				FROM 	tblUser
				WHERE 	Email = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="80" value="#form.email#" />
			</cfquery>
			<cfif checkEmail.recordCount>
				<cfset resp.data = "Email Found" />
				<cfset resp.status = "Success" />
			<cfelse>
				<cfset resp.data = "Email Not Found" />
				<cfset resp.status = "Fail" />
			</cfif>
		</cfcase>		
		<cfcase value="login">
			<cfif isValid("email", form.email)>
				<cfset qryUser = cfcLogin.AuthUser(form.email, form.password) />

				<cfif qryUser.getUser.recordCount EQ 1>
					<!--- Set Session Variables --->
					<cfset session.user.loggedIn = true />
					<cfset session.user.loginDateTime = now() />
					<cfset session.user.email = qryUser.getUser.email />
					<cfset session.user.uuid = qryUser.getUser.UserUUID />
					<cfset session.user.type = qryUser.getUser.UserType />
					<cfset session.user.ipaddress = cgi.REMOTE_ADDR />
					
					<!--- Add logic to handle if user wishes to stay logged in --->

					<!--- Check to see if the user want to be remembered. --->
					<cfif FORM.remember_me>

						<!---
							The user wants their login to be remembered such that they do not have to log into the system upon future
							returns. To do this, let's store and obfuscated and encrypted verion of their user ID in their cookies.
							We are hiding the value so that it cannot be easily tampered with and the user cannot try to login as a
							different user by changing thier cookie value.
						--->

						<!---
							Build the obfuscated value. This will be a list in which the user ID is the middle value.
						--->
						<cfset strRememberMe = (CreateUUID() & ":" & SESSION.user.uuid & ":" & CreateUUID() ) />

						<!--- Encrypt the value. --->
						<cfset strRememberMe = Encrypt(strRememberMe, APPLICATION.EncryptionKey, "cfmx_compat", "hex") />

						<!--- Store the cookie such that it never expires. --->
						<cfcookie name="RememberMe" value="#strRememberMe#" expires="never" />

					</cfif>












					<cfset resp.status = "Success" />
					<cfset resp.message = 'You have successfully logged in' />
					<!--- <cflocation url="login_form.cfm" addtoken="false" /> --->

				<cfelse>
					<cfquery name="checkEmail" datasource="CFP">
						SELECT	UserID
						FROM 	tblUser
						WHERE 	Email = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="80" value="#form.email#" />
					</cfquery>
					<cfif checkEmail.recordCount>
						<cfset resp.status = "FailPassword" />
						<cfset resp.data = "Incorrect Password" />
					<cfelse>
						<cfset resp.status = "FailEmail" />
						<cfset resp.data = "No account for email exists" />
					</cfif>				
				</cfif>
			</cfif>
		</cfcase>
		<cfcase value="logout">
			<cfset vCFID = session.CFID />
			<cfset vCFTOKEN = session.CFTOKEN />

			<!--- Clear the session. --->
			<cfset structClear( session ) />

			<cfset session.CFID = vCFID />
			<cfset session.CFTOKEN = vCFTOKEN />

			<cfset session.user = {} />
			<cfset session.user.loggedIn = false />

			<cfset resp.status = "Success" />
			<cfset resp.message = 'You have successfully logged out' />			
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
					<cfset resp.status = "Success" />
					<cfset resp.message = 'You''re account has been created.<br /><br /><a href="/cfp">Click here to continue</a>' />

				<cfelse>
					<cfset resp.status = "Fail" />
					<!--- Check if user exists --->
					<cfset getUser = cfcLogin.getUser(form.email, form.password) />
					<cfif getUser.exists>
					<!--- User Exists --->
						<cfset resp.message = 'An account already exists for this email address.<br /><br /><a href="/cfp/api/login.cfm?reset&email=#form.email#">Click here an email to reset your password</a>' />
						<!--- <cfset qryUser = cfcLogin.AuthUser(form.email, form.password) /> --->
					<cfelse>
					<!--- Not sure how this would happen (super long password or email???) --->
					</cfif>
				</cfif>
			</cfif>
		</cfcase>
		<cfdefaultcase>			
			<cfdump var="#form#" label="defaultcase">
			<cfabort>
		</cfdefaultcase>
	</cfswitch>

	<cfcatch>
		<cfdump var="#cfcatch#" label="test">
		<cfdump var="#form#" label="myform">
		<cfabort>
	</cfcatch>

</cftry>


<cfcontent reset="true"><cfoutput>#serializeJSON(resp, "struct")#</cfoutput><cfabort>



