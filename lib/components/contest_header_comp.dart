library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'dart:async';
import 'package:webclient/services/refresh_timers_service.dart';

@Component(
    selector: 'contest-header',
    templateUrl: 'packages/webclient/components/contest_header_comp.html',
    useShadowDom: false
)
class ContestHeaderComp implements DetachAware {

  Map<String, dynamic> contestHeaderInfo = {
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
    }
  }

  ContestHeaderComp(this._router, this._routeProvider, this.scrDet) {
    RefreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_UPDATE_COUNTDOWN_DATE, _refreshCountdownDate);
  }

  void _refreshCountdownDate() {
    contestHeaderInfo["textCountdownDate"] = "";
    contestHeaderInfo["countdownDate"] = "";

    if (_contestInfo == null) {
      return;
    }

    if (_contestInfo.isHistory) {
      contestHeaderInfo["startTime"] = "FINALIZADO";
      RefreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_UPDATE_COUNTDOWN_DATE);
    }
    else if (_contestInfo.isLive) {
      contestHeaderInfo["startTime"] = "COMENZÓ EL ${DateTimeService.formatDateTimeShort(_contestInfo.startDate).toUpperCase()}";
      RefreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_UPDATE_COUNTDOWN_DATE);
    }
    else {
      contestHeaderInfo["startTime"] = "COMIENZA EL ${DateTimeService.formatDateTimeShort(_contestInfo.startDate).toUpperCase()}";

      Duration tiempoRestante = DateTimeService.getTimeLeft(_contestInfo.startDate);

      if (tiempoRestante.inSeconds <= 0) {
        contestHeaderInfo["startTime"] = "EN BREVE";
        RefreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_UPDATE_COUNTDOWN_DATE);
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
    contestHeaderInfo["contestantCount"] = "${_contestInfo.contestEntries.length} de ${_contestInfo.maxEntries} jugadores  - Límite de salario: ${_contestInfo.salaryCap}";
  }

  void goToParent() {
    _router.go(_routeProvider.parameters["parent"], {});
  }

  void detach() {
    RefreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_UPDATE_COUNTDOWN_DATE);
  }

  Router _router;
  RouteProvider _routeProvider;

  Contest _contestInfo;
}
