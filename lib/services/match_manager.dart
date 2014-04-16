library match_manager;

import 'dart:async';

import "package:json_object/json_object.dart";

import '../services/server_request.dart';
import "../models/match_day.dart";

class MatchManager {
  bool initialized = false;
  
  var _matchDays;
  
  ServerRequest _server;
  
  MatchManager( this._server );

  Future updated () {
    if ( !initialized ) {
      return all;
    }
    return new Future.value( true );
  }
  
  Future< List<MatchDay> > get all {
    print("MatchManager: all");

    return _server.matchAll()
      .then( (responseJson) {
        initialized = true;
        
        var response = new JsonObject.fromJsonString( responseJson );
        print( "response: $response" );
        
        // Inicialización del mapa de partidos
        _matchDays = new Map<String, MatchDay>();
        for (var x in response) {
          print("match: ${x.id}: $x");
          _matchDays[x.id] = new MatchDay.initFromJSONObject(x);
        }
        
        // Devolver el map en formato lista
        // REVIEW: ¿usar _matchDays.values?
        var list = new List<MatchDay>();
        _matchDays.forEach( (k,v) => list.add(v) );
        return list;        
      });
  }
  
  String startDate( String matchDayId ) {
    MatchDay matchDay = _matchDays[ matchDayId ];
    return matchDay.date;
  }
}