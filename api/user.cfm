<cfparam name="url.action" default="" />
<cfparam name="url.email" default="" />
<cfparam name="url.password" default="" />
<cfparam name="form.action" default="#url.action#" />
<cfparam name="form.email" default="#url.email#" />
<cfparam name="form.password" default="#url.password#" />

<!--- <cfdump var="#form#"><cfabort> --->


<cftry>

	<!--- Verify CSRF --->
	<!--- <cfif NOT StructIsEmpty(form) AND NOT ListFindNoCase("Check,CheckEmail,Logout", Form.action)>
		<cfif NOT CSRFverifyToken(form.token)>
			<cfoutput>Invalid Token</cfoutput>
			<cfabort />
		</cfif>
		<cfoutput><p>Hello, #EncodeForHTML(form.email)# #CSRFverifyToken(form.token)#</p></cfoutput>
	</cfif> --->

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
				SELECT	UserName firstName
				FROM 	tblUser
				WHERE 	Email = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="80" value="#form.email#" />
			</cfquery>
			<cfif checkEmail.recordCount>
				<cfset resp.status = "Success" />
				<cfset resp.data = checkEmail.firstName />
				<cfset resp.message = "Email Found" />
			<cfelse>
				<cfset resp.status = "Fail" />
				<cfset resp.message = "Email Not Found" />
			</cfif>
		</cfcase>
		<cfcase value="login">
			<cfif isValid("email", form.email)>
				<cfset qryUser = cfcLogin.AuthUser(form.email, form.password) />
<!--- <cfdump var="#qryUser#"><cfabort> --->

				<cfif qryUser.status EQ "Success">					
					<!--- Set Session Variables --->
					<cfset session.user.loggedIn = true />
					<cfset session.user.loginDateTime = now() />
					<cfset session.user.email = qryUser.data.email />
					<cfset session.user.firstname = qryUser.data.username />
					<cfset session.user.id = qryUser.data.UserID />
					<cfset session.user.uuid = qryUser.data.UserUUID />
					<cfset session.user.type = qryUser.data.UserType />
					<cfset session.user.ipaddress = cgi.REMOTE_ADDR />
					
					<!--- Add logic to handle if user wishes to stay logged in --->

					<!--- Check to see if the user want to be remembered. --->
					
					<cftry>
						<cfif isDefined("form.enablerememberme") AND form.enablerememberme EQ "true">

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
							<cfcookie name="rememberme" value="#strRememberMe#" expires="never" />

						<cfelse>

							<cfcookie name="rememberme" value="" expires="now" />

						</cfif>

						<!--- <cfdump var="#session#"><cfdump var="#cookie#"><cfabort> --->

						<!--- <cflocation url="login_form.cfm" addtoken="false" /> --->

						<cfcatch>
						
						</cfcatch>
					</cftry>

					<cfset resp.status = "Success" />
					<cfset resp.message = 'You have successfully logged in' />

				<cfelse>
					<cfquery name="checkEmail" datasource="CFP">
						SELECT	UserID
						FROM 	tblUser
						WHERE 	Email = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="80" value="#form.email#" />
					</cfquery>
					<cfif checkEmail.recordCount>
						<cfset resp.status = "FailPassword" />
						<cfset resp.message = "Incorrect Password" />
					<cfelse>
						<cfset resp.status = "FailEmail" />
						<cfset resp.message = "No account for email exists" />
					</cfif>				
				</cfif>
			<cfelse>
				<cfset resp.status = "InvalidEmail" />
				<cfset resp.message = "Invalid email address" />				
			</cfif>
		</cfcase>
		<cfcase value="logout">

			<!--- When logging out, we want to both log out the current user AND make sure that they don't get automatically logged in next time. --->

			<!--- Since our application is using the User ID to keep track of login status, let's reset that value. --->
			<!--- <cfset SESSION.User.ID = 0 /> --->

			<!--- We also don't want the user to be automatically logged in again, so remove the client cookies. --->
			<cfcookie name="rememberme" value="" expires="now" />

			<!--- Now that the user has been logged out, redirect. --->
			<!--- <cflocation url="./" addtoken="false" /> --->

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
				<cfset qryUser = cfcLogin.AddUser(form.email, form.password, form.firstname) />
				<cfif qryUser.status EQ "Success">
					<!--- Set Session Variables --->

					<cfset session.user.loggedIn = true />
					<cfset session.user.loginDateTime = now() />
					<cfset session.user.email = qryUser.data.email />
					<cfset session.user.firstname = qryUser.data.username />
					<cfset session.user.uuid = qryUser.data.UserUUID />
					<cfset session.user.type = qryUser.data.UserType />
					<cfset session.user.ipaddress = cgi.REMOTE_ADDR />
					
					<!--- Add logic to handle if user wishes to stay logged in --->

					<cfset resp.status = "Success" />
					<cfset resp.message = 'You''re account has been created.<br /><br /><a href="/cfp">Click here to continue</a>' />

				<cfelse>
					<cfset resp.status = "Fail" />
					<!--- Check if user exists --->
					<cfset getUser = cfcLogin.getUser(form.email, "Email") />
					<cfdump var="#getUser#">
					<cfif getUser.status EQ "Success">
					<!--- User Exists --->
						<cfset resp.message = 'An account already exists for this email address.<br /><br /><a href="/cfp/api/user.cfm?reset&email=#form.email#">Click here an email to reset your password</a>' />
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



