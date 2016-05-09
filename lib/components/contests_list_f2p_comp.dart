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
import 'package:logging/logging.dart';

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

  String getContestCoinIcon(Money money) {
    if(money.currencyUnit == Money.CURRENCY_GOLD) return 'gold';
    if(money.currencyUnit == Money.CURRENCY_ENERGY) return 'energy';
    if(money.currencyUnit == Money.CURRENCY_MANAGER) return 'manager';

    Logger.root.severe("ContestList - Unknown Currency Symbol detected");
    return 'unknown';
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
  
  bool userIsRegistered(Contest contest) {
    return _profileService.isLoggedIn && contest.containsContestEntryWithUser(_profileService.user.userId);
  }
   
  String timeInfo(DateTime date, [bool shortIfPossible = true]) {
    // Avisamos 2 horas antes...
    int secondsLeft = timeLeft(date);
    if (secondsLeft >= 0 && secondsLeft < SOON_SECONDS && shortIfPossible) {
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
  
  String dateInfo(DateTime date, [bool shortIfPossible = true]) {
    // Avisamos cuando sea "Hoy"
    if (DateTimeService.isToday(date) && shortIfPossible) {
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
  
  String getPointsToShow(Contest contest) {
    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory || contest.isLive) {
      return StringUtils.parseFantasyPoints(contest.getContestEntryWithUser(_profileService.user.userId).currentLivePoints);
    }
    return "0";
  }
  
  Money getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
  }
  
  int friendsCount(Contest contest) {
    bool refresh = true;
    if (_friendsCountCache.containsKey(contest.contestId)) {
      Contest cachedContest = _friendsCountCache[contest.contestId]['contest'];
      int cachedUserFriends = _friendsCountCache[contest.contestId]['userFriends'];
      refresh = (cachedContest != contest && contest.contestEntries != cachedContest.contestEntries) || cachedUserFriends != _profileService.friendList.length;
    }
    
    if (refresh) {
      int contestFriends = _profileService.friendList.where( (user) => contest.containsContestEntryWithUser(user.userId)).length;
      int userFriends = _profileService.friendList.length;
      
      _friendsCountCache[contest.contestId] = {
        'contest': contest,
        'userFriends': userFriends,
        'friends': contestFriends
      };
    }
    
    return _friendsCountCache[contest.contestId]['friends'];
  }
  
  bool isCustomContest(Contest contest) {
    return contest.isAuthor(_profileService.user);
  }
  
  String authorImage() {
    return _profileService.user.profileImage;
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

  
  String dateSeparatorText(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (DateTimeService.isToday(date)) {
      return getLocalizedText("today");
    }
    DateTime auxdate = (new DateTime(date.year, date.month, date.day)).subtract(new Duration(days: 1));
    if (DateTimeService.isToday(auxdate)) {
      return getLocalizedText("tomorrow");
    }
    return DateTimeService.formatDateWithDayOfTheMonth(date);
  }
  bool idDifferentDate(Contest contest) {
    bool isDifferent = true;
    if (_lastContest != null){
      isDifferent = contest.startDate.year != _lastContest.startDate.year ||
                    contest.startDate.month != _lastContest.startDate.month ||
                    contest.startDate.day != _lastContest.startDate.day;
    }
    _lastContest = contest;
    return isDifferent;
  }
  Contest _lastContest = null; //while printing, the last contest si saved
  
  DateTime _dateFilter = null;
  Map _sortOrder = {'fieldName':'contest-start-time', 'order': 1};
  Map _friendsCountCache = {};
  ProfileService _profileService;
  ScreenDetectorService scrDet;
}