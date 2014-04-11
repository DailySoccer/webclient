library contest_manager;

import "package:json_object/json_object.dart";

import "../services/group_manager.dart";
import "../models/contest.dart";

class ContestManager {
  var _contests;
  
  GroupManager _groupManager;
  
  ContestManager( this._groupManager ) {
    // print("new ContestManager");
    initFromJson( json );
  }
    
  initFromJson( String json ) {
    _contests = new Map<String, Contest>();
    
    var collection = new JsonObject.fromJsonString( json );
    for (var x in collection) {
      var contest = new Contest.initFromJSONObject(x);
      
      if ( contest.name.isEmpty ) {
        String date = _groupManager.startDate( contest.groupId );
        contest.name = "Mundial - Salary Cap ${contest.capSalary} - $date";
        print("name: ${contest.name}");
      }
      
      _contests[contest.id] = contest;
    }
  }
  
  List<Contest> all () {
    print("ContestManager: all");
    var list = new List<Contest>();
    _contests.forEach( (k,v) => list.add(v) );
    return list;
  }
  
  Contest get( String contestId ) {
    return _contests[contestId];
  }
  
  String json = """
  [
    { "id": "1-001", "name": "", "groupId": "1-001", "maxPlayers": 10, "capSalary": 60000, "playerIdList": [] }
  ]
  """;
}