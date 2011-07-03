<style type="text/css">
<!--
.sizeList {list-style-type:none;}
-->
</style>

<cfoutput>

<form method="post" action="#cgi.script_name#">

	<fieldset>
		<legend>Google Plus One Settings</legend>
        
        <p>Currently, the only plugin setting you can change is the size/orientation of the "+1" button and the counter:</p>
        <label for="size">
        	<ul class="sizeList">
        		<li><input type="radio" name="size" value="small" <cfif getSetting("size") is "small">checked="checked"</cfif> /> Small (15px), button on left, counter on right.</li>
                <li><input type="radio" name="size" value="medium" <cfif getSetting("size") is "medium">checked="checked"</cfif> /> Medium (20px), button on left, counter on right.</li>
                 <li><input type="radio" name="size" value="standard" <cfif getSetting("size") is "standard">checked="checked"</cfif> /> Standard (24px), button on left, counter on right.</li>
                  <li><input type="radio" name="size" value="tall" <cfif getSetting("size") is "tall">checked="checked"</cfif> /> Tall (60px), counter on top, button below it.</li>
        	</ul>
        </label>
       
       <p>For more information about the "+1" button, see <a href="http://www.google.com/webmasters/+1/button/" target="_blank">http://www.google.com/webmasters/+1/button/</a> (opens in new tab/window).</p>
       
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showGooglePlusOneSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="googlePlusOne" name="selected" />
	</p>

</form>



</cfoutput>

