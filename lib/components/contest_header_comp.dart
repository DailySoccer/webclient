library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'dart:async';
import 'package:webclient/services/active_contests_service.dart';

@Component(
    selector: 'contest-header',
    templateUrl: 'packages/webclient/components/contest_header_comp.html',
    useShadowDom: false
)
class ContestHeaderComp implements DetachAware {

  Map<String, String> contestHeaderInfo = {
    'description':      '',
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

  @NgOneWay("contest")
  Contest get contest => _contest;
  void set contest(Contest value) {

    if (value != null) {
      _contest = value;

      _refreshHeader();
      _refreshCountdownDate();
    }
  }

  // Cuando nos pasan el contestId, ya podemos empezar a mostrar informacion antes de que quien sea (enter_contest, view_contest...)
  // refresque su informacion de concurso (que siempre es mas completa que muchas (o todas) las cosas que necesitamos mostrar aqui)
  @NgOneWay("contest-id")
  void set contestId(String value) {
    if (value != null) {
      _contest = _activeContestsService.getContestById(value);

      _refreshHeader();
      _refreshCountdownDate();
    }
  }

  ContestHeaderComp(this._router, this._routeProvider, this.scrDet, this._activeContestsService) {
    _count = new Timer.periodic(new Duration(seconds: 1), (Timer timer) => _refreshCountdownDate());
  }

  void _refreshCountdownDate() {
    contestHeaderInfo["textCountdownDate"] = "";
    contestHeaderInfo["countdownDate"] = "";

    if (_contest == null) {
      return;
    }

    if (_contest.isHistory) {
      contestHeaderInfo["startTime"] = "FINALIZADO";
      _count.cancel();
    }
    else if (_contest.isLive) {
      contestHeaderInfo["startTime"] = "COMENZÓ EL ${DateTimeService.formatDateTimeShort(_contest.startDate).toUpperCase()}";
      _count.cancel();
    }
    else {
      contestHeaderInfo["startTime"] = "COMIENZA EL ${DateTimeService.formatDateTimeShort(_contest.startDate).toUpperCase()}";

      Duration tiempoRestante = DateTimeService.getTimeLeft(_contest.startDate);

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
    if (_contest == null) {
      return;
    }

    contestHeaderInfo["description"] = "${_contest.name}";
    contestHeaderInfo['contestType'] = "${_contest.tournamentTypeName}: ";
    contestHeaderInfo["entryPrice"] = "${_contest.entryFee}€";
    contestHeaderInfo["prize"] = "${_contest.prizePool}€";
    contestHeaderInfo["prizeType"] = "${_contest.prizeTypeName}";
    contestHeaderInfo["startTime"] = "";
    contestHeaderInfo["contestantCount"] = "${_contest.contestEntries.length} de ${_contest.maxEntries} jugadores  - Límite de salario: ${_contest.salaryCap}";
  }

  void goToParent() {
    _router.go(_routeProvider.parameters["parent"], {});
  }

  void detach() {
    _count.cancel();
  }

  Router _router;
  RouteProvider _routeProvider;
  ActiveContestsService _activeContestsService;

  Timer _count;
  Contest _contest;
}
