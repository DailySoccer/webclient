library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'dart:async';

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
    'countdownDate': '<countdownDate>',
    'contestType': '<contestType>',
    'contestantCount': '<contestantCount>',
    'entryPrice': '<entryPrice>',
    'prize': '<prize>',
    'prizeType':'<prizeType>'
  };
  Timer count;
  DateFormat timeDisplayFormat;
  int elapsed;

  Contest contestInfo;

  @NgOneWay("contestData")
  void set contestData(Contest value) {
    contestInfo = value;

    if (value != null) {
      _refreshHeader();
    }
  }

  String info;
  ScreenDetectorService scrDet;

  ContestHeaderComp(this._scope, this._router, this.scrDet) {

    timeDisplayFormat = new DateFormat("HH:mm:ss");
    count = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => this.countdownDate());
  }

  void countdownDate() {
    DateTime t = new DateTime.now().add(new Duration());
    Duration cd = contestInfo.templateContest.startDate.difference(t);
    //Duration cd = new DateTime(2014, 7, 19).difference(t);

    NumberFormat nf = new NumberFormat("00");
    var hours = nf.format(cd.inHours % 60);
    var minutes = nf.format(cd.inMinutes % 60);
    var seconds = nf.format(cd.inSeconds %  60);

    contestHeaderInfo["countdownDate"] = hours + ":" + minutes + ":" + seconds;
  }

  void _refreshHeader() {
    var date = new DateFormat('dd/MM HH:mm');
    contestHeaderInfo["description"] = "€${contestInfo.templateContest.salaryCap} ${contestInfo.name}";
    contestHeaderInfo["entryPrice"] = "€${contestInfo.templateContest.entryFee}";
    contestHeaderInfo["startTime"] = "COMIENZA EL ${date.format(contestInfo.templateContest.startDate)}";

    int numJugadores = contestInfo.contestEntries.length;
    contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
  }

  Scope _scope;
  Router _router;
}
