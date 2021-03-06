library lobby_f2p_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'lobbyf2p',
  templateUrl: 'packages/webclient/components/lobby_f2p_comp.html',
  useShadowDom: false
)
class LobbyF2PComp implements DetachAware {
  ScreenDetectorService scrDet;
  LoadingService loadingService;
  DateTime selectedDate = null;

  String get today => DateTimeService.today;

  Map<String,List<Contest>> contestListByDay;
  List<Contest> currentContestList;
  List<Map> dayList = new List<Map>();

  LobbyF2PComp(RouteProvider routeProvider, this._router, this._refreshTimersService,
      this._contestsService, this.scrDet, this.loadingService, this._profileService, TutorialService tutorialService) {

    GameMetrics.logEvent(GameMetrics.LOBBY);

    if (_contestsService.activeContests.isEmpty) {
      loadingService.isLoading = true;
    }

    tutorialService.triggerEnter("lobby");

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);
  }

  String getStaticLocalizedText(key) {
    return StringUtils.translate(key, "lobby");
  }
  
  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    _contestsService.refreshActiveContests()
      .then((_) {
        updateDayList();
        loadingService.isLoading = false;
      });
  }

  void updateDayList() {
    dayList = new List<Map>();
    contestListByDay = new Map<String,List<Contest>>();
    DateTime current = DateTimeService.now;
    List<Contest> serverContestList = _contestsService.activeContests;

    
    const int WEEK_DAYS_COUNT = 1; //7; 
    for(int i = 0; i < WEEK_DAYS_COUNT; i++) {
      List<Contest> contestListFiltered = new List<Contest>();
      //contestListFiltered.addAll(serverContestList.where((c) => contestIsAtDate(c, current)));
      contestListFiltered.addAll(serverContestList);
      contestListByDay[_dayKey(current)] = contestListFiltered;

      dayList.add({"weekday": current.weekday.toString(), "monthday": current.day, "date": current, "enabled": contestListFiltered.length > 0});
      current = current.add(new Duration(days: 1));
    }


    if (selectedDate == null) {
      Map firstEnabled = dayList.firstWhere((c) => c['enabled'], orElse: () => null);
      selectedDate = firstEnabled != null? firstEnabled['date'] : DateTimeService.now;
    }

    if (contestListByDay != null) {
      currentContestList = contestListByDay[_dayKey(selectedDate)];
    }
  }

  bool contestIsAtDate(Contest c, DateTime date) {
    return (date.day == c.startDate.day &&
            date.month == c.startDate.month &&
            date.year == c.startDate.year);
  }


  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
  }

  void onSelectedDayChange(DateTime day) {
    selectedDate = day;
    if (contestListByDay != null) {
      currentContestList = contestListByDay[_dayKey(selectedDate)];
    }
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if (scrDet.isDesktop) {
      _router.go('lobby.contest_info', { "contestId": contest.contestId });
    }
    else {
      onActionClick(contest);
    }
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST);
  }

  String _dayKey(DateTime date) {
    return DateTimeService.formatDateWithDayOfTheMonth(date);
  }
  
  bool get showCreateContest => _profileService.isLoggedIn && TutorialService.Instance.isCompleted(TutorialIniciacion.NAME);
  
  void onCreateContestClick() {
    if (!showCreateContest) return;
    _router.go('create_contest', {});
  }

  Router _router;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
}