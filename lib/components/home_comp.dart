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

@Component(
  selector: 'home',
  templateUrl: 'packages/webclient/components/home_comp.html',
  useShadowDom: false
)
class HomeComp  {

  ContestsService contestsService;
  LoadingService loadingService;

  int numLiveContests = 0;
  int numVirtualHistoryContests = 0;
  int numRealHistoryContests = 0;
  int numUpcomingContests = 0;

  bool get userIsLogged => _profileService.isLoggedIn;
  bool get tutorialIsDone => TutorialService.Instance.isCompleted(TutorialIniciacion.NAME);

  bool get isContestTileEnabled => tutorialIsDone;
  bool get isCreateContestTileEnabled => userIsLogged && tutorialIsDone;
  bool get isScoutingTileEnabled => true;
  bool get isMyContestTilesEnabled => userIsLogged && tutorialIsDone;
  bool get isUpcomingTileEnabled => isMyContestTilesEnabled;
  bool get isLiveTileEnabled => isMyContestTilesEnabled;
  bool get isHistoryTileEnabled => isMyContestTilesEnabled;
  bool get isBlogTileEnabled => true;
  bool get isHowItWorksEnabled => true;
  String get CreateContestTileText => !userIsLogged? getLocalizedText('create_contest_text_nolog') :
                                            !tutorialIsDone? getLocalizedText('create_contest_text_notut') :
                                                             getLocalizedText('create_contest_text_logNtut');

  static const String PROMO_CODE_NAME_LOGIN = "Home Contest Tile LogIn";
  static const String PROMO_CODE_NAME_LOGOFF = "Home Contest Tile LogOff";
  Map currentPromo = null;

  HomeComp(this._router, this._profileService, this.contestsService, this._flashMessage,
            this.loadingService, this._refreshTimersService, this._promosService,
            TutorialService tutorialService) {
    loadingService.isLoading = true;
    _refreshMyContests();
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
  }


  static String getStaticLocalizedText(key) {
    return StringUtils.translate(key, "home");
  }
  String getLocalizedText(key) {
    return getStaticLocalizedText(key);
  }

  void _refreshMyContests() {
    if (!userIsLogged) {
      loadingService.isLoading = false;
      return;
    }
    // Parallel processing using the Future API
    Future.wait([ contestsService.refreshMyHistoryContests(),
                  contestsService.refreshMyLiveContests(),
                  contestsService.refreshMyActiveContests()])
      .then((_) {
        loadingService.isLoading = false;
        numVirtualHistoryContests = contestsService.historyContests.where( (c) => c.isSimulation ).length;
        numRealHistoryContests = contestsService.historyContests.length - numVirtualHistoryContests;
        numLiveContests = contestsService.liveContests.length;
        numUpcomingContests = contestsService.waitingContests.length;
      })
      .catchError((ServerError error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      }, test: (error) => error is ServerError);

  }

  Map defaultPromo = {  'url' : '' // EJ: "#/enter_contest/lobby/564cb79ad4c6c22fa0407f5d/none"
                       ,'imageXs' : 'images/ht_ModuloTorneoBGPlay.jpg'  // Not used
                       ,'imageDesktop' : 'images/ht_ModuloTorneoBGPlay.jpg'
                       ,'html' : '''  <span class="tile-title"><strong>${getStaticLocalizedText('play')}</strong></span>
                                      <span class="tile-info">${getStaticLocalizedText('learn_to_play')}</span>
                                 '''
                       ,'text' : 'The promo you are trying to access is not available'
                       ,'promoEnterUrl' : 'lobby' // Not used
                       ,'buttonCaption' : 'Return to Lobby'  // Not used
                       ,'codeName' : '404'
                     };

  Map defaultPromoWithTutorial = {  'url' : '' // EJ: "#/enter_contest/lobby/564cb79ad4c6c22fa0407f5d/none"
                        ,'imageXs' : 'images/ht_ModuloTorneoBG.jpg'  // Not used
                        ,'imageDesktop' : 'images/ht_ModuloTorneoBG.jpg'
                        ,'html' : '''  
                            <span class="tile-title"><strong>Torneos Epic</strong> Eleven</span>
                            <div class="tile-info">
                             <span class="promo-description">Entra a la lista de torneos para empezar a jugar</span>
                            </div>
                                 '''
                        ,'text' : 'The promo you are trying to access is not available'
                        ,'promoEnterUrl' : 'lobby' // Not used
                        ,'buttonCaption' : 'Return to Lobby'  // Not used
                        ,'codeName' : '404'
                      };

  String get contestTileHTML {
    Element tile = querySelector("#contestTile .tile");
    if(tile == null) return defaultPromo['html'];

    List<Map> promos = this._promosService.promos != null? this._promosService.promos : [];
    String promoCodeName = isContestTileEnabled? PROMO_CODE_NAME_LOGIN : PROMO_CODE_NAME_LOGOFF;
    currentPromo = promos.firstWhere((promo) => promo['codeName'] == promoCodeName,
        orElse: () => isContestTileEnabled ? defaultPromoWithTutorial : defaultPromo);

    tile.style.backgroundImage = "url('${currentPromo['imageDesktop']}')";
    return currentPromo['html'];
  }

  void onContestsClick() {
    _promosService.gotoPromo(currentPromo, defaultUrl: 'lobby');
  }

  void onScoutingClick() {
    if (!isScoutingTileEnabled) return;
    _router.go('scouting', {});
  }

  void onCreateContestClick() {
    if (!isCreateContestTileEnabled) return;
    _router.go('create_contest', {});
  }

  void onHistoryClick() {
    if (!isHistoryTileEnabled) return;
    _router.go('my_contests', {'section':'history'});
  }

  void onLiveClick() {
    if (!isLiveTileEnabled) return;
    _router.go('my_contests', {'section':'live'});
  }

  void onUpcomingClick() {
    if (!isUpcomingTileEnabled) return;
    _router.go('my_contests', {'section':'upcoming'});
  }

  void onBlogClick() {
    if (!isBlogTileEnabled) return;
    window.open("http://halftime.epiceleven.com", "HalfTime");
  }

  void onHowItWorksClick() {
    if (!isHowItWorksEnabled) return;
    _router.go('help_info', {});
  }


  ProfileService _profileService;
  Router _router;
  FlashMessagesService _flashMessage;
  RefreshTimersService _refreshTimersService;
  PromosService _promosService;

}