library contest_header_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'dart:async';
import 'package:webclient/services/contests_service.dart';
import 'dart:html';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'contest-header',
    templateUrl: 'packages/webclient/components/contest_header_comp.html',
    useShadowDom: false
)
class ContestHeaderComp implements DetachAware, ShadowRootAware {

  ScreenDetectorService scrDet;

  Map<String, String> info = {
    'description':      '',
    'startTime':        '',
    'contestType':      '',
    'contestantCount':  '',
    'entryPrice':       '',
    'prize':            '',
    'prizeType':        ''
  };

  Contest contest;

  @NgOneWayOneTime("contest")
  void set setContest(Contest value) {
    if (value != null) {
      contest = value;

      _refreshHeader();
      _refreshCountdownDate();
    }
  }

  bool isInsideModal = false;
  @NgAttr('modal')
  void set setModal(String value) {
    if (value != null) {
      isInsideModal = value == "true";
    }
  }

  bool showMatches = true;
  @NgAttr('show-matches')
  void set setShowMatches(String value) {
    if (value != null) {
      showMatches = value == "true";
    }
  }

  // Cuando nos pasan el contestId, ya podemos empezar a mostrar informacion antes de que quien sea (enter_contest, view_contest...)
  // refresque su informacion de concurso (que siempre es mas completa que muchas (o todas) las cosas que necesitamos mostrar aqui)
  @NgOneWayOneTime("contest-id")
  void set setContestId(String value) {
    if (value != null) {
      contest = _contestsService.getContestById(value);

      _refreshHeader();
      _refreshCountdownDate();
    }
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "contestheader");
  }

  ContestHeaderComp(this._router, this._routeProvider, this.scrDet, this._contestsService, this._rootElement) {
    _count = new Timer.periodic(new Duration(seconds: 1), (Timer timer) => _refreshCountdownDate());
  }

  void _refreshCountdownDate() {
    if (contest == null) {
      return;
    }

    if (contest.isHistory) {
      info["startTime"] = getLocalizedText("finished");
      _count.cancel();
    }
    else if (contest.isLive) {
      info["startTime"] = getLocalizedText("startedon") + DateTimeService.formatDateTimeShort(contest.startDate).toUpperCase();
      _count.cancel();
    }
    else {
      info["startTime"] = getLocalizedText("startson") + DateTimeService.formatDateTimeShort(contest.startDate).toUpperCase();

      Duration tiempoRestante = DateTimeService.getTimeLeft(contest.startDate);

      if (tiempoRestante.inHours <= 23) {
        if (tiempoRestante.inSeconds <= 0) {
          info["startTime"] = getLocalizedText("verysoon");
          _count.cancel();
        }
        else {
          info["startTime"] = getLocalizedText("startsin") + DateTimeService.formatTimeLeft(tiempoRestante);
        }
      }
    }
  }

  void _refreshHeader() {
    if (contest == null) {
      return;
    }

    info["description"] = "${contest.name}";
    info['contestType'] = "${contest.tournamentTypeName}: ";
    info["entryPrice"] = "${contest.entryFee}";
    info["prize"] = "${contest.prizePool}";
    info["prizeType"] = "${contest.prizeTypeName}";
    info["startTime"] = "";
    info["contestantCount"] = "${contest.contestEntries.length} of ${contest.maxEntries} ${getLocalizedText("salarycap")}: ${contest.printableSalaryCap}";
  }

  void goToParent() {
    _router.go(_routeProvider.parameters["parent"], {});
  }

  void detach() {
    _count.cancel();
  }

  void onShadowRoot(emulatedRoot) {
    if (isInsideModal) {
      _rootElement.classes.add('rounded-borders');
    }
  }

  Router _router;
  RouteProvider _routeProvider;
  ContestsService _contestsService;
  Element _rootElement;
  Timer _count;
}
