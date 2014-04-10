library match_manager;

import "package:json_object/json_object.dart";

import "../models/match_day.dart";

class MatchManager {
  var _matchDays;
  
  MatchManager() {
    print("new MatchManager");
    _initFromJson( json );
  }

  MatchManager.initFromJson(String json) {
    print("new MatchManager");
    _initFromJson( json );
  }
  
  _initFromJson( String json ) {
    _matchDays = new Map<String, MatchDay>();
    
    var collection = new JsonObject.fromJsonString( json );
    for (var x in collection) {
      var match = new MatchDay.initFromJSONObject(x);
      _matchDays[match.id] = match;
    }
  }
  
  String startDate( String matchDayId ) {
    MatchDay matchDay = _matchDays[ matchDayId ];
    return matchDay.date;
  }
  
  String json = """
[
  {
    "id":"1-BRACRO",
    "teamIdA":"BRA",
    "teamIdB":"CRO",
    "date":"2014/06/12-21:00"
  },
  {
    "id":"2-MEXCMR",
    "teamIdA":"MEX",
    "teamIdB":"CMR",
    "date":"2014/06/13-17:00"
  },
  {
    "id":"3-ESPNED",
    "teamIdA":"ESP",
    "teamIdB":"NED",
    "date":"2014/06/13-20:00"
  },
  {
    "id":"4-CHIAUS",
    "teamIdA":"CHI",
    "teamIdB":"AUS",
    "date":"2014/06/13-23:00"
  }
]
  """;
}