library scouting_league_comp;

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
    selector: 'scouting-league',
    templateUrl: 'packages/webclient/components/scouting/scouting_league_comp.html',
    useShadowDom: false
)
class ScoutingLeagueComp implements DetachAware {
  
  LoadingService loadingService;
  List<dynamic> _allSoccerPlayers;
  List<dynamic> _favoritesPlayers;
  
  List<Map<String, String>> _teamList = [];

  @NgOneWay('soccer-player-list')
  void set allSoccerPlayers(List<dynamic> players) {
    _allSoccerPlayers = players;
  }
  List<dynamic> get allSoccerPlayers => _allSoccerPlayers;
  
  @NgOneWay('favorites-player-list')
  void set favoritesPlayers(List<dynamic> players) {
    _favoritesPlayers = players;
  }
  List<dynamic> get favoritesPlayers => _favoritesPlayers;
  
  @NgOneWay('team-list')
  void set teamList(List<Map<String, String>> teams) {
    _teamList = teams;
  }
  List<Map<String, String>> get teamList => _teamList;
  
  FieldPos fieldPosFilter;
  String nameFilter;
  String teamFilter;

  final String LEAGUE_ES = "LEAGUE_ES";
  final String LEAGUE_UK = "LEAGUE_UK";

  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "favorites", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  ScoutingLeagueComp(this._routeProvider, this._router,
                   this._contestsService, this.loadingService, this._profileService, this._catalogService,
                   this._flashMessage, this._rootElement, this._tutorialService, this._soccerPlayerService) {
    removeAllFilters();
    //_parent = _routeProvider.parameters["parent"];

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
  }

  void detach() {
    /*_routeHandle.discard();

    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }*/
  }
/*

  void onSoccerPlayerActionButton(var soccerPlayer) {

    int indexOfPlayer = favoritesPlayers.indexOf(soccerPlayer);
    if (indexOfPlayer != -1) {
      favoritesPlayers.remove(soccerPlayer);
    } else {
      // TODO: control max
      favoritesPlayers.add(soccerPlayer);
    }
  }

  void initAllSoccerPlayers() {
    int intId = 0;
    allSoccerPlayers = new List<dynamic>();

    contest.instanceSoccerPlayers.forEach((templateSoccerId, instanceSoccerPlayer) {

      MatchEvent matchEvent = instanceSoccerPlayer.soccerTeam.matchEvent;
      SoccerTeam soccerTeam = instanceSoccerPlayer.soccerTeam;

      String shortNameTeamA = matchEvent.soccerTeamA.shortName;
      String shortNameTeamB = matchEvent.soccerTeamB.shortName;

      var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == matchEvent.soccerTeamA.templateSoccerTeamId)
           ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
           : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

      allSoccerPlayers.add({
        "instanceSoccerPlayer": instanceSoccerPlayer,
        "id": instanceSoccerPlayer.id,
        "intId": intId++,
        "fieldPos": instanceSoccerPlayer.fieldPos,
        "fieldPosSortOrder": instanceSoccerPlayer.fieldPos.sortOrder,
        "fullName": instanceSoccerPlayer.soccerPlayer.name,
        "fullNameNormalized": StringUtils.normalize(instanceSoccerPlayer.soccerPlayer.name).toUpperCase(),
        "matchId" : matchEvent.templateMatchEventId,
        "matchEventName": matchEventName,
        "remainingMatchTime": "-",
        "fantasyPoints": instanceSoccerPlayer.soccerPlayer.getFantasyPointsForCompetition(contest.optaCompetitionId),
        "playedMatches": instanceSoccerPlayer.soccerPlayer.getPlayedMatchesForCompetition(contest.optaCompetitionId),
        "salary": instanceSoccerPlayer.salary
      });
    });
  }

  void removeAllFilters() {
    fieldPosFilter = null;
    nameFilter = null;
    teamFilter = null;
  }
  /*
  void deleteFantasyTeam() {
    resetLineup();
    removeAllFilters();
    availableSalary = contest.salaryCap;
    // Comprobamos si estamos en salario negativo
    isNegativeBalance = availableSalary < 0;
    _verifyMaxPlayersInSameTeam();
  }
  */

  String get _getKeyForCurrentUserContest => (_profileService.isLoggedIn ? _profileService.user.userId : 'guest') + '#' + contest.optaCompetitionId;
  */

  void onRowClick(String soccerPlayerId) {
    ModalComp.open(_router, "enter_contest.soccer_player_stats", { "instanceSoccerPlayerId":soccerPlayerId, "selectable": true}, addSoccerPlayerToFavorite);
  }

  void onSoccerPlayerActionButton(var soccerPlayer) {

    int indexOfPlayer = favoritesPlayers.indexOf(soccerPlayer);
    if (indexOfPlayer != -1) {
      favoritesPlayers.remove(soccerPlayer);
    } else {
      // TODO: control max
      favoritesPlayers.add(soccerPlayer);
    }
  }

  void addSoccerPlayerToFavorite(String soccerPlayerId) {
    var soccerPlayer = allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId, orElse: () => null);
    onSoccerPlayerActionButton(soccerPlayer);
  }

  void removeAllFilters() {
    fieldPosFilter = null;
    nameFilter = null;
    teamFilter = null;
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