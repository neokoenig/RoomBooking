<!---================================ Cookies ======================================--->
<!--

    Cookie:RBS_UN : The Username (string)
        Request: request.cookie.username

        Keep this in tag form as for some reason I can never really get this to work in script form.
--->
    <cffunction name="setCookieRememberUsername" hint="Sets a cookie which remembers the login">
        <cfargument name="username">
        <cfcookie name = "RBS_UN" expires="360" value="#arguments.username#" httpOnly="true">
        <cfset addlogline(message="#arguments.username# used cookie remember email", type="Cookie")>
    </cffunction>

    <Cffunction name="setCookieForgetUsername" hint="Remove the username cookie">
         <cfcookie  name = "RBS_UN" expires = "NOW"  httpOnly="true">
        <cfset addlogline(message="Cookie remember email removed", type="Cookie")>
    </Cffunction>
