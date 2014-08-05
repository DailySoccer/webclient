library contest_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/active_contests_service.dart';

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

  @NgTwoWay("contest-data")
  Contest get contestData => _contestData;
  void set contestData(Contest value) {
    _contestData = value;
      if(value != null){
        updateContestInfo(value);
      }
      }

     @NgTwoWay("is-pop-up")
    bool get isPopUp => popUpStyle;
    void set isPopUp (bool value){
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
        'prizes'          : new List()
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
    }

    updateContestInfo(Contest contest)
    {
      currentInfoData["name"]           = contest.templateContest.name;
      currentInfoData["entry"]          = contest.templateContest.entryFee.toString();
      currentInfoData["prize"]          = contest.templateContest.prizePool.toString();
      currentInfoData["startDateTime"]  = getFormatedDate(contest.templateContest.startDate);
      currentInfoData["contestants"]    = contestants;
      currentInfoData["prizes"]         = contest.templateContest.getPrizes().map((value) => {'value' : value}).toList();
      currentInfoData["matchesInvolved"]= contest.templateContest.matchEvents;
    }

    String getFormatedDate(DateTime date)
    {
      String result ="";
      var dateTimeFormat = new DateFormat(' MM/yy H:mm');
      result = getDayOfTheWeek(date.weekday) + dateTimeFormat.format(date);
      return result;
    }

    String getDayOfTheWeek(int weekDay)
    {
      String retorno="";
      switch(weekDay)
      {
        case DateTime.MONDAY:
          retorno = "LUN.";
        break;
        case DateTime.TUESDAY:
          retorno = "MAR.";
        break;
        case DateTime.WEDNESDAY:
          retorno = "MIE.";
        break;
        case DateTime.THURSDAY:
          retorno = "JUE.";
        break;
        case DateTime.FRIDAY:
          retorno = "VIE.";
        break;
        case DateTime.SATURDAY:
          retorno = "SAB.";
        break;
        case DateTime.SUNDAY:
          retorno = "DOM.";
        break;

    }
    return retorno;
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
  bool _popUpStyle;


}
