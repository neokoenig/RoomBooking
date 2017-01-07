<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name, in pluralized form                   |
	| force      | No       | boolean | false   | drop existing table of same name before creating |
	| id         | No       | boolean | true    | if false, defines a table with no primary key    |
	| primaryKey | No       | string  | id      | overrides default primary key name
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = createTable(name='employees',force=false,code=true,primaryKey='empId');
      t.string(columnNames='name', default='', null=true, limit='255');
      t.text(columnNames='bio', default='', null=true);
      t.time(columnNames='lunchStarts', default='', null=true);
      t.datetime(columnNames='employmentStarted', default='', null=true);
      t.integer(columnNames='age', default='', null=true, limit='1');
      t.decimal(columnNames='hourlyWage', default='', null=true, precision='1', scale='2');
      t.date(columnNames='dateOfBirth', default='', null=true);
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Roles">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{

addRecord(table='countries', code='AD', title='Andorra', sortorder=6);
addRecord(table='countries', code='AE', title='United Arab Emirates', sortorder=229);
addRecord(table='countries', code='AF', title='Afghanistan', sortorder=1);
addRecord(table='countries', code='AG', title='Antigua/Barbuda', sortorder=10);
addRecord(table='countries', code='AI', title='Anguilla', sortorder=8);
addRecord(table='countries', code='AL', title='Albania', sortorder=3);
addRecord(table='countries', code='AM', title='Armenia', sortorder=12);
addRecord(table='countries', code='AN', title='Netherlands Antilles', sortorder=152);
addRecord(table='countries', code='AO', title='Angola', sortorder=7);
addRecord(table='countries', code='AQ', title='Antarctica', sortorder=9);
addRecord(table='countries', code='AR', title='Argentina', sortorder=11);
addRecord(table='countries', code='AS', title='American Samoa', sortorder=5);
addRecord(table='countries', code='AT', title='Austria', sortorder=14);
addRecord(table='countries', code='AU', title='Australia', sortorder=15);
addRecord(table='countries', code='AW', title='Aruba', sortorder=13);
addRecord(table='countries', code='AX', title='Åland Islands', sortorder=2);
addRecord(table='countries', code='AZ', title='Azerbaijan', sortorder=16);
addRecord(table='countries', code='BA', title='Bosnia/Herzegovina', sortorder=28);
addRecord(table='countries', code='BB', title='Barbados', sortorder=20);
addRecord(table='countries', code='BD', title='Bangladesh', sortorder=19);
addRecord(table='countries', code='BE', title='Belgium', sortorder=22);
addRecord(table='countries', code='BF', title='Burkina Faso', sortorder=34);
addRecord(table='countries', code='BG', title='Bulgaria', sortorder=33);
addRecord(table='countries', code='BH', title='Bahrain', sortorder=18);
addRecord(table='countries', code='BI', title='Burundi', sortorder=35);
addRecord(table='countries', code='BJ', title='Benin', sortorder=24);
addRecord(table='countries', code='BL', title='St. Barthélemy', sortorder=181);
addRecord(table='countries', code='BM', title='Bermuda', sortorder=25);
addRecord(table='countries', code='BN', title='Brunei Darussalam', sortorder=32);
addRecord(table='countries', code='BO', title='Bolivia', sortorder=27);
addRecord(table='countries', code='BR', title='Brazil', sortorder=31);
addRecord(table='countries', code='BS', title='Bahamas', sortorder=17);
addRecord(table='countries', code='BT', title='Bhutan', sortorder=26);
addRecord(table='countries', code='BV', title='Bouvet Island', sortorder=30);
addRecord(table='countries', code='BW', title='Botswana', sortorder=29);
addRecord(table='countries', code='BY', title='Belarus', sortorder=21);
addRecord(table='countries', code='BZ', title='Belize', sortorder=23);
addRecord(table='countries', code='CA', title='Canada', sortorder=38);
addRecord(table='countries', code='CC', title='Cocos (Keeling) Islands', sortorder=46);
addRecord(table='countries', code='CF', title='Central African Republic', sortorder=41);
addRecord(table='countries', code='CG', title='Congo', sortorder=49);
addRecord(table='countries', code='CH', title='Switzerland', sortorder=211);
addRecord(table='countries', code='CI', title='Côte D''Ivoire', sortorder=52);
addRecord(table='countries', code='CK', title='Cook Islands', sortorder=50);
addRecord(table='countries', code='CL', title='Chile', sortorder=43);
addRecord(table='countries', code='CM', title='Cameroon', sortorder=37);
addRecord(table='countries', code='CN', title='China', sortorder=44);
addRecord(table='countries', code='CO', title='Colombia', sortorder=47);
addRecord(table='countries', code='CR', title='Costa Rica', sortorder=51);
addRecord(table='countries', code='CU', title='Cuba', sortorder=54);
addRecord(table='countries', code='CV', title='Cape Verde', sortorder=39);
addRecord(table='countries', code='CX', title='Christmas Island', sortorder=45);
addRecord(table='countries', code='CY', title='Cyprus', sortorder=55);
addRecord(table='countries', code='CZ', title='Czech Republic', sortorder=56);
addRecord(table='countries', code='DE', title='Germany', sortorder=79);
addRecord(table='countries', code='DJ', title='Djibouti', sortorder=58);
addRecord(table='countries', code='DK', title='Denmark', sortorder=57);
addRecord(table='countries', code='DM', title='Dominica', sortorder=59);
addRecord(table='countries', code='DO', title='Dominican Republic', sortorder=60);
addRecord(table='countries', code='DZ', title='Algeria', sortorder=4);
addRecord(table='countries', code='EC', title='Ecuador', sortorder=61);
addRecord(table='countries', code='EE', title='Estonia', sortorder=66);
addRecord(table='countries', code='EG', title='Egypt', sortorder=62);
addRecord(table='countries', code='EH', title='Western Sahara', sortorder=242);
addRecord(table='countries', code='ER', title='Eritrea', sortorder=65);
addRecord(table='countries', code='ES', title='Spain', sortorder=204);
addRecord(table='countries', code='ET', title='Ethiopia', sortorder=67);
addRecord(table='countries', code='FI', title='Finland', sortorder=71);
addRecord(table='countries', code='FJ', title='Fiji', sortorder=70);
addRecord(table='countries', code='FK', title='Falkland Islands(Malvinas)', sortorder=68);
addRecord(table='countries', code='FM', title='Micronesia', sortorder=139);
addRecord(table='countries', code='FO', title='Faroe Islands', sortorder=69);
addRecord(table='countries', code='FR', title='France', sortorder=72);
addRecord(table='countries', code='GA', title='Gabon', sortorder=76);
addRecord(table='countries', code='GB', title='United Kingdom', sortorder=230);
addRecord(table='countries', code='GD', title='Grenada', sortorder=84);
addRecord(table='countries', code='GE', title='Georgia', sortorder=78);
addRecord(table='countries', code='GF', title='French Guiana', sortorder=73);
addRecord(table='countries', code='GG', title='Guernsey', sortorder=88);
addRecord(table='countries', code='GH', title='Ghana', sortorder=80);
addRecord(table='countries', code='GI', title='Gibraltar', sortorder=81);
addRecord(table='countries', code='GL', title='Greenland', sortorder=83);
addRecord(table='countries', code='GM', title='Gambia', sortorder=77);
addRecord(table='countries', code='GN', title='Guinea', sortorder=89);
addRecord(table='countries', code='GP', title='Guadeloupe', sortorder=85);
addRecord(table='countries', code='GQ', title='Equatorial Guinea', sortorder=64);
addRecord(table='countries', code='GR', title='Greece', sortorder=82);
addRecord(table='countries', code='GS', title='South Georgia/Sandwich Islands', sortorder=202);
addRecord(table='countries', code='GT', title='Guatemala', sortorder=87);
addRecord(table='countries', code='GU', title='Guam', sortorder=86);
addRecord(table='countries', code='GW', title='Guinea-Bissau', sortorder=90);
addRecord(table='countries', code='GY', title='Guyana', sortorder=91);
addRecord(table='countries', code='HK', title='Hong Kong', sortorder=95);
addRecord(table='countries', code='HM', title='Heard Island/Mcdonald Islands', sortorder=93);
addRecord(table='countries', code='HN', title='Honduras', sortorder=94);
addRecord(table='countries', code='HR', title='Croatia', sortorder=53);
addRecord(table='countries', code='HT', title='Haiti', sortorder=92);
addRecord(table='countries', code='HU', title='Hungary', sortorder=96);
addRecord(table='countries', code='ID', title='Indonesia', sortorder=99);
addRecord(table='countries', code='IE', title='Ireland', sortorder=102);
addRecord(table='countries', code='IL', title='Israel', sortorder=104);
addRecord(table='countries', code='IM', title='Isle Of Man', sortorder=103);
addRecord(table='countries', code='IN', title='India', sortorder=98);
addRecord(table='countries', code='IQ', title='Iraq', sortorder=101);
addRecord(table='countries', code='IR', title='Iran', sortorder=100);
addRecord(table='countries', code='IS', title='Iceland', sortorder=97);
addRecord(table='countries', code='IT', title='Italy', sortorder=105);
addRecord(table='countries', code='JE', title='Jersey', sortorder=108);
addRecord(table='countries', code='JM', title='Jamaica', sortorder=106);
addRecord(table='countries', code='JO', title='Jordan', sortorder=109);
addRecord(table='countries', code='JP', title='Japan', sortorder=107);
addRecord(table='countries', code='KE', title='Kenya', sortorder=111);
addRecord(table='countries', code='KG', title='Kyrgyzstan', sortorder=115);
addRecord(table='countries', code='KH', title='Cambodia', sortorder=36);
addRecord(table='countries', code='KI', title='Kiribati', sortorder=113);
addRecord(table='countries', code='KM', title='Comoros', sortorder=48);
addRecord(table='countries', code='KN', title='St. Kitts/Nevis', sortorder=183);
addRecord(table='countries', code='KO', title='Kosovo', sortorder=112);
addRecord(table='countries', code='KP', title='North Korea', sortorder=160);
addRecord(table='countries', code='KR', title='South Korea', sortorder=203);
addRecord(table='countries', code='KW', title='Kuwait', sortorder=114);
addRecord(table='countries', code='KY', title='Cayman Islands', sortorder=40);
addRecord(table='countries', code='KZ', title='Kazakhstan', sortorder=110);
addRecord(table='countries', code='LA', title='Lao', sortorder=116);
addRecord(table='countries', code='LB', title='Lebanon', sortorder=118);
addRecord(table='countries', code='LC', title='St. Lucia', sortorder=184);
addRecord(table='countries', code='LI', title='Liechtenstein', sortorder=122);
addRecord(table='countries', code='LK', title='Sri Lanka', sortorder=205);
addRecord(table='countries', code='LR', title='Liberia', sortorder=120);
addRecord(table='countries', code='LS', title='Lesotho', sortorder=119);
addRecord(table='countries', code='LT', title='Lithuania', sortorder=123);
addRecord(table='countries', code='LU', title='Luxembourg', sortorder=124);
addRecord(table='countries', code='LV', title='Latvia', sortorder=117);
addRecord(table='countries', code='LY', title='Libya', sortorder=121);
addRecord(table='countries', code='MA', title='Morocco', sortorder=145);
addRecord(table='countries', code='MC', title='Monaco', sortorder=141);
addRecord(table='countries', code='MD', title='Moldova', sortorder=140);
addRecord(table='countries', code='ME', title='Montenegro', sortorder=143);
addRecord(table='countries', code='MF', title='St. Martin', sortorder=185);
addRecord(table='countries', code='MG', title='Madagascar', sortorder=127);
addRecord(table='countries', code='MH', title='Marshall Islands', sortorder=133);
addRecord(table='countries', code='MK', title='Macedonia', sortorder=126);
addRecord(table='countries', code='ML', title='Mali', sortorder=131);
addRecord(table='countries', code='MM', title='Myanmar', sortorder=147);
addRecord(table='countries', code='MN', title='Mongolia', sortorder=142);
addRecord(table='countries', code='MO', title='Macao', sortorder=125);
addRecord(table='countries', code='MP', title='Northern Mariana Islands', sortorder=161);
addRecord(table='countries', code='MQ', title='Martinique', sortorder=134);
addRecord(table='countries', code='MR', title='Mauritania', sortorder=135);
addRecord(table='countries', code='MS', title='Montserrat', sortorder=144);
addRecord(table='countries', code='MT', title='Malta', sortorder=132);
addRecord(table='countries', code='MU', title='Mauritius', sortorder=136);
addRecord(table='countries', code='MV', title='Maldives', sortorder=130);
addRecord(table='countries', code='MW', title='Malawi', sortorder=128);
addRecord(table='countries', code='MX', title='Mexico', sortorder=138);
addRecord(table='countries', code='MY', title='Malaysia', sortorder=129);
addRecord(table='countries', code='MZ', title='Mozambique', sortorder=146);
addRecord(table='countries', code='NA', title='Namibia', sortorder=148);
addRecord(table='countries', code='NC', title='New Caledonia', sortorder=153);
addRecord(table='countries', code='NE', title='Niger', sortorder=156);
addRecord(table='countries', code='NF', title='Norfolk Island', sortorder=159);
addRecord(table='countries', code='NG', title='Nigeria', sortorder=157);
addRecord(table='countries', code='NI', title='Nicaragua', sortorder=155);
addRecord(table='countries', code='NL', title='Netherlands', sortorder=151);
addRecord(table='countries', code='NO', title='Norway', sortorder=162);
addRecord(table='countries', code='NP', title='Nepal', sortorder=150);
addRecord(table='countries', code='NR', title='Nauru', sortorder=149);
addRecord(table='countries', code='NU', title='Niue', sortorder=158);
addRecord(table='countries', code='NZ', title='New Zealand', sortorder=154);
addRecord(table='countries', code='OM', title='Oman', sortorder=163);
addRecord(table='countries', code='PA', title='Panama', sortorder=167);
addRecord(table='countries', code='PE', title='Peru', sortorder=170);
addRecord(table='countries', code='PF', title='French Polynesia', sortorder=74);
addRecord(table='countries', code='PG', title='Papua New Guinea', sortorder=168);
addRecord(table='countries', code='PH', title='Philippines', sortorder=171);
addRecord(table='countries', code='PK', title='Pakistan', sortorder=164);
addRecord(table='countries', code='PL', title='Poland', sortorder=173);
addRecord(table='countries', code='PM', title='St. Pierre/Miquelon', sortorder=186);
addRecord(table='countries', code='PN', title='Pitcairn', sortorder=172);
addRecord(table='countries', code='PR', title='Puerto Rico', sortorder=175);
addRecord(table='countries', code='PS', title='Palestine', sortorder=166);
addRecord(table='countries', code='PT', title='Portugal', sortorder=174);
addRecord(table='countries', code='PW', title='Palau', sortorder=165);
addRecord(table='countries', code='PY', title='Paraguay', sortorder=169);
addRecord(table='countries', code='QA', title='Qatar', sortorder=176);
addRecord(table='countries', code='RE', title='Réunion', sortorder=177);
addRecord(table='countries', code='RO', title='Romania', sortorder=178);
addRecord(table='countries', code='RS', title='Serbia', sortorder=193);
addRecord(table='countries', code='RU', title='Russian Federation', sortorder=179);
addRecord(table='countries', code='RW', title='Rwanda', sortorder=180);
addRecord(table='countries', code='SA', title='Saudi Arabia', sortorder=191);
addRecord(table='countries', code='SB', title='Solomon Islands', sortorder=199);
addRecord(table='countries', code='SC', title='Seychelles', sortorder=194);
addRecord(table='countries', code='SD', title='Sudan', sortorder=206);
addRecord(table='countries', code='SE', title='Sweden', sortorder=210);
addRecord(table='countries', code='SG', title='Singapore', sortorder=196);
addRecord(table='countries', code='SH', title='St. Helena', sortorder=182);
addRecord(table='countries', code='SI', title='Slovenia', sortorder=198);
addRecord(table='countries', code='SJ', title='Svalbard/Jan Mayen', sortorder=208);
addRecord(table='countries', code='SK', title='Slovakia', sortorder=197);
addRecord(table='countries', code='SL', title='Sierra Leone', sortorder=195);
addRecord(table='countries', code='SM', title='San Marino', sortorder=189);
addRecord(table='countries', code='SN', title='Senegal', sortorder=192);
addRecord(table='countries', code='SO', title='Somalia', sortorder=200);
addRecord(table='countries', code='SR', title='Suriname', sortorder=207);
addRecord(table='countries', code='ST', title='Sao Tome/Principe', sortorder=190);
addRecord(table='countries', code='SV', title='El Salvador', sortorder=63);
addRecord(table='countries', code='SY', title='Syrian Arab Republic', sortorder=212);
addRecord(table='countries', code='SZ', title='Swaziland', sortorder=209);
addRecord(table='countries', code='TC', title='Turks/Caicos Islands', sortorder=225);
addRecord(table='countries', code='TD', title='Chad', sortorder=42);
addRecord(table='countries', code='TF', title='French Southern Territories', sortorder=75);
addRecord(table='countries', code='TG', title='Togo', sortorder=218);
addRecord(table='countries', code='TH', title='Thailand', sortorder=216);
addRecord(table='countries', code='TJ', title='Tajikistan', sortorder=214);
addRecord(table='countries', code='TK', title='Tokelau', sortorder=219);
addRecord(table='countries', code='TL', title='Timor-Leste', sortorder=217);
addRecord(table='countries', code='TM', title='Turkmenistan', sortorder=224);
addRecord(table='countries', code='TN', title='Tunisia', sortorder=222);
addRecord(table='countries', code='TO', title='Tonga', sortorder=220);
addRecord(table='countries', code='TR', title='Turkey', sortorder=223);
addRecord(table='countries', code='TT', title='Trinidad And Tobago', sortorder=221);
addRecord(table='countries', code='TV', title='Tuvalu', sortorder=226);
addRecord(table='countries', code='TW', title='Taiwan', sortorder=213);
addRecord(table='countries', code='TZ', title='Tanzania', sortorder=215);
addRecord(table='countries', code='UA', title='Ukraine', sortorder=228);
addRecord(table='countries', code='UG', title='Uganda', sortorder=227);
addRecord(table='countries', code='UM', title='United States Minor Islands', sortorder=232);
addRecord(table='countries', code='US', title='United States', sortorder=231);
addRecord(table='countries', code='UY', title='Uruguay', sortorder=233);
addRecord(table='countries', code='UZ', title='Uzbekistan', sortorder=234);
addRecord(table='countries', code='VA', title='Vatican City State', sortorder=236);
addRecord(table='countries', code='VC', title='St. Vincent/The Grenadines', sortorder=187);
addRecord(table='countries', code='VE', title='Venezuela', sortorder=237);
addRecord(table='countries', code='VG', title='Virgin Islands, British', sortorder=239);
addRecord(table='countries', code='VI', title='Virgin Islands, U.S.', sortorder=240);
addRecord(table='countries', code='VN', title='Viet Nam', sortorder=238);
addRecord(table='countries', code='VU', title='Vanuatu', sortorder=235);
addRecord(table='countries', code='WF', title='Wallis/Futuna', sortorder=241);
addRecord(table='countries', code='WS', title='Samoa', sortorder=188);
addRecord(table='countries', code='YE', title='Yemen', sortorder=243);
addRecord(table='countries', code='YT', title='Mayotte', sortorder=137);
addRecord(table='countries', code='ZA', title='South Africa', sortorder=201);
addRecord(table='countries', code='ZM', title='Zambia', sortorder=244);
addRecord(table='countries', code='ZW', title='Zimbabwe', sortorder=245);
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}

	    </cfscript>
	     <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
  <cffunction name="down">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
removeRecord(table='countries');
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}

	    </cfscript>
	    <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
</cfcomponent>


