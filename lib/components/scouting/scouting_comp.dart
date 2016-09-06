library scouting_comp;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/loading_service.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/models/competition.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:logging/logging.dart';
import 'package:webclient/models/template_soccer_player.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/refresh_timers_service.dart';

@Component(
    selector: 'scouting',
    templateUrl: 'packages/webclient/components/scouting/scouting_comp.html',
    useShadowDom: false
)
class ScoutingComp implements DetachAware {

  LoadingService loadingService;

  List<SoccerPlayerListItem> favoritesPlayers = [];

  //List<dynamic> allSoccerPlayersES;
  List<SoccerPlayerListItem> allSoccerPlayersES;
  List<Map<String, String>> teamListES = [];
  bool leagueES_isLoading;
  //List<dynamic> allSoccerPlayersUK;
  List<SoccerPlayerListItem> allSoccerPlayersUK;
  List<Map<String, String>> teamListUK = [];
  bool leagueUK_isLoading;
  static bool favoritesIsSaving = false;
  bool thereIsNewFavorites;
  num managerLevel = 0;
  

  FieldPos fieldPosFilter = FieldPos.GOALKEEPER;
  bool onlyFavorites = false;

  String currentTab = 'spanish-league';

  SoccerPlayerListItem selectedInstanceSoccerPlayer;
  
  static const String SOCCER_PLAYER_STATS = "SOCCER_PLAYER_STATS";
  static const String SOCCER_PLAYERS_LIST = "SOCCER_PLAYERS_LIST";
  
  
  String _sectionActive = SOCCER_PLAYERS_LIST;
  
  void set sectionActive(String section) { 
    _sectionActive = section;
    switch(_sectionActive) {
      case SOCCER_PLAYERS_LIST:        
        refreshTopBar();
        _appStateService.appSecondaryTabBarState.tabList = tabList;
      break;
      case SOCCER_PLAYER_STATS:
        _appStateService.appSecondaryTabBarState.tabList = [];
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Estadísticas");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
      break;
    }
  }
  String get sectionActive => _sectionActive;

  bool get isSoccerPlayerListActive => sectionActive == SOCCER_PLAYERS_LIST;
  bool get isSoccerPlayerStatsActive => sectionActive == SOCCER_PLAYER_STATS;
  String get selectedPlayerId => selectedInstanceSoccerPlayer != null ? selectedInstanceSoccerPlayer.id : ""; 
  List<AppSecondaryTabBarTab> tabList = [];
  
  void cancelPlayerDetails() {
    sectionActive = SOCCER_PLAYERS_LIST;
  }
  
  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "favorites", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  ScoutingComp(this._routeProvider, this._router, this.loadingService, this._profileService, this._soccerPlayerService, this._appStateService, this._refreshTimersService) {
    if (_profileService.isLoggedIn) {
      managerLevel = _profileService.user.managerLevel;
    }
    refreshTopBar();
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, refreshTopBar);
     
    tabList = [
      new AppSecondaryTabBarTab("POR",                                        () => setFilter(FieldPos.GOALKEEPER, false),() => FieldPos.GOALKEEPER == fieldPosFilter),
      new AppSecondaryTabBarTab("DEF",                                        () => setFilter(FieldPos.DEFENSE, false),   () => FieldPos.DEFENSE == fieldPosFilter),
      new AppSecondaryTabBarTab("MED",                                        () => setFilter(FieldPos.MIDDLE, false),    () => FieldPos.MIDDLE == fieldPosFilter),
      new AppSecondaryTabBarTab("DEL",                                        () => setFilter(FieldPos.FORWARD, false),   () => FieldPos.FORWARD == fieldPosFilter),
      new AppSecondaryTabBarTab('''<i class="material-icons">&#xE838;</i>''', () => setFilter(null, true),                () => onlyFavorites)
    ];

    _appStateService.appSecondaryTabBarState.tabList = tabList;
    _appStateService.appTabBarState.show = true;    
    
