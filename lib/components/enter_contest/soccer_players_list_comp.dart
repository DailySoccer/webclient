library soccer_players_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/contest.dart';

@Component(
    selector: 'soccer-players-list',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_list_comp.html',
    useShadowDom: false
)
class SoccerPlayersListComp {

  ScreenDetectorService scrDet;
  EnterContestComp enterContestComp;

  @NgOneWay("contest")
  void set contest(Contest value) {
    _contest = value;
  }

  @NgCallback("on-row-click")
  Function onRowClick;

  SoccerPlayersListComp(this.enterContestComp, this._contestService, this.scrDet);

  // Para pintar el color correspondiente segun la posicion del jugador
  String getSlotClassColor(String abrevName) => _POS_CLASS_NAMES[abrevName];

  // Numero de caracteres a partir del cual cortamos el nombre y mostramos 3 puntos
  int showWidth(String playerName) => 19;

  void onRow(String soccerPlayerId) {
    if (onRowClick != null) {
      onRowClick({"soccerPlayerId":soccerPlayerId});
    }
  }

  ActiveContestsService _contestService;
  Contest _contest;

  static final Map<String, String> _POS_CLASS_NAMES = { "POR": "posPOR", "DEF": "posDEF", "MED": "posMED", "DEL": "posDEL" };
}
