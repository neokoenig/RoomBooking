//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Custom Fields"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany(name="customfieldjoins");
		property(name="sortorder", defaultValue=0);
	}

}