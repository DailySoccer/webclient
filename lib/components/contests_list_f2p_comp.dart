library contests_list_f2p_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/money.dart';

@Component(
    selector: 'contests-list-f2p',
    templateUrl: 'packages/webclient/components/contests_list_f2p_comp.html',
    useShadowDom: false
)
class ContestsListF2PComp {

  static const num SOON_SECONDS = 2 * 60 * 60;
  static const num VERY_SOON_SECONDS = 30 * 60;
  
  // Lista original de los contest
  List<Contest> contestsListOriginal = [];
  List<Contest> contestsListOrdered = [];
  
  /********* BINDINGS */
  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    if (value == null || value.isEmpty) {
      contestsListOriginal = new List<Contest>();
      return;
    }
    contestsListOriginal = value;
    refreshListOrder();
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "VER";
  
  @NgOneWay("show-date")
  bool showDate = false;
  
  @NgOneWay("sorting")
  void set sortOrder(Map value) {
    _sortOrder = value;
    refreshListOrder();
  }

  @NgOneWay("date-filter")
  void set filterByDate(DateTime value) {
    _dateFilter = value;
    refreshListOrder();
  }
  
  @NgCallback('on-list-change')
  Function onListChange;

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "contestlist", substitutions);
  }

  ContestsListF2PComp(this.scrDet, this._profileService);

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

  // Date info
  num timeLeft(DateTime date) {
    Duration duration = DateTimeService.getTimeLeft(date);
    int secondsLeft = duration.inSeconds;
    return secondsLeft;
  }
  
  bool isSoon(DateTime date) {
    int secondsLeft = timeLeft(date);
    return secondsLeft >= 0 && secondsLeft < SOON_SECONDS;
  }
  
  String timeInfo(DateTime date) {
    // Avisamos 2 horas antes...
    int secondsLeft = timeLeft(date);
    if (secondsLeft >= 0 && secondsLeft < SOON_SECONDS) {
      int minutes = secondsLeft ~/ 60;
      int seconds = secondsLeft - (minutes * 60);
      
      if (secondsLeft < VERY_SOON_SECONDS) {
        String timeFormatted = (seconds >= 10) ?  "$minutes:$seconds" :  "$minutes:0$seconds";
        return "${getLocalizedText("verySoonHint", {"TIME": timeFormatted})}";
      } else {
        return "${getLocalizedText("soonHint", {"TIME": minutes})}";
      }
    }
    return DateTimeService.formatTimeShort(date);
  }
  
  String dateInfo(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (DateTimeService.isToday(date)) {
      return getLocalizedText("today");
    }
    return DateTimeService.formatDateShort(date);
  }

  void refreshListOrder() {
    if (_sortOrder == null || _sortOrder.isEmpty) {
      return;
    }

    contestsListOrdered = [];
    contestsListOrdered.addAll(contestsListOriginal);

    switch(_sortOrder['fieldName']) {
      case "contest-name":
        contestsListOrdered.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareNameTo(contest2)) );
      break;

      case "contest-entry-fee":
        contestsListOrdered.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareEntryFeeTo(contest2)) );
      break;

      case "contest-start-time":
        contestsListOrdered.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareStartDateTo(contest2)) );
      break;

      default:
        print('-CONTEST_LIST-: No se ha encontrado el campo para ordenar');
      break;
    }
  }

  String printableMyPosition(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory) {
      return (mainContestEntry.position >= 0) ? "${mainContestEntry.position + 1}" : "-";
    }

    return "${contest.getUserPosition(mainContestEntry)}";
  }

  Money getPrizeToShow(Contest contest) {
    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory || contest.isLive) {
      return getMyPrize(contest);
    }

    return contest.prizePool;
  }
  
  Money getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
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
  
  DateTime _dateFilter = null;
  Map _sortOrder = {'fieldName':'contest-start-time', 'order': 1};
  ProfileService _profileService;
  ScreenDetectorService scrDet;
}