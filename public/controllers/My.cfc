component extends="Controller"
{
  function init() {
    super.init();
    filters(through="f_getCountries");
  }

  function account(){
	   user=model("user").findByKey(session.user.properties.id);
  }
  function accountupdate(){
	   user=model("user").findByKey(session.user.properties.id);
  }
  function bookings(){
    param name="params.page" default="1";
	   bookings=model("booking").findAllByUserid(userid=session.user.properties.id, order="startUTC", page=params.page, perpage=25);
  }
}
