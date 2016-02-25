component extends="Model" hint="Repeating Event Exception"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		belongsTo("event");
	}

}