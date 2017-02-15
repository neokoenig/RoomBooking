<cfscript>

  // Create simplish set of arrays for buildings + room picker
  array function getBuildingArray(){
    local.rv=[];
    local.buildings=model("building").findall(order="title");
    // "Standalone" Rooms container
    arrayAppend(local.rv, {
        "id": 0,
        "title": "Standalone Rooms",
        "icon": "",
        "hexcolour": "b.hexcolour",
        "children": []
    });

    for(b in local.buildings){
      arrayAppend(local.rv, {
        "id": b.id,
        "calendarid": b.calendarid,
        "title": b.title,
        "icon": b.icon,
        "hexcolour": b.hexcolour,
        "children": []
      });
    }
    return local.rv;
  }

  array function getRoomArray(){
    local.rv=[];
    local.rooms=model("room").findall(order="title");
    for(b in local.rooms){
      arrayAppend(local.rv, {
        "id": b.id,
        "calendarid": b.calendarid,
        "title": b.title,
        "icon": b.icon,
        "hexcolour": b.hexcolour,
        "buildingid": b.buildingid
      });
    }
    return local.rv;
  }

  array function getLocationsAsNestedArray(array buildings, array rooms){
    local.rv=[];
    local.buildings=arguments.buildings;
    local.rooms=arguments.rooms;
    local.c=1;
    for(b in local.buildings){
      arrayAppend(local.rv, b);
        for(r in local.rooms){
          if(r.buildingid == b.id){
            arrayAppend(local.rv[c]["children"], r);
          }
        }
      c++;
    }
    return local.rv;
  }

  // Merge buildings and Rooms for a calendar, seperate by groupby etc
  array function mergeLocations(calendarbuildings, calendarrooms){
    local.rv=[];
    local.cb=1;
    for(local.b in calendarbuildings){
      arrayAppend(local.rv, {
        "id": local.b.id,
        "calendarid": local.b.calendarid,
        "fc_resourceid": "#local.b.id#",
        "title": local.b.title,
        "hexcolour": local.b.hexcolour,
        "icon": local.b.icon,
        "description": local.b.description,
        "type": "building",
        "groupby": {}
      });

      for(local.r in calendarrooms){
        // Rooms attached to buildings
        if(local.r.buildingid == local.b.id && local.b.id != 0 && local.b.id != ""){
          if( structKeyExists(local.rv[local.cb], "groupby") ){
            if( !structKeyExists(local.rv[local.cb]["groupby"], local.r.groupby) ){
              local.rv[local.cb]["groupby"][local.r.groupby]=[];
            }
            arrayAppend(local.rv[local.cb]["groupby"][local.r.groupby], {
              "id": local.r.id,
              "calendarid": local.r.calendarid,
              "fc_resourceid": "#local.b.id#-#local.r.id#",
              "title": local.r.title,
              "hexcolour": local.r.hexcolour,
              "icon": local.r.icon,
              "description": local.r.description,
              "type": "room"
            });
          }
        }
      }
      local.cb++;
    }
    // Check for orphaned rooms and append to end
    for(local.r in calendarrooms){
      if(local.r.buildingid == 0 || local.r.buildingid == ""){
        // Orphaned Rooms
        arrayAppend(local.rv, {
          "id": local.r.id,
          "calendarid": local.r.calendarid,
          "fc_resourceid": "0-#local.r.id#",
          "title": local.r.title,
          "hexcolour": local.r.hexcolour,
          "icon": local.r.icon,
          "description": local.r.description,
          "type": "room"
        });
      }
    }
    return local.rv;
   }
   </cfscript>
