library view_contest_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/soccer_team.dart';
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/utils/game_info.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';
import 'package:webclient/models/user.dart';
import 'package:source_span/src/utils.dart';

@Component(
    selector: 'view-contest',
    templateUrl: 'packages/webclient/components/view_contest/view_contest_comp.html',
    useShadowDom: false)
class ViewContestComp implements DetachAware {
  
  /*
   * VIEW_CONTEST STATES MANAGEMENTS
   */
  
  static const String LINEUP_FIELD_CONTEST_ENTRY = "LINEUP_FIELD_CONTEST_ENTRY";
  static const String CONTEST_INFO = "CONTEST_INFO";
  static const String RIVALS_LIST = "RIVALS_LIST";
  static const String COMPARATIVE = "COMPARATIVE";
  static const String SOCCER_PLAYER_LIST = "SOCCER_PLAYER_LIST";
  static const String SOCCER_PLAYER_STATS = "SOCCER_PLAYER_STATS";
  
  String get metricsScreenName => _contestsService.lastContest.isLive? GameMetrics.SCREEN_LIVE_CONTEST : GameMetrics.SCREEN_HISTORY_CONTEST;
  
  String _sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
  String _lastSectionActive = LINEUP_FIELD_CONTEST_ENTRY;
  void set sectionActive(String section) { 
    if (_sectionActive != CONTEST_INFO) {
      _lastSectionActive = _sectionActive;
    }
    _sectionActive = section;
    switch(_sectionActive) {
      case SOCCER_PLAYER_LIST:
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Elige un ${fieldPosFilter.fullName}");
        _appStateService.appTopBarState.activeState.onLeftColumn = _closePlayerChanges;
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;
      case SOCCER_PLAYER_STATS:
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Estadísticas");
        _appStateService.appTopBarState.activeState.onLeftColumn = _cancelPlayerDetails;
      break;
      case CONTEST_INFO:
        GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_CONTEST_INFO, contest);
        _setupContestInfoTopBar(false, _cancelContestDetails);
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;
      case LINEUP_FIELD_CONTEST_ENTRY:
        _setupContestInfoTopBar(true, /*() => _router.go('lobby', {})*/AppTopBarState.GOBACK, _onContestInfoClick);
        _appStateService.appSecondaryTabBarState.tabList = tabList;
      break;
      case COMPARATIVE:
      case RIVALS_LIST:
        GameMetrics.contestScreenVisitEvent(section == RIVALS_LIST? GameMetrics.SCREEN_RIVAL_LIST : GameMetrics.SCREEN_RIVAL_LINEUP, contest, {"availableChanges": numAvailableChanges});
        _setupContestInfoTopBar(true, /* () => _router.go('lobby', {})*/AppTopBarState.GOBACK, _onContestInfoClick);
        _appStateService.appSecondaryTabBarState.tabList = tabList;
      break;
    }
  }
  String get sectionActive => _sectionActive;
  
  bool displayChangeablePlayers = false;
  bool isGameplaysModalOn = false;
  
  bool isConfirmModalOn = false;
  
  bool get isLineupFieldContestEntryActive => sectionActive == LINEUP_FIELD_CONTEST_ENTRY;
  bool get isContestInfoActive => sectionActive == CONTEST_INFO;
  bool get isRivalsListActive  => sectionActive == RIVALS_LIST;
  bool get isComparativeActive => sectionActive == COMPARATIVE;
  bool get isSelectingSoccerPlayerActive => sectionActive == SOCCER_PLAYER_LIST;
  bool get isSoccerPlayerStatsActive => sectionActive == SOCCER_PLAYER_STATS;

  List<AppSecondaryTabBarTab> tabList;
  /*
   * END VIEW_CONTEST STATES MANAGEMENTS
   */
  
  /*
   * PLAYER THINGS
   */

  num lineupCost = 0;
  num get availableSalary => contest != null? contest.salaryCap - lineupCost : 0;
  num playerManagerLevel = 10;

  ContestEntry _mainPlayer;
  ContestEntry get mainPlayer => _mainPlayer;
  void set mainPlayer(player) {
    _mainPlayer = player;
    // The list is created every call. In order to stabilize the list,
    // it is generated only when mainPlayer change
    _rivalList = player.contest.contestEntriesOrderByPoints;

    _updateSoccerPlayerStates(_mainPlayer);
    lineupCost = 0;
    lineupSlots = new List<SoccerPlayerListItem>();
    _mainPlayer.instanceSoccerPlayers.forEach((item) {
      lineupSlots.add(new SoccerPlayerListItem(item, _profileService.user.managerLevel, contest));
      lineupCost += item.salary;
    });
  }
  
  List<String> get lineupFormation => FieldPos.FORMATIONS[formationId];
  List<SoccerPlayerListItem> favoritesPlayers = [];
  List<SoccerPlayerListItem> lineupSlots = [];

  String get formationId => mainPlayer != null? mainPlayer.formation : ContestEntry.FORMATION_442;
  void set formationId(id) {
    Logger.root.warning("Formation shouldnt be changed during live tournament");
    if (mainPlayer != null) mainPlayer.formation = id; 
  }

  String get printableCurrentSalary => StringUtils.parseSalary(availableSalary);
  
  /*
   * END PLAYER THINGS
   */
  
  
  
  /*
   * OPPONENT THINGS
   */
  
  ContestEntry _selectedOpponent;
  void set selectedOpponent(ContestEntry player) {
    _selectedOpponent = player;
    
    if(tabList.length == 2) {
      tabList.add(new AppSecondaryTabBarTab(_selectedOpponent.user.nickName,                                        
                                            () { sectionActive = COMPARATIVE; },
                                            () => sectionActive == COMPARATIVE));
    } else {
      tabList[2].text = _selectedOpponent.user.nickName;
    }
    
  
    _updateSoccerPlayerStates(_selectedOpponent);
    opponentLineupSlots = [];
    availableOpponentSalary = 0;
    _selectedOpponent.instanceSoccerPlayers.forEach((item) {
      opponentLineupSlots.add(new SoccerPlayerListItem(item, _profileService.user.managerLevel, contest));
      availableOpponentSalary += item.salary;
    });
  }
  
  ContestEntry get selectedOpponent => _selectedOpponent;
  List<SoccerPlayerListItem> opponentLineupSlots = [];
  String get opponentFormationId => selectedOpponent != null? selectedOpponent.formation : ContestEntry.FORMATION_442;
  void set opponentFormationId(id) { if (selectedOpponent != null) selectedOpponent.formation = id; }
  List<String> get opponentLineupFormation => FieldPos.FORMATIONS[opponentFormationId];
  num availableOpponentSalary = 0;
  String get printableOpponentSalary => contest != null? StringUtils.parseSalary(contest.salaryCap - availableOpponentSalary) : "-";

  /*
   * END OPPONENT THINGS
   */
  
  /*
   * CONTEST DATA
   */

  String contestId;
  Contest contest;
  
  DateTime updatedDate;
  
  List<ContestEntry> _rivalList = [];
  List<ContestEntry> get rivalList => _rivalList;

  bool get isLive => _routeProvider.route.name.contains("live_contest");
  bool get isHistory => _routeProvider.route.name.contains("history_contest");
  
  String get printableSalaryCap => contest != null ? contest.printableSalaryCap : '-';
  int get maxSalary => contest != null ? contest.salaryCap : 0;

  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;
  /*
   * END CONTEST DATA
   */

  
  /*
   * SOCCER PLAYER LIST
   */
  
  // Filters
  String nameFilter;
  FieldPos fieldPosFilter;
  String matchFilter;
  
  bool onlyFavorites = false;
  
  // Showing player
  String instanceSoccerPlayerDisplayInfo = null;
  
  // Soccer player list
  List<SoccerPlayerListItem> allSoccerPlayers;
  
  /*
   * END SOCCER PLAYER LIST
   */
  
  /*
   * SUBSTITUTION POURPOSES
   */
  InstanceSoccerPlayer changingPlayer;
  InstanceSoccerPlayer newSoccerPlayer;
  
  int get numAvailableChanges => mainPlayer != null ? mainPlayer.numAvailableChanges : 0;
  Money get changePrice => mainPlayer != null ? mainPlayer.changePrice() : ContestEntry.DEFAULT_PRICE;
  num get availableSalaryChangingPlayer => changingPlayer != null? availableSalary + changingPlayer.salary : availableSalary;
  String get printableSalaryForChange => StringUtils.parseSalary(availableSalaryChangingPlayer);

  String get changingPlayerId => changingPlayer != null? changingPlayer.id : null;
  
  /*
   * END SUBSTITUTION POURPOSES
   */
  
  
  /*
   * SHOWING GAMEPLAYS OF A SOCCERPLAYER
   */
  SoccerPlayerListItem _gameplaysPlayer;
  void set gameplaysPlayer(SoccerPlayerListItem player) {
    _gameplaysPlayer = player;
    soccerPlayerGameplays = player.instanceSoccerPlayer.printableLivePointsPerOptaEvent;
  }
  SoccerPlayerListItem get gameplaysPlayer => _gameplaysPlayer;
  List<Map> soccerPlayerGameplays = [];

  /*
   * END SHOWING GAMEPLAYS OF A SOCCERPLAYER
   */
  

  /*
   * HTML POURPOSES
   */
  bool isMainPlayer(ContestEntry entry) { return entry.user.userId == mainPlayer.user.userId; }

  String name(ContestEntry entry) => entry.user.nickName;
  String points(ContestEntry entry) => StringUtils.parseFantasyPoints(entry.currentLivePoints);
  String percentLeft(ContestEntry entry) => "${entry.percentLeft}%";

  //String getPrize(int index) => (contest != null) ? contest.getPrize(index) : "-";
  
  /*
   * END HTML POURPOSES
   */
  
  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "viewcontest", substitutions);
  }
  
  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  ViewContestComp(this._turnZone, this._routeProvider, this._router, this._refreshTimersService, this._appStateService,
      this._contestsService, this._profileService, this._flashMessage, this._loadingService/*, this._tutorialService*/) {
    
    _loadingService.isLoading = true;
    
    _setupAppStateService();
    
    contestId = _routeProvider.route.parameters['contestId'];
  
    _retrieveContestData();
  }
  
  void detach() {
    _finishLiveTimers();
  }
  
  /*
   * CALLBACKS
   */
  // click on a rival at rivals list
  void onUserClick(ContestEntry contestEntry, {preventViewOpponent: false}) {
    if (isMainPlayer(contestEntry)) {
      sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
    } else {
      selectedOpponent = contestEntry;
      
      if(!preventViewOpponent) {
        sectionActive = COMPARATIVE;
      }
      
      //_tutorialService.triggerEnter("user_selected", component: this, activateIfNeeded: false);
    }
  }
  
  void switchDisplayChangeablePlayers() {
    if (numAvailableChanges == 0) {
      displayChangeablePlayers = false;
    } else {
      displayChangeablePlayers = !displayChangeablePlayers;
      if (displayChangeablePlayers) {
        GameMetrics.contestActionEvent(GameMetrics.ACTION_LIVE_SUBSTITUTION_INIT, metricsScreenName, contest, {'availableChanges' : numAvailableChanges});
      } else {
        GameMetrics.contestActionEvent(GameMetrics.ACTION_LIVE_SUBSTITUTION_CANCEL, metricsScreenName, contest, {'availableChanges' : numAvailableChanges});
      }
    }
  }
  
  void onLineupSlotSelected(int slotIndex) {
    SoccerPlayerListItem player = lineupSlots[slotIndex];
    if (displayChangeablePlayers) {
      if ( !player.hasPlayed ) {
        _showSoccerPlayerChangeList(player.instanceSoccerPlayer);
      }
    } else {
      if (player.isPlaying || player.hasPlayed) {
        gameplaysPlayer = player;
        isGameplaysModalOn = true;
        GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_SOCCER_PLAYER_CONTEST_SCORE, contest, {'footballPlayer' : player.name, "isRival": false, 'availableChanges' : numAvailableChanges});
      }
    }
  }

  void onOpponentLineupSlotSelected(int slotIndex) {
    SoccerPlayerListItem player = opponentLineupSlots[slotIndex];
    if (player.isPlaying || player.hasPlayed) {
      gameplaysPlayer = player;
      isGameplaysModalOn = true;
      GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_SOCCER_PLAYER_CONTEST_SCORE, contest, {'footballPlayer' : player.name, "isRival": true, 'availableChanges' : numAvailableChanges});
    }
  }
  
  void onSoccerPlayerInfoClick(String soccerPlayerId) {
    //ModalComp.open(_router, "enter_contest.soccer_player_stats", { "instanceSoccerPlayerId":soccerPlayerId, "selectable":isSlotAvailableForSoccerPlayer(soccerPlayerId)}, addSoccerPlayerToLineup);
    sectionActive = SOCCER_PLAYER_STATS;
    instanceSoccerPlayerDisplayInfo = soccerPlayerId;
  }

  void onSoccerPlayerActionButton(SoccerPlayerListItem soccerPlayer) {
    _checkSoccerPlayerSubstitution(soccerPlayer.instanceSoccerPlayer);
  }
  
  void hideConfirmModal() {
    isConfirmModalOn = false;
    GameMetrics.contestActionEvent(GameMetrics.ACTION_LIVE_SUBSTITUTION_CANCEL, metricsScreenName, contest, {'availableChanges' : numAvailableChanges});
  }

  /*
   * END CALLBACKS
   */
  
  /*
   * HTML HELPERS
   */
  
  String changesButtonText() {
    if (displayChangeablePlayers == true) {
      return "Cancelar Cambio";
    } else if (numAvailableChanges == 0){
      return "No hay cambios disponibles";
    } else if (substituiblePlayersInLineup() == 0) {
      return "Todos tus jugadores ya han jugado";
    } else {
      return "$numAvailableChanges Cambios disponibles";
    }
  }
  
  int substituiblePlayersInLineup() {
    return lineupSlots.where((s) => s.isPlaying || s.hasNotPlayed).length;
  }
  
  void makeSoccerPlayerSubstitution() {
    _loadingService.isLoading = true;
    
    _contestsService.changeSoccerPlayer(mainPlayer.contestEntryId, 
                  changingPlayer.soccerPlayer.templateSoccerPlayerId, 
                  newSoccerPlayer.soccerPlayer.templateSoccerPlayerId)
            .then((_) {
              GameMetrics.contestActionEvent(GameMetrics.ACTION_LIVE_SUBSTITUTION_COMPLETE, metricsScreenName, contest, {'availableChanges' : numAvailableChanges,
                                                                                                           'footballPlayerOut': changingPlayer.soccerPlayer.name,
                                                                                                           'footballPlayerIn': newSoccerPlayer.soccerPlayer.name,
                                                                                                           'salaryCap': maxSalary,
                                                                                                           'salaryNotUsed': availableSalary,
                                                                                                           'salaryUsed': lineupCost});
              _retrieveLiveData();
              /*_turnZone.run(() {
                //_profileService.user.goldBalance.amount -= newSoccerPlayer.moneyToBuy(contest, _profileService.user.managerLevel).amount;
                _retrieveLiveData();
                //print ("onSoccerPlayerActionButton: Ok");
              });*/
            })
            .catchError((ServerError error) {
              Logger.root.info("Error: ${error.responseError}");
              if (error.isRetryOpError) {
                _retryOpTimer = new Timer(const Duration(seconds:3), () => _checkSoccerPlayerSubstitution(newSoccerPlayer));
              } else {
                print("EEEEEERRRROOOORRR!!!!!!!!!!!!");
                //_showMsgError(error, goldNeeded.amount.toInt());
              }
            }, test: (error) => error is ServerError)
            .whenComplete(() {
              _closePlayerChanges();
              _loadingService.isLoading = false;
            });
  }
  
  void nothing() {}
  

  /* ***************************************** *
   *        PRIVATE METHODS & VARIABLES        *
   * ***************************************** */
  
  /*
   * RETRIEVE DATA
   */
  
  void _retrieveContestData() {
    (isLive ? _contestsService.refreshMyLiveContest(contestId) : _contestsService.refreshMyHistoryContest(contestId))
          .then((_) {
            
            _updateRetrievedData();
            
            if(contestEntries.length == 2) {
              selectedOpponent = contestEntries.firstWhere((contestEntry) => contestEntry.contestEntryId != mainPlayer.contestEntryId, orElse: () => null);
              if (selectedOpponent != null) {
                onUserClick(selectedOpponent, preventViewOpponent: true);
              }
            }
           
            _setupContestInfoTopBar(true, /*() => _router.go('my_contests', {"section": "live"})*/ AppTopBarState.GOBACK, _onContestInfoClick);
            _setupLiveTimers();
            
            _loadingService.isLoading = false;
          })
          .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
  }

  void _retrieveLiveData() {
    // Actualizamos únicamente la lista de live MatchEvents
    (_contestsService.lastContest.simulation
      ? _contestsService.refreshLiveMatchEvents(contestId: _contestsService.lastContest.contestId)
      : _contestsService.refreshLiveMatchEvents(templateContestId: _contestsService.lastContest.templateContestId))
    //(isLive ? _contestsService.refreshMyLiveContest(contestId) : _contestsService.refreshMyHistoryContest(contestId))
        .then((_) {
          _updateRetrievedData();
        })
        .catchError((ServerError error) {
          //_flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }, test: (error) => error is ServerError);
  }

  void _retrieveLiveContestEntriesData() {
    // Actualizamos únicamente la lista de live contestEntries
    _contestsService.refreshLiveContestEntries(_contestsService.lastContest.contestId)
        .then((_) {
          contest = _contestsService.lastContest;
          // Actualizamos el contestEntry del usuario seleccionado
          if (selectedOpponent != null) {
            //selectedOpponent = contestEntries.firstWhere((contestEntry) => contestEntry.contestEntryId == selectedOpponent.contestEntryId, orElse: () => null);
            selectedOpponent = contest.getContestEntryWithUser(selectedOpponent.user.userId);
          }
        })
        .catchError((ServerError error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }, test: (error) => error is ServerError);
  }
  
  void _updateRetrievedData() {
    updatedDate = DateTimeService.now;
    contest = _contestsService.lastContest;
    
    // Actualizar al usuario principal (al que destacamos)
    if (_profileService.isLoggedIn && contest.containsContestEntryWithUser(_profileService.user.userId)) {
      mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
    } else {
      mainPlayer = contest.contestEntriesOrderByPoints.first;
    }
  }
  
  void _setupLiveTimers() {
    // Únicamente actualizamos los contests que estén en "live"
    if (_contestsService.lastContest.isLive) {
      _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE, _retrieveLiveData);
      _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES, _retrieveLiveContestEntriesData);
      GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_LIVE_CONTEST, contest, {'availableChanges' : numAvailableChanges});
    } else if (_contestsService.lastContest.isHistory) {
      GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_HISTORY_CONTEST, contest);
    }
  }
  
  void _finishLiveTimers() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE);
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES);
  }

  void _showSoccerPlayerChangeList(InstanceSoccerPlayer requestedSoccerPlayer) {
    fieldPosFilter = requestedSoccerPlayer.fieldPos;
    sectionActive = SOCCER_PLAYER_LIST;

    changingPlayer = requestedSoccerPlayer;

    if (allSoccerPlayers == null) {
      _contestsService.getSoccerPlayersAvailablesToChange(contest.contestId)
        .then((List<InstanceSoccerPlayer> instanceSoccerPlayers) {
            allSoccerPlayers = [];
            _allInstanceSoccerPlayers = instanceSoccerPlayers;
            
            _refreshAllSoccerPlayerList();
            _updateLineupSlots();
            _updateFavorites();
      });
    } else {
      _refreshAllSoccerPlayerList();
      _updateLineupSlots();
      _updateFavorites();
    }
  }
  
  /*
   * END RETRIEVE DATA
   */
  

  
  /*
   * SOCCER PLAYER LIST MANAGING METHODS
   */
  void _updateSoccerPlayerStates(ContestEntry player) {
    player.instanceSoccerPlayers.forEach( _updateSingleSoccerPlayerState );
  }
  
  void _updateSingleSoccerPlayerState(InstanceSoccerPlayer i) {
    MatchEvent match = contest.matchEvents.firstWhere( (m) => m.containsTeam(i.soccerTeam));
    i.playState = match.isFinished ? InstanceSoccerPlayer.STATE_PLAYED  :
                  match.isStarted  ? InstanceSoccerPlayer.STATE_PLAYING :
                          /*Else*/   InstanceSoccerPlayer.STATE_NOT_PLAYED;
  }

  void _refreshAllSoccerPlayerList() {
    allSoccerPlayers.clear();
    
    _allInstanceSoccerPlayers.forEach((instanceSoccerPlayer) {
        if (instanceSoccerPlayer.soccerPlayer.name == null) {
          Logger.root.severe("Currently there isn't info about this soccer player: ${instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId}");
        } else {
          _updateSingleSoccerPlayerState(instanceSoccerPlayer);

          if (_isSoccerPlayerVisibleForChange(instanceSoccerPlayer)) {
            SoccerPlayerListItem slot = new SoccerPlayerListItem(instanceSoccerPlayer, _profileService.user.managerLevel, contest);
            allSoccerPlayers.add(slot);
          }
        }
      });
  }

  bool _isSoccerPlayerVisibleForChange(InstanceSoccerPlayer instanceSoccerPlayer) {
    if (instanceSoccerPlayer.playState != InstanceSoccerPlayer.STATE_PLAYED && availableSalaryChangingPlayer >= instanceSoccerPlayer.salary) {
      String newSoccerTeamId = instanceSoccerPlayer.soccerPlayer.soccerTeam.templateSoccerTeamId;
      int sameTeamCount = mainPlayer.instanceSoccerPlayers.where((i) => i.soccerTeam.templateSoccerTeamId == newSoccerTeamId && i.id != changingPlayer.id).length;
      bool isInLineup = lineupSlots.where((soccerPlayer) => soccerPlayer.id == instanceSoccerPlayer.id).length != 0;
      return sameTeamCount < 4 && !isInLineup;
    }
    return false;
  }

  void _updateFavorites() {
    favoritesPlayers.clear();
    if (_profileService.isLoggedIn) {
      favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
          allSoccerPlayers.firstWhere( (player) => player.id == playerId, orElse: () => null)
        ).where( (d) => d != null));
    }
  }

  void _checkSoccerPlayerSubstitution(InstanceSoccerPlayer instanceSoccerPlayer) {
    newSoccerPlayer = instanceSoccerPlayer;
    
    //Check Soccer team
    String newSoccerTeamId = newSoccerPlayer.soccerPlayer.soccerTeam.templateSoccerTeamId;
    
    int sameTeamCount = mainPlayer.instanceSoccerPlayers.where((i) => i.soccerTeam.templateSoccerTeamId == newSoccerTeamId && i.id != changingPlayer.id).length;
    bool isSameTeamOk = sameTeamCount < 4;
    
    //Check Salary
    int salary = availableSalary + changingPlayer.salary - newSoccerPlayer.salary;
    bool isSalaryOk = salary >= 0;
    
    //Check gold
    Money goldNeeded = newSoccerPlayer.moneyToBuy(contest, _profileService.user.managerLevel);
    goldNeeded = goldNeeded.plus(mainPlayer.changePrice());
    bool isGoldOk = _profileService.user.goldBalance.amount >= goldNeeded.amount;
    
    //Check num changes availables
    bool areAvailableChanges = numAvailableChanges > 0;
    
    if (isSameTeamOk && isSalaryOk && areAvailableChanges && isGoldOk) {
      isConfirmModalOn = true;
    } else {
      /*if (!isSameTeamOk){
        alertTooMuchSameTeam();
        //print("HAY DEMASIADOS DEL MISMO EQUIPO");
      } else if (!isSalaryOk) {
        print("TE PASAS DEL SALARY");
      } else if (!areAvailableChanges) {
        print("NO HAY CAMBIOS DISPONIBLES");
      } else if (!isGoldOk) {
        alertNotEnoughGold(goldNeeded.amount.toInt());
      }*/
    }
  }
  
  /*
   * END SOCCER PLAYER LIST MANAGING METHODS
   */
  
  /*
   * STATE MANAGING METHODS
   */
  
  void _setupAppStateService() {
    _setupContestInfoTopBar(false, () => _router.go('my_contests', {"section": "live"}));

    tabList = [
      new AppSecondaryTabBarTab("Alineación",                                        
                                () { sectionActive = LINEUP_FIELD_CONTEST_ENTRY; },
                                () => sectionActive == LINEUP_FIELD_CONTEST_ENTRY),
      new AppSecondaryTabBarTab("Rivales",                                        
                                () { sectionActive = RIVALS_LIST; },
                                () => sectionActive == RIVALS_LIST),
    ];

    _appStateService.appSecondaryTabBarState.tabList = tabList;
    _appStateService.appTabBarState.show = false;
  }

  void _setupContestInfoTopBar(bool showInfoButton, Function backFunction, [Function infoFunction]) {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, showInfoButton, backFunction, infoFunction);
  }
  
  void _onContestInfoClick() {
    sectionActive = CONTEST_INFO;
  }
  void _cancelContestDetails() {
    sectionActive = _lastSectionActive;
  }
  void _cancelSoccerPlayerSelection() {
    sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
  }
  void _cancelPlayerDetails() {
    sectionActive = SOCCER_PLAYER_LIST;
  }

  void _closePlayerChanges() {
    isConfirmModalOn = false;
    displayChangeablePlayers = false;
    _cancelSoccerPlayerSelection();
    GameMetrics.contestActionEvent(GameMetrics.ACTION_LIVE_SUBSTITUTION_CANCEL, metricsScreenName, contest, {'availableChanges' : numAvailableChanges});
  }
  
  /*
   * END STATE MANAGING METHODS
   */

  VmTurnZone _turnZone;
  Router _router;
  Timer _retryOpTimer;
  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
  //TutorialService _tutorialService;
  LoadingService _loadingService;
  List<InstanceSoccerPlayer> _allInstanceSoccerPlayers;
  
  AppStateService _appStateService;
  
  /*
   * DELETEABLE
   */


