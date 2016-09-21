library scouting_comp;

//import 'dart:html';
//import 'dart:async';
//import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/loading_service.dart';
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/instance_soccer_player.dart";
//import 'package:webclient/utils/string_utils.dart';
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
import 'package:webclient/components/leaderboards/leaderboard_comp.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/components/enter_contest/soccer_player_stats_comp.dart';

@Component(
    selector: 'scouting',
    templateUrl: 'packages/webclient/components/scouting/scouting_comp.html',
    useShadowDom: false
)
class ScoutingComp implements DetachAware {

  static bool favoritesIsSaving = false;
  static const String SOCCER_PLAYER_STATS = "SOCCER_PLAYER_STATS";
  static const String SOCCER_PLAYERS_LIST = "SOCCER_PLAYERS_LIST";
  
  String statsMode = SoccerPlayerStatsComp.FAVORITE_MODE;
  
  LoadingService loadingService;

  List<SoccerPlayerListItem> favoritesPlayers = [];
  List<SoccerPlayerListItem> allSoccerPlayersES;
  List<Map<String, String>> teamListES = [];  
  List<SoccerPlayerListItem> allSoccerPlayersUK;
  List<Map<String, String>> teamListUK = [];  

  num managerLevel = 0;
  
  FieldPos fieldPosFilter = FieldPos.GOALKEEPER;
  
  bool leagueES_isLoading;
  bool leagueUK_isLoading;
  bool onlyFavorites = false;
  bool thereIsNewFavorites;
  
  SoccerPlayerListItem selectedInstanceSoccerPlayer;
  
  String _sectionActive = SOCCER_PLAYERS_LIST;
  String get sectionActive => _sectionActive;
  
  void set sectionActive(String section) { 
    _sectionActive = section;
    switch(_sectionActive) {
      case SOCCER_PLAYERS_LIST:        
        refreshTopBar();
        _appStateService.appSecondaryTabBarState.tabList = _tabList;
      break;
      case SOCCER_PLAYER_STATS:
        _appStateService.appSecondaryTabBarState.tabList = [];
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Estadísticas");
        _appStateService.appTopBarState.activeState.onLeftColumn = goBack;
        _appStateService.appTabBarState.show = true; 
        
      break;
    }
  }

  bool get isSoccerPlayerListActive => sectionActive == SOCCER_PLAYERS_LIST;
  bool get isSoccerPlayerStatsActive => sectionActive == SOCCER_PLAYER_STATS;
  
  bool get isCurrentSelectedFavorite => favoritesPlayers.contains(selectedInstanceSoccerPlayer);
  
  String _selectedPlayerId = "";
  String get selectedPlayerId => _selectedPlayerId;
  
  void set selectedPlayerId(String value) {
    _selectedPlayerId = value == null || value == "" ? "" : value;
  }

  ScoutingComp(this._router, this.loadingService, this._profileService, this._soccerPlayerService, this._appStateService, this._refreshTimersService, this._leaderBoardService) {
    if (_profileService.isLoggedIn) {
      managerLevel = _profileService.user.managerLevel;
    }
    refreshTopBar();
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, refreshTopBar);
     
    _tabList = [
      new AppSecondaryTabBarTab("POR",                                        () => setFilter(FieldPos.GOALKEEPER, false),() => FieldPos.GOALKEEPER == fieldPosFilter),
      new AppSecondaryTabBarTab("DEF",                                        () => setFilter(FieldPos.DEFENSE, false),   () => FieldPos.DEFENSE == fieldPosFilter),
      new AppSecondaryTabBarTab("MED",                                        () => setFilter(FieldPos.MIDDLE, false),    () => FieldPos.MIDDLE == fieldPosFilter),
      new AppSecondaryTabBarTab("DEL",                                        () => setFilter(FieldPos.FORWARD, false),   () => FieldPos.FORWARD == fieldPosFilter),
      new AppSecondaryTabBarTab('''<i class="material-icons">&#xE838;</i>''', () => setFilter(null, true),                () => onlyFavorites)
    ];

    _appStateService.appSecondaryTabBarState.tabList = _tabList;
    _appStateService.appTabBarState.show = true;    
    
