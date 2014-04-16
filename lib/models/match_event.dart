library match_day;

import "package:json_object/json_object.dart";

class MatchEvent {
  String id;
  String teamIdA;
  String teamIdB;
  String date;

  MatchEvent( this.id, this.teamIdA, this.teamIdB, this.date );

  MatchEvent.initFromJSONObject( JsonObject json ) {
    _initFromJSONObject( json );
  }

  _initFromJSONObject( JsonObject json ) {
      id        = json.id;
      teamIdA   = json.teamIdA;
      teamIdB   = json.teamIdB;
      date      = json.date;

      print( "new MatchEvent: $json" );
  }
}