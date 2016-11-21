library template_service;

import 'dart:async';
import 'package:angular2/core.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/models/template_soccer_team.dart';
import 'package:webclient/models/template_soccer_player.dart';
import 'package:webclient/services/template_references.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/datetime_service.dart';


@Injectable()
class TemplateService {

  static num SECONDS_TO_REFRESH = 60 * 60 * 8; // 8 horas
  // static num SECONDS_TO_REFRESH = 60; // 1 minuto
  static TemplateService get Instance => _instance; 
  
  TemplateService(this._server) {
    _instance = this;
  }

  TemplateReferences get references => _templateReferences;
  
  void forceRefresh() => _dateTimeRefreshed = null;
  
  bool get timedOut => _dateTimeRefreshed == null || (DateTimeService.now.difference(_dateTimeRefreshed).inSeconds > SECONDS_TO_REFRESH);
  
  TemplateSoccerPlayer getTemplateSoccerPlayer(String templateSoccerPlayerId) {
    return _templateReferences.getTemplateSoccerPlayerById(templateSoccerPlayerId);
  }
  
  TemplateSoccerTeam getTemplateSoccerTeam(String templateSoccerTeamId) {
    return _templateReferences.getTemplateSoccerTeamById(templateSoccerTeamId);
  }

  Future refreshTemplateSoccerPlayers() {
    if (_completer == null || timedOut) {
      Logger.root.info("RefreshTemplateSoccerPlayers: ${DateTimeService.now}");
      
      _dateTimeRefreshed = DateTimeService.now;
      
      _completer = new Completer();
  
      Future.wait([_server.getTemplateSoccerTeams(), _server.getTemplateSoccerPlayers()])
          .then((List jsonMaps) {
            _templateReferences = new TemplateReferences();
            
            if (jsonMaps[0].containsKey("template_soccer_teams")) {
              jsonMaps[0]["template_soccer_teams"].map( (jsonTeam) =>
                  new TemplateSoccerTeam.fromJsonObject(jsonTeam, _templateReferences)).toList();
            }
            
            if (jsonMaps[1].containsKey("template_soccer_players")) {
              jsonMaps[1]["template_soccer_players"].map((jsonMap) => 
                  new TemplateSoccerPlayer.fromJsonObject(jsonMap, _templateReferences)).toList();
            }
            
            _completer.complete();
          })
          .catchError((error) {
            forceRefresh();
            
            Logger.root.severe("WTF 7773: refreshTemplateSoccerPlayers Error: ${error}");
            _completer.complete();
          });
    }

    return _completer.future;
  }

  DateTime _dateTimeRefreshed = null;
  TemplateReferences _templateReferences = new TemplateReferences();
  Completer _completer;
  
  ServerService _server;
  
  static TemplateService _instance;
}