    loadData();
    thereIsNewFavorites = false;
    GameMetrics.logEvent(GameMetrics.SCOUTING);
  }
  
  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
  }
  
  void goBack() {
    selectedPlayerId = "";
    selectedInstanceSoccerPlayer = null;
    sectionActive = SOCCER_PLAYERS_LIST;
  }
  
  void setFilter(FieldPos fieldpos, bool onlyfavs) {
    fieldPosFilter = fieldpos;
    onlyFavorites = onlyfavs;    
  }
  
  void refreshTopBar() {
    if (isSoccerPlayerStatsActive)
      return;
    
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router, _leaderBoardService);
  }

  void loadData() {
    loadingService.isLoading = true;
    leagueES_isLoading = true;
    leagueUK_isLoading = true;

    void loadUKData() {
      _soccerPlayerService.getSoccerPlayersByCompetition(Competition.LEAGUE_UK_ID)
        .then((Map info) {
          List<InstanceSoccerPlayer> instanceSoccerPlayers = info["instanceSoccerPlayers"];
          List<SoccerTeam> soccerTeams = info["soccerTeams"];
          
          allSoccerPlayersUK = new List<SoccerPlayerListItem>();
          teamListUK = [];
          
          instanceSoccerPlayers.forEach( (InstanceSoccerPlayer instance) {
            if (instance.soccerPlayer.name != TemplateSoccerPlayer.UNKNOWN) {
              allSoccerPlayersUK.add( new SoccerPlayerListItem(instance, managerLevel, null));
            } else {
              // Con la caché de TemplateSoccerPlayers es posible que recibamos futbolistas "desconocidos"
              Logger.root.severe("WTF 1013: Bad SoccerPlayer: ${instance.soccerPlayer.templateSoccerPlayerId}");
            }
          });          
          soccerTeams.forEach((team) {
            teamListUK.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });
          updateFavorites();
        }
      );
    }
    void loadESData() {
      _soccerPlayerService.getSoccerPlayersByCompetition(Competition.LEAGUE_ES_ID)
        .then((Map info) {
          List<InstanceSoccerPlayer> instanceSoccerPlayers = info["instanceSoccerPlayers"];
          List<SoccerTeam> soccerTeams = info["soccerTeams"];
  
          allSoccerPlayersES = new List<SoccerPlayerListItem>();
          teamListES = [];
          
          instanceSoccerPlayers.forEach((InstanceSoccerPlayer instance) {
            if (instance.soccerPlayer.name != TemplateSoccerPlayer.UNKNOWN) {
              allSoccerPlayersES.add( new SoccerPlayerListItem(instance, managerLevel, null));
            } else {
              // Con la caché de TemplateSoccerPlayers es posible que recibamos futbolistas "desconocidos"
              Logger.root.severe("WTF 1013: Bad SoccerPlayer: ${instance.soccerPlayer.templateSoccerPlayerId}");
            }
          });        
          soccerTeams.forEach((team) {
            teamListES.add({"id": team.templateSoccerTeamId, "name": team.name, "shortName": team.shortName});
          });
          updateFavorites();
          
          leagueES_isLoading = false;
          // Para evitar la carga simultanea y sobrecarga de peticiones, concatenamos la llamada a la liga UK trás la liga ES.
          //loadUKData();
        }
      );
    }
    
    loadESData();
    loadingService.isLoading = false;
  }

  void onSoccerPlayerInfo(SoccerPlayerListItem soccerPlayer) {
    selectedInstanceSoccerPlayer = soccerPlayer;
    selectedPlayerId = selectedInstanceSoccerPlayer.id;
    sectionActive  = SOCCER_PLAYER_STATS;
  }
  
  void updateFavorites() {
    favoritesPlayers.clear();
    favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
        allSoccerPlayersES.firstWhere( (player) => player.id == playerId,
            orElse: () => allSoccerPlayersES.firstWhere( (player) => player.id == playerId,
            orElse: () => null))
      ).where( (d) => d != null));
  }
  
  void onFavoritesChange(var soccerPlayer) {
    if (!(leagueES_isLoading /*|| leagueUK_isLoading*/)) {
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
      _soccerPlayerService.setFavorites(favoritesPlayers.map((player) => player.id).toList())
        .then( (_) {
            favoritesIsSaving = false;
            if (thereIsNewFavorites) saveFavorites();
        }
      );
    }
  }
  
  void addToFavorites(String playerId) {
    SoccerPlayerListItem scli = allSoccerPlayersES.firstWhere( (player) => player.id == playerId);
    onFavoritesChange(scli);
  }

  List<AppSecondaryTabBarTab> _tabList = [];
  
  Router _router;
  
  SoccerPlayerService _soccerPlayerService;
  ProfileService _profileService;
  AppStateService _appStateService;
  RefreshTimersService _refreshTimersService;
  LeaderboardService _leaderBoardService;
}