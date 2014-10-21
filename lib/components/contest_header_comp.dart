library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'dart:async';

@Component(
    selector: 'contest-header',
    templateUrl: '/packages/webclient/components/contest_header_comp.html',
    useShadowDom: false
)
class ContestHeaderComp implements DetachAware {

  Map<String, String> contestHeaderInfo = {
    'description':      'cargando datos...',
    'startTime':        '',
    'countdownDate':    '',
    'textCountdownDate':'',
    'contestType':      '',
    'contestantCount':  '',
    'entryPrice':       '',
    'prize':            '',
    'prizeType':        ''
  };

  ScreenDetectorService scrDet;

  @NgOneWay("contestData")
  void set contestData(Contest value) {
    _contestInfo = value;

    if (value != null) {
      _refreshHeader();
      _refreshCountdownDate();
    }
  }

  ContestHeaderComp(this._router, this._routeProvider, this.scrDet) {
    _count = new Timer.periodic(new Duration(seconds: 1), (Timer timer) => _refreshCountdownDate());
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
        contestHeaderInfo["countdownDate"] = DateTimeService.formatTimeLeft(tiempoRestante);
        contestHeaderInfo["textCountdownDate"] = (scrDet.isDesktop) ? "EL CONCURSO COMENZARÁ EN: " : "FALTAN";
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
    contestHeaderInfo["contestantCount"] = "${_contestInfo.contestEntries.length} de ${_contestInfo.maxEntries} jugadores  - Límite de salario: ${_contestInfo.salaryCap}";
  }

  void goToParent() {
    _router.go(_routeProvider.parameters["parent"], {});
  }

  void detach() {
    _count.cancel();
  }

  Router _router;
  RouteProvider _routeProvider;

  Timer _count;
  Contest _contestInfo;
}
