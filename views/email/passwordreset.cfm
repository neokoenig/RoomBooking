<cfoutput>
#includePartial("/email/header")# 
                    <layout label="Message">
                        <table class="w580" width="580" cellpadding="0" cellspacing="0" border="0">
                            <tbody><tr>
                                <td class="w580" width="580">
                                    <p align="left" class="article-title"><singleline label="Title">Password Reset Request</singleline></p>
                                    <div align="left" class="article-content">
                                        <multiline label="Description">

                                    	<p>Hi #user.firstname#,</p>
                                    	<p>We've received a request to reset your password. Click the link below to reset your password:</p>
                                    	<p>#linkto(controller="passwordResets", action="edit", onlyPath=false,  key=user.passwordResetToken)#</p>	
                                    	<p>If you did not request a password reset, please ignore this message. Your password will remain the same.</p> 
                                        </multiline>
                                    </div>
                                </td>
                            </tr>
                            <tr><td class="w580" width="580" height="10"></td></tr>
                        </tbody></table>
                    </layout> 
#includePartial("/email/footer")#
</cfoutput>