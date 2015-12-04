library contest_header_f2p_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import "package:webclient/models/contest.dart";
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/money.dart';
import 'dart:async';
import 'package:webclient/services/contests_service.dart';
import 'dart:html';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/facebook_service.dart';

@Component(
    selector: 'contest-header-f2p',
    templateUrl: 'packages/webclient/components/contest_header_f2p_comp.html',
    useShadowDom: false
)
class ContestHeaderF2PComp implements DetachAware, ShadowRootAware {

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
  
  String get fbTitle => FacebookService.titleByContest(contest, _profileService.user.userId);
  String get fbDescription => FacebookService.descriptionByContest(contest, _profileService.user.userId);
  String get fbPhoto => FacebookService.imageByContest(contest, _profileService.user.userId);
  String get fbCaption => FacebookService.captionByContest(contest, _profileService.user.userId);

  ContestHeaderF2PComp(this._router, this._routeProvider, this._profileService, this.scrDet, this._contestsService, this._rootElement) {
    _count = new Timer.periodic(new Duration(seconds: 1), (Timer timer) => _refreshCountdownDate());
  }

  String getContestTypeIcon() {
    return contest.isSimulation ? "train" : "real";
  }

  String getSourceFlag() {
    String ret = "flag ";
    if (contest != null) switch (contest.competitionType) {
      case "LEAGUE_ES":
        ret += "flag-es";
      break;
      case "LEAGUE_UK":
        ret += "flag-gb";
      break;
      case "CHAMPIONS":
        ret += "flag-eu";
      break;
      default:
        ret += "flag-es";
      break;
    }

    return ret;
  }


  String printableMyPosition() {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory) {
      return (mainContestEntry.position >= 0) ? "${mainContestEntry.position + 1}" : "-";
    }

    return "${contest.getUserPosition(mainContestEntry)}";
  }

  Money getPrizeToShow() {
    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory || contest.isLive) {
      return getMyPrize(contest);
    }

    return contest.prizePool;
  }
  
  Money getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
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
  ProfileService _profileService;
}
