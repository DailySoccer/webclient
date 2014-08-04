library contest_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/template_match_event.dart';


@Component(
    selector: 'contest-info',
    templateUrl: 'packages/webclient/components/contest_info_comp.html',
    publishAs: 'contestInfo',
    useShadowDom: false
)

class ContestInfoComp {

  bool popUpStyle;
  Map currentInfoData;
  List contestants  = new List();
  List prizes = new List();
  TemplateContest tmplateContest;
  List<TemplateMatchEvent> matchesInvolved;

  @NgTwoWay("contest-data")
  Contest get contestData => _contestData;
  void set contestData(Contest value) {
    _contestData = value;
    if (value != null) {
      updateContestInfo(value);
    }
  }

  @NgTwoWay("is-pop-up")
  bool get isPopUp => popUpStyle;
  void set isPopUp (bool value) {
    popUpStyle = value;
  }

  ContestInfoComp(Scope scope, this._router, this._contestService) {

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
      'prizes'          : prizes
    };

    contestants.add({
      'name'    : 'Jhon Doe 1',
      'points'  : '0000'
    });
    contestants.add({
      'name'    : 'Jhon Doe 2',
      'points'  : '0000'
    });
    contestants.add({
      'name'    : 'Jhon Doe 3',
      'points'  : '0000'
    });
    contestants.add({
      'name'    : 'Jhon Doe 4',
      'points'  : '0000'
    });
    contestants.add({
      'name'    : 'Jhon Doe 5',
      'points'  : '0000'
    });
    contestants.add({
      'name'    : 'Jhon Doe 6',
      'points'  : '0000'
    });

    prizes.add({'value' : '<first>'});
    prizes.add({'value' : '<second>'});
    prizes.add({'value' : '<third>' });
  }

  updateContestInfo(Contest cont)
  {
    currentInfoData["name"]           = cont.templateContest.name;
    currentInfoData["entry"]          = cont.templateContest.entryFee.toString();
    currentInfoData["startDateTime"]  = getFormatedDate(cont.templateContest.startDate);
    currentInfoData["contestants"]    = contestants;
    currentInfoData["prizes"]         = prizes;
    currentInfoData["matchesInvolved"]= cont.templateContest.templateMatchEvents;
  }

  String getFormatedDate(DateTime date)
  {
    var dateTimeFormat = new DateFormat(' MM/yy H:mm');
    return getDayOfTheWeek(date.weekday) + dateTimeFormat.format(date);
  }

  String getDayOfTheWeek(int weekDay)
  {
    String ret="";
    switch(weekDay)
    {
      case DateTime.MONDAY:
        ret = "LUN.";
      break;
      case DateTime.TUESDAY:
        ret = "MAR.";
      break;
      case DateTime.WEDNESDAY:
        ret = "MIE.";
      break;
      case DateTime.THURSDAY:
        ret = "JUE.";
      break;
      case DateTime.FRIDAY:
        ret = "VIE.";
      break;
      case DateTime.SATURDAY:
        ret = "SAB.";
      break;
      case DateTime.SUNDAY:
        ret = "DOM.";
      break;

    }
    return ret;
  }

  void enterContest() {
    _router.go('enter_contest', { "contestId": contestData.contestId });
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    if(contentTab != null) {
      contentTab.classes.add("active");
    }
  }

  Router _router;
  ActiveContestsService _contestService;
  Contest _contestData;
}
