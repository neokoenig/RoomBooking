//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Custom Field Values"
{
	/*
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany(name="customfieldjoins");
	}

}