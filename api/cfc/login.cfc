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
		<cfargument name="id" type="string" required="true" />
		<cfargument name="idType" type="string" required="false" default="Email" />

		<cfset local.rv = {} />
		<cfset local.rv.status = "Fail" />
		<cfset local.rv.error = "" />
		
		<cfquery name="local.getUser" datasource="CFP">
			SELECT 	*
			FROM 	tblUser
			<cfif arguments.idType EQ "ID">
				WHERE 	userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#trim(arguments.id)#" />
			<cfelseif arguments.idType EQ "UUID">
				WHERE 	userUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.id)#" maxlength="36" />
			<cfelseif arguments.idType EQ "Email">
				WHERE 	email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.id)#" />
			</cfif>
			AND 	activeFlag = 1
		</cfquery>

		<cfif GetUser.recordCount eq 1>
			<!--- Success --->
			<cfset local.rv.status = "Success" />
			<cfset local.rv.getUser = GetUser />
		<cfelseif GetUser.recordCount eq 0>
			<cfset local.rv.error = "No Match Found2" >
		<cfelse>
			<!--- TODO: Email/Log Issue --->
			<cfset local.rv.error = "Multiple Matches Found" >
		</cfif>
		
		<cfreturn local.rv />
	
	</cffunction>

	<cffunction name="AuthUser" output="true" returnType="struct">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="false">

		<cfset local.resp = {} />
		<cfset local.resp.status = "Fail" />
		<cfset local.message = "" />

		<cfif isDefined("Arguments.Password") AND Len(Trim(Arguments.Password)) GTE 8>

			<!--- Get User --->
			<cfset local.User = GetUser(arguments.email, "email") />

			<!--- <cfdump var="#local#"><cfabort> --->

			<cfif local.User.Error EQ "">
				<!--- User Found --->
				<cfif this.BCrypt.checkString(Arguments.password, local.User.GetUser.Password)>
					<!--- User authentication - Success --->
					<cfset local.resp.status = "Success" />
					<cfset local.resp.data = local.user.GetUser />
				<cfelse>
					<!--- User authentication - Fail --->
					<cfset local.resp.message = "Incorrect Password" />
				</cfif>
			<cfelse>
				<!--- No User Found --->
				<cfset local.resp.message = "User not found" />
			</cfif>
		<cfelse>

			<!--- No record --->
			<cfset local.resp.message = "Invalid Password" />
		</cfif>
		
		<cfreturn local.resp />
	
	</cffunction>

	<cffunction name="AddUser" returntype="struct">
		<cfargument name="email" type="string">
		<cfargument name="password" type="string">
		<cfargument name="firstname" type="string">

		<cfset local.resp = {} />
		<cfset local.resp.status = "Fail" />
		<cfset local.message = "" />

		<cftry>
			<cfquery name="addUser" datasource="CFP">
				INSERT INTO tblUser
						(UUID, Email, UserName, Password, UserType, CreateDate, ActiveFlag)
				VALUES	(
							'#CreateUUID()#',
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(Arguments.Email)#" maxlength="80" />, 
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(Arguments.firstname)#" maxlength="80" />, 
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#hashPassword(Arguments.password)#" maxlength="80" />, 
							'User', sysDate(), 1
						)
			</cfquery>

			<cfset local.User = GetUser(arguments.email) />

			<cfif local.User.Error EQ "">
				<cfset local.resp.status = "Success" />
				<cfset local.resp.data = local.User.GetUser />
			</cfif>

			<cfcatch>
				<cfset local.resp.status = "Error" />
				<!--- <cfreturn false /> --->
			</cfcatch>
		</cftry>


		<cfreturn local.resp />

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

		<cfquery name="getUser" datasource="CFP">
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

