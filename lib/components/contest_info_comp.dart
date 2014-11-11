library contest_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/components/modal_comp.dart';

@Component(
  selector: 'contest-info',
  templateUrl: 'packages/webclient/components/contest_info_comp.html',
  useShadowDom: false
)
class ContestInfoComp implements DetachAware {

  bool isModal = false;
  Map currentInfoData;
  Contest contest = null;

  ContestInfoComp(ScreenDetectorService scrDet, RouteProvider routeProvider, this._router, this._contestService, this._flashMessage) {

    _streamListener = scrDet.mediaScreenWidth.listen(onScreenWidthChange);

    isModal = (_router.activePath.length > 0) && (_router.activePath.first.name == 'lobby');

    currentInfoData = {
      'description'     : '',
      'name'            : '',
      'entry'           : '',
      'prize'           : '',
      'rules'           : 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
      'startDateTime'   : '', // 'COMIENZA EL DOM. 15/05 19:00',
      'matchesInvolved' : null,
      'legals'          : '',
      'contestants'     : [],
      'prizes'          : []
    };

    _contestId = routeProvider.route.parameters['contestId'];

    // Solo refrescamos del servidor en caso de que no este ya cargado
    _contestService.refreshContest(_contestId)
      .then((_) {
        updateContestInfo();
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  void detach() {
    _streamListener.cancel();
  }

  void onScreenWidthChange(String msg) {
    // Solo nos mostramos como modal en desktop
    if (isModal) {
      ModalComp.close();
    }
  }

  void updateContestInfo() {

    contest = _contestService.lastContest;
    List contestants = [];

    for (ContestEntry contestEntry in contest.contestEntries) {
      contestants.add({
        'name'  : contestEntry.user.nickName,
        'wins'  : contestEntry.user.wins
      });
    }

    currentInfoData["name"]           = contest.name;
    currentInfoData["description"]    = contest.description;
    currentInfoData["entry"]          = contest.entryFee.toString();
    currentInfoData["prize"]          = contest.prizePool.toString();
    currentInfoData["startDateTime"]  = DateTimeService.formatDateTimeLong(contest.startDate).toUpperCase();
    currentInfoData["contestants"]    = contestants;
    currentInfoData["prizes"]         = contest.prizes.map((value) => {'value' : value.toString()}).toList();
    currentInfoData["matchesInvolved"]= contest.matchEvents;
  }

  void enterContest() {
    _router.go('enter_contest', { "contestId": _contestId, "parent": "lobby", "contestEntryId": "none" });
  }

  String formatMatchDate(DateTime date) {
    return DateTimeService.formatDateTimeShort(date);
  }

  void tabChange(String tab) {
    querySelectorAll(".tab-pane").classes.remove('active');

    Element contentTab = querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
  }

  var _streamListener;
  Router _router;

  ActiveContestsService _contestService;
  FlashMessagesService _flashMessage;

  String _contestId;
}