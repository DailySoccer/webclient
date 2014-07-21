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

class ContestHeaderComp implements DetachAware{
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
    NumberFormat nf_day = new NumberFormat("0");
    NumberFormat nf_time = new NumberFormat("00");
    DateTime t = new DateTime.now().add(new Duration());
    Duration cd = contestInfo.templateContest.startDate.difference(t);
    //Duration cd = new DateTime(2014, 7, 23, 12, 19, 0).difference(t);

    if(cd.inSeconds <= 0) {
      contestHeaderInfo["countdownDate"] = "FINALIZADO";
      count.cancel();
    } else {
      var days = cd.inDays;
      var hours = nf_time.format(cd.inHours % 24);
      var minutes = nf_time.format(cd.inMinutes % 60);
      var seconds = nf_time.format(cd.inSeconds % 60);
      if(days > 0) {
        contestHeaderInfo["countdownDate"] = nf_day.format(days) + (days > 1 ? " DIAS ": " DIA ") + hours + ":" + minutes + ":" + seconds;
      } else {
        contestHeaderInfo["countdownDate"] = hours + ":" + minutes + ":" + seconds;
      }
    }
  }

  void _refreshHeader() {
    var date = new DateFormat('dd/MM HH:mm');
    contestHeaderInfo["description"] = "€${contestInfo.templateContest.salaryCap} ${contestInfo.name}";
    contestHeaderInfo["entryPrice"] = "€${contestInfo.templateContest.entryFee}";
    contestHeaderInfo["startTime"] = "COMIENZA EL ${date.format(contestInfo.templateContest.startDate)}";

    int numJugadores = contestInfo.contestEntries.length;
    contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
  }

  void goToLobby(){
    _router.go("lobby", {});
  }

  void detach() {
    count.cancel();
  }

  Scope _scope;
  Router _router;
}
