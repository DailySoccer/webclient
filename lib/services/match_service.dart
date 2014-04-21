library match_service;

import 'dart:async';
import "package:json_object/json_object.dart";

import "package:webclient/services/server_service.dart";
import "package:webclient/models/match_event.dart";


class MatchService {

  bool initialized = false;
   
  String getMatchStartDate(String matchEventId) => _matchEvents[matchEventId].date;

   MatchService(this._server);
  
   Future updated () {
     if ( !initialized ) {
       return getAllMatchEvents();
     }
     return new Future.value( true );
   }
   
   Future< List<MatchEvent> > getAllMatchEvents() {
     print("MatchManager: all");
  
    return _server.getAllMatchEvents()
        .then( (response) {
          initialized = true;
         
           print( "response: $response" );
           
           // Inicialización del mapa de partidos
           _matchEvents = new Map<String, MatchEvent>();
           for (var x in response) {
             print("match: ${x.id}: $x");
             _matchEvents[x.id] = new MatchEvent.fromJsonObject(x);
           }
           
           // Devolver el map en formato lista
           // TODO: ¿usar _matchDays.values?
             var list = new List<MatchEvent>();
             _matchEvents.forEach( (k,v) => list.add(v) );
             return list;        
        });
  }
 
   ServerService _server;
   var _matchEvents;
}