/*
  bool get showChanges => contest != null? ( contest.isLive 
                                          && numAvailableChanges > 0 
                                          && _profileService.isLoggedIn 
                                          && contest.containsContestEntryWithUser(_profileService.user.userId)) : false;
*/
  
/*
  num get playerManagerLevel {
    num result = _profileService.isLoggedIn ? _profileService.user.managerLevel : 0;
    if (contest != null) {
      result = (contest.simulation) ? User.MAX_MANAGER_LEVEL : min(result, contest.maxManagerLevel);
    }
    return result;
  }
  
*/

  //int get userManagerLevel => _profileService.isLoggedIn? _profileService.user.managerLevel.toInt() : 0;
  


  void _updateLineupSlots() {
    if (!isLineupFieldContestEntryActive) { return; }
    lineupSlots.clear();
    
    mainPlayer.instanceSoccerPlayers.forEach( (i) {
      
      InstanceSoccerPlayer instanceSoccerPlayer = _allInstanceSoccerPlayers != null? _allInstanceSoccerPlayers.firstWhere( (soccerPlayer) => soccerPlayer.id == i.id, orElse: () => i) : i;
      SoccerPlayerListItem slot = new SoccerPlayerListItem(instanceSoccerPlayer, _profileService.user.managerLevel, contest);
      
      //SoccerPlayerListItem slot = allSoccerPlayers.firstWhere( (soccerPlayer) => soccerPlayer.id == i.id, orElse: () => i);
      if (slot != null) {
        lineupSlots.add(slot);
      }
    });
  }
  
  
  
  
  
}

