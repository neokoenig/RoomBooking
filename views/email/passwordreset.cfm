<cfoutput>
#includePartial("/common/email/header")#
 <h4 style="Margin-top: 0;color: ##565656;font-weight: 700;font-size: 24px;Margin-bottom: 18px;font-family: sans-serif;line-height: 24px">Password Reset Request:</h4>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">Hi #user.firstname#,</p>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">We've received a request to reset your password. Click the link below to reset your password:</p>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">#linkto(controller="passwordResets", action="edit", onlyPath=false,  key=user.passwordResetToken)#</p>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">If you did not request a password reset, please ignore this message. Your password will remain the same.</p>

#includePartial("/common/email/footer")#
</cfoutput>