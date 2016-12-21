component extends="controllers.Controller"
/*
	Main API Responses used application wide. Should conform to JSONApi Spec
	http://jsonapi.org/format/
*/
{
	function init() {
		provides("json");
		filters(through="isValidAPIRequest");
	}

//=====================================================================
//= 	Public Endpoints
//=====================================================================

	function environment(){
		respond("data": {"environment": get("environment")});
	}

//=====================================================================
//= 	Auth'd / Checked Endpoints
//=====================================================================

//=====================================================================
//= 	Private
//=====================================================================
	private function isValidAPIRequest(){
		var req=GetHTTPRequestData();

		// Create default response Object;
		createResponse();

		// Servers MUST send all JSON API data in response documents with the header
		// Content-Type: application/vnd.api+json without any media type parameters.
		params.format="json";
		checkUnsupportedMediaType(req);
		checkMediaParameters(req);
	}

	// Servers MUST respond with a 415 Unsupported Media Type status code if a request
	// specifies the header Content-Type: application/vnd.api+json with any media type parameters.
	private function checkUnsupportedMediaType(required struct req){
		if(!structKeyExists(req, "headers")
			|| !structKeyExists(req.headers, "Content-Type")
			|| req.headers["Content-Type"] != "application/vnd.api+json"){
			resp["errors"]=[];
			arrayAppend(resp.errors, {"code": 415, "title": "Unsupported Media Type"});
			renderWith(data=resp, status=415);
		}
	}

	// TODO: Servers MUST respond with a 406 Not Acceptable status code if a request’s
	/// Accept header contains the JSON API media type and all instances of that media type are modified with media type parameters.
	private function checkMediaParameters(required struct req){

	}

	private function respond(struct data, struct errors, status=200){
		if(structKeyExists(arguments, "data")){
			resp["data"]=data;
		}
		if(structKeyExists(arguments, "errors")){
			resp["error"]=error;
		}
		renderWith(data=resp, status=status);
	}

	private function createResponse(){
		resp={
			"jsonapi": {
				"version": "1.0"
			},
			"meta": {
				"generator": "OxAlto RoomBooking System",
				"version": "#application.rbs.version#"
			}
		};
	}

}
