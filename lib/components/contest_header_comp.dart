library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
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
  
  String info;
  ScreenDetectorService scrDet;
  
  ContestHeaderComp(this._scope, this._router, this.scrDet, this._liveContestCtrl) {
    print('printing the contest info' + contestHeaderInfo.toString());
    _scope.watch("updatedDate", (newValue, oldValue) {
      _refreshHeader();
    }, context: _liveContestCtrl);    
  }

  void _refreshHeader() {
    if (_liveContestCtrl.contest != null) {
      contestHeaderInfo["description"] = "€${_liveContestCtrl.contest.templateContest.salaryCap} ${_liveContestCtrl.contest.name}";
      contestHeaderInfo["entryPrice"] = "€${_liveContestCtrl.contest.templateContest.entryFee}";
      
      int numJugadores = _liveContestCtrl.contest.currentUserIds.length;
      contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
    }
  }
  
  Scope _scope;
  Router _router;
  LiveContestCtrl _liveContestCtrl;
}
