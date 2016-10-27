library enter_contest_comp;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'dart:math';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/game_info.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/components/enter_contest/soccer_player_listitem.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/host_server.dart';

@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest/enter_contest_comp.html',
    useShadowDom: false
)
class EnterContestComp implements DetachAware {
  
  static const String ERROR_RETRY_OP = "ERROR_RETRY_OP";
  static const String ERROR_CONTEST_NOT_ACTIVE = "ERROR_CONTEST_NOT_ACTIVE";
  static const String ERROR_CONTEST_FULL = "ERROR_CONTEST_FULL";
  static const String ERROR_USER_ALREADY_INCLUDED = "ERROR_USER_ALREADY_INCLUDED";
  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";
  static const String ERROR_MAX_PLAYERS_SAME_TEAM = "ERROR_MAX_PLAYERS_SAME_TEAM";
  static const String ERROR_MANAGER_LEVEL_INVALID = "ERROR_MANAGER_LEVEL_INVALID";
  static const String ERROR_TRUESKILL_INVALID = "ERROR_TRUESKILL_INVALID";

  // Errores de los que no tendríamos que informar
  static const String ERROR_CONTEST_INVALID = "ERROR_CONTEST_INVALID";
  static const String ERROR_FANTASY_TEAM_INCOMPLETE = "ERROR_FANTASY_TEAM_INCOMPLETE";
  static const String ERROR_SALARYCAP_INVALID = "ERROR_SALARYCAP_INVALID";
  static const String ERROR_FORMATION_INVALID = "ERROR_FORMATION_INVALID";
  static const String ERROR_OP_UNAUTHORIZED = "ERROR_OP_UNAUTHORIZED";
  static const String ERROR_CONTEST_ENTRY_INVALID = "ERROR_CONTEST_ENTRY_INVALID";

  static const String LINEUP_FIELD_SELECTOR = "LINEUP_FIELD_SELECTOR";
  static const String SELECTING_SOCCER_PLAYER = "SELECTING_SOCCER_PLAYER";
  static const String SOCCER_PLAYER_STATS = "SOCCER_PLAYER_STATS";
  static const String CONTEST_INFO = "CONTEST_INFO";

  String get metricsScreenName => editingContestEntry? GameMetrics.SCREEN_LINEUP_EDIT : GameMetrics.SCREEN_LINEUP;
  String joiningErrorText = "";
  
  //ScreenDetectorService scrDet;
  LoadingService loadingService;

  Contest contest;
  String contestId;
  String _formationId = ContestEntry.FORMATION_442;
  String get formationId => _formationId;
  void set formationId(String id) {
    _formationId = id;
    onLineupFormationChange();
  }
  String contestEntryId;

