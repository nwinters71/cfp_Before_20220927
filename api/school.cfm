<!--- 
<cfoutput>The eagle has landed</cfoutput>
<cfdump var="#application#"><cfabort>
 --->

<!--- <cfoutput>#url.id#</cfoutput><cfabort> --->

<cfparam name="url.id" default="j8kvs" />

<cfset resp = {} />
<cfset resp.status = "FAIL" />

<cfquery name="resp.getSchool" datasource="CFP">
	select 	s.schoolCode, h.UNITID, h.INSTNM
		-- Admission fields
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
			, a.applcn, a.applcnm, a.applcnw, a.admssn, a.admssnm, a.admssnw
			, 200 enrlt, format(a.enrlm, 0), format(a.enrlw, 0), format(a.enrlft, 0), format(a.enrlftm, 0), format(a.enrlftw, 0), format(a.enrlpt, 0), format(a.enrlptm, 0), format(a.enrlptw, 0)
			, s.fullname, s.shortname

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

			case 
				when length(s.icon) then concat('/cfpimages/school/icons/batch2/',s.icon) 
				else '' 
			end icon, 
			case
				when length(s.image) then concat('/cfpimages/school/images/',s.image) 
				else ''
			end image, s.address1, s.city, s.state, s.zip, s.phone, s.domain
	from 	ipeds.hd2017 h 
			left join ipeds.adm2017 a on h.UNITID = a.UNITID
			join cfp.tblschool s on h.UNITID = s.UnitID
	where  s.SchoolCode IN (#preserveSingleQuotes(url.id)#)
</cfquery>


<cfquery name="resp.getMajors" datasource="CFP">
	select 	cip.cipCode, cip.cipTitle, count(distinct c.cipcode) NumberOfMajors, sum(c.CTOTALT) NumberOfUnderGradsMajor
	from 	ipeds.c2019a c -- on cip.cipcode = c.cipcode
			join ipeds.cipcode2010 cip on Left(c.cipcode, 2) = cip.cipcode
	where 	UNITID = '130794' -- Yale
	and 	c.MAJORNUM = 1
	and 	c.AWLEVEL = 5
	group 	by cip.cipCode, cip.CIPTitle
	order 	by CIPTitle 
</cfquery>

	<!--- where  s.SchoolCode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#url.id#" /> --->

<!--- <cfquery name="resp.getMajors" datasource="CFP">
	select  -- s.UnitID, s.INSTNM shortname, 
	 		cip.CIPCode, cip.CIPTitle, c.MAJORNUM, c.ctotalt, c.ctotalm, c.CTOTALW -- , c.ctotalm/c.ctotalt pm, c.ctotalw/c.ctotalt pw
	from 	ipeds.c2019a c 
			right join ipeds.cipcode2010 cip on c.CIPCODE = cip.CIPCode 
	where 	c.UnitID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#resp.getSchool.UnitID#" />
	-- and 	c.MAJORNUM = 1
	 and 	c.AWLEVEL = 5
	order	by ctotalt desc -- PercentWomen desc, s.INSTNM
</cfquery> --->

<cfset resp.status = "SUCCESS" />

<cfcontent reset="true"><cfoutput>#serializeJSON(resp, "struct")#</cfoutput><cfabort>


