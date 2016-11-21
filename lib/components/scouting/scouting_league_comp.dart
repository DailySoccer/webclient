library scouting_league_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';

@Component(
    selector: 'scouting-league',
    templateUrl: 'scouting_league_comp.html'
)
class ScoutingLeagueComp implements OnDestroy {

  LoadingService loadingService;
  List<SoccerPlayerListItem> _allSoccerPlayers;
  List<SoccerPlayerListItem> _favoritesPlayers;
  
  @Input('only-favorites')
  bool onlyFavorites = false;

  List<Map<String, String>> _teamList = [];

  @Input('soccer-player-list')
  void set allSoccerPlayers(List<SoccerPlayerListItem> players) {
    _allSoccerPlayers = players;
  }
  List<SoccerPlayerListItem> get allSoccerPlayers => _allSoccerPlayers;

  @Input('favorites-player-list')
  void set favoritesPlayers(List<SoccerPlayerListItem> players) {
    _favoritesPlayers = players;
  }
  List<SoccerPlayerListItem> get favoritesPlayers => _favoritesPlayers;

  @Input('team-list')
  void set teamList(List<Map<String, String>> teams) {
    _teamList = teams;
  }

  List<Map<String, String>> get teamList => _teamList;

  @Input('on-action-button')
  Function onSoccerPlayerAction;
  
  @Input('on-info-button')
  Function onInfoPlayerButton;

  void onSoccerPlayerActionButton(var soccerPlayer) {
    onSoccerPlayerAction({"soccerPlayer": soccerPlayer});
  }

  String idSufix;
  @Input('id-sufix')
  void set identifier(String id) {
    idSufix = id;
  }

  @Input('filter-pos')
  FieldPos fieldPosFilter;

  @Input('name-filter')
  String nameFilter;
  String teamFilter;
/*
  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "favorites", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }
*/
  ScoutingLeagueComp() {
    //removeAllFilters();
  }
  /*
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
  */

  @override void ngOnDestroy() {
    /*_routeHandle.discard();

    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }*/
  }

  void onRowClick(String soccerPlayerId) {
    onInfoPlayerButton({'soccerPlayer': _allSoccerPlayers.firstWhere((player) => player.id == soccerPlayerId)});
  }
  /*
  void addSoccerPlayerToFavorite(String soccerPlayerId) {
    var soccerPlayer = allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer.id == soccerPlayerId, orElse: () => null);
    onSoccerPlayerActionButton(soccerPlayer);
  }

  void removeAllFilters() {
    fieldPosFilter = null;
    nameFilter = null;
    teamFilter = null;
  }
*/
  Element alertMaxplayerInSameTeam;
}