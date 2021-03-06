library scouting_league_comp;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';

@Component(
    selector: 'scouting-league',
    templateUrl: 'packages/webclient/components/scouting/scouting_league_comp.html',
    useShadowDom: false
)
class ScoutingLeagueComp implements DetachAware {

  LoadingService loadingService;
  List<dynamic> _allSoccerPlayers;
  List<dynamic> _favoritesPlayers;
  bool onlyFavorites = false;

  List<Map<String, String>> _teamList = [];

  @NgOneWay('soccer-player-list')
  void set allSoccerPlayers(List<dynamic> players) {
    _allSoccerPlayers = players;
  }
  List<dynamic> get allSoccerPlayers => _allSoccerPlayers;

  @NgTwoWay('favorites-player-list')
  void set favoritesPlayers(List<dynamic> players) {
    _favoritesPlayers = players;
  }
  List<dynamic> get favoritesPlayers => _favoritesPlayers;

  @NgOneWay('team-list')
  void set teamList(List<Map<String, String>> teams) {
    _teamList = teams;
  }
  List<Map<String, String>> get teamList => _teamList;

  @NgCallback('on-action-button')
  Function onSoccerPlayerAction;

  void onSoccerPlayerActionButton(var soccerPlayer) {
    onSoccerPlayerAction({"soccerPlayer": soccerPlayer});
  }

  String idSufix;
  @NgOneWay('id-sufix')
  void set identifier(String id) {
    idSufix = id;
  }

  FieldPos fieldPosFilter;
  String nameFilter;
  String teamFilter;

  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "favorites", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  ScoutingLeagueComp(this._routeProvider, this._router) {
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

  void onRowClick(String soccerPlayerId) {
    ModalComp.open(_router, "scouting.soccer_player_stats", {
        "soccerPlayerId": soccerPlayerId,
        "selectable": (favoritesPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId, orElse: () => null) == null)
      }, addSoccerPlayerToFavorite);
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

  Element alertMaxplayerInSameTeam;
}