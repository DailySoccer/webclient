library my_contests_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/models/contest.dart';



@Component(selector: 'my-contests',
           templateUrl: 'packages/webclient/components/my_contests_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class MyContestsComp implements DetachAware {

  MyContestsService myContestsService;

  MyContestsComp(this.myContestsService, this._router, this._flashMessage) {

    _updateLive();
    _timer = new Timer.periodic(const Duration(seconds:3), (Timer t) => _updateLive());
  }

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
  }

  void detach() {
    if (_timer != null)
      _timer.cancel();
  }

  void _updateLive() {
    myContestsService.refreshMyContests()
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  Timer _timer;

  Router _router;
  FlashMessagesService _flashMessage;
}