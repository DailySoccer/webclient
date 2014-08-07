library my_contests_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
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

  MyContestsComp(this.myContestsService, this._router, this._flashMessage) {
    _updateLive();
    _timer = new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateLive());
  }

  String waitingColumns = "ID-1,TORNEO-4,INICIO-1,SALARIO-1,CONTRINCANTE-2,ENTRADA-1,PREMIOS-2";
  String liveColumns, historyColumns = "ID-1,TORNEO-4,SALARIO-1,PUNTOS-1,CONTRINCANTE-2,ENTRADA-1,PREMIOS-2";

  void onWaitingRowClick(Contest contest) {
  }

  void onWaitingActionClick(Contest contest) {
  }

  void onLiveRowClick(Contest contest) {
  }

  void onLiveActionClick(Contest contest) {
    _router.go('live_contest', {"contestId" : contest.contestId});
  }

  void onHistoryRowClick(Contest contest) {
  }

  void onHistoryActionClick(Contest contest) {
    _router.go('history_contest', {"contestId" : contest.contestId});
  }

  void gotoLobby() {
    _router.go("lobby", {});
  }

  void detach() {
    if (_timer != null)
      _timer.cancel();
  }

  void _generateLiveTable() {

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

  Timer _timer;
  Router _router;
  FlashMessagesService _flashMessage;
}