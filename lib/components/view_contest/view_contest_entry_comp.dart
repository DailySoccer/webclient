library view_contest_entry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/match_event.dart';
import 'dart:html';

@Component(
   selector: 'view-contest-entry',
   templateUrl: 'packages/webclient/components/view_contest/view_contest_entry_comp.html',
   useShadowDom: false
)
class ViewContestEntryComp {
  ScreenDetectorService scrDet;

  ContestEntry mainPlayer;
  dynamic selectedOpponent;

  DateTime updatedDate;

  List<String> matchesInvolved = [];

  bool get isLoaded => !LoadingService.enabled;
  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  // A esta pantalla entramos de varias maneras:
  bool get isModeViewing => _viewContestEntryMode == "viewing"; // Clickamos "my_contests->proximos->ver".
  bool get isModeCreated => _viewContestEntryMode == "created"; // Acabamos de crearla a traves de enter_contest
  bool get isModeEdited  => _viewContestEntryMode == "edited";  // Venimos de editarla a traves de enter_contest.
  bool get isModeSwapped => _viewContestEntryMode == "swapped"; // Acabamos de crearla pero el servidor nos cambio a otro concurso pq el nuestro estaba lleno.

  ViewContestEntryComp(this._routeProvider, this.scrDet, this._myContestsService, this._profileService, this._flashMessage, this._router) {
    LoadingService.enabled = true;

    _viewContestEntryMode = _routeProvider.route.parameters['viewContestEntryMode'];
    _contestId = _routeProvider.route.parameters['contestId'];

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshMyContest(_contestId)
      .then((jsonObject) {
        LoadingService.enabled = false;

        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

        updatedDate = DateTimeService.now;

        // generamos los partidos para el filtro de partidos
        matchesInvolved.clear();
        List<MatchEvent> matchEventsSorted = new List<MatchEvent>.from(contest.matchEvents)
            .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
            .. forEach( (match) {
              matchesInvolved.add(match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate));
            });

      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void goToParent() {
    _router.go(_routeProvider.parameters["parent"] , {});
  }

  void cancelContestEntry() {
    _myContestsService.cancelContestEntry(mainPlayer.contestEntryId)
      .then((jsonObject) {
        goToParent();
      });
  }

  Router _router;
  RouteProvider _routeProvider;

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  MyContestsService _myContestsService;

  String _contestId;
  String _viewContestEntryMode;
}