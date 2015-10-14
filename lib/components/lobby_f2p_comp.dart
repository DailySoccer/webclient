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

  LobbyF2PComp(this._router, this._refreshTimersService, this._contestsService, this.scrDet, this.loadingService, this._profileService) {

    GameMetrics.logEvent(GameMetrics.LOBBY);

    if (_contestsService.activeContests.isEmpty) {
      loadingService.isLoading = true;
    }

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);

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
    
    for(int i = 0; i < 7; i++) {
      List<Contest> contestListFiltered = new List<Contest>();
      contestListFiltered.addAll(serverContestList.where((c) => contestIsAtDate(c, current)));
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
    if (_profileService.isLoggedIn) {
      _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
    }
    else {
      _router.go('enter_contest.welcome', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
    }
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

  Router _router;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
}