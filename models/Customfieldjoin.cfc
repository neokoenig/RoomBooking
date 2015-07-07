//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Custom Field Joins"
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