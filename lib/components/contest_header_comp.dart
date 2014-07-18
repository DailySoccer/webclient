library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";

@Component(
    selector: 'contest-header', 
    templateUrl: 'packages/webclient/components/contest_header_comp.html', 
    publishAs: 'contestHeader', 
    useShadowDom: false
)

class ContestHeaderComp {
  var contestHeaderInfo = {
    'description': '<description>',
    'startTime':'<startTime>',
    'contestType': '<contestType>',
    'contestantCount': '<contestantCount>',    
    'entryPrice': '<entryPrice>',
    'prize': '<prize>',
    'prizeType':'<prizeType>'
  };
  
  Contest contestInfo; 

  @NgOneWay("contestData")
  void set contestData(Contest value) {
    contestInfo = value;
    
    if (value != null) {
      print('CABECERA: he recibido el concurso: ' + value.contestId);
      _refreshHeader();
    }
  }
  
  String info;
  ScreenDetectorService scrDet;
  
  ContestHeaderComp(this._scope, this._router, this.scrDet) {
    print('printing the contest info' + contestHeaderInfo.toString());
  }

  void _refreshHeader() { 
    var date = new DateFormat('dd-MM-yy HH:mm');
    contestHeaderInfo["description"] = "€${contestInfo.templateContest.salaryCap} ${contestInfo.name}";
    contestHeaderInfo["entryPrice"] = "€${contestInfo.templateContest.entryFee}";
    contestHeaderInfo["startTime"] = "${date.format(contestInfo.templateContest.startDate)}";
    
    int numJugadores = contestInfo.contestEntries.length;
    contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
  }
  
  Scope _scope;
  Router _router;
}
