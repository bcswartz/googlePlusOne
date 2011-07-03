<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("org/thoughtdelimited/mango/plugins/googlePlusOne") />
    
    		<cfset initSettings(size = "standard") />
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Google Plus One plugin activated. Would you like to <a href='generic_settings.cfm?event=showGooglePlusOneSettings&amp;owner=googlePlusOne&amp;selected=showGooglePlusOneSettings'>configure it now</a>?" />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Deactivated Plugin." />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
			
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />		
			
			<cfif eventName EQ "beforeHtmlHeadEnd">	
				<cfsavecontent variable="plusOneScript"><cfoutput>
					 <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & plusOneScript />
				<cfset arguments.event.outputData = data />
			
			
			<cfelseif eventName EQ "beforePostContentEnd">
				
					<cfsavecontent variable="plusOneButton"><cfoutput>
                    	<cfif getSetting('size') EQ "standard">
                        	<g:plusone></g:plusone>
                        <cfelse>
                        	<g:plusone size="#getSetting('size')#"></g:plusone>
                        </cfif>
					</cfoutput></cfsavecontent>	
					
					<cfset data = arguments.event.outputData />
					<cfset data = data & plusOneButton />
					<cfset arguments.event.outputData = data />	
			
            <!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "googlePlusOne">
				<cfset link.page = "settings" />
				<cfset link.title = "Google Plus One" />
				<cfset link.eventName = "showGooglePlusOneSettings" />
				<cfset arguments.event.addLink(link) />
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showGooglePlusOneSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(size = data.externaldata.size) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Google Plus One Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Google Plus One Settings") />
					<cfset data.message.setData(page) />
            
			</cfif>
            
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>