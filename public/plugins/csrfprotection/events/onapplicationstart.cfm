<cflock scope="application" timeout="30">
	<cfparam name="application.csrf.store" type="string" default="session">
	<cfparam name="application.csrf.cookieName" type="string" default="_wheels_authenticity">
	<cfparam name="application.csrf.cookieDomain" type="string" default="">
	<cfparam name="application.csrf.cookieEncodeValue" type="boolean" default="false">
	<cfparam name="application.csrf.cookieHttpOnly" type="boolean" default="true">
	<cfparam name="application.csrf.cookiePath" type="string" default="">
	<cfparam name="application.csrf.cookiePreserveCase" type="boolean" default="false">
	<cfparam name="application.csrf.cookieSecure" type="boolean" default="false">
	<cfparam name="application.csrf.encryptionAlgorithm" type="string" default="AES">
	<cfparam name="application.csrf.encryptionSecretKey" type="string" default="">
	<cfparam name="application.csrf.encryptionEncoding" type="string" default="Base64">
</cflock>
