component extends="controllers.Controller"
{
  function init() {
    super.init();
    filters(through="f_getLocations");
    provides("html,json");
  }

  function new(){

  }
}
