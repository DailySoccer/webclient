library view_contest_entry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/facebook_service.dart';

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

  String get _getKeyForCurrentUserContest => (_profileService.isLoggedIn ? _profileService.user.userId : 'guest') + '#' + contest.contestId;

  bool get showInviteButton => (contest != null) ?  contest.maxEntries != contest.contestEntries.length : false;
  
  // A esta pantalla entramos de varias maneras:
  bool get isModeViewing => _viewContestEntryMode == "viewing"; // Clickamos "my_contests->proximos->ver".
  bool get isModeCreated => _viewContestEntryMode == "created"; // Acabamos de crearla a traves de enter_contest
  bool get isModeEdited  => _viewContestEntryMode == "edited";  // Venimos de editarla a traves de enter_contest.
  bool get isModeSwapped => _viewContestEntryMode == "swapped"; // Acabamos de crearla pero el servidor nos cambio a otro concurso pq el nuestro estaba lleno.


  String get fbTitle => FacebookService.titleOfInscription();
  String get fbDescription => FacebookService.descriptionOfInscription();
  String get fbImage => FacebookService.imageOfInscription();
  
  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "viewcontestentry", substitutions);
  }

  ViewContestEntryComp(this._routeProvider, this.scrDet, this._contestsService,
                       this._profileService, this._router, this.loadingService, TutorialService tutorialService) {
    loadingService.isLoading = true;

    _viewContestEntryMode = _routeProvider.route.parameters['viewContestEntryMode'];
    contestId = _routeProvider.route.parameters['contestId'];

    tutorialService.triggerEnter("view_contest_entry");

    _contestsService.refreshMyContestEntry(contestId)
      .then((_) {
        loadingService.isLoading = false;
        contest = _contestsService.lastContest;
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

        updatedDate = DateTimeService.now;
      })
      .catchError((ServerError error) {
        _router.go("lobby", {});
      }, test: (error) => error is ServerError);
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

  void confirmContestCancellation(){
    modalShow(
                getLocalizedText("alertcanceltitle"),
                contest.entryFee.amount > 0 ?
                  getLocalizedText("alertcancelpaidcontest",{'PRICE' : contest.entryFee}) :
                  getLocalizedText("alertcancelcontest"),
                onOk: getLocalizedText("alertbuttonyes"),
                onCancel: getLocalizedText("alertbuttonno")
             )
             .then((resp){
                if(resp) {
                  cancelContestEntry();
                  window.localStorage.remove(_getKeyForCurrentUserContest);
                }
              });
  }


  void cancelContestEntry() {
    GameMetrics.logEvent(GameMetrics.CANCEL_CONTEST_ENTRY, {"value": contest.entryFee});
    _contestsService.cancelContestEntry(mainPlayer.contestEntryId)
      .then((jsonObject) {
        goToParent();
      });
  }

  void onInviteFriends() {
    String theBasicUrl = window.location.toString().split("#")[0];
    String theUrl = "${theBasicUrl}#/enter_contest/lobby/${contest.contestId}/none";
    
    modalShow(      "Invita a tus amigos",
                    theUrl,
                    onOk: "Copiado",
                    modalSize: "lg",
                    type: 'welcome'
                 )
                 .then((resp){
                  });
  }
  
  Router _router;
  RouteProvider _routeProvider;

  ProfileService _profileService;
  ContestsService _contestsService;

  String _viewContestEntryMode;
}