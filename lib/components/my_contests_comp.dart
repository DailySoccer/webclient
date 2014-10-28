library my_contests_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/models/contest.dart';

@Component(
  selector: 'my-contests',
  templateUrl: 'packages/webclient/components/my_contests_comp.html',
  useShadowDom: false
)
class MyContestsComp implements DetachAware {

  MyContestsService myContestsService;

  String liveSortType = "contest-start-time_asc";
  String waitingSortType = "contest-start-time_asc";
  String historySortType = "contest-start-time_desc";

  bool get hasLiveContests    => myContestsService.liveContests     == null ? false : myContestsService.liveContests.length     > 0;
  bool get hasWaitingContests => myContestsService.waitingContests  == null ? false : myContestsService.waitingContests.length  > 0;
  bool get hasHistoryContests => myContestsService.historyContests  == null ? false : myContestsService.historyContests.length  > 0;

  int get totalHistoryContestsWinner => myContestsService.historyContests.fold(0, (prev, contest) => (contest.getContestEntryWithUser(_profileService.user.userId).position == 0) ? prev+1 : prev);
  int get totalHistoryContestsPrizes => myContestsService.historyContests.fold(0, (prev, contest) => prev + contest.getContestEntryWithUser(_profileService.user.userId).prize);

  MyContestsComp(this._profileService, this._refreshTimersService, this.myContestsService, this._router, this._flashMessage) {

    myContestsService.clear();

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _updateLive);
  }

  void onWaitingRowClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId": contest.contestId, "parent": "my_contests", "viewContestEntryMode": "viewing"});
  }

  void onWaitingActionClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId": contest.contestId, "parent": "my_contests", "viewContestEntryMode": "viewing"});
  }

  void onLiveRowClick(Contest contest) {
    _router.go('live_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void onLiveActionClick(Contest contest) {
    _router.go('live_contest', {"contestId": contest.contestId, "parent": "my_contests"});
  }

  void onHistoryRowClick(Contest contest) {
    _router.go('history_contest', {"contestId": contest.contestId, "parent": "my_contests"});
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
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }


  void _updateLive() {
    myContestsService.refreshMyContests()
      .then((_) {})
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  Router _router;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
}