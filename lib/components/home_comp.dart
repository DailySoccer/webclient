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
import 'package:webclient/components/account/notifications_comp.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/template_service.dart';

@Component(
  selector: 'home',
  templateUrl: 'packages/webclient/components/home_comp.html',
  useShadowDom: false
)
class HomeComp implements DetachAware {

  ContestsService contestsService;
  LoadingService loadingService;

  int numLiveContests = 0;
  int numVirtualHistoryContests = 0;
  int numRealHistoryContests = 0;
  int numUpcomingContests = 0;

  bool get userIsLogged => _profileService.isLoggedIn;
  bool get tutorialIsDone => TutorialService.Instance.isCompleted(TutorialIniciacion.NAME);
  /*
  bool get isContestTileEnabled => tutorialIsDone;
  bool get isCreateContestTileEnabled => userIsLogged && tutorialIsDone;
  bool get isScoutingTileEnabled => userIsLogged && tutorialIsDone;
  bool get isMyContestTilesEnabled => userIsLogged && tutorialIsDone;
  bool get isUpcomingTileEnabled => isMyContestTilesEnabled;
  bool get isLiveTileEnabled => isMyContestTilesEnabled;
  bool get isHistoryTileEnabled => isMyContestTilesEnabled;
  bool get isBlogTileEnabled => true;
  bool get isHowItWorksEnabled => true;
  */
  bool get isContestTileEnabled => false;
  bool get isCreateContestTileEnabled => false;
  bool get isScoutingTileEnabled => true;
  bool get isMyContestTilesEnabled => false;
  bool get isUpcomingTileEnabled => false;
  bool get isLiveTileEnabled => false;
  bool get isHistoryTileEnabled => false;
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
    //contestTileHTML = isContestTileEnabled ? defaultPromo['html'] : defaultPromoWithTutorial['html'];
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
    _profileService.triggerNotificationsPopUp(_router);

    GameMetrics.logEvent(GameMetrics.HOME, {"logged": _profileService.isLoggedIn});
  }


  static String getStaticLocalizedText(key) {
    return StringUtils.translate(key, "home");
  }
  String getLocalizedText(key) {
    return getStaticLocalizedText(key);
  }

  void _refreshMyContests() {
    if (!userIsLogged) {
      // Intentamos cargar lo más pronto posible los TemplateSoccerPlayers
      TemplateService.Instance.refreshTemplateSoccerPlayers();
 
      loadingService.isLoading = false;
      refreshContestTileHTML();
      return;
    }
    // Parallel processing using the Future API
    Future.wait([ TemplateService.Instance.refreshTemplateSoccerPlayers(), 
                  contestsService.countMyContests()])
      .then((List jsonMaps) {
        Map jsonData = jsonMaps[1];
        loadingService.isLoading = false;
        numVirtualHistoryContests = jsonData.containsKey("numVirtualHistory") ? jsonData["numVirtualHistory"] : 0;
        numRealHistoryContests    = jsonData.containsKey("numRealHistory") ? jsonData["numRealHistory"] : 0;
        numLiveContests           = jsonData.containsKey("numLive") ? jsonData["numLive"] : 0;
        numUpcomingContests       = jsonData.containsKey("numWaiting") ? jsonData["numWaiting"] : 0;
        refreshContestTileHTML();
      })
      .catchError((ServerError error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      }, test: (error) => error is ServerError);
  }
/*
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
                            <span class="tile-title"><strong>Torneos<br>Fútbol Cuatro</strong></span>
                            <div class="tile-info">
                              <span class="promo-description">Entra a la lista de torneos para empezar a jugar</span>
                            </div>
                                 '''
                        ,'text' : 'The promo you are trying to access is not available'
                        ,'promoEnterUrl' : 'lobby' // Not used
                        ,'buttonCaption' : 'Return to Lobby'  // Not used
                        ,'codeName' : '404'
                      };
*/

  Map defaultPromoWithTutorial = {  'url' : '' // EJ: "#/enter_contest/lobby/564cb79ad4c6c22fa0407f5d/none"
                        ,'imageXs' : 'images/ht_ModuloTorneoSeasonEnd.jpg'  // Not used
                        ,'imageDesktop' : 'images/ht_ModuloTorneoSeasonEnd.jpg'
                        ,'html' : '''  
                            <span class="tile-title"><strong>Fútbol Cuatro</strong></span>
                            <div class="tile-info">
                              <span class="end-of-season">
                                La temporada 15/16 ha terminado, volvemos en agosto con nuevas funcionalidades. ¡Podrás estar al día de las novedades en nuestras redes sociales!
                              </span>
                              <a target="_blank" class="home-facebook-social" href="https://www.facebook.com/Futbolcuatro/">
                                <img title="Futbol Cuatro en Facebook" alt="Futbol Cuatro en Facebook" src="images/facebook.png">
                              </a>
                              <a target="_blank" class="home-twitter-social" href="https://twitter.com/Futbol_cuatro">
                                <img title="Futbol Cuatro en Twitter" alt="Futbol Cuatro en Twitter" src="images/twitter.png">
                              </a>
                            </div>
                                 '''
                        ,'text' : 'The promo you are trying to access is not available'
                        ,'promoEnterUrl' : 'lobby' // Not used
                        ,'buttonCaption' : 'Return to Lobby'  // Not used
                        ,'codeName' : '404'
                      };
  
  Map get defaultPromo => defaultPromoWithTutorial;
  
  void refreshContestTileHTML() {
    Element tile = querySelector("#contestTile .tile");
    if(tile == null) {
      _contestTileHTML = '';
      return;
    }
    
    List<Map> promos = this._promosService.promos != null? this._promosService.promos : [];
    String promoCodeName = isContestTileEnabled? PROMO_CODE_NAME_LOGIN : PROMO_CODE_NAME_LOGOFF;
    currentPromo = promos.firstWhere((promo) => promo['codeName'] == promoCodeName,
        orElse: () => isContestTileEnabled ? defaultPromoWithTutorial : defaultPromo);

    if (tile.style.backgroundImage != "url('${currentPromo['imageDesktop']}')") { 
      tile.style.backgroundImage = "url('${currentPromo['imageDesktop']}')";
    }
    _contestTileHTML = currentPromo['html'];
  }
  
  String _contestTileHTML = '';
  
  String get contestTileHTML {
    if (_contestTileHTML == '') {
      refreshContestTileHTML();
    }
    return _contestTileHTML;
  }

  void onContestsClick() {
    if (_contestTileHTML == '') {
      _router.go('lobby', {});
    } else {
      _promosService.gotoPromo(currentPromo, defaultUrl: 'lobby');
    }
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
    GameMetrics.logEvent(GameMetrics.ENTERED_FORUMS);
    // window.open("http://halftime.epiceleven.com", "HalfTime");
    window.open("http://www.futbolcuatro.com/foros/", "Foro Fútbol Cuatro");
  }

  void onHowItWorksClick() {
    if (!isHowItWorksEnabled) return;
    // _router.go('help_info', {});
    window.open("http://www.futbolcuatro.com/ayuda/", "Como jugar a Futbol Cuatro");
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS);
  }

  ProfileService _profileService;
  Router _router;
  FlashMessagesService _flashMessage;
  RefreshTimersService _refreshTimersService;
  PromosService _promosService;

}