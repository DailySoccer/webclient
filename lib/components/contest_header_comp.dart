library contest_header_comp;

import 'package:angular/angular.dart';

@Component(
    selector: 'contest-header', 
    templateUrl: 'packages/webclient/components/contest_header_comp.html', 
    publishAs: 'contestHeader', 
    useShadowDom: false
)

class ContestHeaderComp {
  Map contest = {
    'description': 'TORNEO MULTIJUGADOR (500) LIM. 60M',
    'startTime':'Empezó a las 20:45',
    'contestType': 'Liga Multijugador',
    'contestantCount': '35 jugadores',    
    'entryPrice': '€25',
    'prize': '€65.000',
    'prizeType':'TODO PARA EL GANADOR'
  };
  String info;
  
  ContestHeaderComp(Scope scope, this._router) {}

  Router _router;
}
