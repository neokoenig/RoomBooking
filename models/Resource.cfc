//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Resources Model"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany("eventresources");
	}

}