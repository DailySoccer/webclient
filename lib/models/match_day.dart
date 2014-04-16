library match_day;

import "package:json_object/json_object.dart";

import "soccer_team.dart";

class MatchDay {
  String id;
  SoccerTeam   teamA;
  SoccerTeam   teamB;
  String date;
  
  MatchDay( this.id, this.teamA, this.teamB, this.date );
  
  MatchDay.initFromJSONObject( JsonObject json ) {
    _initFromJSONObject( json );
  }
  
  _initFromJSONObject( JsonObject json ) {
      id        = json.id;
      date      = json.date;

      teamA     = new SoccerTeam.initFromJSONObject( json.teamA );
      teamB     = new SoccerTeam.initFromJSONObject( json.teamB );
      
      print( "new MatchDay: $json" );
  }
}