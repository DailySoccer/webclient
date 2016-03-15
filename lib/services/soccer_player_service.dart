library soccer_player_service;

import 'dart:async';
import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/contest.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/match_event.dart";
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/template_soccer_team.dart';
import 'package:webclient/models/template_soccer_player.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/services/template_service.dart';


@Injectable()
class SoccerPlayerService {

  InstanceSoccerPlayer instanceSoccerPlayer;
  SoccerPlayer soccerPlayer;
  MatchEvent nextMatchEvent;

  SoccerPlayerService(this._server, this._contestsService, this._profileService);

  // InstanceSoccerPlayer en cualquiera de los ultimos concursos recibidos
  InstanceSoccerPlayer getInstanceSoccerPlayer(String contestId, String instanceSoccerPlayerId) {

    InstanceSoccerPlayer ret = null;

    Contest contest = _contestsService.getContestById(contestId);
    if (contest != null) {
      ret = contest.getInstanceSoccerPlayer(instanceSoccerPlayerId);
    }

    return ret;
  }

  Future refreshInstancePlayerInfo(String contestId, String instanceSoccerPlayerId) {
    var completer = new Completer();

    Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getInstancePlayerInfo(contestId, instanceSoccerPlayerId)])
        .then((List jsonMaps) {
          TemplateReferences templateReferences = TemplateService.Instance.references;
          ContestReferences contestReferences = new ContestReferences();

          nextMatchEvent = jsonMaps[1].containsKey("match_event") ? new MatchEvent.fromJsonObject(jsonMaps[1]["match_event"], contestReferences) : null;
          jsonMaps[1]["soccer_teams"].forEach( (jsonTeam) =>
              new SoccerTeam.fromJsonObject(jsonTeam, templateReferences, contestReferences) );
          
          instanceSoccerPlayer = new InstanceSoccerPlayer.initFromJsonObject(jsonMaps[1]["instance_soccer_player"], contestReferences);
          
          soccerPlayer = new SoccerPlayer.fromId(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId, instanceSoccerPlayer.soccerTeam.templateSoccerTeamId, templateReferences, contestReferences);
          TemplateService.Instance.getTemplateSoccerPlayer(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId).loadStatsFromJsonObject(jsonMaps[1]["soccer_player"], templateReferences);
          
          completer.complete();
        });

    return completer.future;
  }

  Future refreshSoccerPlayerInfo(String soccerPlayerId) {
    var completer = new Completer();

    Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getSoccerPlayerInfo(soccerPlayerId)])
        .then((List jsonMaps) {
          TemplateReferences templateReferences = TemplateService.Instance.references;
          ContestReferences contestReferences = new ContestReferences();

          nextMatchEvent = jsonMaps[1].containsKey("match_event") ? new MatchEvent.fromJsonObject(jsonMaps[1]["match_event"], contestReferences) : null;
          jsonMaps[1]["soccer_teams"].forEach( (jsonTeam) =>
              new SoccerTeam.fromJsonObject(jsonTeam, templateReferences, contestReferences) );
          
          instanceSoccerPlayer = new InstanceSoccerPlayer.initFromJsonObject(jsonMaps[1]["instance_soccer_player"], contestReferences);
          
          soccerPlayer = new SoccerPlayer.fromId(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId, instanceSoccerPlayer.soccerTeam.templateSoccerTeamId, templateReferences, contestReferences);
          TemplateService.Instance.getTemplateSoccerPlayer(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId).loadStatsFromJsonObject(jsonMaps[1]["soccer_player"], templateReferences);
          
          completer.complete();
        });

    return completer.future;
  }

  Future getSoccerPlayersByCompetition(String competitionId) {
    var completer = new Completer();

    Future.wait([TemplateService.Instance.refreshTemplateSoccerPlayers(), _server.getSoccerPlayersByCompetition(competitionId)])
        .then((List jsonMaps) {
          TemplateReferences templateReferences = TemplateService.Instance.references;
          ContestReferences contestReferences = new ContestReferences();
          
          List<InstanceSoccerPlayer> instanceSoccerPlayers = [];
          List<SoccerTeam> soccerTeams = [];

          if (jsonMaps[1].containsKey("soccer_teams")) {
            soccerTeams = jsonMaps[1]["soccer_teams"].map( (jsonTeam) =>
                new SoccerTeam.fromJsonObject(jsonTeam, templateReferences, contestReferences)).toList();
          }

          if (jsonMaps[1].containsKey("instanceSoccerPlayers")) {
            jsonMaps[1]["instanceSoccerPlayers"].forEach((jsonObject) {
              InstanceSoccerPlayer instanceSoccerPlayer = new InstanceSoccerPlayer.initFromJsonObject(jsonObject, contestReferences);
              instanceSoccerPlayers.add( instanceSoccerPlayer );
              
              // Asociar el soccerPlayer
              new SoccerPlayer.fromId(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId, instanceSoccerPlayer.soccerTeam.templateSoccerTeamId, templateReferences, contestReferences);
            });
          }

          /*
          if (jsonMaps[1].containsKey("soccer_players")) {
            jsonMaps[1]["soccer_players"].map((jsonMap) => new SoccerPlayer.fromJsonObject(jsonMap, templateReferences, contestReferences)).toList();
          }
          */ 

          if (jsonMaps[1].containsKey("profile")) {
            _profileService.updateProfileFromJson(jsonMaps[1]["profile"]);
          }

          completer.complete({
              "instanceSoccerPlayers": instanceSoccerPlayers,
              "soccerTeams": soccerTeams
            });
        });

    return completer.future;
  }

  Future setFavorites(List<String> soccerPlayers) {
    var completer = new Completer();

    _server.favorites(soccerPlayers)
      .then((jsonMap) {
        if (jsonMap.containsKey("profile")) {
          _profileService.updateProfileFromJson(jsonMap["profile"]);
        }

        completer.complete(_profileService.isLoggedIn ? _profileService.user.favorites : []);
    });

    return completer.future;
  }

  ServerService _server;
  ProfileService _profileService;

  ContestsService _contestsService;
}