library soccer_team;

import "package:json_object/json_object.dart";

import "soccer.dart";

class SoccerTeam {
  String id;
  String name;
  List<Soccer> soccers = new List<Soccer>();
  
  SoccerTeam.initFromJSONObject( JsonObject json ) {
    _initFromJSONObject( json );
  }
  
  _initFromJSONObject( JsonObject json ) {
      id    = json.id;
      name  = json.name;
      
      for (var x in json.soccers) {
        soccers.add( new Soccer.initFromJSONObject(x) );
      }
      
      print( "new SoccerTeam: $json" );
  }  
}