library match_manager;

import "package:json_object/json_object.dart";
import 'package:angular/angular.dart';

import "../models/match_day.dart";

/*
@NgInjectableService(
)
*/
class MatchManager {
  var _matchDays;
  
  MatchManager() {
    print("new MatchManager");
    initFromJson( json );
  }
  
  initFromJson( String json ) {
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
    "date":"12/06/2014-21:00"
  },
  {
    "id":"2-MEXCMR",
    "teamIdA":"MEX",
    "teamIdB":"CMR",
    "date":"13/06/2014-17:00"
  },
  {
    "id":"3-ESPNED",
    "teamIdA":"ESP",
    "teamIdB":"NED",
    "date":"13/06/2014-20:00"
  },
  {
    "id":"4-CHIAUS",
    "teamIdA":"CHI",
    "teamIdB":"AUS",
    "date":"13/06/2014-23:00"
  }
]
  """;
}