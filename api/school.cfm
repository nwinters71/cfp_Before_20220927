<!--- 
<cfoutput>The eagle has landed</cfoutput>
<cfdump var="#application#"><cfabort>
 --->

<cfparam name="url.id" default="j8kvs" />

<cfquery name="getSChool" datasource="CFP">
	select 	h.UNITID, h.INSTNM
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
			, a.enrlt, a.enrlm, a.enrlw, a.enrlft, a.enrlftm, a.enrlftw, a.enrlpt, a.enrlptm, a.enrlptw
			, s.fullname, s.shortname, s.icon, s.image, s.address1, s.city, s.state, s.zip, s.phone, s.domain
	from 	ipeds.hd2017 h 
			left join ipeds.adm2017 a on h.UNITID = a.UNITID
			join cfp.tblschool s on h.UNITID = s.UnitID
	where  s.SchoolCode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#url.id#" />
</cfquery>


<cfcontent reset="true"><cfoutput>#serializeJSON(getSchool, "struct")#</cfoutput><cfabort>


