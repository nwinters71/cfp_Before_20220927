<cfparam name="url.action" default="" />

<cfset resp = {} />
<cfset resp.status = "Fail" />

<cfswitch expression="#url.action#">

	<cfcase value="tables">
		<cfquery name="resp.data" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
			select 	Survey, TableName, TableNumber, TableTitle, Description 
			from 	ipeds.tables17
		</cfquery>
	</cfcase>

	<cfcase value="fields">
		<cfquery name="resp.data" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
			select 	VarNumber, VarName, VarTitle, DataType, FieldWidth, Format, SectionNumber, LongDescription, SectionTitle
			from 	ipeds.vartable17
			where	tableNumber = <cfqueryparam cfsqltype="numeric" value="#url.table#" />
			order 	by varOrder
		</cfquery>
	</cfcase>

	<cfcase value="values">
		<cfquery name="resp.data" datasource="CFP" cachedwithin="#CreateTimeSpan( 0, 0, 0, 10)#">
			select 	ValueOrder, ValueLabel, CodeValue, VarTitle, Frequency, Percent 
			from 	ipeds.valueSets17
			where	VarNumber = <cfqueryparam cfsqltype="numeric" value="#url.field#" />
			order 	by ValueOrder
		</cfquery>
	</cfcase>

</cfswitch>


<cfcontent reset="true"><cfoutput>#serializeJSON(resp, "struct")#</cfoutput><cfabort />