    loadData();
    thereIsNewFavorites = false;
    GameMetrics.logEvent(GameMetrics.SCOUTING);
  }
  
  void setFilter(FieldPos fieldpos, bool onlyfavs) {
    fieldPosFilter = fieldpos;
    onlyFavorites = onlyfavs;    
  }
  
  void refreshTopBar() {
    if (isSoccerPlayerStatsActive)
      return;
    
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router);
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
          //allSoccerPlayersUK = new List<dynamic>();
          
          allSoccerPlayersUK = new List<SoccerPlayerListItem>();
          teamListUK = [];
          
          
          instanceSoccerPlayers.forEach( (InstanceSoccerPlayer instance) {
            allSoccerPlayersUK.add( new SoccerPlayerListItem(instance, managerLevel, null));
            /*
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
              "fantasyPoints": instance.soccerPlayer.getFantasyPointsForCompetition(Competition.LEAGUE_UK_ID),
              "playedMatches": instance.soccerPlayer.getPlayedMatchesForCompetition(Competition.LEAGUE_UK_ID),
              "salary": instance.salary
            });
          */
          });
          soccerTeams.forEach((team) {
            teamListUK.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });

          leagueUK_isLoading = false;
          updateFavorites();
          evaluateTabLoading();
        });
    }


    _soccerPlayerService.getSoccerPlayersByCompetition(Competition.LEAGUE_ES_ID)
        .then((Map info) {
          List<InstanceSoccerPlayer> instanceSoccerPlayers = info["instanceSoccerPlayers"];
          List<SoccerTeam> soccerTeams = info["soccerTeams"];

          print ("InstanceSoccerPlayers ES: ${instanceSoccerPlayers.length}");
          //allSoccerPlayersES = new List<dynamic>();
          allSoccerPlayersES = new List<SoccerPlayerListItem>();
          teamListES = [];
          
         
              
          instanceSoccerPlayers.forEach( (InstanceSoccerPlayer instance) {
            if (instance.soccerPlayer.name != TemplateSoccerPlayer.UNKNOWN) {
              allSoccerPlayersES.add( new SoccerPlayerListItem(instance, managerLevel, null));
              
              /*
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
                "fantasyPoints": instance.soccerPlayer.getFantasyPointsForCompetition(Competition.LEAGUE_ES_ID),
                "playedMatches": instance.soccerPlayer.getPlayedMatchesForCompetition(Competition.LEAGUE_ES_ID),
                "salary": instance.salary
              });
              */
            }
            else {
              // Con la caché de TemplateSoccerPlayers es posible que recibamos futbolistas "desconocidos"
              Logger.root.severe("WTF 1013: Bad SoccerPlayer: ${instance.soccerPlayer.templateSoccerPlayerId}");
            }
          });
          soccerTeams.forEach((team) {
            teamListES.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });

          leagueES_isLoading = false;
          evaluateTabLoading();
          updateFavorites();
          loadUKData();
        });
  }

  void updateFavorites() {
    favoritesPlayers.clear();
    favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
        allSoccerPlayersES.firstWhere( (player) => player.id == playerId,
            orElse: () => allSoccerPlayersES.firstWhere( (player) => player.id == playerId,
            orElse: () => null))
      ).where( (d) => d != null));
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
                               (currentTab == 'premier-league' && leagueUK_isLoading) ||
                               favoritesIsSaving;
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
    
    /*_routeHandle.discard();
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }*/
  }

  void onSoccerPlayerInfo(SoccerPlayerListItem soccerPlayer) {
    selectedInstanceSoccerPlayer = soccerPlayer;
    sectionActive  = SOCCER_PLAYER_STATS;
  }
  
  void onFavoritesChange(var soccerPlayer) {
    if (!(leagueES_isLoading || leagueES_isLoading)) {
      thereIsNewFavorites = favoritesIsSaving;
      int indexOfPlayer = favoritesPlayers.indexOf(soccerPlayer);
      if (indexOfPlayer != -1) {
        favoritesPlayers.remove(soccerPlayer);
      } else {
        // TODO: control max
        favoritesPlayers.add(soccerPlayer);
      }

      saveFavorites();
    }
  }

  void saveFavorites() {
    if (!favoritesIsSaving) {
      thereIsNewFavorites = false;
      favoritesIsSaving = true;
      evaluateTabLoading();
      _soccerPlayerService.setFavorites(favoritesPlayers.map((player) => player.id).toList())
          .then( (_) {
              favoritesIsSaving = false;
              evaluateTabLoading();
              if (thereIsNewFavorites) saveFavorites();
            });
    }
  }

  Router _router;
  RouteProvider _routeProvider;
  String _parent;

  SoccerPlayerService _soccerPlayerService;
  ProfileService _profileService;
  AppStateService _appStateService;
  RefreshTimersService _refreshTimersService;
}