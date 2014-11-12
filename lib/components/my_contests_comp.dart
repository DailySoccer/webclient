library my_contests_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/loading_service.dart';

@Component(
  selector: 'my-contests',
  templateUrl: 'packages/webclient/components/my_contests_comp.html',
  useShadowDom: false
)
class MyContestsComp implements DetachAware {

  MyContestsService myContestsService;
  LoadingService loadingService;

  Map liveSortType    = {'fieldName':'contest-start-time', 'order': 1};
  Map waitingSortType = {'fieldName':'contest-start-time', 'order': 1};
  Map historySortType = {'fieldName':'contest-start-time', 'order': 1};

  String get liveContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasLiveContests? "TIENES ${myContestsService.liveContests.length} TORNEOS ACTIVOS" :
                            "AQUÍ PODRÁS CONSULTAR EN TIEMPO REAL LOS TORNEOS QUE TENGAS ACTIVOS";
  }
  String get waitingContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasWaitingContests ? "TE HAS INSCRITO EN ${myContestsService.waitingContests.length} TORNEOS" :
                                "AQUÍ PODRÁS CONSULTAR Y MODIFICAR LOS EQUIPOS QUE TIENES PENDIENTES DE JUGAR EN UN TORNEO";
  }
  String get historyContestsMessage {
    if (loadingService.isLoading)
      return "";

    return hasHistoryContests? "${myContestsService.historyContests.length} REGISTROS ${totalHistoryContestsWinner} GANADOS" :
                               "AQUÍ PODRÁS REPASAR TODOS LOS TORNEOS QUE HAS JUGADO: TUS EQUIPOS, RIVALES, PUNTUACIONES…";
  }

  bool get hasLiveContests    => myContestsService.liveContests     == null ? false : myContestsService.liveContests.length     > 0;
  bool get hasWaitingContests => myContestsService.waitingContests  == null ? false : myContestsService.waitingContests.length  > 0;
  bool get hasHistoryContests => myContestsService.historyContests  == null ? false : myContestsService.historyContests.length  > 0;

  int get totalHistoryContestsWinner => myContestsService.historyContests.fold(0, (prev, contest) => (contest.getContestEntryWithUser(_profileService.user.userId).position == 0) ? prev+1 : prev);
  int get totalHistoryContestsPrizes => myContestsService.historyContests.fold(0, (prev, contest) => prev + contest.getContestEntryWithUser(_profileService.user.userId).prize);

  MyContestsComp(this.loadingService, this._profileService, this._refreshTimersService, this.myContestsService, this._router, this._flashMessage) {

    loadingService.isLoading = true;

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _updateLive);
  }

  void _updateLive() {
    myContestsService.refreshMyContests()
      .then((_) {
        loadingService.isLoading = false;
      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  void onWaitingActionClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId": contest.contestId, "parent": "my_contests", "viewContestEntryMode": "viewing"});
  }

  void onLiveActionClick(Contest contest) {
    _router.go('live_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void onHistoryActionClick(Contest contest) {
    _router.go('history_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void gotoLobby() {
    _router.go("lobby", {});
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS);
  }

  void tabChange(String tab) {

    querySelectorAll(".tab-pane").classes.remove("active");
    querySelector("#" + tab).classes.add("active");

    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  Router _router;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
}