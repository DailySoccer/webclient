library contests_list_f2p_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:math';
import 'package:webclient/services/datetime_service.dart';

@Component(
    selector: 'contests-list-f2p',
    templateUrl: 'packages/webclient/components/contests_list_f2p_comp.html',
    useShadowDom: false
)
class ContestsListF2PComp {

  // Lista original de los contest
  List<Contest> contestsListOriginal;
  ScreenDetectorService scrDet;

  /********* BINDINGS */
  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    if (value == null || value.isEmpty) {
      return;
    }
    contestsListOriginal = value;

    Random rand = new Random();

    _contestTypeValues = new List<String>();
    for (var i = 0; i < contestsListOriginal.length; i++) {
      _contestTypeValues.add(rand.nextInt(2) == 0? 'train' : 'real');
    }
    _contestMorfology = new List<String>();
    for (var i = 0; i < contestsListOriginal.length; i++) {
      _contestMorfology.add(rand.nextInt(2) == 0? 'normal' : 'special');
    }
    _contestImage = new List<String>();
    for (var i = 0; i < contestsListOriginal.length; i++) {
      if (_contestMorfology[i] == 'special') {
        _contestImage.add(rand.nextInt(2) == 0? 'sampleImage1' : 'sampleImage2');
      }
      else
        _contestImage.add("");
    }
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
      default:
        ret += "flag-es";
      break;
    }

    return ret;
  }

  //TODO: Esto es temporal... hay que obtener el valor del contest.
  String getContestTypeIcon(int id) {
    if (_contestTypeValues != null) {
      return  _contestTypeValues[id];
    }

    return "train";
  }

  String getContestMorfology(int id) {
    if (_contestMorfology != null) {
      return _contestMorfology[id];
    }
    return "normal";
  }

  String getContestImage(int id) {
    if (_contestImage != null) {
      return _contestImage[id];
    }
    if (_contestMorfology != null) {
      return _contestMorfology[id] == "normal" ? "" : "sampleImage1";
    }
    return "";
  }

  String timeInfo(DateTime date) {
    return DateTimeService.formatTimeShort(date);
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

  List<String> _contestTypeValues;
  List<String> _contestMorfology;
  List<String> _contestImage;
}