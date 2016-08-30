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
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/game_info.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/app_state_service.dart';

@Component(
   selector: 'view-contest-entry',
   templateUrl: 'packages/webclient/components/view_contest/view_contest_entry_comp.html',
   useShadowDom: false
)
class ViewContestEntryComp {
  ScreenDetectorService scrDet;
  LoadingService loadingService;

  ContestEntry mainPlayer;
  String get formationId => mainPlayer != null? mainPlayer.formation : ContestEntry.FORMATION_442;
  void set formationId(id) { 
    if (mainPlayer != null) mainPlayer.formation = id; 
  }
  List<SoccerPlayerListItem> lineupSlots = [];
  List<String> get lineupFormation => FieldPos.FORMATIONS[formationId];
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
  
  List<User> _friendList = [];
  List<User> _filteredFriendList = [];
  List<User> get filteredFriendList {
    if (contest == null || contest.isFull) return _filteredFriendList;
    if (_friendList != _profileService.friendList) {
      _friendList = _profileService.friendList;
      _filteredFriendList = _friendList.where((u) => !contest.contestEntries.any(
              (entry) => entry.user.facebookID == u.facebookID)).toList();
    }
    return _filteredFriendList;
  }
  
  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "viewcontestentry", substitutions);
  }

  ViewContestEntryComp(this._routeProvider, this.scrDet, this._contestsService, this._appStateService,
                       this._profileService, this._router, this.loadingService, TutorialService tutorialService) {
    loadingService.isLoading = true;
    
    setupContestInfoTopBar(false, () => _router.go('my_contests', {"section": "upcoming"}));
    //_appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, false, () => _router.go('lobby', {}));
    _appStateService.appSecondaryTabBarState.tabList = [];
    _appStateService.appTabBarState.show = false;

    _viewContestEntryMode = _routeProvider.route.parameters['viewContestEntryMode'];
    contestId = _routeProvider.route.parameters['contestId'];

    tutorialService.triggerEnter("view_contest_entry");
    
    _contestsService.refreshMyContestEntry(contestId)
      .then((_) {
        loadingService.isLoading = false;
        contest = _contestsService.lastContest;
        setupContestInfoTopBar(true, () => _router.go('my_contests', {"section": "upcoming"}), onContestInfoClick);
        _appStateService.appSecondaryTabBarState.tabList = [];
        _appStateService.appTabBarState.show = false;
        
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
        
        mainPlayer.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
          num managerLevel = 0;
          if (_profileService.isLoggedIn) {
            managerLevel = _profileService.user.managerLevel;
          }
          lineupSlots.add(new SoccerPlayerListItem(instanceSoccerPlayer, managerLevel, contest));
        });
        
        updatedDate = DateTimeService.now;
        if(!_contestsService.lastContest.isHistory && !_contestsService.lastContest.isLive) {
          GameMetrics.logEvent(GameMetrics.UPCOMING_CONTEST);
        }
      })
      .catchError((ServerError error) {
        _router.go("lobby", {});
      }, test: (error) => error is ServerError);
  }

  void onContestInfoClick() {
    //sectionActive = CONTEST_INFO;
  }
  
  void setupContestInfoTopBar(bool showInfoButton, Function backFunction, [Function infoFunction]) {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, showInfoButton, backFunction, infoFunction);
  }
  void onLineupSlotSelected(slotIndex) {
    SoccerPlayerListItem soccerPlayer = lineupSlots[slotIndex];
    
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
  
  /*
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
                  GameInfo.remove(_getKeyForCurrentUserContest);
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
  */
  String get inviteUrl => "${HostServer.domain}/#/sec/${contest.contestId}";
  
  void onInviteFriends() {
    if (_shareContent == null) {
      _shareContent = querySelector("#shareMethodsContent");
    }
    _shareContent.remove();
    
    modalShow(      "Invita a tus amigos",
                    '',
                    contentNode: _shareContent,
                    onOk: "Cerrar",
                    modalSize: "md",
                    type: 'welcome',
                    aditionalClass: 'invite-friends-popup'
                 )
                 .then((resp){});
    
    querySelector(".share-url").focus();
  }
  
  void onChallenge(user) {
    GameMetrics.logEvent(GameMetrics.FRIEND_BAR_CHALLENGE);
    onInviteFriends();
  }

  void onShareTextareaFocus(Event e) {
    InputElement inputText = e.currentTarget;
    inputText.setSelectionRange(0, inviteUrl.length);
  }
  
  Map _sharingInfo = {};
  Map get sharingInfo {
    if (contest == null) return _sharingInfo;
    if (_sharingInfo.length == 0) {
      if (contest.isAuthor(_profileService.user)) {
        _sharingInfo = FacebookService.createdContest(contest.contestId);
      } else {
        _sharingInfo = FacebookService.inscribeInContest(contest.contestId);
      }
      _sharingInfo['selector-prefix'] = '${_sharingInfo['selector-prefix']}_inviteBtt';
    }
    return _sharingInfo;
  }
  
  Router _router;
  RouteProvider _routeProvider;
  Element _shareContent;

  ProfileService _profileService;
  ContestsService _contestsService;
  AppStateService _appStateService;

  String _viewContestEntryMode;
}