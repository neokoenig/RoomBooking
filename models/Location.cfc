//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Locations Model"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany("events");
	}

}