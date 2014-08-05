library contest_header_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/datetime_service.dart';
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

  Map<String, dynamic> contestHeaderInfo = {
    'description': '<description>',
    'startTime':'<startTime>',
    'countdownDate': '',
    'contestType': '<contestType>',
    'contestantCount': '<contestantCount>',
    'entryPrice': '<entryPrice>',
    'prize': '<prize>',
    'prizeType':'<prizeType>'
  };

  ScreenDetectorService scrDet;

  @NgOneWay("contestData")
  void set contestData(Contest value) {
    _contestInfo = value;

    if (value != null) {
      _refreshHeader();
    }
  }


  ContestHeaderComp(this._scope, this._router, this.scrDet, this._dateTimeService) {

    _timeDisplayFormat = new DateFormat("HH:mm:ss");
    _count = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => this.countdownDate());
  }

  void countdownDate() {
    if(_contestInfo != null) {
      NumberFormat nf_day = new NumberFormat("0");
      NumberFormat nf_time = new NumberFormat("00");
      DateTime t = _dateTimeService.now.add(new Duration());
      Duration cd = contestInfo.templateContest.startDate.difference(t);
      //Duration cd = new DateTime(2014, 8, 26, 12, 19, 0).difference(t);

      List<SpanElement> textCountdown = document.querySelectorAll(".text-countdown");
      textCountdown.forEach((element) => element.remove());

      if(cd.inSeconds <= 0) {
        contestHeaderInfo["countdownDate"] = "";
        contestHeaderInfo["startTime"] = "FINALIZADO";
        _count.cancel();
      } else {
        var days = cd.inDays;
        var hours = nf_time.format(cd.inHours % 24);
        var minutes = nf_time.format(cd.inMinutes % 60);
        var seconds = nf_time.format(cd.inSeconds % 60);

        if(scrDet.isDesktop) {
          _msg = "EL DESAFIO COMENZARÁ EN: ";
        } else {
          _msg = "FALTAN ";
        }
        SpanElement countdownTextSpan = new SpanElement();
        countdownTextSpan.text = _msg;
        countdownTextSpan.classes.add('text-countdown');
        List<Element> countdownText = document.querySelectorAll(".countdown-text");
        countdownText.forEach((element) => element.append(countdownTextSpan));

        List<Element> countdownDays = document.querySelectorAll(".time-countdown");
        if(days > 0) {
          contestHeaderInfo["countdownDate"] = nf_day.format(days) + (days > 1 ? " DIAS ": " DIA ") + hours + ":" + minutes + ":" + seconds;
          countdownDays.forEach((element) => element.classes.add("days"));
        } else {
          contestHeaderInfo["countdownDate"] = hours + ":" + minutes + ":" + seconds;
          countdownDays.forEach((element) => element.classes.remove("days"));
        }
      }
    }
  }

  void _refreshHeader() {
    var date = new DateFormat('dd/MM HH:mm');
    contestHeaderInfo["description"] = "${contestInfo.templateContest.salaryCap}€ ${contestInfo.name}";
    contestHeaderInfo["entryPrice"] = "${contestInfo.templateContest.entryFee}€";
    contestHeaderInfo["startTime"] = "COMIENZA EL ${date.format(contestInfo.templateContest.startDate)}";
    contestHeaderInfo["prize"] = "${contestInfo.templateContest.prizePool}€";
    contestHeaderInfo["prizeType"] = "${contestInfo.templateContest.prizeTypeName}";

    int numJugadores = _contestInfo.contestEntries.length;
    contestHeaderInfo["contestantCount"] = "$numJugadores" + ((numJugadores == 1) ? " jugador" : " jugadores");
  }

  void goToLobby(){
    _router.go("lobby", {});
  }

  void detach() {
    _count.cancel();
  }

  Scope _scope;
  Router _router;

  DateTimeService _dateTimeService;
  Timer _count;
  DateFormat _timeDisplayFormat;
  String _msg = "";
  Contest _contestInfo;
}
