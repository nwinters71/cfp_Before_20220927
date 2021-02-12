<cfcomponent>

    <cfset this.name = "CFP" />
    <cfset this.applicationTimeout = CreateTimeSpan(0, 1, 0, 0) />
    <cfset this.datasource = "CFP" />
    <cfset this.sessionManagement = true />
    <cfset this.sessionTimeout = CreateTimeSpan(0, 0, 0, 10) />
    <cfset this.SetClientCookies = true />
    <cfset this.dsn = "CFP" />
    <!--- // this.customTagPaths = [ expandPath('/myAppCustomTags') ]; --->
    <!--- // this.mappings = { --->
    <!--- //     "/foo" = expandPath('/com/myCompany/foo') --->
    <!--- // }; --->

    <!--- // see also: http://help.adobe.com/en_US/ColdFusion/10.0/CFMLRef/WSc3ff6d0ea77859461172e0811cbec22c24-750b.html --->
    <!--- // see also: http://help.adobe.com/en_US/ColdFusion/10.0/Developing/WSED380324-6CBE-47cb-9E5E-26B66ACA9E81.html --->

    <cffunction name="onApplicationStart">

        <cfset APPLICATION.EncryptionKey = "G0ld3nT!ck3t" />
        
        <cfreturn true />
    </cffunction>

    <cffunction name="onSessionStart">

        <!---
            Store the CF id and token. We are about to clear the
            session scope for intialization and want to make sure
            we don't lose our auto-generated tokens.
        --->
        <cfset LOCAL.CFID = SESSION.CFID />
        <cfset LOCAL.CFTOKEN = SESSION.CFTOKEN />

        <!--- Clear the session. --->
        <cfset StructClear( SESSION ) />

        <!---
            Replace the id and token so that the ColdFusion
            application knows who we are.
        --->
        <cfset SESSION.CFID = LOCAL.CFID />
        <cfset SESSION.CFTOKEN = LOCAL.CFTOKEN />

        <!--- Create the default user. --->
        <cfset SESSION.User = {ID = 0, DateCreated = Now()} />

        <!---
            Now that we are starting a new session, let's check to see if this user want to be automatically logged
            in using their cookies.
            Since we don't know if the user has this "remember me" cookie in place, I would normally say let's param it
            and then use it. However, since this process involves decryption which might throw an error, I say, let's
            just wrap the whole thing in a TRY / CATCH and that way we don't have to worry about the multiple checks.
        --->
        <cftry>

                    <!--- Decrypt out remember me cookie. --->
            <cfset LOCAL.RememberMe = Decrypt(COOKIE.RememberMe, APPLICATION.EncryptionKey, "cfmx_compat", "hex") />

            <!---
                For security purposes, we tried to obfuscate the
                way the ID was stored. We wrapped it in the middle
                of list. Extract it from the list.
            --->
            <cfset LOCAL.RememberMe = ListGetAt(LOCAL.RememberMe, 2, ":") />


<!--- <cfdump var="#Local#" label="Check1"> --->

            <!---
                Check to make sure this value is numeric,
                otherwise, it was not a valid value.
            --->
            <cfif Len(LOCAL.RememberMe) GTE 35>

                <!---
                    We have successfully retreived the "remember me" ID from the user's cookie. Now, store
                    that ID into the session as that is how we are tracking the logged-in status.
                <cfset SESSION.User.uuid = LOCAL.RememberMe />
                --->

                <cfset cfcLogin = createObject("component", "api.cfc.login") />

                <cfset local.qryUser = cfcLogin.getUser(LOCAL.RememberMe, "uuid") />

                <cfif qryUser.status EQ "Success">                  
                    <!--- Set Session Variables --->
                    <cfset session.user.loggedIn = true />
                    <cfset session.user.loginDateTime = now() />
                    <cfset session.user.email = qryUser.getUser.email />
                    <cfset session.user.firstname = qryUser.getUser.username />
                    <cfset session.user.id = qryUser.getUser.UserID />
                    <cfset session.user.uuid = qryUser.getUser.UserUUID />
                    <cfset session.user.type = qryUser.getUser.UserType />
                    <cfset session.user.ipaddress = cgi.REMOTE_ADDR />
                </cfif>

            <cfelse>
                <cfcookie name="rememberme" value="" expires="now" />
            </cfif>

            <!--- Catch any errors. --->
            <cfcatch>

                <cfcookie name="rememberme" value="" expires="now" />
                <!---
                    There was either no remember me cookie, or the cookie was not valid for decryption. Let
                    the user proceed as NOT LOGGED IN.
                --->
            </cfcatch>
        </cftry>

        <!--- Return out. --->
        <cfreturn />

    </cffunction>

    <!--- // the target page is passed in for reference,  --->
    <!--- // but you are not required to include it --->
    <cffunction name="onRequestStart">
        <cfargument name="targetPage" type="string" />
        <cfset APPLICATION.EncryptionKey = "G0ld3nT!ck3t" />
    </cffunction>


    <cffunction name="onRequest">
        <cfargument name="targetPage" type="string" />
        <cfinclude template="#arguments.targetPage#" />
    </cffunction>


    <cffunction name="onRequestEnd">        
    </cffunction>

    <cffunction name="onSessionEnd">
        <cfargument name="SessionScope" type="struct" />
        <cfargument name="ApplicationScope" type="struct" />
    </cffunction>

    <cffunction name="onApplicationEnd">
        <cfargument name="ApplicationScope" type="struct" />
    </cffunction>

    <cffunction name="onError">
        <cfargument name="Exception" type="any" />
        <cfargument name="EventName" type="string" />

        <h2>Something has gone awry!</h2>
        <cfdump var="#Exception#" />

    </cffunction>

</cfcomponent>
