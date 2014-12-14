//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Event Resource Model"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		belongsTo("event");
		belongsTo("resource");
	}

}