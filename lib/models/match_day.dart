library match_day;

import "package:json_object/json_object.dart";

class MatchDay {
  String id;
  String teamIdA;
  String teamIdB;
  String date;
  
  MatchDay( this.id, this.teamIdA, this.teamIdB, this.date );
  
  MatchDay.initFromJSONObject( JsonObject json ) {
    _initFromJSONObject( json );
  }
  
  _initFromJSONObject( JsonObject json ) {
      id        = json.id;
      teamIdA   = json.teamIdA;
      teamIdB   = json.teamIdB;
      date      = json.date;
      
      print( "new MatchDay: $json" );
  }
}