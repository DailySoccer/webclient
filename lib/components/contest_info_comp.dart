library contest_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:async';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/utils/js_utils.dart';

@Component(
  selector: 'contest-info',
  templateUrl: 'packages/webclient/components/contest_info_comp.html',
  publishAs: 'contestInfo',
  useShadowDom: false
)

class ContestInfoComp implements ShadowRootAware {

  bool popUpStyle;
  Map currentInfoData;
  List contestants  = [];

  @NgTwoWay("contest-data")
  Contest get contestData => _contestData;
  void set contestData(Contest value) {
    _contestData = value;
    if (value != null) {
      updateContestInfo(value.contestId);
    }
  }

  @NgTwoWay("is-pop-up")
  bool get isPopUp => popUpStyle;
  void set isPopUp (bool value){
    popUpStyle = value;
  }

  ContestInfoComp(Scope scope, this._router, this._contestService, this._flashMessage) {

    currentInfoData = {  /*  hay que utilizar esta variable para meter los datos de este componente  */
      'description'     : 'cargando datos...',
      'name'            : '',
      'entry'           : '',
      'prize'           : '',
      'rules'           : 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',         // 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
      'startDateTime'   : '', // 'COMIENZA EL DOM. 15/05 19:00',
      'matchesInvolved' : null,
      'legals'          : '',
      'contestants'     : contestants,
      'prizes'          : []
    };
  }

  void updateContestInfo(String contestId) {
    _contestService.refreshContest(contestId)
      .then((_) {
        Contest contest = _contestService.lastContest;

        currentInfoData["name"]           = contest.name;
        currentInfoData["description"]    = contest.description;
        currentInfoData["entry"]          = contest.entryFee.toString();
        currentInfoData["prize"]          = contest.prizePool.toString();
        currentInfoData["startDateTime"]  = DateTimeService.formatDateTimeLong(contest.startDate).toUpperCase();
        currentInfoData["contestants"]    = contestants;
        currentInfoData["prizes"]         = contest.prizes.map((value) => {'value' : value}).toList();
        currentInfoData["matchesInvolved"]= contest.matchEvents;

        contestants.clear();
        for (ContestEntry contestEntry in contest.contestEntries) {
          contestants.add({
                'name'  : contestEntry.user.nickName,
                'wins'  : contestEntry.user.wins
              });
        }
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  void goToEnterContest(obj) {
    if (_goToEnterContest) {
      _router.go('enter_contest', { "contestId": contestData.contestId, "parent": "lobby" });
    }
  }

  void enterContest() {
    _goToEnterContest = true;
    //Element modal = querySelector('#infoContestModal');
    // quitamos la clase fade porque se lanza el router antes de cerrar la modal y queda
    //modal.classes.remove('fade');
    // hacemos una llamada de jQuery para ocultar la ventana modal
    JsUtils.runJavascript('#infoContestModal', 'modal', 'hide');
    //modal.classes.add('fade');
    //_router.go('enter_contest', { "contestId": contestData.contestId });
  }

  String formatMatchDate(DateTime date) {
    return DateTimeService.formatDateTimeShort(date);
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
  }

  Router _router;
  ActiveContestsService _contestService;
  FlashMessagesService _flashMessage;

  Timer _timer;

  Contest _contestData;
  bool _popUpStyle;
  bool _goToEnterContest = false;

  void onShadowRoot(root) {
    JsUtils.runJavascript('#infoContestModal', 'on', {'hidden.bs.modal': goToEnterContest});
  }

}
