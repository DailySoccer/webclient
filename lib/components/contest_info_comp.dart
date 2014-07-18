library contest_info_comp;

import 'package:angular/angular.dart';
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

  @NgTwoWay("contestData")
      Contest get contestData => _contestData;
      void set contestData(Contest value) {
        _contestData = value;
          if(value != null)
            updateContestInfo(value);
      }

    Map currentInfoData;
    List contestants  = new List();
    List prizes = new List();

    ContestInfoComp(Scope scope, this._router, this._contestService) {

      currentInfoData = {  /*  hay que utilizar esta variable para meter los datos de este componente  */
        'description'     : '<description>',
        'name'            : '<name>',
        'entry'           : '<entry>',
        'prize'           : '<prize>',
        'rules'           : '<rules>',         // 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
        'startDateTime'   : '<startDateTime>', // 'COMIENZA EL DOM. 15/05 19:00',
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
      matchesInvolved = cont.templateContest.templateMatchEvents;

      currentInfoData["description"]    = cont.templateContest.postName;
      currentInfoData["name"]           = cont.templateContest.name;
      currentInfoData["entry"]          = cont.templateContest.entryFee.toString();
      currentInfoData["startDateTime"]  = getFormatedDate(cont.templateContest.startDate);
      currentInfoData["contestants"]    = contestants;
      currentInfoData["prizes"]         = prizes;

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

      /*
      if ( weekDay == DateTime.MONDAY)
        return "LUN.";
      if ( weekDay == DateTime.TUESDAY)
        return "MAR.";
      if ( weekDay == DateTime.WEDNESDAY)
        return "MIE.";
      if ( weekDay == DateTime.THURSDAY)
        return "JUE.";
      if ( weekDay == DateTime.FRIDAY)
        return "VIE.";
      if ( weekDay == DateTime.SATURDAY)
        return "SAB.";

      return "DOM.";
      */
    }


    void enterContest() {
            _router.go('enter_contest', { "contestId": contestData.contestId });
       }

    TemplateContest tmplateContest;
    List<TemplateMatchEvent> matchesInvolved;

    Router _router;
    ActiveContestsService _contestService;
    Contest _contestData;

}
