library contest_manager;

import 'dart:async';
import "package:json_object/json_object.dart";

import '../services/server_request.dart';
import "../services/group_manager.dart";
import "../models/contest.dart";

class ContestManager {
  bool initialized = false;
  
  var _contests;
  
  ServerRequest _server;
  GroupManager _groupManager;
  
  ContestManager( this._server, this._groupManager );
    
  Future< List<Contest> > get all {
    print("ContestManager: all");

    return _groupManager.updated()
      .then( (_) => _server.contestAll() )
      .then( (responseJson) {
        initialized = true;
        
        var response = new JsonObject.fromJsonString( responseJson );
        print( "response: $response" );
        
        // Inicialización del mapa de partidos
        _contests = new Map<String, Contest>();
        for (var x in response) {
          print("contest: ${x.id}: $x");
          
          var contest = new Contest.initFromJSONObject(x);
          
          // Generación automática del nombre (si está vacio)
          if (contest.name.isEmpty) {
            String date = _groupManager.startDate( contest.groupId );
            contest.name = "Mundial - Salary Cap ${contest.capSalary} - $date";
            // print("name: ${contest.name}");        
          }
          
          _contests[x.id] = contest;
        }
        
        // Devolver el map en formato lista
        // REVIEW: ¿usar _contests.values?
        var list = new List<Contest>();
        _contests.forEach( (k,v) => list.add(v) );
        return list;
      });
  }
  
  Contest get( String contestId ) {
    return _contests[contestId];
  }

  String startDate( String contestId ) {
    Contest contest = _contests[ contestId ];
    return _groupManager.startDate( contest.groupId );
  }
}