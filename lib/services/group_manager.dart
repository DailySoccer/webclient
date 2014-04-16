library group_manager;

import 'dart:async';
import "package:json_object/json_object.dart";

import '../services/server_request.dart';
import "../services/match_manager.dart";
import "../models/match_group.dart";

class GroupManager {
  bool initialized = false;
  
  var _groups;
  
  ServerRequest _server;
  MatchManager _matchManager;
  
  GroupManager( this._server, this._matchManager );
  
  Future updated () {
    if ( !initialized ) {
      return all;
    }
    return new Future.value( true );
  }
  
  Future< List<MatchGroup> > get all {
    print("MatchGroup: all");

    return _matchManager.updated()
      .then( (_) => _server.groupAll() )
      .then( (responseJson) {
        initialized = true;
      
        var response = new JsonObject.fromJsonString( responseJson );
        print( "response: $response" );
        
        // Inicialización del mapa de grupos de partidos
        _groups = new Map<String, MatchGroup>();
        for (var x in response) {
          print("group: ${x.id}: $x");
          _groups[x.id] = new MatchGroup.initFromJSONObject(x);
        }
        
        // Devolver el map en formato lista
        // REVIEW: ¿usar _matchGroups.values?
        var list = new List<MatchGroup>();
        _groups.forEach( (k,v) => list.add(v) );
        return list;        
      });
  }
  
  String startDate( String groupId ) {
    MatchGroup matchGroup = _groups[ groupId ];
    // REVIEW: Averiguar cuál es la fecha más próxima de la lista de partidos
    return _matchManager.startDate( matchGroup.matchIdList[0] );
  }
}