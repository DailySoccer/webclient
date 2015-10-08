library contests_list_f2p_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:math';
import 'package:webclient/services/datetime_service.dart';
import 'dart:html';

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
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "VER";
  
  @NgOneWay("show-date")
  bool showDate = true;

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

  String getContestTypeIcon(Contest contest) {
    return contest.isSimulation ? "train" : "real";
  }

  String getContestMorfology(Contest contest) {
    return contest.hasSpecialImage ? "special" : "normal";
  }

  String getContestImage(Contest contest) {
    return contest.hasSpecialImage ? contest.specialImage : "";
  }

  
  String timeInfo(DateTime date) {
    // Avisamos 2 horas antes...
    if (DateTimeService.isToday(date) && date.isAfter(DateTimeService.now)) {
      Duration duration = DateTimeService.getTimeLeft(date);
      int minutesLeft = duration.inMinutes;
      if (minutesLeft >= 0 && minutesLeft < 120) {
        return (minutesLeft >= 30) ? "${minutesLeft} min." : "Faltan";
      }
    }
    return DateTimeService.formatTimeShort(date);
  }
  
  String dateInfo(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (DateTimeService.isToday(date)) {
      Duration duration = DateTimeService.getTimeLeft(date);

      // Avisamos unos minutos antes (30 min)
      if (duration.inMinutes >= 0 && duration.inMinutes < 30) {
        int secondsTotal = duration.inSeconds;
        int minutes = secondsTotal ~/ 60;
        int seconds = secondsTotal - (minutes * 60);
        if (minutes >= 0 && seconds >= 0) {
          return (seconds >= 10) ? "$minutes:$seconds" : "$minutes:0$seconds";
        }
      }
      return "Today";
    }
    return DateTimeService.formatDateShort(date);
  }

  /********* HANDLERS */
  void onRow(Contest contest) {
    if (onRowClick != null) {
      onRowClick({"contest":contest});
    }
  }

  void onAction(Contest contest, Event event) {
    event.stopPropagation();
    if (onActionClick != null) {
      onActionClick({"contest":contest});
    }
  }
}