  List<SoccerPlayerListItem> allSoccerPlayers;
  List<SoccerPlayerListItem> lineupSlots;
  List<String> get lineupFormation => FieldPos.FORMATIONS[formationId];
  List<SoccerPlayerListItem> favoritesPlayers = [];
  bool _onlyFavorites = false;
  bool get onlyFavorites => _onlyFavorites;
  void set onlyFavorites(bool f) {
    _onlyFavorites = f;
    GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_FAVORITES_FILTER, metricsScreenName, contest, {"formation": formationId, "isFavouritesFilterOn": _onlyFavorites});
  }

  FieldPos fieldPosFilter;
  String nameFilter;
  String matchFilter;
  
  String instanceSoccerPlayerDisplayInfo = null;

  String _sectionActive = LINEUP_FIELD_SELECTOR;
  void set sectionActive(String section) { 
    _sectionActive = section;
    _appStateService.appSecondaryTabBarState.tabList = [];
    switch(_sectionActive) {
      case LINEUP_FIELD_SELECTOR:
        if (contest != null && !_isRestoringTeam) GameMetrics.contestScreenVisitEvent(metricsScreenName, contest);
        setupContestInfoTopBar(true, cancelCreateLineup, onContestInfoClick);
      break;
      case SELECTING_SOCCER_PLAYER:
        nameFilter = "";
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSectionWithSearch("Elige un ${fieldPosFilter.fullName}", (String val){ nameFilter = val.length > 1? val : ""; });
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerSelection;
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;
      /*case SELECTING_SOCCER_PLAYER:
        _tabList = [
                         new AppSecondaryTabBarTab("TODOS LOS JUGADORES",                        () => setFilter(false), () => !onlyFavorites),
                         new AppSecondaryTabBarTab('''<i class="material-icons">&#xE838;</i>''', () => setFilter(true),  () => onlyFavorites)
        ];
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Elige un ${fieldPosFilter.fullName}", rightColumn: '<i class="material-icons favorites-top-bar ${onlyFavorites? "favorites-on": "favorites-off"}">${onlyFavorites? "&#xE838;" : "&#xE83A;"}</i>');
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerSelection;
        _appStateService.appTopBarState.activeState.onRightColumn = () {
          setFilter(!onlyFavorites);
          sectionActive = _sectionActive;
        };
        _appStateService.appSecondaryTabBarState.tabList = [];
      break;*/
      case SOCCER_PLAYER_STATS:
        _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.subSection("Estadísticas");
        _appStateService.appTopBarState.activeState.onLeftColumn = cancelPlayerDetails;
      break;
      case CONTEST_INFO:
        GameMetrics.contestScreenVisitEvent(GameMetrics.SCREEN_CONTEST_INFO, contest);
        setupContestInfoTopBar(false, cancelContestDetails);
      break;
    }
  }
  void setFilter(bool onlyfavs) {
    onlyFavorites = onlyfavs;    
  }
  
  String get sectionActive => _sectionActive;

  bool get isLineupFieldSelectorActive => sectionActive == LINEUP_FIELD_SELECTOR;
  bool get isSelectingSoccerPlayerActive => sectionActive == SELECTING_SOCCER_PLAYER;
  bool get isSoccerPlayerStatsActive => sectionActive == SOCCER_PLAYER_STATS;
  bool get isContestInfoActive => sectionActive == CONTEST_INFO;
  bool isLineupFinished = false;
  
  InstanceSoccerPlayer selectedInstanceSoccerPlayer;
  
  bool get isCurrentSelectedAdded => lineupSlots.contains(selectedInstanceSoccerPlayer);

  int availableSalary = 0;
  Money _coinsNeeded = new Money.from(Money.CURRENCY_GOLD, 0);
  Money get coinsNeeded {
    _coinsNeeded.amount = 0;

    /*
    lineupSlots
      .where((c) => c != null)
      .forEach( (c) => _coinsNeeded.amount += c.moneyToBuy.amount);
    */
    if (contest != null && contest.entryFee != null && contest.entryFee.isGold && !editingContestEntry) {
      _coinsNeeded.amount += contest.entryFee.amount;
    }
    return _coinsNeeded;
  }

  Money get moneyNeeded {
    return (contest != null)
        ? (contest.simulation ? (editingContestEntry ? new Money.from(Money.CURRENCY_ENERGY, 0) : contest.entryFee) : coinsNeeded)
        : new Money.from(Money.CURRENCY_GOLD, 0);
  }

  String get printableCurrentSalary => contest != null? StringUtils.parseSalary(availableSalary) : "-";
  String get printableSalaryCap => contest != null? StringUtils.parseSalary(contest.salaryCap) : "-";
  
  // Comprobamos si tenemos recursos suficientes para pagar el torneo (salvo que estemos editando el contestEntry)
  bool get enoughResourcesForEntryFee =>
      contest == null || !_profileService.isLoggedIn || _profileService.user.hasMoney(moneyNeeded);

  String get resourceName => contest != null && contest.simulation ? getLocalizedText("resource-energy") : getLocalizedText("resource-gold");

  bool playersInSameTeamInvalid = false;
  bool isNegativeBalance = false;

  bool get isInvalidFantasyTeam => lineupSlots.any((player) => player == null) || playersInSameTeamInvalid || isNegativeBalance;
  bool get editingContestEntry => contestEntryId != "none";
  bool get isCreatingContest => _parent.contains("create_contest");

  bool contestInfoFirstTimeActivation = false;  // Optimizacion para no compilar el contest_info hasta que no sea visible la primera vez

  num get playerManagerLevel {
    num result = _profileService.isLoggedIn ? _profileService.user.managerLevel : 0;
    if (contest != null) {
      result = (contest.simulation) ? User.MAX_MANAGER_LEVEL : min(result, contest.maxManagerLevel);
    }
    //return result;
    // HACK:
    return User.MAX_MANAGER_LEVEL;
  }

  int get playerGold => _profileService.isLoggedIn ? _profileService.user.Gold: 0;
  int get playerEnergy => _profileService.isLoggedIn ? _profileService.user.Energy : 0;

  List<String> lineupAlertList = [];

  List<User> _userList = [];
  List<User> _orderedList = [];
  List<User> get filteredFriendList {
    if (contest == null) return _orderedList;
    if (_userList.length != contest.contestEntries.length) {
      _userList = contest.contestEntries.map( (contestEntry) => contestEntry.user).toList();
      List<User> friendList = _profileService.friendList;

      // Añadimos primero en la lista los amigos
      _orderedList = _userList.where((u) => friendList.any(
              (friend) => friend.facebookID == u.facebookID)).toList();
      // Despues añadimos los que no son amigos y no son el propio jugador (para editar alineación)
      _orderedList.addAll( _userList.where((u) =>
            !friendList.any((friend) => friend.facebookID == u.facebookID)
            && (!_profileService.isLoggedIn || u.userId != _profileService.user.userId)
          ).toList());

    }
    return _orderedList;
  }
  
  bool get userIsLoggedIn => _profileService.isLoggedIn;

  Map<String, Map> errorMap;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "entercontest", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  EnterContestComp(this._routeProvider, this._router, this._appStateService,
                   this._contestsService, this.loadingService, this._profileService, this._catalogService,
                   this._flashMessage, this._rootElement, this._tutorialService) {
    
    setupContestInfoTopBar(false, cancelCreateLineup);
    //_appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, false, () => _router.go('lobby', {}));
    _appStateService.appSecondaryTabBarState.tabList = [];
    _appStateService.appTabBarState.show = false;
    sectionActive = LINEUP_FIELD_SELECTOR;
    
    loadingService.isLoading = true;

    errorMap = {
      ERROR_CONTEST_NOT_ACTIVE: {
          "title"   : getLocalizedText("errorcontestnotactivetitle"),
          "generic" : getLocalizedText("errorcontestnotactivegeneric"),
          "editing" : getLocalizedText("errorcontestnotactiveediting")
      },
      ERROR_MANAGER_LEVEL_INVALID: {
          "title"   : getLocalizedText("error-managerlevel-invalid-title"),
          "generic" : getLocalizedText("error-managerlevel-invalid-generic")
      },
      ERROR_TRUESKILL_INVALID: {
        "title"   : getLocalizedText("error-trueskill-invalid-title"),
        "generic" : getLocalizedText("error-trueskill-invalid-generic")
      },
      ERROR_MAX_PLAYERS_SAME_TEAM: {
        "title"   : getLocalizedText("errormaxplayerssameteamtitle"),
        "generic" : getLocalizedText("errormaxplayerssameteamgeneric"),
      },
      // TODO: Avisamos al usuario de que no dispone del dinero suficiente pero, cuando se integre la branch "paypal-ui", se le redirigirá a "añadir fondos"
      ERROR_USER_BALANCE_NEGATIVE: {
        "title"   : getLocalizedText("erroruserbalancenegativetitle"),
        "generic" : getLocalizedText("erroruserbalancenegativegeneric")
      },
      "ERROR_CONTEST_FULL": {
          "title"   : getLocalizedText("cannot-enter-full-title"),
          "generic" : getLocalizedText("cannot-enter-full-desc"),
      },
      "_ERROR_DEFAULT_": {
          "title"   : getLocalizedText("errordefaulttitle"),
          "generic" : getLocalizedText("errordefaultgeneric"),
          "editing" : getLocalizedText("errordefaultediting")
      },
    };
    resetLineup();

    _parent = _routeProvider.parameters["parent"];
    contestId = _routeProvider.route.parameters['contestId'];
    contestEntryId = _routeProvider.route.parameters['contestEntryId'];

    _tutorialService.triggerEnter("enter_contest", component: this);

    Future refreshContest = isCreatingContest
                              ? _contestsService.refreshMyCreateContest(contestId)
                              : editingContestEntry
                                ? _contestsService.refreshMyActiveContest(contestId)
                                : _contestsService.refreshActiveContest(contestId);
    refreshContest
      .then((_) {
        contest = _contestsService.lastContest;
        sectionActive = LINEUP_FIELD_SELECTOR;

        // FIX: Si no estoy editando, pero sí que estoy inscrito en el torneo hay que actualizar el contestEntryId (para indicar que realmente es una edición)
        // Esta situación se puede producir cuando alguien comparte un link con un usuario, en un torneo en el que está inscrito
        if (!editingContestEntry && _profileService.isLoggedIn && contest.userIsRegistered(_profileService.user.userId)) {
          contestEntryId = contest.getContestEntryWithUser(_profileService.user.userId).contestEntryId;

          // Tenemos que pedir al servidor los datos ampliados (con nuestra alineación)
          _contestsService.refreshMyActiveContest(contestId)
          .then((_) {
            contest = _contestsService.lastContest;
            refreshInfoFromContest();
          });
        }
        else {
          refreshInfoFromContest();
        }
      })
      .catchError((ServerError error) {
        // Si estamos editando un contestEntry y el server nos indica un fallo (generalmente es porque el usuario "no tiene permiso"), nos saldremos de la pantalla
        if (editingContestEntry) {
          cancelCreateLineup();
          //_router.go("lobby", {});
        }
        else {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }
      }, test: (error) => error is ServerError);

    subscribeToLeaveEvent();
  }
  
  void setupContestInfoTopBar(bool showInfoButton, Function backFunction, [Function infoFunction]) {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.contestSection(contest, showInfoButton && infoFunction != null, backFunction, infoFunction);
  }
  
  void refreshInfoFromContest() {
    
    loadingService.isLoading = false;
    
    setupContestInfoTopBar(true, cancelCreateLineup, onContestInfoClick);
    
    if (_profileService.isLoggedIn && !contest.canEnter(_profileService.user) && !editingContestEntry) {
      cannotEnterMessageRedirect();
      return;
    }

    if (!_profileService.isLoggedIn && contest.isFull) {
      cannotEnterMessageRedirect();
      return;
    }

    availableSalary = contest.salaryCap;
    // Comprobamos si estamos en salario negativo
    isNegativeBalance = availableSalary < 0;
    initAllSoccerPlayers();

    // Si nos viene el torneo para editar la alineación
    if (editingContestEntry) {
      ContestEntry contestEntry = contest.getContestEntry(contestEntryId);
      if (contestEntry != null) {
        formationId = contestEntry.formation;
        // Insertamos en el lineup el jugador
        _isRestoringTeam = true;
        contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
          addSoccerPlayerToLineup(instanceSoccerPlayer.id);
        });
        _isRestoringTeam = false;
      }
    }
    else {
      // TODO: ¿Únicamente restauramos el contestEntry anteriormente registrado si estamos creando uno nuevo?
      restoreContestEntry();
    }
  }
  
  void cannotEnterMessageRedirect() {
    String title = "";
    String description = "";
    int userLevel = _profileService.isLoggedIn ? _profileService.user.managerLevel.toInt() : 0;
    int userTrueSkill = _profileService.isLoggedIn ? _profileService.user.trueSkill : 0;
    //getLocalizedText("alert-no-energy-message_2", substitutions:{'ENERGY': playerEnergy})
    if (contest.isLive || contest.isHistory) {
      title = contest.isLive ? getLocalizedText("cannot-enter-live-title") : getLocalizedText("cannot-enter-history-title");
      description = getLocalizedText("cannot-enter-live-history-desc");
    }
    else if (contest.isFull) {
      title = getLocalizedText("cannot-enter-full-title");
      description = getLocalizedText("cannot-enter-full-desc");
    } else if (!contest.hasManagerLevel(userLevel)) {
      if (userLevel < contest.minManagerLevel ) {
        title = getLocalizedText("cannot-enter-min-manager-title");
        description = getLocalizedText("cannot-enter-min-manager-desc", substitutions: {
                                              'MIN_MANAGER_LEVEL': contest.minManagerLevel,
                                              'USER_LEVEL': userLevel 
                                            });
      } else {
        title = getLocalizedText("cannot-enter-max-manager-title");
        description = getLocalizedText("cannot-enter-max-manager-desc", substitutions: {
                                              'MAX_MANAGER_LEVEL': contest.maxManagerLevel,
                                              'USER_LEVEL': userLevel 
                                            });
      }
    } else if (!contest.hasTrueSkill(userTrueSkill)) {
      if (userTrueSkill < contest.minTrueSkill ) {
        title = getLocalizedText("cannot-enter-min-trueskill-title");
        description = getLocalizedText("cannot-enter-min-trueskill-desc", substitutions: {
                                              'MIN_TRUESKILL': contest.minTrueSkill,
                                              'USER_TRUESKILL': userTrueSkill 
                                            });
      } else {
        title = getLocalizedText("cannot-enter-max-trueskill-title");
        description = getLocalizedText("cannot-enter-max-trueskill-desc", substitutions: {
                                              'MAX_TRUESKILL': contest.maxTrueSkill,
                                              'USER_TRUESKILL': userTrueSkill 
                                            });
      }
    }
    joiningErrorText = description;
    /*modalShow(
          "",
          '''
            <div class="content-wrapper">
              <h1 class="alert-content-title">$title</h1>
              <h2 class="alert-content-subtitle">$description</h2>
            </div>
          '''
          , onBackdropClick: true
          , aditionalClass: "cannotEnter"
        )
        .then((_) => cancelCreateLineup())
        .catchError((_) => cancelCreateLineup());*/
  }

  void updateFavorites() {
    favoritesPlayers.clear();
    if (_profileService.isLoggedIn) {
      favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
          allSoccerPlayers.firstWhere( (player) => player.id == playerId, orElse: () => null)
        ).where( (d) => d != null));
    }
  }


  void subscribeToLeaveEvent() {
    // Subscripción para controlar la salida
    _routeHandle = _routeProvider.route.newHandle();
    _routeHandle.onPreLeave.listen(allowLeaveThePage);
  }

  void allowLeaveThePage(RoutePreLeaveEvent event) {

    // Si estoy validando la alineación permitimos salir
    if (_teamConfirmed) {
      event.allowLeave(new Future<bool>.value(true));
      return;
    }
    // Verificamos si esta la lista vacía por completo para permitir salir sin alertas.
    bool isLineupEmpty = !lineupSlots.any((soccerPlayer) => soccerPlayer != null);
    // Si no hemos metido a nadie en nuestro equipo
    if(!isLineupEmpty && !_teamConfirmed && !editingContestEntry) {
      // TODO: Quitamos el mensaje informativo...
      // _flashMessage.addGlobalMessage(StringUtils.translate("lineupsavedmsg", "entercontest"), 3);
    }else {
      event.allowLeave(new Future<bool>.value(true));
      return;
    }
  }
  bool get isLineupFilled => !lineupSlots.any((soccerPlayer) => soccerPlayer == null);

  void resetLineup() {
    lineupSlots = new List.filled(lineupFormation.length, null);
    availableSalary = contest != null ? contest.salaryCap : 0;
    isNegativeBalance = availableSalary < 0;
    if (contest != null) GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CLEAR, metricsScreenName, contest, {"formation": formationId});
  }

  void detach() {
    _routeHandle.discard();

    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }
  }

  void tabChange(String tab) {

    if (!contestInfoFirstTimeActivation && tab == "contest-info-tab-content") {
      contestInfoFirstTimeActivation = true;
    }

    querySelectorAll("#enter-contest-wrapper .tab-pane").classes.remove('active');
    querySelector("#${tab}").classes.add("active");
  }

  void onLineupSlotSelected(int slotIndex) {

    // Si todavia no tenemos concurso (esta cargando), rechazamos el click
    if (contest == null) {
      return;
    }

    if (lineupSlots[slotIndex] != null) {
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_SOCCERPLAYER_DELETED, metricsScreenName, contest, {"footballPlayer": lineupSlots[slotIndex].name, "formation": formationId});
      
      // Al borrar el jugador seleccionado en el lineup, sumamos su salario al total
      availableSalary += lineupSlots[slotIndex].salary;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;
      //guardamos los cambios
      saveContestEntry();

      // Quitamos la modal de números rojos si ya hay salario disponible
      isNegativeBalance = availableSalary < 0;
    }
    else {
      fieldPosFilter = new FieldPos(lineupFormation[slotIndex]);
      sectionActive = SELECTING_SOCCER_PLAYER;
      //scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: false, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
      // Cuando seleccionan un slot del lineup cambiamos siempre el filtro de la soccer-player-list, especialmente
      // en movil que cambiamos de vista a "solo ella".
      // El componente hijo se entera de que le hemos cambiado el filtro a traves del two-way binding.
    }

    _verifyMaxPlayersInSameTeam();
  }

  void addSoccerPlayerToLineup(String soccerPlayerId) {
    var soccerPlayer = allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer.id == soccerPlayerId, orElse: () => null);
    if (soccerPlayer != null) {
      _tryToAddSoccerPlayerToLineup(soccerPlayer);
    }
  }
  
  void generateAutomaticLineup() {
    if (contest != null) {
      _contestsService.generateLineup(contest, _formationId)
        .then( (List<InstanceSoccerPlayer> lineup) {
          deleteFantasyTeam();
          lineup.forEach( (instance) {
            if (instance != null) {
              addSoccerPlayerToLineup(instance.id);
            }
          });
          GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_AUTOGENERATE, metricsScreenName, contest, {"formation": formationId});
        });
    }
  }

  void onLineupFormationChange() {

    int firstAvailablePosition(String soccerPosition) {
      for (int c = 0; c < lineupSlots.length; ++c) {
        if (lineupSlots[c] == null && lineupFormation[c] == soccerPosition)
          return c;
      }
      return -1;
    }

    int cheapestByPosition(String soccerPosition) {
      int cheapestIdx;
      int cheapestValue = -1;
      for (int c = 0; c < lineupSlots.length; ++c) {
        if (lineupSlots[c] != null && lineupFormation[c] == soccerPosition) {
          if (cheapestValue == -1 || lineupSlots[c].salary < cheapestValue){
            cheapestValue = lineupSlots[c].salary;
            cheapestIdx = c;
          }
        }
      }
      return cheapestIdx;
    }


    for (int c = 0; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] != null && lineupFormation[c] != lineupSlots[c].fieldPos.value) {
        // print(lineupSlots[c]["fieldPos"].value + " -ConflictoCon- " + lineupFormation[c]);
        SoccerPlayerListItem soccerPlayer = lineupSlots[c];
        int availablePosition = firstAvailablePosition(lineupSlots[c].fieldPos.value);
        // print("Posicion disponible: $availablePosition");

        if (availablePosition != -1) {
          onLineupSlotSelected(c);
          _tryToAddSoccerPlayerToLineup(soccerPlayer);
        } else {
          int cheapestIndex = cheapestByPosition(lineupSlots[c].fieldPos.value);
          // print("Más barato: $cheapestIndex");
          onLineupSlotSelected(c);
          if (c != cheapestIndex) {
            onLineupSlotSelected(cheapestIndex);
            _tryToAddSoccerPlayerToLineup(soccerPlayer);
          }
        }
      }
    }

    _tutorialService.triggerEnter("formation-" + _formationId.toString(), activateIfNeeded: false);
    if (contest != null && !_isRestoringTeam) GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CHANGE_FORMATION, metricsScreenName, contest, {"formation": formationId});
    
    // EJEMPLO DE USO del Generate Lineup
    /*
    if (contest != null) {
      _contestsService.generateLineup(contest, _formationId)
        .then( (List<InstanceSoccerPlayer> lineup) {
          deleteFantasyTeam();
          lineup.forEach( (instance) {
            if (instance != null) {
              addSoccerPlayerToLineup(instance.id);
            }
          });
        });
    }
     */

    /*
    for (int c = 0; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && lineupFormation[c] == theFieldPos.value) {
        // TODO:...
        // _catalogService.buySoccerPlayer(contest.contestId, soccerPlayer["id"]);

        lineupSlots[c] = soccerPlayer;
        isSelectingSoccerPlayer = false;
        availableSalary -= soccerPlayer["salary"];
        // Comprobamos si estamos en salario negativo
        isNegativeBalance = availableSalary < 0;

        nameFilter = null;
        // Actualizamos el contestEntry, independientemente que estemos editando o creando
        if(!_isRestoringTeam) {
          saveContestEntry();
        }
        break;
      }
    }*/

  }

  void onSoccerPlayerActionButtonFromStats(String playerId) {
    
    SoccerPlayerListItem sc = allSoccerPlayers.firstWhere( (player) => player.id == playerId);
    
    onSoccerPlayerActionButton(sc);
    
    sectionActive = LINEUP_FIELD_SELECTOR;    
  }
  
  void onSoccerPlayerActionButton(SoccerPlayerListItem soccerPlayer) {

    int indexOfPlayer = lineupSlots.indexOf(soccerPlayer);
    if (indexOfPlayer != -1) {
      onLineupSlotSelected(indexOfPlayer);  // Esto se encarga de quitarlo del lineup
    } else {
      _tryToAddSoccerPlayerToLineup(soccerPlayer);

    }
    _verifyMaxPlayersInSameTeam();    
  }

  bool isFieldPositionFull(FieldPos pos) {
    for (int c = 0; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && lineupFormation[c] == pos.value) {
        return false;
      }
    }
    return true;
  }
  
  void _tryToAddSoccerPlayerToLineup(SoccerPlayerListItem soccerPlayer) {
    if (contest.entryFee.isGold && !_isRestoringTeam) {
      Money moneyToBuy = new Money.from(Money.CURRENCY_GOLD, soccerPlayer.moneyToBuy.amount);

      // TODO: En el tutorial no queremos permitir que el usuario alinee un futbolista que cueste GOLD
      // BEGIN HACK ---------------------->
      if (TutorialService.isActivated) {
        bool hasMoney = _profileService.isLoggedIn ? _profileService.user.hasMoney(moneyToBuy) : moneyToBuy.isZero;
        if (!hasMoney) {
          alertNotBuy(moneyToBuy);
          return;
        }
      }
      // END HACK ---------------------->
    }

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer.fieldPos;

    for (int c = 0; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && lineupFormation[c] == theFieldPos.value) {
        // TODO:...
        // _catalogService.buySoccerPlayer(contest.contestId, soccerPlayer["id"]);

        lineupSlots[c] = soccerPlayer;
        availableSalary -= soccerPlayer.salary;
        // Comprobamos si estamos en salario negativo
        isNegativeBalance = availableSalary < 0;
        if (isFieldPositionFull(theFieldPos)) {
          sectionActive = LINEUP_FIELD_SELECTOR;
        }

        nameFilter = null;
        // Actualizamos el contestEntry, independientemente que estemos editando o creando
        if(!_isRestoringTeam) {
          saveContestEntry();
        }
        break;
      }
    }

    // Si ya no estamos en modo seleción, scrolleamos hasta la altura del dinero que nos queda disponible.
    /*if (!isSelectingSoccerPlayer) {
      scrDet.scrollTo('.enter-contest-actions-wrapper', fps: 15, smooth: false, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
    }*/

    if(!_isRestoringTeam) {
      _verifyMaxPlayersInSameTeam();

      int playerInLineup = lineupSlots.where((player) => player != null).length;
      _tutorialService.triggerEnter("lineup-" + playerInLineup.toString(), activateIfNeeded: false);
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_SOCCERPLAYER_SELECTED, metricsScreenName, contest, {
        "footballPlayer": soccerPlayer.name, 
        "formation": formationId, 
        'isFavouritesFilterOn' : onlyFavorites, 
        'isFavourite' : favoritesPlayers.where((s) => s.id == soccerPlayer.id).isNotEmpty});
    }

  }

  bool isSlotAvailableForSoccerPlayer(String soccerPlayerId) {
    if (soccerPlayerId == null || soccerPlayerId.isEmpty || allSoccerPlayers == null || allSoccerPlayers.isEmpty) {
      return false;
    }

    SoccerPlayerListItem soccerPlayer = allSoccerPlayers.firstWhere((sp) => sp.id == soccerPlayerId);

    FieldPos theFieldPos = soccerPlayer.fieldPos;
    int c = 0;
    if (lineupSlots.contains(soccerPlayer)) {
      return false;
    }
    for ( ; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && lineupFormation[c] == theFieldPos.value)
        return true;
    }
    return false;
  }

  void initAllSoccerPlayers() {
    allSoccerPlayers = new List<SoccerPlayerListItem>();

    ContestEntry contestEntry = null;
    if (editingContestEntry) {
      contestEntry = contest.getContestEntry(contestEntryId);
    }
    
    contest.instanceSoccerPlayers.forEach((templateSoccerId, instanceSoccerPlayer) {
      if (contestEntry != null && contestEntry.isPurchased(instanceSoccerPlayer)) {
        instanceSoccerPlayer.level = 0;
      }
      num managerLevel = 0;
      if (_profileService.isLoggedIn) {
        managerLevel = _profileService.user.managerLevel;
      }
      if (instanceSoccerPlayer.salary > 0) {
        allSoccerPlayers.add(new SoccerPlayerListItem(instanceSoccerPlayer, managerLevel, contest));
      }
    });
    updateFavorites();
  }

  
  void createFantasyTeam() {
    if (isNegativeBalance) {
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM_ERROR, metricsScreenName, contest, {"errorDescription": "Balance negativo", "errorDebug": "NOT_HANDLED"});
      return;
    }

    // No permitimos la reentrada de la solicitud (hasta que termine el timer de espera para volver a reintentarlo)
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      return;
    }

    // Actualizamos el contestEntry, independientemente que estemos editando o creando
    saveContestEntry();

    //TODO: Mostramos los IDs del fantasyTeam creado
    //print ("FantasyTeam: " + GameInfo.get(_getKeyForCurrentUserContest));

    if (!_profileService.isLoggedIn) {
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM_ERROR, metricsScreenName, contest, {"errorDescription": "User is not logged", "errorDebug": "NOT_HANDLED"});
      //_router.go("enter_contest.join", {});
      return;
    }

    if (!enoughResourcesForEntryFee) {
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM_ERROR, metricsScreenName, contest, {"errorDescription": "Not enought resources for entry fee", "errorDebug": "HANDLED"});
      alertNotEnoughResources();
      return;

      /*
      // Registramos dónde tendría que navegar al tener éxito en "add_funds"
      GameInfo.assign("add_funds_success", window.location.href);
      _router.go("add_funds", {});
       */
    }

    if (editingContestEntry) {
      _contestsService.editContestEntry(contestEntryId, formationId, lineupSlots.map((player) => player.id).toList())
        .then((_) {
          // num managerLevel = playerManagerLevel;
          // Iterable boughtPlayers = lineupSlots.where((c) => c.moneyToBuy.amount > 0);
          
          GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_MODIFY_COMPLETE, metricsScreenName, contest, { 'formation' : formationId,
                                                                                                                  'salaryCap': contest.salaryCap, 
                                                                                                                  'salaryNotUsed': availableSalary, 
                                                                                                                  'salaryUsed': contest.salaryCap - availableSalary});
          _teamConfirmed = true;
          isLineupFinished = true;
          /*
          _router.go('view_contest_entry', { "contestId": contest.contestId,
                                             "parent": _routeProvider.parameters["parent"],
                                             "viewContestEntryMode": "edited"});
          */
        })
        .catchError((ServerError error) => _errorCreating(error));
    }
    else {
        _contestsService.addContestEntry(contest.contestId, formationId, lineupSlots.map((SoccerPlayerListItem player) => player.id).toList())
          .then((contestId) {
            /*
            num managerLevel = playerManagerLevel;
            Iterable boughtPlayers = lineupSlots.where((c) => c.moneyToBuy.amount > 0);
            boughtPlayers.forEach( (c) {
              num cost = c.instanceSoccerPlayer.moneyToBuy(contest, managerLevel).amount;
            });
            */

            GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM, metricsScreenName, contest, { 'formation' : formationId,
                                                                                                            'salaryCap': contest.salaryCap, 
                                                                                                            'salaryNotUsed': availableSalary, 
                                                                                                            'salaryUsed': contest.salaryCap - availableSalary});

            _teamConfirmed = true;
            isLineupFinished = true;
          })
          .catchError((ServerError error) => _errorCreating(error));
    }
  }

  void _errorCreating(ServerError error) {
    if (error.isRetryOpError) {
      _retryOpTimer = new Timer(const Duration(seconds:3), () => createFantasyTeam());
    } else if (error.responseError.contains(ERROR_USER_ALREADY_INCLUDED)) {
      GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM_ERROR, metricsScreenName, contest, {"errorDescription": "User already Included", "errorDebug": "HANDLED"});
      _router.go('view_contest_entry', { "contestId": contestId,
                                         "parent": _routeProvider.parameters["parent"],
                                         "viewContestEntryMode": "created" });
    }
    else {
      _showMsgError(error);
    }
  }
  
  void removeAllFilters() {
    fieldPosFilter = null;
    nameFilter = null;
    matchFilter = null;
  }

  void deleteFantasyTeam() {
    resetLineup();
    removeAllFilters();
    availableSalary = contest.salaryCap;
    // Comprobamos si estamos en salario negativo
    isNegativeBalance = availableSalary < 0;
    _verifyMaxPlayersInSameTeam();
  }

  bool isPlayerSelected() {
    for (SoccerPlayerListItem player in lineupSlots) {
      if (player != null) {
        return false;
      }
    }
    return true;
  }
  
  void onContestInfoClick() {
    sectionActive = CONTEST_INFO;
  }
  
  void cancelCreateLineup() {
    GameMetrics.actionEvent(GameMetrics.ACTION_BACK_CONTEST_LIST, metricsScreenName);
    
    if (editingContestEntry) {
      _router.go('my_contests', {'section': 'upcoming'});
    } else {
      _router.go('lobby', {});
    }
  }
  
  void goUpcomingContest() {
    GameMetrics.contestActionEvent(GameMetrics.ACTION_CHECK_LINEUP, metricsScreenName, contest);
    _router.go('view_contest_entry', {"contestId": contest.contestId, 
                                      "parent": "my_contests", 
                                      "viewContestEntryMode": "viewing"});
  }

  void cancelContestDetails() {
    sectionActive = LINEUP_FIELD_SELECTOR;
    //scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
  }
  void cancelPlayerSelection() {
    sectionActive = LINEUP_FIELD_SELECTOR;
    //scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
  }
  void cancelPlayerDetails() {
    sectionActive = SELECTING_SOCCER_PLAYER;
    //scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
  }

  void onSoccerPlayerInfoClick(String soccerPlayerId) {
    //ModalComp.open(_router, "enter_contest.soccer_player_stats", { "instanceSoccerPlayerId":soccerPlayerId, "selectable":isSlotAvailableForSoccerPlayer(soccerPlayerId)}, addSoccerPlayerToLineup);
    sectionActive = SOCCER_PLAYER_STATS;
    instanceSoccerPlayerDisplayInfo = soccerPlayerId;
  }

  void _showMsgError(ServerError error) {
    String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );

    GameMetrics.contestActionEvent(GameMetrics.ACTION_LINEUP_CONFIRM_ERROR, metricsScreenName, contest, {"errorDescription": keyError, "errorDebug": "HANDLED"});
    
    if (keyError == ERROR_USER_BALANCE_NEGATIVE) {
      alertNotEnoughResources();
    } 
    else if (keyError == ERROR_CONTEST_FULL) {
      joiningErrorText = "El torneo está lleno";
    }
    else {
      joiningErrorText = errorMap[keyError]["title"];
      /*
      modalShow(
        errorMap[keyError]["title"],
        (editingContestEntry && errorMap[keyError].containsKey("editing")) ? errorMap[keyError]["editing"] : errorMap[keyError]["generic"]
      ).then((resp) {
        if (keyError == ERROR_CONTEST_NOT_ACTIVE) {
          _router.go(_routeProvider.parameters["parent"], {});
        }
      });
      * 
       */
    }
  }

  void _verifyMaxPlayersInSameTeam() {
    playersInSameTeamInvalid = false;

    Map<String, int> playersInSameTeam = new Map<String, int>();

    lineupSlots.where((player) => player != null).forEach((player) {
      String key = player.instanceSoccerPlayer.soccerTeam.templateSoccerTeamId;
      int num = playersInSameTeam.containsKey(key)
                ? playersInSameTeam[key]
                : 0;
      if (num < Contest.MAX_PLAYERS_SAME_TEAM) {
        playersInSameTeam[key] = num + 1;
      }
      else {
        playersInSameTeamInvalid = true;
        return;
      }
    });
  }
  
  bool get isThereAnyLineupConfigError => playersInSameTeamInvalid || availableSalary < 0;
  String get lineupConfigErrorText => isThereAnyLineupConfigError? getLocalizedText(playersInSameTeamInvalid? 'alert-max-players-same-team' :'alert-negative-budget'): '';
  

  void saveContestEntryFromJson(String key, String json) {
    GameInfo.assign(key, json);
  }

  void saveContestEntry() {
    // Lo almacenamos localStorage.
    Map data = { 'formation' :  formationId, 'lineupSlots' : lineupSlots.where((player) => player != null).map((player) => player.id).toList()};

    saveContestEntryFromJson(_getKeyForCurrentUserContest, JSON.encode(data));
  }

  void restoreContestEntry() {
    if (GameInfo.contains(_getKeyForCurrentUserContest)) {
      // print ("localStorage: key: " + _getKeyForCurrentUserContest + ": " + GameInfo.get(_getKeyForCurrentUserContest));
      Map loadedData = JSON.decode(GameInfo.get(_getKeyForCurrentUserContest));

     _isRestoringTeam = true;
     formationId = loadedData['formation'];
     List loadedLineup = loadedData['lineupSlots'];
     loadedLineup.forEach((id) {
       addSoccerPlayerToLineup(id);
     });
     _isRestoringTeam = false;
     _verifyMaxPlayersInSameTeam();
    }
  }

  void alertNotBuy(Money coins) {
    modalShow(
      "",
      '''
      <div class="content-wrapper">
        <h1 class="alert-content-title">${getLocalizedText("alert-no-gold-to-buy-message")}</h1>
        <div class="gold-needed-icon-wrapper">
          <img class="gold-image" src="images/EpicCoinModales.png">
          <span class="not-enough-resources-count">${coins}</span>
        </div>
        <h2 class="alert-content-subtitle">${getLocalizedText('alert-user-gold-message', substitutions:{'MONEY': playerGold})}<span class="gold-icon-tiny"></span></h2>
      </div>
      '''
      , onBackdropClick: true
      , aditionalClass: "noGold"
    )
    .then((_) {
      _tutorialService.triggerEnter("alert-not-buy");
    });
  }

  void alertNotEnoughResources() {
    /*modalShow(
      "",
      (contest.entryFee.isEnergy ? alertNotEnoughEnergyContent() : alertNotEnoughGoldContent()),
      onOk: contest.entryFee.isEnergy ? getLocalizedText('buy-energy-button') : getLocalizedText("buy-gold-button"),
      onBackdropClick: true,
      closeButton:true
    )*/
    if (contest.entryFee.isEnergy) alertNotEnoughEnergyContent(); else alertNotEnoughGoldContent();
    
    /*(contest.entryFee.isEnergy ? alertNotEnoughEnergyContent() : alertNotEnoughGoldContent())
    .then((_) {
      // Registramos dónde tendría que navegar al tener éxito en "add_funds"
      GameInfo.assign(contest.entryFee.isEnergy ? "add_energy_success" : "add_gold_success", window.location.href);

      _router.go('shop.buy', {});
    });*/

    _tutorialService.triggerEnter("alert-not-enough-resources");
  }

  void alertNotEnoughGoldContent() {
    joiningErrorText = getLocalizedText("alert-no-gold-message");
    /*return modalShow(
          ""
          , '''
          <div class="content-wrapper">
            <h1 class="alert-content-title">${getLocalizedText("alert-no-gold-message")}</h1>
            <div class="gold-needed-icon-wrapper">
              <img class="gold-image" src="images/EpicCoinModales.png">
              <span class="not-enough-resources-count">${coinsNeeded}</span>
            </div>
            <h2 class="alert-content-subtitle">${getLocalizedText('alert-user-gold-message', substitutions:{'MONEY': playerGold})}<span class="gold-icon-tiny"></span></h2>
          </div>
          '''
          , onOk: getLocalizedText("buy-gold-button")
          , onBackdropClick: TutorialService.isActivated
          , closeButton: true
          , aditionalClass: "noGold"
        );
    */
  }

  void alertNotEnoughEnergyContent() {
    joiningErrorText = getLocalizedText("alert-no-energy-message_1");
    /*return modalShow(
          ""
          , '''
          <div class="content-wrapper">
            <h1 class="alert-content-title">${getLocalizedText("alert-no-energy-message_1")}</h1>
            <div class="gold-needed-icon-wrapper">
              <img class="gold-image" src="images/IconEnergyXL.png">
              <span class="not-enough-resources-count">${moneyNeeded.toInt()}</span>
            </div>
            <h2 class="alert-content-subtitle">${getLocalizedText("alert-no-energy-message_2", substitutions:{'ENERGY': playerEnergy})}<span class="energy-icon-tiny"></span></h2>
          </div>
          '''
          , onOk: getLocalizedText('buy-energy-button')
          , onBackdropClick: TutorialService.isActivated
          , closeButton: true
          , aditionalClass: "noGold"
        );*/
    /*return '''
    <div class="content-wrapper">
      <img class="main-image" src="images/iconNoEnergy.png">
      <div class="energy-bar-wrapper">
        <div class="progress">
          <div class="progress-bar" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="${User.MAX_ENERGY}" style="width:${_profileService.user.Energy * 100 / User.MAX_ENERGY}%"></div>
        </div>
      </div>
      <p class="content-text">${getLocalizedText("alert-no-energy-message")}</p>
    </div>
    ''';*/
  }

  String getConfirmButtonText() {
    if (contest == null || (contest.entryFee.isEnergy && editingContestEntry)) return getLocalizedText("buttoncontinue");

    Money cost = contest.entryFee.isEnergy? contest.entryFee : coinsNeeded;
    return'${getLocalizedText("buttoncontinue")}: <span class="confirm-cost ${cost.isEnergy? "energy": "coins"}">${cost.amount.toInt()}</span>';
  }
  
  void inviteFriends() {
    GameMetrics.contestActionEvent(GameMetrics.ACTION_INVITE_FRIENDS, metricsScreenName, contest);
    JsUtils.runJavascript(null, "socialShare", ["Apuntate al torneo","${HostServer.domain}/sec?contestId=${contest.contestId}"]);
  }

  String get _getKeyForCurrentUserContest => (_profileService.isLoggedIn ? _profileService.user.userId : 'guest') + '#' + contest.optaCompetitionId;

  Router _router;
  RouteProvider _routeProvider;
  String _parent;

  TutorialService _tutorialService;
  ContestsService _contestsService;
  ProfileService _profileService;
  CatalogService _catalogService;
  FlashMessagesService _flashMessage;

  var _streamListener;
  ElementList<dynamic> _totalSalaryTexts;

  Timer _retryOpTimer;

  RouteHandle _routeHandle;

  bool _teamConfirmed = false;
  bool _isRestoringTeam = false;

  Element _rootElement;
  Element alertMaxplayerInSameTeam;
  AppStateService _appStateService;
  List<AppSecondaryTabBarTab> _tabList = [];
}