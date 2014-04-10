library group_manager;

import "package:json_object/json_object.dart";
import 'package:angular/angular.dart';

import "../services/match_manager.dart";
import "../models/match_group.dart";

/*
@NgInjectableService(
)
*/
class GroupManager {
  var _groups;
  
  MatchManager _matchManager;
  
  GroupManager( this._matchManager ) {
    print("new GroupManager");
    initFromJson( json );
  }
  
  initFromJson( String json ) {
    _groups = new Map<String, MatchGroup>();
    
    var collection = new JsonObject.fromJsonString( json );
    for (var x in collection) {
      var group = new MatchGroup.initFromJSONObject(x);
      _groups[group.id]= group;
    }
  }
  
  String startDate( String groupId ) {
    MatchGroup matchGroup = _groups[ groupId ];
    return _matchManager.startDate( matchGroup.matchIdList[0] );
  }
  
  String json = """
[
  {
    "id":"1-001",
    "matchIdList": ["1-BRACRO", "2-MEXCMR", "3-ESPNED", "4-CHIAUS"]
  }
]
  """;  
}