library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'package:webclient/controllers/live_contest_ctrl.dart';

@Component(
    selector: 'contest-header', 
    templateUrl: 'packages/webclient/components/contest_header_comp.html', 
    publishAs: 'contestHeader', 
    useShadowDom: false
)

class ContestHeaderComp {
  var contestHeaderInfo = {
    'description': '',
    'startTime':'Empezó a las 20:45',
    'contestType': 'Liga Multijugador',
    'contestantCount': '',    
    'entryPrice': '',
    'prize': '€65.000',
    'prizeType':'TODO PARA EL GANADOR'
  };
  
  Contest contestInfo; 

  @NgTwoWay("contestData")
  Contest get contestData => contestInfo;
  void set contestData(Contest value) {
    contestInfo = value;
    _refreshHeader();
  }
  
  String info;
  ScreenDetectorService scrDet;
  
  ContestHeaderComp(this._scope, this._router, this.scrDet) {
    print('printing the contest info' + contestHeaderInfo.toString());
  }

  void _refreshHeader() { 
    contestHeaderInfo["description"] = "€${contestInfo.templateContest.salaryCap} ${contestInfo.name}";
    contestHeaderInfo["entryPrice"] = "€${contestInfo.templateContest.entryFee}";
    
    int numJugadores = contestInfo.contestEntries.length;
    contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
  }
  
  Scope _scope;
  Router _router;
}
