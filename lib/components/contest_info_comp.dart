library contest_info_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/match_event.dart';


@Component(selector: 'contest-info', templateUrl: 'packages/webclient/components/contest_info_comp.html', publishAs: 'contestInfo', useShadowDom: false)
class ContestInfoComp {

  @NgTwoWay("showContest")
      Contest get showedContest => _showedContest;
      void set showedContest(Contest value) {
        _showedContest = value;
          if(value != null)
            updateContestInfo(value);
      }
  
      
      
    Map old_contest;
    var contestants  = new List();
    var prizes = new List();

    ContestInfoComp(Scope scope, this._router, this._contestService) {
   
      contestants.add({
        'name'    : 'Santiago Reveliñas',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Federico Mon',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Ximo Martinez Albors',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Victor Zincoontrin',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Javichu Lajaraster',
        'points'  : '0000'
      });
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
      
      prizes.add({'value' : '300,00'});
      prizes.add({'value' : '100,00'});
      prizes.add({'value' : '50,00' });
    }
    
    updateContestInfo(Contest showedContest)
    {
      tmplateContest  = _contestService.getTemplateContestById(showedContest.templateContestId);
      matchesInvolved = _contestService.getMatchEventsForTemplateContest(tmplateContest);
      
      old_contest = {  /*  Los datos que no tengo aún, los fakeo en esta variable  */
        'description'     : showedContest.name,
        'name'            : 'CONQUISTA EUROPA',
        'entry'           : '25',
        'prize'           : '65.000',
        'rules'           : 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
        'startDateTime'   : 'COMIENZA EL DOM. 15/05 19:00',
        'contestants'     : contestants,
        'prizes'          : prizes,
        'rulesDescription': '   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam porta nunc eget purus elementum orn,.are.'+ 
                            'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam at mollis purus.' +
                            'Maecenas congue odio quis dolor vehicula, in eleifend massa dignissim. Suspendisse potenti.' +
                            '\n   Donec eu purus dui. Pellentesque egestas lacinia arcu, at vulputate lorem varius ut. Mauris diam justo, fermentum vel ligula sed, laoreet blandit lacus.' +
                            '\n   In, sollicitudin diam. Donec a imperdiet est, vitae tincidunt lorem. Donec risus elit, pretium sed pharetra vitae, gravida vel nulla.'
      };
    }
    
    void enterContest() {
            _router.go('enter_contest', { "contestId": showedContest.contestId });
       }
    
    TemplateContest tmplateContest;
    List<MatchEvent> matchesInvolved;
    
    Router _router;
    ContestService _contestService;
    Contest _showedContest;
    
}
