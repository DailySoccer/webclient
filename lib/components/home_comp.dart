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

  
  
  HomeComp(this._router, this._profileService, this.contestsService, this._flashMessage,
            this.loadingService, this._refreshTimersService, this._promosService, 
            TutorialService tutorialService) {
    loadingService.isLoading = true;
    _refreshMyContests();
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_MY_CONTESTS, _refreshMyContests);
  }


  void _refreshMyContests() {
    if (!userIsLogged) return;
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
  
  Map defaultPromo = {  'url': ''
                       ,'imageXs'  : '../images/ht_ModuloTorneoBG.jpg'
                       ,'imageDesktop'  : '../images/ht_ModuloTorneoBG.jpg'
                       ,'html' : '''  <span class="tile-title">Jugar</span>
                                      <span class="tile-info">Aprende a ganar<br>y comienza tu carrera de manager</span>
                                 '''
                       ,'text'     : 'The promo you are trying to access is not available'
                       ,'promoEnterUrl' : 'lobby'
                       ,'buttonCaption' :'Return to Lobby'
                       ,'codeName': '404'
                     };
  
  String get contestTileHTML {
    List<Map> promos = this._promosService.promos != null? this._promosService.promos : [];
    Map currentPromo = promos.length > 0? promos[0] : defaultPromo;
    
    querySelector("#contestTile .tile").style.backgroundImage = "url('${currentPromo['imageDesktop']}')";
    
    return currentPromo['html'];
  }
  
  
  void onContestsClick() {
    _router.go('lobby', {});
  }

  void onScoutingClick() {
    if (!userIsLogged) return;
  }

  void onCreateContestClick() {
    if (!userIsLogged) return;
    _router.go('create_contest', {});
  }

  void onHistoryClick() {
    if (!userIsLogged) return;
    _router.go('my_contests', {'section':'history'});
  }

  void onLiveClick() {
    if (!userIsLogged) return;
    _router.go('my_contests', {'section':'live'});
  }

  void onUpcomingClick() {
    if (!userIsLogged) return;
    _router.go('my_contests', {'section':'upcoming'});
  }

  void onBlogClick() {

  }
  void onTutorialClick() {
    _router.go('tutorial_list', {});
  }

  bool get userIsLogged => _profileService.isLoggedIn;

  ProfileService _profileService;
  Router _router;
  FlashMessagesService _flashMessage;
  RefreshTimersService _refreshTimersService;
  PromosService _promosService;

}