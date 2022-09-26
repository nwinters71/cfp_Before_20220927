<!--- <cfdump var="#form#"><cfabort> --->
<cfparam name="url.action" default="" />
<cfparam name="form.action" default="#url.action#" />

<cfif isDefined("Session.User.UUID") AND Session.User.UUID NEQ "">
	<cfset UserUUID = Session.User.UUID />
<cfelse>
	<cfset UserUUID = cookie.CFID />
	<cfset schoolList = "'Adelphi University','Vassar College','Amherst College','Swarthmore College','Cornell University','Dartmouth College','Columbia University','Brown University','Case Western Reserve University','University of Michigan','Massachusetts Institute of Technology','Clemson University','Rollins College','Emory University','Macalester College','University of Chicago','Johns Hopkins University','University of Notre Dame','University of Georgia','Bucknell University','Carnegie Mellon University','Georgia State University','Davidson College','Williams College','harvard university','stanford university','emory university','Georgia Institute of Technology','Auburn University','Duke University','Berry College','Vanderbilt University'" />
</cfif>

<cfswitch expression="#form.action#">

	<cfcase value="myschools">
		<cfquery name="getSchools" datasource="CFP">
		  SELECT  	s.UnitID, s.SchoolCode, s.FullName, s.ShortName,
				 	s.Address1, s.City, s.State, s.Zip, s.Phone, s.Domain,
					case 
						when length(s.icon) then concat('/cfpimages/school/icons/batch/',s.icon) 
						else '' 
					end Icon, 
					case
						when length(s.image) then concat('/cfpimages/school/images/',s.image) 
						else ''
					end Image
					, Format(a.applcn, 0) applcn, Format(a.applcnm, 0) applcnm, Format(a.applcnw, 0) applcnw, Format(a.admssn, 0) admssn, Format(a.admssnm, 0) admssnm, Format(a.admssnw, 0) admssnw
					, Format(a.enrlt, 0) enrlt, Format(a.enrlm, 0) enrlm, Format(a.enrlw, 0) enrlw, Format(a.enrlft, 0) enrlft, Format(a.enrlftm, 0) enrlftm, Format(a.enrlftw, 0) enrlftw, Format(a.enrlpt, 0) enrlpt, Format(a.enrlptm, 0) enrlptm, Format(a.enrlptw, 0) enrlptw
					, a.satvr25, a.satvr75, a.satmt25, a.satmt75, a.acten25, a.acten75, a.actmt25, a.actmt75, a.actcm25, a.actcm75, a.satnum, a.satpct, a.actnum, a.actpct
					, a.admcon1 cons_hsrank
					, a.admcon2 cons_hsgpa
					, a.admcon3 cons_hsrecord
					, a.admcon4 cons_collegeprep
					, a.admcon5 cons_recommendations
					, a.admcon6 cons_formalcompetency
					, a.admcon7 cons_admtestscores
					, a.admcon8 cons_othertest
					, a.admcon9 cons_toefl


					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'kk6f')	Website
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = '3fuh')	About
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'rmfb')	Visit
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = '63w2')	VirtualTour
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'ov9z')	CampusMap
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'u7oj')	Directions
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'pz53')	Parking
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'mwwq')	ContactInfo
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'wxxe')	RequestInfo
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'wtni')	Facebook
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = '8c2c')	LinkedIn
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'n1ps')	Twitter
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = '92zt')	Youtube
					, (select rawSlug from tblschoolslug where schoolcode = S.SchoolCode and sitecode = 'uct7')	Instagram
			

		  			-- a.satvr25, a.satvr75, a.satmt25, a.satmt75, a.applcn, a.admssn, a.enrlt,
					, 
					<cfif IsDefined("session.user.uuid")>
						(SELECT ifnull(1, 0) 
							FROM tblUserSchools U 
							where SchoolCode = S.SchoolCode 
							and UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.uuid#" maxlength="36" />
						)
					<cfelse>
						0
					</cfif>  UserUUID
		  FROM 		CFP.tblUserSchools U
					left join CFP.tblSchool S ON S.schoolCode = U.schoolCode
					left join ipeds.adm2017 a on S.UnitID = a.UNITID 
		<cfif IsDefined("session.user.uuid")>
			  WHERE   	U.UserUUID = '#Session.User.UUID#'
		<cfelse>
				WHERE   S.ActiveFlag = 1
				AND     S. FullName IN (#PreserveSingleQuotes(schoolList)#)
		</cfif>
		  -- AND 		S.ActiveFlag = 1
		  ORDER 	BY FullName
		</cfquery>

		<!--- <cfdump var="#getschools#"><cfabort> --->

	</cfcase>

	<cfcase value="getmajors">
		<cfquery name="getMajors" datasource="CFP">
			select 	cip.cipCode, cip.cipTitle, count(distinct c.cipcode) NumberOfMajors, sum(c.CTOTALT) NumberOfUnderGradsMajor
			from 	ipeds.c2019a c -- on cip.cipcode = c.cipcode
					join ipeds.cipcode2010 cip on Left(c.cipcode, 2) = cip.cipcode
			where 	UNITID = '130794' -- Yale
			and 	c.MAJORNUM = 1
			and 	c.AWLEVEL = 5
			group 	by cip.cipCode, cip.CIPTitle
			order 	by CIPTitle 
		</cfquery>
		<!--- <cfdump var="#getschools#"><cfabort> --->
	</cfcase>

	<cfdefaultcase>
		<cfquery name="getSchools" datasource="CFP">
			SELECT  S.*, a.satvr25, a.satvr75, a.satmt25, a.satmt75, a.applcn, a.admssn, a.enrlt
					,
					<cfif isDefined("session.user.uuid")>
						(
							SELECT 	ifnull(1, 0) 
							FROM 	tblUserSchools U 
							where 	SchoolCode = S.SchoolCode 
							and 	UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.uuid#" maxlength="36" />
						)
					<cfelse>
						0
					</cfif> UserUUID
			FROM   	CFP.tblSchool S
					-- LEFT JOIN CFP.tblUserSchools U ON S.schoolCode = U.schoolCode
					join ipeds.adm2017 a on S.UnitID = a.UNITID 
			WHERE   1 = 1
			<cfif Len(Trim(Form.Keyword))>
				AND 		FullName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Form.keyword#%" maxlength="50" />
			</cfif>
			<cfif IsDefined("Form.State") AND Len(Form.State)>
				AND 	S.State IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.State#" maxlength="2" />)
			</cfif>
			AND 	S.ActiveFlag < 110	
			ORDER 	BY FullName
			limit	100
		</cfquery>

		<!--- <cfdump var="#getSchools#"><cfabort> --->

	</cfdefaultcase>

</cfswitch>




<cfcontent reset="true"><cfoutput>#serializeJSON(getSchools, "struct")#</cfoutput><cfabort>

