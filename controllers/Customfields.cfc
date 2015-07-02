//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Custom Fields and Templating"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessCustomfields");
		filters(through="denyInDemoMode", except="index");
		useslayout(template=false, only="fieldpicker");

		// Verification
		verifies(only="delete,deletetemplate", params="key", paramsTypes="string", route="home", error="Sorry, that field can't be found");

	}

/******************** Public***********************/

/******************** Admin ***********************/

	/**
	*  @hint Custom fields index
	*/
	public void function index() {
		customfields=model("customfield").findAll(order="parentmodel ASC,sortorder ASC");
		customtemplates=model("template").findAll(order="parentmodel ASC");
	}

	/**
	*  @hint Add New Custom Field
	*/
	public void function add() {
		customfield=model("customfield").new();
	}

	/**
	*  @hint Create Custom Field
	*/
	public void function create() {
		if(structkeyexists(params, "customfield")){
	    	customfield = model("customfield").new(params.customfield);
			if ( customfield.save() ) {
				redirectTo(action="index", success="customfield successfully created");
			}
	        else {
				renderPage(action="add", error="There were problems creating that customfield");
			}
		}
	}

	/**
	*  @hint Edit Custom Field
	*/
	public void function edit() {
		customfield=model("customfield").findOne(where="id = #params.key#");
	}

	/**
	*  @hint Update Custom Field
	*/
	public void function update() {
		if(structkeyexists(params, "customfield")){
	    	customfield = model("customfield").findOne(where="id = #params.key#");
			customfield.update(params.customfield);
			if ( customfield.save() )  {
				redirectTo(action="index", success="customfield successfully updated");
			}
	        else {
				renderPage(action="edit", error="There were problems updating that customfield");
			}
		}
	}

	/**
	*  @hint Delete Custom Field
	*/
	public void function delete() {
    	customfield = model("customfield").findOne(where="id = #params.key#");
		if ( customfield.delete() )  {
			redirectTo(action="index", success="customfield successfully deleted");
		}
        else {
			redirectTo(action="index", error="There were problems deleting that customfield");
		}
	}

/******************** Templating ***********************/
	/**
	*  @hint Add New Template
	*/
	public void function addtemplate() {
		template=model("template").new();
		template.template='';
 	}

	/**
	*  @hint Create Template
	*/
	public void function createtemplate() {
		if(structkeyexists(params, "template")){
	    	template = model("template").new(params.template);
			if ( template.save() ) {
				redirectTo(action="index", success="template successfully created");
			}
	        else {
				renderPage(action="addtemplate", error="There were problems creating that template");
			}
		}
	}

	/**
	*  @hint Edit Template
	*/
	public void function edittemplate() {
		template=model("template").findOne(where="parentmodel = '#params.key#' AND type='#params.type#'");
	}

	/**
	*  @hint Update Template
	*/
	public void function updatetemplate() {
		if(structkeyexists(params, "template")){
	    	template = model("template").findOne(where="parentmodel = '#params.key#' AND type='#params.type#'");
			template.update(params.template);
			if ( template.save() )  {
				redirectTo(action="index", success="template successfully updated");
			}
	        else {
				renderPage(action="edittemplate", error="There were problems updating that template");
			}
		}
	}

	/**
	*  @hint Delete Template
	*/
	public void function deletetemplate() {
    	template = model("template").findOne(where="parentmodel = '#params.key#' AND type='#params.type#'");
		if ( template.delete() )  {
			redirectTo(action="index", success="template successfully deleted");
		}
        else {
			redirectTo(action="index", error="There were problems deleting that template");
		}
	}
/******************** Private *********************/

/******************** Ajax/Remote/Misc*************/
	/**
	*  @hint Gridmanger field picker
	*/
	public string function fieldpicker() {
			systemfields=model(params.key).new();
			customfields=getBlankCustomFields(params.key);

	}

}