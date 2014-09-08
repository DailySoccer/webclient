library contest_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Component(
  selector: 'contest-info',
  templateUrl: 'packages/webclient/components/contest_info_comp.html',
  publishAs: 'contestInfo',
  useShadowDom: false
)

class ContestInfoComp {

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
      'description'     : '<description>',
      'name'            : '<name>',
      'entry'           : '<entry>',
      'prize'           : '<prize>',
      'rules'           : '<rules>',         // 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
      'startDateTime'   : '<startDateTime>', // 'COMIENZA EL DOM. 15/05 19:00',
      'matchesInvolved' : null,
      'legals'          : '<legals>',
      'contestants'     : contestants,
      'prizes'          : []
    };
  }

  void updateContestInfo(String contestId) {
    _contestService.refreshContest(contestId)
      .then((_) {
        Contest contest = _contestService.lastContest;

        currentInfoData["name"]           = contest.templateContest.name;
        currentInfoData["description"]    = contest.description;
        currentInfoData["entry"]          = contest.templateContest.entryFee.toString();
        currentInfoData["prize"]          = contest.templateContest.prizePool.toString();
        currentInfoData["startDateTime"]  = DateTimeService.formatDateTimeLong(contest.templateContest.startDate).toUpperCase();
        currentInfoData["contestants"]    = contestants;
        currentInfoData["prizes"]         = contest.templateContest.prizes.map((value) => {'value' : value}).toList();
        currentInfoData["matchesInvolved"]= contest.templateContest.matchEvents;

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

  void enterContest() {
    _router.go('enter_contest', { "contestId": contestData.contestId });
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

  Contest _contestData;
  bool _popUpStyle;
}
