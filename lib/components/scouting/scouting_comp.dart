library scouting_comp;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/models/competition.dart';

@Component(
    selector: 'scouting',
    templateUrl: 'packages/webclient/components/scouting/scouting_comp.html',
    useShadowDom: false
)
class ScoutingComp implements DetachAware {

  LoadingService loadingService;

  List<dynamic> favoritesPlayers = [];

  List<dynamic> allSoccerPlayersES;
  List<Map<String, String>> teamListES = [];
  bool leagueES_isLoading;
  List<dynamic> allSoccerPlayersUK;
  List<Map<String, String>> teamListUK = [];
  bool leagueUK_isLoading;

  String currentTab = 'spanish-league';

  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "favorites", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  ScoutingComp(this._routeProvider, this._router,
                   this._contestsService, this.loadingService, this._profileService, this._catalogService,
                   this._flashMessage, this._rootElement, this._tutorialService, this._soccerPlayerService) {
    loadData();
  }

  void loadData() {
    loadingService.isLoading = true;
    leagueES_isLoading = true;
    leagueUK_isLoading = true;
    int intId = 0;
    
    void loadUKData() {
      _soccerPlayerService.getSoccerPlayersByCompetition(Competition.LEAGUE_UK_ID)
        .then((Map info) {
          List<InstanceSoccerPlayer> instanceSoccerPlayers = info["instanceSoccerPlayers"];
          List<SoccerTeam> soccerTeams = info["soccerTeams"];
          
          print ("InstanceSoccerPlayers UK: ${instanceSoccerPlayers.length}");
          allSoccerPlayersUK = new List<dynamic>();
          teamListUK = [];
          instanceSoccerPlayers.forEach( (InstanceSoccerPlayer instance) {
            allSoccerPlayersUK.add({
              "instanceSoccerPlayer": instance,
              "id": instance.id,
              "intId": intId++,
              "fieldPos": instance.fieldPos,
              "fieldPosSortOrder": instance.fieldPos.sortOrder,
              "fullName": instance.soccerPlayer.name,
              "fullNameNormalized": StringUtils.normalize(instance.soccerPlayer.name).toUpperCase(),
              "matchId" :  instance.soccerTeam.templateSoccerTeamId,
              "matchEventName": instance.soccerTeam.name.toUpperCase(),
              "remainingMatchTime": "-",
              "fantasyPoints": instance.soccerPlayer.fantasyPoints,
              "playedMatches": instance.soccerPlayer.getPlayedMatchesForCompetition(Competition.LEAGUE_UK_ID),
              "salary": instance.salary
            });
          });
          soccerTeams.forEach((team) {
            teamListUK.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });

          leagueUK_isLoading = false;
          evaluateTabLoading();
          updateFavorites();
        });
    }
    
    
    _soccerPlayerService.getSoccerPlayersByCompetition(Competition.LEAGUE_ES_ID)
        .then((Map info) {
          List<InstanceSoccerPlayer> instanceSoccerPlayers = info["instanceSoccerPlayers"];
          List<SoccerTeam> soccerTeams = info["soccerTeams"];
          
          print ("InstanceSoccerPlayers ES: ${instanceSoccerPlayers.length}");
          allSoccerPlayersES = new List<dynamic>();
          teamListES = [];
          instanceSoccerPlayers.forEach( (InstanceSoccerPlayer instance) {
            allSoccerPlayersES.add({
              "instanceSoccerPlayer": instance,
              "id": instance.id,
              "intId": intId++,
              "fieldPos": instance.fieldPos,
              "fieldPosSortOrder": instance.fieldPos.sortOrder,
              "fullName": instance.soccerPlayer.name,
              "fullNameNormalized": StringUtils.normalize(instance.soccerPlayer.name).toUpperCase(),
              "matchId" :  instance.soccerTeam.templateSoccerTeamId,
              "matchEventName": instance.soccerTeam.name.toUpperCase(),
              "remainingMatchTime": "-",
              "fantasyPoints": instance.soccerPlayer.fantasyPoints,
              "playedMatches": instance.soccerPlayer.getPlayedMatchesForCompetition(Competition.LEAGUE_ES_ID),
              "salary": instance.salary
            });
          });
          soccerTeams.forEach((team) {
            teamListES.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });
          
          leagueES_isLoading = false;
          evaluateTabLoading();
          loadUKData();
          updateFavorites();
        });
  }
  
  void updateFavorites() {
    favoritesPlayers.clear();
    
    favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) {
        allSoccerPlayersES.firstWhere( (player) => player['id'] == playerId, 
            orElse: () => allSoccerPlayersES.firstWhere( (player) => player['id'] == playerId, 
            orElse: () => null));
      }).where( (d) => d != null));
  }

  Future getContentJson(String fileName) {
    var completer = new Completer();
    HttpRequest.getString(fileName).then((json) {
        completer.complete(JSON.decode(json));
      });
    return completer.future;
  }

  void tabChange(String tab) {
    querySelectorAll("#enter-contest-wrapper .tab-pane").classes.remove('active');
    querySelector("#${tab}").classes.add("active");
    currentTab = tab;
  }
  
  void evaluateTabLoading() {
    loadingService.isLoading = (currentTab == 'spanish-league' && leagueES_isLoading) || 
                               (currentTab == 'premier-league' && leagueUK_isLoading);
  }
  
  void detach() {
    /*_routeHandle.discard();

    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }*/
  }

  void onFavoritesChange(var soccerPlayer) {
    if (!(leagueES_isLoading || leagueES_isLoading)) {
      int indexOfPlayer = favoritesPlayers.indexOf(soccerPlayer);
      if (indexOfPlayer != -1) {
        favoritesPlayers.remove(soccerPlayer);
      } else {
        // TODO: control max
        favoritesPlayers.add(soccerPlayer);
      }
      _soccerPlayerService.setFavorites(favoritesPlayers.map((player) => player["id"]).toList());
    }
  }

  Router _router;
  RouteProvider _routeProvider;
  String _parent;

  SoccerPlayerService _soccerPlayerService;
  TutorialService _tutorialService;
  ContestsService _contestsService;
  ProfileService _profileService;
  CatalogService _catalogService;
  FlashMessagesService _flashMessage;

  var _streamListener;
  ElementList<dynamic> _totalSalaryTexts;

  Timer _retryOpTimer;
  ScreenDetectorService _scrDet;

  RouteHandle _routeHandle;

  bool _teamConfirmed = false;
  bool _isRestoringTeam = false;

  Element _rootElement;
  Element alertMaxplayerInSameTeam;
}