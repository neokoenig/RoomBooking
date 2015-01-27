component extends="Model" hint=""
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany(name="customfieldjoins");
	}

}