<!--- <cfdump var="#form#"><cfabort> --->
<cfparam name="url.action" default="" />
<cfparam name="form.action" default="#url.action#" />


<cfswitch expression="#form.action#">

	<cfcase value="myschools">
		<cfquery name="getSchools" datasource="CFP">
		  SELECT  	s.UnitID, s.SchoolCode, s.FullName, s.ShortName,
				 	s.Address1, s.City, s.State, s.Zip, s.Phone, s.Domain,
					case 
						when length(s.icon) then concat('/cfpimages/school/icons/batch2/',s.icon) 
						else '' 
					end Icon, 
					case
						when length(s.image) then concat('/cfpimages/school/images/',s.image) 
						else ''
					end Image
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

		  			-- a.satvr25, a.satvr75, a.satmt25, a.satmt75, a.applcn, a.admssn, a.enrlt,
					, (SELECT ifnull(1, 0) 
						FROM tblUserSchools U 
						where SchoolCode = S.SchoolCode 
						and UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.uuid#" maxlength="36" />
					) UserUUID 
		  FROM 		CFP.tblUserSchools U
					left join CFP.tblSchool S ON S.schoolCode = U.schoolCode
					left join ipeds.adm2017 a on S.UnitID = a.UNITID 
		  WHERE   	U.UserUUID = '#Session.User.UUID#'
		  -- AND 		S.ActiveFlag = 1
		  ORDER 	BY FullName
		</cfquery>

		<!--- <cfdump var="#getschools#"><cfabort> --->

	</cfcase>


	<cfdefaultcase>
		<cfquery name="getSchools" datasource="CFP">
		  SELECT  	S.*, a.satvr25, a.satvr75, a.satmt25, a.satmt75, a.applcn, a.admssn, a.enrlt
					, (SELECT ifnull(1, 0) 
						FROM tblUserSchools U 
						where SchoolCode = S.SchoolCode 
						and UserUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.uuid#" maxlength="36" />
					) UserUUID 
		  FROM   	CFP.tblSchool S
		  			-- LEFT JOIN CFP.tblUserSchools U ON S.schoolCode = U.schoolCode
					join ipeds.adm2017 a on S.UnitID = a.UNITID 
		  WHERE   	FullName LIKE '%#Form.keyword#%'
		  AND 		S.ActiveFlag < 110	
		  ORDER 	BY FullName
		  limit		40
		</cfquery>

		<!--- <cfdump var="#getSchools#"><cfabort> --->

	</cfdefaultcase>

</cfswitch>




<cfcontent reset="true"><cfoutput>#serializeJSON(getSchools, "struct")#</cfoutput><cfabort>

