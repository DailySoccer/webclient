library home_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/promos_service.dart';
import 'dart:html';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/utils/string_utils.dart';
//import 'package:webclient/components/account/notifications_comp.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/reward.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:logging/logging.dart';

@Component(
  selector: 'home',
  templateUrl: 'packages/webclient/components/home_comp.html',
  useShadowDom: false
)
class HomeComp implements DetachAware {

  ContestsService contestsService;
  LoadingService loadingService;

  bool get userIsLogged => _profileService.isLoggedIn;
  bool get tutorialIsDone => TutorialService.Instance.isCompleted(TutorialIniciacion.NAME);

  bool get isContestTileEnabled => tutorialIsDone;
  bool get isCreateContestTileEnabled => userIsLogged && tutorialIsDone;
  bool get isScoutingTileEnabled => userIsLogged && tutorialIsDone;
  bool get isMyContestTilesEnabled => userIsLogged && tutorialIsDone;
  bool get isUpcomingTileEnabled => isMyContestTilesEnabled;
  bool get isLiveTileEnabled => isMyContestTilesEnabled;
  bool get isHistoryTileEnabled => isMyContestTilesEnabled;
  bool get isBlogTileEnabled => true;
  bool get isHowItWorksEnabled => true;
  
  List<Achievement> achievementList = Achievement.AVAILABLES.map( (achievementMap) => new Achievement.fromJsonObject(achievementMap)).toList();
  String get achievementsEarned => countAchievementsEarned().toString();

  bool achievementEarned(achievementKey) {
     bool ret;
     if (_profileService.user != null){
         ret = _profileService.user.achievements.contains(achievementKey);
     }
     else { 
       ret = false;
     }
     return ret;
   }

  User get user => _profileService.user;
  
  List<Map> pointsUserList;
  //Map playerPointsInfo = null ;//{'position':'_', 'id':'', 'name': '', 'points': ' '};
  
  String skillLevelName;
  String skillLevelImage;

  bool isThePlayer(id) => id == user.userId;
  
  String get CreateContestTileText => !userIsLogged? getLocalizedText('create_contest_text_nolog') :
                                            !tutorialIsDone? getLocalizedText('create_contest_text_notut') :
                                                             getLocalizedText('create_contest_text_logNtut');

  static const String PROMO_CODE_NAME_LOGIN = "Home Contest Tile LogIn";
  static const String PROMO_CODE_NAME_LOGOFF = "Home Contest Tile LogOff";
  Map currentPromo = null;

  String infoBarText = "";
  bool availableNextContest = false;
  
  Contest get nextContest => contestsService.getAvailableNextContest();
  
  void _calculateInfoBarText() {
    //Contest nextContest = contestsService.getAvailableNextContest();
    if (availableNextContest) {
      infoBarText = nextContest == null? 'Todos los torneos están llenos' : 'PRóXIMO TORNEO <span class="home-next-contest-hour"> ${_calculateTimeToNextTournament()}</span>';
    }
  }

  String _calculateTimeToNextTournament() {
    return DateTimeService.formatTimeLeft(DateTimeService.getTimeLeft( contestsService.getAvailableNextContest().startDate ) );
  }  
  
  HomeComp(this._router, this._profileService, this._appStateService, this.contestsService, this._flashMessage,
            this.loadingService, this._refreshTimersService, this._promosService,
            TutorialService tutorialService, this._leaderboardService) {
   
    if (!this._profileService.isLoggedIn) {
      loadingService.isLoading = true;
      this._profileService.onLogin.listen((_) { loadingService.isLoading = false; });
    }
    _refreshProfileStream = _profileService.onRefreshProfile.listen(onProfileRefresh);
    
    refreshTopBar();
    refreshRankingPosition();
    
    _appStateService.appSecondaryTabBarState.tabList = [];
    _appStateService.appTabBarState.show = true;

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, refreshTopBar);
    //_refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_RANKING_POSITION, refreshRankingPosition);

    //countAchievementsEarned(); 
    
    contestsService.refreshActiveContests()
      .then((_) => availableNextContest = true);
    
    _nextTournamentInfoTimer = new Timer.periodic(new Duration(seconds: 1), (Timer t) => _calculateInfoBarText());
    
    GameMetrics.screenVisitEvent(GameMetrics.SCREEN_START);
  }
  
  void onProfileRefresh(User user) {
    refreshRankingPosition();
  }
  
  void refreshRankingPosition() {
    _leaderboardService.calculateMyTrueSkillData();
    skillLevelName =  _leaderboardService.myTrueSkillName;
    skillLevelImage = _leaderboardService.myTrueSkillImage;
  }
  
  int countAchievementsEarned() {
    int count = 0;
    achievementList.forEach((ach) {
      if (achievementEarned(ach.id))
        count++;
    });
    // achievementList.where((ach) => achievementEarned(ach.id)).length;
    return count;
  }
  
  void refreshTopBar() {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router, _leaderboardService, true);
  }

  static String getStaticLocalizedText(key) {
    return StringUtils.translate(key, "home");
  }
  
  String getLocalizedText(key) {
    return getStaticLocalizedText(key);
  }

  void goNextContest() {
    /*if (nextContest != null)
      _router.go('enter_contest', { "contestId": nextContest.contestId, "parent": "lobby", "contestEntryId": "none" });
    else*/
    GameMetrics.actionEvent(GameMetrics.ACTION_START_PLAY_BUTTON, GameMetrics.SCREEN_START);
    _router.go('lobby', {});
  } 
  
  void goScouting(){
    _router.go('scouting', {});
  } 
  
  void goShop() {
    _router.go('shop', {});
  }
  
  void goHistory() {
    _router.go('my_contests', {"section": "history"});
  }
    
  void goRanking() {
    _router.go('leaderboard', {'userId': 'me'});
  }
    
  void goAchievements() {
    _router.go('achievements', {});
  }
    
  void detach() {
    _refreshProfileStream.cancel();
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
    //_refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_RANKING_POSITION);
    _nextTournamentInfoTimer.cancel();
  }

  StreamSubscription<User> _refreshProfileStream;
  ProfileService _profileService;
  Router _router;
  FlashMessagesService _flashMessage;
  RefreshTimersService _refreshTimersService;
  PromosService _promosService;
  AppStateService _appStateService;
  Timer _nextTournamentInfoTimer;
  LeaderboardService _leaderboardService;
}