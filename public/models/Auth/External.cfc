component extends="models.Model"
/*  Authentication Tableless Model ?
	All these actions need to operate outside the central permissions system
*/
{
	function init() {
		table(false);
	}
}
