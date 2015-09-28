library contests_list_f2p_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'contests-list-f2p',
    templateUrl: 'packages/webclient/components/contests_list_f2p_comp.html',
    useShadowDom: false
)
class ContestsListF2PComp {

  /********* BINDINGS */
  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    if (value == null || value.isEmpty) {
      return;
    }
    _contestsListOriginal = value;
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "DETAIL";

  @NgCallback('on-list-change')
  Function onListChange;

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "contestlist");
  }

  ContestsListF2PComp(this.scrDet);

  /********* METHODS */
  String getSourceFlag(Contest contest) {
    String ret = "flag ";
    switch(contest.competitionType){
      case "LEAGUE_ES":
        ret += "flag-es";
      break;
      case "LEAGUE_UK":
        ret += "flag-gb";
      break;
      case "CHAMPIONS":
        ret += "flag-eu";
      break;
    }

    return ret;
  }

  /********* HANDLERS */
  void onRow(Contest contest) {
    if (onRowClick != null) {
      onRowClick({"contest":contest});
    }
  }

  void onAction(Contest contest) {
    if (onActionClick != null) {
      onActionClick({"contest":contest});
    }
  }

  /********* PRIVATE DECLARATIONS */
  // Lista original de los contest
  List<Contest> _contestsListOriginal;
  ScreenDetectorService scrDet;
}