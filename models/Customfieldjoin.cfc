component extends="Model" hint=""
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		belongsTo(name="customfield", joinType="left");
		belongsTo(name="customfieldvalue", joinType="left");
	}

}