component extends="Model" hint="Event Repeat Rule"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		belongsTo("event");
		validatespresenceof("starts");
		validate("checkStartDate");
	}

	/**
	*  @hint
	*/
	public void function checkStartDate() {
		if(structKeyExists(this, "type") AND len(this.type)){
			// Really need a repeat start date for repeats to work properly.
			if(!isDate(this.starts)){
				this.starts=now();
			}
		}
	}
}