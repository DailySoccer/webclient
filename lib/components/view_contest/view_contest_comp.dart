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
  static const String LINEUP_FIELD_CONTEST_ENTRY = "LINEUP_FIELD_CONTEST_ENTRY";
  static const String CONTEST_INFO = "CONTEST_INFO";
  static const String RIVALS_LIST = "RIVALS_LIST";
  static const String COMPARATIVE = "COMPARATIVE";
  static const String SOCCER_PLAYER_LIST = "SOCCER_PLAYER_LIST";
  static const String SOCCER_PLAYER_STATS = "SOCCER_PLAYER_STATS";
  
  
  ScreenDetectorService scrDet;
  LoadingService loadingService;

  ContestEntry _mainPlayer;
  void set mainPlayer(player) {
    _mainPlayer = player;
    // The list is created every call. In order to stabilize the list,
    // it is generated only when mainPlayer change
    _rivalList = player.contest.contestEntriesOrderByPoints;

    updateSoccerPlayerStates(_mainPlayer);
    availableSalary = 0;
    lineupSlots = [];
    _mainPlayer.instanceSoccerPlayers.forEach((item) {
      lineupSlots.add(new SoccerPlayerListItem(item, _profileService.user.managerLevel, contest));
      availableSalary += item.salary;
    });
  }
  ContestEntry get mainPlayer => _mainPlayer;

  num get playerManagerLevel {
    num result = _profileService.isLoggedIn ? _profileService.user.managerLevel : 0;
    if (contest != null) {
      result = (contest.simulation) ? User.MAX_MANAGER_LEVEL : min(result, contest.maxManagerLevel);
    }
    return result;
  }
  
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
    
  
    updateSoccerPlayerStates(_selectedOpponent);
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
    
  
  List<ContestEntry> _rivalList = [];
  List<ContestEntry> get rivalList => _rivalList;
  
  bool isMainPlayer(ContestEntry entry) { return entry.user.userId == mainPlayer.user.userId; }

  String name(ContestEntry entry) => entry.user.nickName;
  String points(ContestEntry entry) => StringUtils.parseFantasyPoints(entry.currentLivePoints);
  String percentLeft(ContestEntry entry) => "${entry.percentLeft}%";

  List<AppSecondaryTabBarTab> tabList;
  bool get isLineupFieldContestEntryActive => sectionActive == LINEUP_FIELD_CONTEST_ENTRY;
  bool get isContestInfoActive => sectionActive == CONTEST_INFO;
  bool get isRivalsListActive  => sectionActive == RIVALS_LIST;
  bool get isComparativeActive => sectionActive == COMPARATIVE;
  bool get isSelectingSoccerPlayerActive => sectionActive == SOCCER_PLAYER_LIST;
  bool get isSoccerPlayerStatsActive => sectionActive == SOCCER_PLAYER_STATS;
  bool isConfirmModalOn = false;
  
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
        _appStateService.appTopBarState.activeState.onLeftColumn = closePlayerChanges;
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;
      case SOCCER_PLAYER_STATS:
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Estadísticas");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
      break;
      case CONTEST_INFO:
        setupContestInfoTopBar(false, cancelContestDetails);
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;
      case LINEUP_FIELD_CONTEST_ENTRY:
        setupContestInfoTopBar(true, () => _router.go('lobby', {}), onContestInfoClick);
        _appStateService.appSecondaryTabBarState.tabList = tabList;
        updateLineupSlots();
      break;
      case COMPARATIVE:
      case RIVALS_LIST:
        setupContestInfoTopBar(true, () => _router.go('lobby', {}), onContestInfoClick);
        _appStateService.appSecondaryTabBarState.tabList = tabList;
      break;
    }
  }
  String get sectionActive => _sectionActive;
  
  
  String get formationId => mainPlayer != null? mainPlayer.formation : ContestEntry.FORMATION_442;
  void set formationId(id) { 
    if (mainPlayer != null) mainPlayer.formation = id; 
  }
  List<String> get lineupFormation => FieldPos.FORMATIONS[formationId];

  num availableSalary = 0;
  
  String get printableSalaryForChange => contest != null? StringUtils.parseSalary((contest.salaryCap - availableSalary) + changingPlayer.salary) : "-";
  String get printableCurrentSalary => contest != null? StringUtils.parseSalary(contest.salaryCap - availableSalary) : "-";
  String get printableSalaryCap => contest != null? StringUtils.parseSalary(contest.salaryCap) : "-";
  

  DateTime updatedDate;
  String lastOpponentSelected = "";
  bool isOpponentSelected = false;

  String contestId;
  Contest contest;

  String nameFilter;
  FieldPos fieldPosFilter;
  bool onlyFavorites = false;
  String instanceSoccerPlayerDisplayInfo = null;
  
  InstanceSoccerPlayer changingPlayer;
  InstanceSoccerPlayer newSoccerPlayer;
  
  int get numAvailableChanges => mainPlayer != null ? mainPlayer.numAvailableChanges : 0;
  Money get changePrice => mainPlayer != null ? mainPlayer.changePrice() : ContestEntry.DEFAULT_PRICE;
  
  String matchFilter;
  List<SoccerPlayerListItem> allSoccerPlayers;
  List<SoccerPlayerListItem> favoritesPlayers = [];
  List<SoccerPlayerListItem> lineupSlots = [];

  bool get isLive => _routeProvider.route.name.contains("live_contest");
  bool get showChanges => contest != null? (contest.isLive && numAvailableChanges > 0 && _profileService.isLoggedIn && contest.containsContestEntryWithUser(_profileService.user.userId)) : false;
  //bool isMakingChange = false;

  String get salaryCap => contest.printableSalaryCap;
  
  int get maxSalary => contest != null ? contest.salaryCap : 0;
  int get lineupCost => mainPlayer != null? mainPlayer.instanceSoccerPlayers.fold(0, (sum, i) => sum += i.salary) : 0;
  int get remainingSalary => maxSalary - lineupCost;
  int get remainingSalaryChangingPlayer => remainingSalary + (changingPlayer == null? 0 : changingPlayer.salary);
  int get changingSalaryPlayer => (changingPlayer == null? 0 : changingPlayer.salary);

  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  String get changingPlayerId => changingPlayer != null? changingPlayer.id : null;
  
  int get userManagerLevel => _profileService.isLoggedIn? _profileService.user.managerLevel.toInt() : 0;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "viewcontest", substitutions);
  }

  ViewContestComp(this._turnZone, this._routeProvider, this._router, this.scrDet, this._refreshTimersService, this._appStateService,
      this._contestsService, this._profileService, this._flashMessage, this.loadingService, this._tutorialService) {
    
    loadingService.isLoading = true;
    
    setupContestInfoTopBar(false, () => _router.go('my_contests', {"section": "live"}));

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
    
    lastOpponentSelected = getLocalizedText("opponent");

    contestId = _routeProvider.route.parameters['contestId'];
    
    // Si viene de un cambio... Registraremos el futbolista "antiguo" y el "nuevo"
    _sourceSoccerPlayerIdToChange = _targetSoccerPlayerIdToChange = null;
    
    if (window.location.toString().contains("change")) {
      Route routeChange = _router.findRoute("live_contest.change");
      if (routeChange != null) {
        _sourceSoccerPlayerIdToChange = routeChange.parameters['sourceSoccerPlayerId'];
        _targetSoccerPlayerIdToChange = routeChange.parameters['targetSoccerPlayerId'];
        Logger.root.info("Continue: Change: ${_sourceSoccerPlayerIdToChange} -> ${_targetSoccerPlayerIdToChange}");
      }
    }
    
    //contestId = _routeProvider.route.parameters['contestId'];

    //_tutorialService.triggerEnter("view_contest", component: this);

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    (isLive ? _contestsService.refreshMyLiveContest(contestId) : _contestsService.refreshMyHistoryContest(contestId))
      .then((_) {
        loadingService.isLoading = false;
        contest = _contestsService.lastContest;
        setupContestInfoTopBar(true, () => _router.go('my_contests', {"section": "upcoming"}), onContestInfoClick);

        if (_profileService.isLoggedIn && contest.containsContestEntryWithUser(_profileService.user.userId)) {
          mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
          print("LOGGED IN ------------------------------------------------------------------------------------------");
        }
        else {
          mainPlayer = contest.contestEntriesOrderByPoints.first;
          print("NO LOGGED IN ------------------------------------------------------------------------------------------");
        }
        

        // En el caso de los tipos de torneo 1vs1 el oponente se autoselecciona
        if(contest.tournamentType == Contest.TOURNAMENT_HEAD_TO_HEAD) {
          selectedOpponent = contestEntries.firstWhere((contestEntry) => contestEntry.contestEntryId != mainPlayer.contestEntryId, orElse: () => null);
          if (selectedOpponent != null) {
            onUserClick(selectedOpponent, preventViewOpponent: true);
          }
        }
      
        updatedDate = DateTimeService.now;

        // Únicamente actualizamos los contests que estén en "live"
        if (_contestsService.lastContest.isLive) {
          _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE, updateLive);
          _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES, updateLiveContestEntries);
          GameMetrics.logEvent(GameMetrics.LIVE_CONTEST_VISITED);
        } else if (_contestsService.lastContest.isHistory) {
          GameMetrics.logEvent(GameMetrics.VIEW_HISTORY);
        }
        
        if (_sourceSoccerPlayerIdToChange != null) {
          InstanceSoccerPlayer instanceToSelect = mainPlayer.instanceSoccerPlayers.firstWhere((instance) => instance.soccerPlayer.templateSoccerPlayerId == _sourceSoccerPlayerIdToChange, orElse: () => null);
          if (instanceToSelect != null) {
            onRequestChange(instanceToSelect);
          }
          _sourceSoccerPlayerIdToChange = null;
        }
      })
      .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
  }

  void setupContestInfoTopBar(bool showInfoButton, Function backFunction, [Function infoFunction]) {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, showInfoButton, backFunction, infoFunction);
  }
  void onContestInfoClick() {
    sectionActive = CONTEST_INFO;
  }
  void cancelContestDetails() {
    sectionActive = _lastSectionActive;
  }
  void cancelSoccerPlayerSelection() {
    sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
  }
  void cancelPlayerDetails() {
    sectionActive = SOCCER_PLAYER_LIST;
    //scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
  }
  
  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }
  
  
  String getPrize(int index) => (contest != null) ? contest.getPrize(index) : "-";

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE);
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE_CONTEST_ENTRIES);
  }

  void updateLive() {
    // Actualizamos únicamente la lista de live MatchEvents
    (_contestsService.lastContest.simulation
      ? _contestsService.refreshLiveMatchEvents(contestId: _contestsService.lastContest.contestId)
      : _contestsService.refreshLiveMatchEvents(templateContestId: _contestsService.lastContest.templateContestId))
        .then((_) {
          updatedDate = DateTimeService.now;
          contest = _contestsService.lastContest;

          // Actualizar al usuario principal (al que destacamos)
          if (!_profileService.isLoggedIn || !contest.containsContestEntryWithUser(_profileService.user.userId)) {
            mainPlayer = contest.contestEntriesOrderByPoints.first;
          } else {
            mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
          }
          
        })
        .catchError((ServerError error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }, test: (error) => error is ServerError);
  }

  void updateLiveContestEntries() {
    // Actualizamos únicamente la lista de live contestEntries
    _contestsService.refreshLiveContestEntries(_contestsService.lastContest.contestId)
        .then((_) {
          // Actualizamos el contestEntry del usuario seleccionado
          if (selectedOpponent != null) {
            selectedOpponent = contestEntries.firstWhere((contestEntry) => contestEntry.contestEntryId == selectedOpponent.contestEntryId, orElse: () => null);
            isOpponentSelected = (selectedOpponent != null);
          }
        })
        .catchError((ServerError error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }, test: (error) => error is ServerError);
  }
  
  void updateSoccerPlayerStates(ContestEntry player) {
    player.instanceSoccerPlayers.forEach( _updateSingleSoccerPlayerState );
  }
  
  void _updateSingleSoccerPlayerState(InstanceSoccerPlayer i) {
    MatchEvent match = contest.matchEvents.firstWhere( (m) => m.containsTeam(i.soccerTeam));
    i.playState = match.isFinished ? InstanceSoccerPlayer.STATE_PLAYED  :
                  match.isStarted  ? InstanceSoccerPlayer.STATE_PLAYING :
                          /*Else*/   InstanceSoccerPlayer.STATE_NOT_PLAYED;
  }
  
  void onUserClick(ContestEntry contestEntry, {preventViewOpponent: false}) {
    if (contestEntry.contestEntryId == mainPlayer.contestEntryId) {
      sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
    }
    else {
      switch (_routeProvider.route.name)
      {
        case "live_contest":
        case "history_contest":
          selectedOpponent = contestEntry;
          isOpponentSelected = true;
          lastOpponentSelected = contestEntry.user.nickName;

          AnchorElement tabLabel = querySelector("#opponentFantasyTeamTab");
          if(tabLabel != null) {
            tabLabel.text  = lastOpponentSelected;
          }
          if(!preventViewOpponent) {
            sectionActive = COMPARATIVE;
          }
        break;
      }

      _tutorialService.triggerEnter("user_selected", component: this, activateIfNeeded: false);
    }
  }

  void tabChange(String tab) {
    if (tab == "opponentFantasyTeam" && !isOpponentSelected) {
      return;
    }
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

    List<dynamic> allTabButtons = document.querySelectorAll("#liveContestTab li");
    allTabButtons.forEach((element) => element.classes.remove('active'));

    // activamos el tab button
    Element tabButton = document.querySelector("#" + tab + "Tab");
    if (tabButton != null) {
      tabButton.parent.classes.add("active");
    }
  }
  
  bool displayChangeablePlayers = false;
  
  String changesButtonText() {
    if (displayChangeablePlayers == true) {
      return "Cancelar Cambio";
    } else if (numAvailableChanges == 0){
      return "No hay cambios disponibles";
    } else {
      return "$numAvailableChanges Cambios disponibles";
    }
  }
  void switchDisplayChangeablePlayers() {
    if (numAvailableChanges == 0) {
      displayChangeablePlayers = false;
    } else {
      displayChangeablePlayers = !displayChangeablePlayers;
    }
  }
  void onLineupSlotSelected(int slotIndex) {
    if (!displayChangeablePlayers) return;
    onRequestChange(lineupSlots[slotIndex].instanceSoccerPlayer);
  }
  void onSoccerPlayerInfoClick(String soccerPlayerId) {
    //ModalComp.open(_router, "enter_contest.soccer_player_stats", { "instanceSoccerPlayerId":soccerPlayerId, "selectable":isSlotAvailableForSoccerPlayer(soccerPlayerId)}, addSoccerPlayerToLineup);
    sectionActive = SOCCER_PLAYER_STATS;
    instanceSoccerPlayerDisplayInfo = soccerPlayerId;
  }

  void closePlayerChanges() {
    isConfirmModalOn = false;
    displayChangeablePlayers = false;
    cancelSoccerPlayerSelection();
  }
  void onRequestChange([InstanceSoccerPlayer requestedSoccerPlayer = null]) {
    if (requestedSoccerPlayer == null) {
      sectionActive = LINEUP_FIELD_CONTEST_ENTRY;
    } else {
      fieldPosFilter = requestedSoccerPlayer.fieldPos;
      sectionActive = SOCCER_PLAYER_LIST;
    }

    if (isSelectingSoccerPlayerActive) {

      changingPlayer = requestedSoccerPlayer;

      //allSoccerPlayers = [];
      if (allSoccerPlayers == null) {
        _contestsService.getSoccerPlayersAvailablesToChange(contest.contestId)
          .then((List<InstanceSoccerPlayer> instanceSoccerPlayers) {
              allSoccerPlayers = [];
              _allInstanceSoccerPlayers = instanceSoccerPlayers;
              
              refreshAllSoccerPlayerList();
              updateLineupSlots();
              updateFavorites();
              
              if (_targetSoccerPlayerIdToChange != null) {
                InstanceSoccerPlayer instanceToSelect = _allInstanceSoccerPlayers.firstWhere((instance) => instance.soccerPlayer.templateSoccerPlayerId == _targetSoccerPlayerIdToChange, orElse: () => null);
                if (instanceToSelect != null) {
                  onChangeSoccerPlayer(instanceToSelect);
                }
                _targetSoccerPlayerIdToChange = null;
              }
        });
      } else {
        refreshAllSoccerPlayerList();
        updateLineupSlots();
        updateFavorites();
      }
    } else {
      changingPlayer = null;
    }

    if (changingPlayer != null) {
      fieldPosFilter = changingPlayer.fieldPos;
      print("CLICKED: ${requestedSoccerPlayer.soccerPlayer.name}");
    }
  }
  
  void refreshAllSoccerPlayerList() {
    int intId = 0;
    allSoccerPlayers.clear();
    
    _allInstanceSoccerPlayers.forEach((instanceSoccerPlayer) {
        if (mainPlayer != null && mainPlayer.isPurchased(instanceSoccerPlayer)) {
          instanceSoccerPlayer.level = 0;
        }

        if (instanceSoccerPlayer.soccerPlayer.name == null) {
          Logger.root.severe("Currently there isn't info about this soccer player: ${instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId}");
        } else {
          _updateSingleSoccerPlayerState(instanceSoccerPlayer);

          if (_showSoccerPlayer(instanceSoccerPlayer)) {
            //dynamic slot = _createSlot(instanceSoccerPlayer, intId++);
            SoccerPlayerListItem slot = new SoccerPlayerListItem(instanceSoccerPlayer, _profileService.user.managerLevel, contest);
            allSoccerPlayers.add(slot);
          }
        }
      });
  }
  
  bool _showSoccerPlayer(InstanceSoccerPlayer instanceSoccerPlayer) {
    if (instanceSoccerPlayer.playState == InstanceSoccerPlayer.STATE_NOT_PLAYED && remainingSalaryChangingPlayer >= instanceSoccerPlayer.salary) {
      String newSoccerTeamId = instanceSoccerPlayer.soccerPlayer.soccerTeam.templateSoccerTeamId;
      int sameTeamCount = mainPlayer.instanceSoccerPlayers.where((i) => i.soccerTeam.templateSoccerTeamId == newSoccerTeamId && i.id != changingPlayer.id).length;
      return sameTeamCount < 4;
    }
    return false;
  }
  /*
  Map _createSlot(InstanceSoccerPlayer instanceSoccerPlayer, int intId) {
    MatchEvent matchEvent = instanceSoccerPlayer.soccerTeam.matchEvent;
    //SoccerTeam soccerTeam = instanceSoccerPlayer.soccerTeam;

    String shortNameTeamA = matchEvent.soccerTeamA.shortName;
    String shortNameTeamB = matchEvent.soccerTeamB.shortName;

    var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == matchEvent.soccerTeamA.templateSoccerTeamId)
         ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
         : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

    return {  "instanceSoccerPlayer": instanceSoccerPlayer,
              "id": instanceSoccerPlayer.id,
              "intId": intId,
              "fieldPos": instanceSoccerPlayer.fieldPos,
              "fieldPosSortOrder": instanceSoccerPlayer.fieldPos.sortOrder,
              "fullName": instanceSoccerPlayer.soccerPlayer.name,
              "fullNameNormalized": StringUtils.normalize(instanceSoccerPlayer.soccerPlayer.name).toUpperCase(),
              "matchId" : matchEvent.templateMatchEventId,
              "matchEventName": matchEventName,
              "remainingMatchTime": "-",
              "fantasyPoints": instanceSoccerPlayer.soccerPlayer.getFantasyPointsForCompetition(contest.optaCompetitionId),
              "playedMatches": instanceSoccerPlayer.soccerPlayer.getPlayedMatchesForCompetition(contest.optaCompetitionId),
              "salary": instanceSoccerPlayer.salary
            };
  }
  */
  void updateSoccerPlayerSlots() {
    allSoccerPlayers.removeWhere( (SoccerPlayerListItem slot) {
      InstanceSoccerPlayer instanceSoccerPlayer = slot.instanceSoccerPlayer;
      _updateSingleSoccerPlayerState(instanceSoccerPlayer);
      return instanceSoccerPlayer.playState != InstanceSoccerPlayer.STATE_NOT_PLAYED;
    });
  }

  void updateLineupSlots() {
    if (!isLineupFieldContestEntryActive) { return; }
    lineupSlots = [];
    mainPlayer.instanceSoccerPlayers.forEach( (i) {
      
      InstanceSoccerPlayer instanceSoccerPlayer = _allInstanceSoccerPlayers.firstWhere( (soccerPlayer) => soccerPlayer.id == i.id, orElse: () => i);
      SoccerPlayerListItem slot = new SoccerPlayerListItem(instanceSoccerPlayer, _profileService.user.managerLevel, contest);
      
      //SoccerPlayerListItem slot = allSoccerPlayers.firstWhere( (soccerPlayer) => soccerPlayer.id == i.id, orElse: () => null);
      if (slot != null) {
        lineupSlots.add(slot);
      }
    });
  }
  
  void updateFavorites() {
    favoritesPlayers.clear();
    if (_profileService.isLoggedIn) {
      favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
          allSoccerPlayers.firstWhere( (player) => player.id == playerId, orElse: () => null)
        ).where( (d) => d != null));
    }
  }

  void onRowClick(String soccerPlayerId) {
    ModalComp.open(_router, "live_contest.soccer_player_stats", {
        "instanceSoccerPlayerId": soccerPlayerId,
        "selectable": true
      }, (String soccerPlayerId) {
        SoccerPlayerListItem soccerPlayer = allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer.id == soccerPlayerId, orElse: () => null);
        onSoccerPlayerActionButton(soccerPlayer);
      });
  }

  void onSoccerPlayerActionButton(SoccerPlayerListItem soccerPlayer) {
    onChangeSoccerPlayer(soccerPlayer.instanceSoccerPlayer);
  }
  
  void hideConfirmModal() {
    isConfirmModalOn = false;
  }
  void onChangeSoccerPlayer(var instanceSoccerPlayer) {
    newSoccerPlayer = instanceSoccerPlayer;
    
    //Check Soccer team
    String newSoccerTeamId = newSoccerPlayer.soccerPlayer.soccerTeam.templateSoccerTeamId;
    
    int sameTeamCount = mainPlayer.instanceSoccerPlayers.where((i) => i.soccerTeam.templateSoccerTeamId == newSoccerTeamId && i.id != changingPlayer.id).length;
    bool isSameTeamOk = sameTeamCount < 4;
    
    //Check Salary
    int salary = remainingSalary + changingPlayer.salary - newSoccerPlayer.salary;
    bool isSalaryOk = salary >= 0;
    
    //Check gold
    Money goldNeeded = newSoccerPlayer.moneyToBuy(contest, _profileService.user.managerLevel);
    goldNeeded = goldNeeded.plus(mainPlayer.changePrice());
    bool isGoldOk = _profileService.user.goldBalance.amount >= goldNeeded.amount;
    
    //Check num changes availables
    bool areAvailableChanges = numAvailableChanges > 0;
    
    if (isSameTeamOk && isSalaryOk && areAvailableChanges && isGoldOk) {
      isConfirmModalOn = true;
      /*modalShow("",
                '''
                <p>${getLocalizedText('change-player-modal', 
                                      substitutions: {'SOCCER_PLAYER1': _changingPlayer.soccerPlayer.name, 
                                                      'SOCCER_PLAYER2': _newSoccerPlayer.soccerPlayer.name})}</p>
              '''
                // <ul>${NEEDED_PERMISSIONS.fold('', (prev, curr) => '$prev<li>$curr</li>')}</ul>
                , onBackdropClick: false
                , onOk: getLocalizedText((goldNeeded.amount > 0)? 'change-player-modal-confirm' : 'change-player-modal-confirm0', substitutions: {'GOLD_COINS': goldNeeded.amount.toInt()})
                , onCancel: getLocalizedText('change-player-modal-cancel')
                , aditionalClass: "change-player-modal"
              ).then((_) {
                _changeSoccerPlayer(_newSoccerPlayer, goldNeeded);
              })
              .catchError((_) {});*/
      
    } else {
      if (!isSameTeamOk){
        alertTooMuchSameTeam();
        //print("HAY DEMASIADOS DEL MISMO EQUIPO");
      } else if (!isSalaryOk) {
        print("TE PASAS DEL SALARY");
      } else if (!areAvailableChanges) {
        print("NO HAY CAMBIOS DISPONIBLES");
      } else if (!isGoldOk) {
        alertNotEnoughGold(goldNeeded.amount.toInt());
      }
    }
  }
  
  String get confirmChangesModalText {
    if (!isConfirmModalOn) return '';
    
    return "${getLocalizedText('change-player-modal', 
                  substitutions: {'SOCCER_PLAYER1': "<span class='change-soccer-player player-old'> ${changingPlayer.soccerPlayer.name}</span>", 
                                  'SOCCER_PLAYER2': "<span class='change-soccer-player player-new'> ${newSoccerPlayer.soccerPlayer.name}</span>"})}";
  }
  
  void changeSoccerPlayer() {
    loadingService.isLoading = true;
    
    _contestsService.changeSoccerPlayer(mainPlayer.contestEntryId, 
                  changingPlayer.soccerPlayer.templateSoccerPlayerId, 
                  newSoccerPlayer.soccerPlayer.templateSoccerPlayerId)
            .then((_) {
              _turnZone.run(() {
                //_profileService.user.goldBalance.amount -= newSoccerPlayer.moneyToBuy(contest, _profileService.user.managerLevel).amount;
                updateLive();
                //print ("onSoccerPlayerActionButton: Ok");
              });
            })
            .catchError((ServerError error) {
              Logger.root.info("Error: ${error.responseError}");
              if (error.isRetryOpError) {
                _retryOpTimer = new Timer(const Duration(seconds:3), () => onChangeSoccerPlayer(newSoccerPlayer));
              } else {
                print("EEEEEERRRROOOORRR!!!!!!!!!!!!");
                print("EEEEEERRRROOOORRR!!!!!!!!!!!!");
                print("EEEEEERRRROOOORRR!!!!!!!!!!!!");
                print("EEEEEERRRROOOORRR!!!!!!!!!!!!");
                //_showMsgError(error, goldNeeded.amount.toInt());
              }
            }, test: (error) => error is ServerError)
            .whenComplete(() {
              closePlayerChanges();
              loadingService.isLoading = false;
            });
  }

  void _showMsgError(ServerError error, int coinsNeeded) {
    String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );
    
    if (keyError == ERROR_USER_BALANCE_NEGATIVE) {
      alertNotEnoughGold(coinsNeeded);
    } else {
      modalShow(
        errorMap[keyError]["title"],
        errorMap[keyError]["generic"]
      );
    }
  }

  static const String ERROR_RETRY_OP = "ERROR_RETRY_OP";
  static const String ERROR_SOURCE_SOCCERPLAYER_INVALID = "ERROR_SOURCE_SOCCERPLAYER_INVALID";
  static const String ERROR_TARGET_SOCCERPLAYER_INVALID = "ERROR_TARGET_SOCCERPLAYER_INVALID";
  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";
  static const String ERROR_SALARYCAP_INVALID = "ERROR_SALARYCAP_INVALID";
  static const String ERROR_MAX_PLAYERS_SAME_TEAM = "ERROR_MAX_PLAYERS_SAME_TEAM";
  
  Map<String, Map> get errorMap => {
      ERROR_MAX_PLAYERS_SAME_TEAM: {
        "title"   : getLocalizedText("errormaxplayerssameteamtitle"),
        "generic" : getLocalizedText("errormaxplayerssameteamgeneric"),
      },
      ERROR_SOURCE_SOCCERPLAYER_INVALID: {
        "title"   : getLocalizedText("error-source-soccerplayer-invalid-title"),
        "generic" : getLocalizedText("error-source-soccerplayer-invalid-generic"),
      },
      ERROR_TARGET_SOCCERPLAYER_INVALID: {
        "title"   : getLocalizedText("error-target-soccerplayer-invalid-title"),
        "generic" : getLocalizedText("error-target-soccerplayer-invalid-generic"),
      },
      ERROR_SALARYCAP_INVALID: {
        "title"   : getLocalizedText("error-salarycap-invalid-title"),
        "generic" : getLocalizedText("error-salarycap-invalid-generic"),
      },
      // TODO: Avisamos al usuario de que no dispone del dinero suficiente pero, cuando se integre la branch "paypal-ui", se le redirigirá a "añadir fondos"
      ERROR_USER_BALANCE_NEGATIVE: {
        "title"   : getLocalizedText("erroruserbalancenegativetitle"),
        "generic" : getLocalizedText("erroruserbalancenegativegeneric")
      },
      "_ERROR_DEFAULT_": {
          "title"   : getLocalizedText("errordefaulttitle"),
          "generic" : getLocalizedText("errordefaultgeneric")
      },
  };
  
  void alertTooMuchSameTeam() {
    modalShow("",
              '''
                <p>${getLocalizedText('alert-too-much-same-team')}</p>
              '''
              // <ul>${NEEDED_PERMISSIONS.fold('', (prev, curr) => '$prev<li>$curr</li>')}</ul>
              , onBackdropClick: false
              , onOk: getLocalizedText("alert-too-much-same-team-ok")
              , aditionalClass: "change-player-modal"
            );//.then((_) {    }).catchError((_) {});
  }

  void alertNotEnoughGold(coinsNeeded) {
    modalShow(
        ""
        , '''
          <div class="content-wrapper">
            <h1 class="alert-content-title">${getLocalizedText("alert-no-gold-message")}</h1>
            <div class="gold-needed-icon-wrapper">
              <img class="gold-image" src="images/EpicCoinModales.png">
              <span class="not-enough-resources-count">${coinsNeeded}</span>
            </div>
            <h2 class="alert-content-subtitle">${getLocalizedText('alert-user-gold-message', substitutions:{'MONEY': _profileService.user.goldBalance.amount.toInt()})}<span class="gold-icon-tiny"></span></h2>
          </div>
          '''
        , onOk: getLocalizedText("buy-gold-button")
        , onBackdropClick: false
        , closeButton: true
        , aditionalClass: "noGold"
    ).then((_) {
      // La lista de futbolistas ("soccer_players_list") se muestra "fuera" de angular ("runOutsideAngular")
      //   Necesitamos ejecutar la transición "dentro" de angular (en caso contrario, se produce una excepción)
      _turnZone.run(() {
        // Registramos dónde tendría que navegar al tener éxito en "add_funds"
        String hash = "#/live_contest/my_contests/${contestId}/change/${changingPlayer.soccerPlayer.templateSoccerPlayerId}/${newSoccerPlayer.soccerPlayer.templateSoccerPlayerId}";
        String url = "${window.location.origin}${window.location.pathname}$hash";
        GameInfo.assign("add_gold_success", url);
        _router.go('shop.buy', {});
      });
    });

    _tutorialService.triggerEnter("alert-not-enough-resources");
  }
  
  void nothing() {}
  

  VmTurnZone _turnZone;
  Router _router;
  Timer _retryOpTimer;
  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
  TutorialService _tutorialService;
  List<InstanceSoccerPlayer> _allInstanceSoccerPlayers;
  
  String _sourceSoccerPlayerIdToChange;
  String _targetSoccerPlayerIdToChange;
  AppStateService _appStateService;
}

