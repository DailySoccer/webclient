library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'contest-header', 
    templateUrl: 'packages/webclient/components/contest_header_comp.html', 
    publishAs: 'contestHeader', 
    useShadowDom: false
)

class ContestHeaderComp {
  var contestHeaderInfo = {
    'description': '€11.250K Domingo Mongol',
    'startTime':'Empezó a las 20:45',
    'contestType': 'Liga Multijugador',
    'contestantCount': '35 jugadores',    
    'entryPrice': '25€',
    'prize': '65.000€',
    'prizeType':'TODO PARA EL GANADOR'
  };
  
  /*Contest contestHeaderInfo; 

  @NgTwoWay("contestId")
        String get contestId => contestHeaderInfo.contestId;
       
      void set contestId(String value) {
        contestHeaderInfo = _contestService.getContestById(value);;
       }
      
 */
  
  String info;
  ScreenDetectorService scrDet;
  
  ContestHeaderComp(Scope scope, this._router, this.scrDet, this._contestService) {
    print('printing the contest info' + contestHeaderInfo.toString());
  }

  Router _router;
  ContestService _contestService;
  
 
}
