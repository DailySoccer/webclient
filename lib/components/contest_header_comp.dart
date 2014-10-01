library contest_header_comp;

import 'package:angular/angular.dart';
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
  static const int VIEW_CONTEST_ENTRY = 2;

  bool get isEnterContestMode => _mode == ENTER_CONTEST;

  // torneo gratis
  //bool isFreeContest = false;

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
      // torneo gratis
      //isFreeContest = _contestInfo.entryFee == 0;
    }
  }

  @NgOneWay("parent")
    void set goParent(String value) {
      _parent = value;
  }

  @NgOneWay("mode")
  void set viewMode(String value) {
    switch(value) {
      case "ENTER_CONTEST":
        _mode = ENTER_CONTEST;
        break;
      case "VIEW_CONTEST":
        _mode = VIEW_CONTEST;
        break;
      case "VIEW_CONTEST_ENTRY":
        _mode = VIEW_CONTEST_ENTRY;
        break;
    }
  }

  ContestHeaderComp(this._router, this.scrDet) {
    _count = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => _refreshCountdownDate());
  }

  void _refreshCountdownDate() {
    contestHeaderInfo["textCountdownDate"] = "";
    contestHeaderInfo["countdownDate"] = "";

    if (_contestInfo == null) {
      return;
    }

    if (_contestInfo.isHistory) {
      contestHeaderInfo["startTime"] = "FINALIZADO";
      _count.cancel();
    }
    else if (_contestInfo.isLive) {
      contestHeaderInfo["startTime"] = "COMENZÓ EL ${DateTimeService.formatDateTimeShort(_contestInfo.startDate).toUpperCase()}";
      _count.cancel();
    }
    else {
      contestHeaderInfo["startTime"] = "COMIENZA EL ${DateTimeService.formatDateTimeShort(_contestInfo.startDate).toUpperCase()}";

      Duration tiempoRestante = DateTimeService.getTimeLeft(_contestInfo.startDate);

      if (tiempoRestante.inSeconds <= 0) {
        contestHeaderInfo["startTime"] = "EN BREVE";
        _count.cancel();
      }
      else {
        contestHeaderInfo["textCountdownDate"] = (scrDet.isDesktop) ? "EL CONCURSO COMENZARÁ EN: " : "FALTAN";
        contestHeaderInfo["countdownDate"] = DateTimeService.formatTimeLeft(tiempoRestante);
      }
    }
  }

  void _refreshHeader() {
    contestHeaderInfo["description"] = "${_contestInfo.name}";
    contestHeaderInfo['contestType'] = "${_contestInfo.tournamentTypeName}: ";
    contestHeaderInfo["entryPrice"] = "${_contestInfo.entryFee}€";
    contestHeaderInfo["prize"] = "${_contestInfo.prizePool}€";
    contestHeaderInfo["prizeType"] = "${_contestInfo.prizeTypeName}";
    contestHeaderInfo["startTime"] = "";
    contestHeaderInfo["contestantCount"] = "${_contestInfo.contestEntries.length} de ${_contestInfo.maxEntries} jugadores  - LIM. SAL.: ${_contestInfo.salaryCap}";
  }

  void goBackTo() {
    _router.go(_parent, {});
  }

  void detach() {
    _count.cancel();
  }

  Router _router;

  Timer _count;
  Contest _contestInfo;
  int _mode;
  String _parent;
}
