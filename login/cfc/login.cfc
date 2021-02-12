<cfcomponent>

	<cfset this.BCrypt = createObject("component", "BCrypt").init() />

	<cffunction name="sayHello" returnType="string">
		<cfreturn "Hello World" />
	</cffunction>

	<cffunction name="hashPassword">
		<cfargument name="Password" type="string">
		<cfreturn this.BCrypt.hashString(Arguments.Password, this.BCrypt.genSalt()) />
	</cffunction>

	<cffunction name="checkPassword" returntype="boolean">
		<cfargument name="Password" type="string">
		<cfreturn this.BCrypt.checkString(Arguments.password, hash) />
	</cffunction>
	
	<cffunction name="GetUser" output="true" returnType="struct">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="false">

		<cfset local.rv = {} >
		<cfset local.rv.error = '' >
		
		<cfquery name="local.getUser">
			SELECT 	*
			FROM 	tblUser
			WHERE 	email = <cfqueryparam value="#arguments.email#" />
			AND 	activeFlag = 1
		</cfquery>

		<cfif GetUser.recordCount eq 1>
			<!--- User Exists --->
			<cfset local.rv.getUser = GetUser />
			<cfset local.rv.exists = 1>
		<cfelseif GetUser.recordCount eq 0>
			<cfset local.rv.error = "No Match Found" >
			<cfset local.rv.exists = 0 >
		<cfelse>
			<!--- TODO: Email/Log Issue --->
			<cfset local.rv.error = "Multiple Matches Found" >
			<cfset local.rv.exists = 2 >
		</cfif>
		
		<cfreturn local.rv />
	
	</cffunction>

	<cffunction name="AuthUser" output="true" returnType="struct">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="false">

		<cfif isDefined("Arguments.Password") AND Len(Trim(Arguments.Password)) GTE 8>

			<!--- Get User --->
			<cfset local.User = GetUser(arguments.email) />

			<cfif local.User.Error EQ "">
				<!--- User Found --->
				<cfif this.BCrypt.checkString(Arguments.password, local.User.GetUser.Password)>
					<!--- User authentication - Success --->
				<cfelse>
					<!--- User authentication - Fail --->
					<!--- Remove User --->
					<cftry>
						<cfset queryDeleteRow(local.User.GetUser, 1) />
						<cfcatch><!--- In case no match found ---></cfcatch>
					</cftry>
				</cfif>
			<cfelse>
				<!--- No User Found --->
			</cfif>
		<cfelse>
			<!--- No record --->
			<cfset local.User = structNew() />
			<cfset local.User.GetUser = queryNew("UserID") />
		</cfif>
		
		<cfreturn local.User />
	
	</cffunction>

	<cffunction name="AddUser">
		<cfargument name="email" type="">
		<cfargument name="password" type="">

		<cftry>
			<cfset local.status = true />

			<cfquery name="addUser" datasource="#Application.DSN#">
				INSERT INTO tblUser
						(UserUUID, UserName, Email, Password, UserType, CreateDate, ActiveFlag)
				VALUES	(	
							UUID(),
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.Email#" maxlength="80" />, 
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.Email#" maxlength="80" />, 
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#hashPassword(Arguments.hash)#" maxlength="80" />, 
							getDate(), 1
						)
			</cfquery>

			<cfset local.result = addUser />

			<cfcatch>
				<cfset local.status = false />
				<cfset local.error = cfcatch />
			</cfcatch>
		</cftry>

		<cfreturn local />
	
	</cffunction>

	<cffunction name="sendActivationEmail">
		<cfargument name="email" type="">
	</cffunction>

	<cffunction name="activateUser">
		<cfargument name="email" type="">
	</cffunction>

	<cffunction name="Login">
		<cfargument name="email" type="">
		<cfargument name="password" type="">

		<cfquery name="getUser" datasource="#Application.DSN#">
			SELECT	*
			FROM	tblUser
			WHERE	Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.Email#" maxlength="80" />
		</cfquery>

		<cfif getUser.recordCount EQ 1>

			<cfif this.BCrypt.checkString(Arguments.password, getUser.Password) EQ true>
				<!--- Succes.  Log User In --->
				<!--- <cfloginuser name="#cflogin.name#"
					password="#cflogin.password#"
					roles= #trim(qSecurity.Roles)#" > --->
			
			<cfelse>
				<!--- Fail. Invalid Password  --->
				

			</cfif>

		<cfelse>
			<!--- This shouldn't happen.  Log Notification and present user with a message --->
		</cfif>

	</cffunction>

	<cffunction name="ResetPassword">
		
	</cffunction>

	<cffunction name="AddUserGoogle">		
	</cffunction>

	<cffunction name="AddUserFacebook">
	</cffunction>

</cfcomponent>

