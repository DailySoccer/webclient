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

  static const int ENTER_CONTEST = 0;
  static const int VIEW_CONTEST = 1;

  int mode;

  Map<String, dynamic> contestHeaderInfo = {
    'description': '<description>',
    'startTime':'<startTime>',
    'countdownDate': '',
    'textCountdownDate': '',
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

  @NgOneWay("mode")
  void set viewMode(String value) {
    switch(value) {
      case "ENTER_CONTEST":
        mode = ENTER_CONTEST;
        break;
      case "VIEW_CONTEST":
        mode = VIEW_CONTEST;
        break;
    }
  }


  ContestHeaderComp(this._router, this.scrDet, this._dateTimeService) {
    _count = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => this.countdownDate());
  }

  void countdownDate() {
    contestHeaderInfo["textCountdownDate"] = "";
    contestHeaderInfo["countdownDate"] = "";

    if (_contestInfo != null) {
      if (_contestInfo.templateContest.isHistory) {
        contestHeaderInfo["startTime"] = "FINALIZADO";
        _count.cancel();
      }
      else if (_contestInfo.templateContest.isLive) {
        contestHeaderInfo["startTime"] = "COMENZÓ EL ${DateTimeService.formatDateTimeShort(_contestInfo.templateContest.startDate).toUpperCase()}";
        _count.cancel();
      }
      else {
        contestHeaderInfo["startTime"] = "COMIENZA EL ${DateTimeService.formatDateTimeShort(_contestInfo.templateContest.startDate).toUpperCase()}";

        Duration tiempoRestante = _dateTimeService.timeLeft(_contestInfo.templateContest.startDate);
        if (tiempoRestante.inSeconds <= 0) {
          contestHeaderInfo["startTime"] = "EN BREVE";
          _count.cancel();
        }
        else {
          contestHeaderInfo["textCountdownDate"] = (scrDet.isDesktop) ? "EL DESAFIO COMENZARÁ EN: " : "FALTAN";
          contestHeaderInfo["countdownDate"] = formatTimeLeft(tiempoRestante);
        }
      }
    }
  }

  String formatTimeLeft(Duration tiempoRestante) {
    NumberFormat nf_day = new NumberFormat("0");
    NumberFormat nf_time = new NumberFormat("00");

    var days = tiempoRestante.inDays;
    var hours = nf_time.format(tiempoRestante.inHours % 24);
    var minutes = nf_time.format(tiempoRestante.inMinutes % 60);
    var seconds = nf_time.format(tiempoRestante.inSeconds % 60);

    return (days > 0)
              ? nf_day.format(days) + (days > 1 ? " DIAS ": " DIA ") + hours + ":" + minutes + ":" + seconds
              : hours + ":" + minutes + ":" + seconds;
  }

  void _refreshHeader() {
    contestHeaderInfo["description"] = "${_contestInfo.name}";
    contestHeaderInfo['contestType'] = "${_contestInfo.templateContest.tournamentTypeName}: ";
    contestHeaderInfo["entryPrice"] = "${_contestInfo.templateContest.entryFee}€";
    contestHeaderInfo["prize"] = "${_contestInfo.templateContest.prizePool}€";
    contestHeaderInfo["prizeType"] = "${_contestInfo.templateContest.prizeTypeName}";
    contestHeaderInfo["startTime"] = "";
    contestHeaderInfo["contestantCount"] = "${_contestInfo.contestEntries.length} de ${_contestInfo.maxEntries} jugadores  - LIM. SAL.: ${_contestInfo.templateContest.salaryCap}";
  }

  void goBackTo() {
    switch(mode) {
      case ENTER_CONTEST:
        _router.go("lobby", {});
        break;
      case VIEW_CONTEST:
        _router.go("my_contests", {});
        break;
    }
  }

  void detach() {
    _count.cancel();
  }

  Router _router;

  DateTimeService _dateTimeService;
  Timer _count;
  Contest _contestInfo;
}
