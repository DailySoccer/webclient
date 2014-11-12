library view_contest_entry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';

@Component(
   selector: 'view-contest-entry',
   templateUrl: 'packages/webclient/components/view_contest/view_contest_entry_comp.html',
   useShadowDom: false
)
class ViewContestEntryComp {
  ScreenDetectorService scrDet;
  LoadingService loadingService;

  ContestEntry mainPlayer;
  dynamic selectedOpponent;
  String contestId;

  DateTime updatedDate;

  Contest contest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  // A esta pantalla entramos de varias maneras:
  bool get isModeViewing => _viewContestEntryMode == "viewing"; // Clickamos "my_contests->proximos->ver".
  bool get isModeCreated => _viewContestEntryMode == "created"; // Acabamos de crearla a traves de enter_contest
  bool get isModeEdited  => _viewContestEntryMode == "edited";  // Venimos de editarla a traves de enter_contest.
  bool get isModeSwapped => _viewContestEntryMode == "swapped"; // Acabamos de crearla pero el servidor nos cambio a otro concurso pq el nuestro estaba lleno.

  ViewContestEntryComp(this._routeProvider, this.scrDet, this._myContestsService, this._profileService, this._flashMessage, this._router, this.loadingService) {
    loadingService.isLoading = true;

    _viewContestEntryMode = _routeProvider.route.parameters['viewContestEntryMode'];
    contestId = _routeProvider.route.parameters['contestId'];

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshMyContestEntry(contestId)
      .then((jsonMap) {
        loadingService.isLoading = false;
        contest = _myContestsService.lastContest;
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

        updatedDate = DateTimeService.now;
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
  ContestsService _myContestsService;

  String _viewContestEntryMode;
}