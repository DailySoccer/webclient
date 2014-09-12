library my_contests_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/models/contest.dart';

@Component(
  selector: 'my-contests',
  templateUrl: 'packages/webclient/components/my_contests_comp.html',
  publishAs: 'comp',
  useShadowDom: false
)

class MyContestsComp implements DetachAware {

  MyContestsService myContestsService;

  MyContestsComp(this._profileService, this.myContestsService, this._router, this._flashMessage) {
    _updateLive();
    _timer = new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateLive());
  }

  void onWaitingRowClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void onWaitingActionClick(Contest contest) {
    _router.go('view_contest_entry', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void onLiveRowClick(Contest contest) {
    _router.go('live_contest', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void onLiveActionClick(Contest contest) {
    _router.go('live_contest', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void onHistoryRowClick(Contest contest) {
    _router.go('history_contest', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void onHistoryActionClick(Contest contest) {
    _router.go('history_contest', {"contestId" : contest.contestId, "parent" : "my_contests"});
  }

  void gotoLobby() {
    _router.go("lobby", {});
  }

  void detach() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _updateLive() {
    myContestsService.refreshMyContests()
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  bool get hasLiveContests    => myContestsService.liveContests     == null ? false : myContestsService.liveContests.length     > 0;
  bool get hasWaitingContests => myContestsService.waitingContests  == null ? false : myContestsService.waitingContests.length  > 0;
  bool get hasHistoryContests => myContestsService.historyContests  == null ? false : myContestsService.historyContests.length  > 0;

  int get totalHistoryContestsWinner => myContestsService.historyContests.fold(0, (prev, contest) => (contest.getContestEntryWithUser(_profileService.user.userId).position == 0) ? prev+1 : prev);
  int get totalHistoryContestsPrizes => myContestsService.historyContests.fold(0, (prev, contest) => prev + contest.getContestEntryWithUser(_profileService.user.userId).prize);

  Timer _timer;
  Router _router;
  FlashMessagesService _flashMessage;
  ProfileService _profileService;

}