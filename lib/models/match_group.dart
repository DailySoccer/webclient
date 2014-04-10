library match_group;

import "package:json_object/json_object.dart";

class MatchGroup {
  String id;
  List<String> matchIdList;
  
  MatchGroup( this.id, this.matchIdList );
  
  MatchGroup.initFromJSONObject( JsonObject json ) {
    _initFromJSONObject( json );
  }
  
  _initFromJSONObject( JsonObject json ) {
      id          = json.id;
      matchIdList = json.matchIdList;
      
      print( "new MatchGroup: $json" );
  }  
}