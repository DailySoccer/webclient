library enter_contest_comp;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
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

@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest/enter_contest_comp.html',
    useShadowDom: false
)
class EnterContestComp implements DetachAware {

  static const String ERROR_RETRY_OP = "ERROR_RETRY_OP";
  static const String ERROR_CONTEST_NOT_ACTIVE = "ERROR_CONTEST_NOT_ACTIVE";
  static const String ERROR_USER_ALREADY_INCLUDED = "ERROR_USER_ALREADY_INCLUDED";
  static const String ERROR_USER_BALANCE_NEGATIVE = "ERROR_USER_BALANCE_NEGATIVE";
  static const String ERROR_MAX_PLAYERS_SAME_TEAM = "ERROR_MAX_PLAYERS_SAME_TEAM";

  // Errores de los que no tendríamos que informar
  static const String ERROR_CONTEST_INVALID = "ERROR_CONTEST_INVALID";
  static const String ERROR_CONTEST_FULL = "ERROR_CONTEST_FULL";
  static const String ERROR_FANTASY_TEAM_INCOMPLETE = "ERROR_FANTASY_TEAM_INCOMPLETE";
  static const String ERROR_SALARYCAP_INVALID = "ERROR_SALARYCAP_INVALID";
  static const String ERROR_FORMATION_INVALID = "ERROR_FORMATION_INVALID";
  static const String ERROR_OP_UNAUTHORIZED = "ERROR_OP_UNAUTHORIZED";
  static const String ERROR_CONTEST_ENTRY_INVALID = "ERROR_CONTEST_ENTRY_INVALID";

  ScreenDetectorService scrDet;
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

  List<dynamic> allSoccerPlayers;
  List<dynamic> lineupSlots;
  List<String> get lineupFormation => FieldPos.FORMATIONS[formationId];

  FieldPos fieldPosFilter;
  String nameFilter;
  String matchFilter;

  bool isSelectingSoccerPlayer = false;
  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  int availableSalary = 0;
  Money _coinsNeeded = new Money.from(Money.CURRENCY_GOLD, 0);
  Money get coinsNeeded {
    _coinsNeeded.amount = 0;
    num managerLevel = playerManagerLevel;
    lineupSlots
      .where((c) => c != null)
      .forEach( (c) =>
          _coinsNeeded.amount += c["instanceSoccerPlayer"].moneyToBuy(managerLevel).amount);

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

  String get printableAvailableSalary => StringUtils.parseSalary(availableSalary);

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

  num get playerManagerLevel =>
      (contest != null && contest.simulation) ? User.MAX_MANAGER_LEVEL : (_profileService.isLoggedIn ? _profileService.user.managerLevel : 0);

  int get playerGold => _profileService.isLoggedIn ? _profileService.user.Gold: 0;
  int get playerEnergy => _profileService.isLoggedIn ? _profileService.user.Energy : 0;

  List<String> lineupAlertList = [];

  Map<String, Map> errorMap;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "entercontest", substitutions);
  }

  String formatCurrency(String amount) {
    return StringUtils.formatCurrency(amount);
  }

  EnterContestComp(this._routeProvider, this._router, this.scrDet,
                   this._contestsService, this.loadingService, this._profileService, this._catalogService,
                   this._flashMessage, this._rootElement, this._tutorialService) {
    loadingService.isLoading = true;

    errorMap = {
      ERROR_CONTEST_NOT_ACTIVE: {
          "title"   : getLocalizedText("errorcontestnotactivetitle"),
          "generic" : getLocalizedText("errorcontestnotactivegeneric"),
          "editing" : getLocalizedText("errorcontestnotactiveediting")
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
      "_ERROR_DEFAULT_": {
          "title"   : getLocalizedText("errordefaulttitle"),
          "generic" : getLocalizedText("errordefaultgeneric"),
          "editing" : getLocalizedText("errordefaultediting")
      },
    };

    scrDet.scrollTo('#mainApp');

    resetLineup();

    _parent = _routeProvider.parameters["parent"];
    contestId = _routeProvider.route.parameters['contestId'];
    contestEntryId = _routeProvider.route.parameters['contestEntryId'];

    _tutorialService.triggerEnter("enter_contest", component: this);

    GameMetrics.logEvent(GameMetrics.ENTER_CONTEST);

    Future refreshContest = isCreatingContest
                              ? _contestsService.refreshMyCreateContest(contestId)
                              : editingContestEntry
                                ? _contestsService.refreshMyActiveContest(contestId)
                                : _contestsService.refreshActiveContest(contestId);
    refreshContest
      .then((_) {
        loadingService.isLoading = false;

        contest = _contestsService.lastContest;
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
            contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
              addSoccerPlayerToLineup(instanceSoccerPlayer.id);
            });
          }
        }
        else {
          // TODO: ¿Únicamente restauramos el contestEntry anteriormente registrado si estamos creando uno nuevo?
          restoreContestEntry();
        }
      })
      .catchError((ServerError error) {
        // Si estamos editando un contestEntry y el server nos indica un fallo (generalmente es porque el usuario "no tiene permiso"), nos saldremos de la pantalla
        if (editingContestEntry) {
          _router.go("lobby", {});
        }
        else {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }
      }, test: (error) => error is ServerError);

    subscribeToLeaveEvent();
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

  void resetLineup() {
    lineupSlots = new List.filled(lineupFormation.length, null);
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
      // Al borrar el jugador seleccionado en el lineup, sumamos su salario al total
      availableSalary += lineupSlots[slotIndex]["salary"];

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;
      //guardamos los cambios
      saveContestEntry();

      // Quitamos la modal de números rojos si ya hay salario disponible
      isNegativeBalance = availableSalary < 0;
    }
    else {
      isSelectingSoccerPlayer = true;
      scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
      // Cuando seleccionan un slot del lineup cambiamos siempre el filtro de la soccer-player-list, especialmente
      // en movil que cambiamos de vista a "solo ella".
      // El componente hijo se entera de que le hemos cambiado el filtro a traves del two-way binding.
      fieldPosFilter = new FieldPos(lineupFormation[slotIndex]);
    }

    _verifyMaxPlayersInSameTeam();
  }

  void addSoccerPlayerToLineup(String soccerPlayerId) {
    var soccerPlayer = allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId, orElse: () => null);
    if (soccerPlayer != null) {
      _tryToAddSoccerPlayerToLineup(soccerPlayer);
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
          if (cheapestValue == -1 || lineupSlots[c]["salary"] < cheapestValue){
            cheapestValue = lineupSlots[c]["salary"];
            cheapestIdx = c;
          }
        }
      }
      return cheapestIdx;
    }


    for (int c = 0; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] != null && lineupFormation[c] != lineupSlots[c]["fieldPos"].value) {
        // print(lineupSlots[c]["fieldPos"].value + " -ConflictoCon- " + lineupFormation[c]);
        var soccerPlayer = lineupSlots[c];
        int availablePosition = firstAvailablePosition(lineupSlots[c]["fieldPos"].value);
        // print("Posicion disponible: $availablePosition");

        if (availablePosition != -1) {
          onLineupSlotSelected(c);
          _tryToAddSoccerPlayerToLineup(soccerPlayer);
        } else {
          int cheapestIndex = cheapestByPosition(lineupSlots[c]["fieldPos"].value);
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

  void onSoccerPlayerActionButton(var soccerPlayer) {

    int indexOfPlayer = lineupSlots.indexOf(soccerPlayer);
    if (indexOfPlayer != -1) {
      onLineupSlotSelected(indexOfPlayer);  // Esto se encarga de quitarlo del lineup
    }
    else {
      _tryToAddSoccerPlayerToLineup(soccerPlayer);
    }
    _verifyMaxPlayersInSameTeam();
  }

  void _tryToAddSoccerPlayerToLineup(var soccerPlayer) {
    if (contest.entryFee.isGold && !_isRestoringTeam) {
      Money moneyToBuy = new Money.from(Money.CURRENCY_GOLD, soccerPlayer["instanceSoccerPlayer"].moneyToBuy(playerManagerLevel).amount);
      bool hasMoney = _profileService.isLoggedIn ? _profileService.user.hasMoney(moneyToBuy) : moneyToBuy.isZero;
      if (!hasMoney) {
        alertNotBuy(moneyToBuy);
        return;
      }
    }

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];

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
    }

    // Si ya no estamos en modo seleción, scrolleamos hasta la altura del dinero que nos queda disponible.
    if (!isSelectingSoccerPlayer) {
      scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
    }

    if(!_isRestoringTeam) {
      _verifyMaxPlayersInSameTeam();

      int playerInLineup = lineupSlots.where((player) => player != null).length;
      _tutorialService.triggerEnter("lineup-" + playerInLineup.toString(), activateIfNeeded: false);
    }
  }

  bool isSlotAvailableForSoccerPlayer(String soccerPlayerId) {
    if (soccerPlayerId == null || soccerPlayerId.isEmpty || allSoccerPlayers == null || allSoccerPlayers.isEmpty) {
      return false;
    }

    var soccerPlayer = allSoccerPlayers.firstWhere((sp) => sp["id"] == soccerPlayerId);

    FieldPos theFieldPos = soccerPlayer["fieldPos"];
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

    int intId = 0;
    allSoccerPlayers = new List<dynamic>();

    ContestEntry contestEntry = null;
    if (editingContestEntry) {
      contestEntry = contest.getContestEntry(contestEntryId);
    }


    contest.instanceSoccerPlayers.forEach((templateSoccerId, instanceSoccerPlayer) {

      if (contestEntry != null && contestEntry.isPurchased(instanceSoccerPlayer)) {
        instanceSoccerPlayer.level = 0;
      }

      MatchEvent matchEvent = instanceSoccerPlayer.soccerTeam.matchEvent;
      SoccerTeam soccerTeam = instanceSoccerPlayer.soccerTeam;

      String shortNameTeamA = matchEvent.soccerTeamA.shortName;
      String shortNameTeamB = matchEvent.soccerTeamB.shortName;

      var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == matchEvent.soccerTeamA.templateSoccerTeamId)
           ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
           : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

      allSoccerPlayers.add({
        "instanceSoccerPlayer": instanceSoccerPlayer,
        "id": instanceSoccerPlayer.id,
        "intId": intId++,
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
      });
    });
  }

  void createFantasyTeam() {
    if (isNegativeBalance)
      return;

    // No permitimos la reentrada de la solicitud (hasta que termine el timer de espera para volver a reintentarlo)
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      return;
    }

    // Actualizamos el contestEntry, independientemente que estemos editando o creando
    saveContestEntry();

    //TODO: Mostramos los IDs del fantasyTeam creado
    //print ("FantasyTeam: " + window.localStorage[_getKeyForCurrentUserContest]);

    if (!_profileService.isLoggedIn) {
      _router.go("enter_contest.join", {});
      return;
    }

    if (!enoughResourcesForEntryFee) {
      alertNotEnoughResources();
      return;

      /*
      // Registramos dónde tendría que navegar al tener éxito en "add_funds"
      window.localStorage["add_funds_success"] = window.location.href;
      _router.go("add_funds", {});
       */
    }

    if (editingContestEntry) {
      _contestsService.editContestEntry(contestEntryId, formationId, lineupSlots.map((player) => player["id"]).toList())
        .then((_) {
          _teamConfirmed = true;
          _router.go('view_contest_entry', { "contestId": contest.contestId,
                                             "parent": _routeProvider.parameters["parent"],
                                             "viewContestEntryMode": "edited"});
        })
        .catchError((ServerError error) => _errorCreating(error));
    }
    else {
        _contestsService.addContestEntry(contest.contestId, formationId, lineupSlots.map((player) => player["id"]).toList())
          .then((contestId) {
            GameMetrics.logEvent(GameMetrics.TEAM_CREATED);
            GameMetrics.identifyMixpanel(_profileService.user.email);
            GameMetrics.peopleSet({"Last Team Created": new DateTime.now()});
            GameMetrics.peopleSet({"Last Team Created (${contest.competitionType})": new DateTime.now()});
            GameMetrics.logEvent(GameMetrics.ENTRY_FEE, {"value": contest.entryFee.toString()});
            _teamConfirmed = true;

            if (isCreatingContest) {
              _router.go( 'view_contest_entry', {
                            "contestId": contestId,
                            "parent": "my_contests",
                            "section": "upcoming",
                            "viewContestEntryMode": contestId == contest.contestId? "created" : "swapped"
                });
            }
            else {
              _router.go( 'view_contest_entry', {
                            "contestId": contestId,
                            "parent": _routeProvider.parameters["parent"],
                            "viewContestEntryMode": contestId == contest.contestId? "created" : "swapped"
                });
            }
          })
          .catchError((ServerError error) => _errorCreating(error));
    }
  }

  void _errorCreating(ServerError error) {
    if (error.isRetryOpError) {
      _retryOpTimer = new Timer(const Duration(seconds:3), () => createFantasyTeam());
    }
    else if (error.responseError.contains(ERROR_USER_ALREADY_INCLUDED)) {
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
    for (dynamic player in lineupSlots) {
      if (player != null) {
        return false;
      }
    }
    return true;
  }

  void cancelPlayerSelection() {
    isSelectingSoccerPlayer = false;
    scrDet.scrollTo('.enter-contest-actions-wrapper', smooth: true, duration: 200, offset: -querySelector('#mainAppMenu').offsetHeight, ignoreInDesktop: true);
  }

  void onRowClick(String soccerPlayerId) {
    ModalComp.open(_router, "enter_contest.soccer_player_stats", { "instanceSoccerPlayerId":soccerPlayerId, "selectable":isSlotAvailableForSoccerPlayer(soccerPlayerId)}, addSoccerPlayerToLineup);
  }

  void _showMsgError(ServerError error) {
    String keyError = errorMap.keys.firstWhere( (key) => error.responseError.contains(key), orElse: () => "_ERROR_DEFAULT_" );
    modalShow(
        errorMap[keyError]["title"],
        (editingContestEntry && errorMap[keyError].containsKey("editing")) ? errorMap[keyError]["editing"] : errorMap[keyError]["generic"]
    )
    .then((resp) {
      if (keyError == ERROR_CONTEST_NOT_ACTIVE) {
        _router.go(_routeProvider.parameters["parent"], {});
      }
    });
  }

  void _verifyMaxPlayersInSameTeam() {
    playersInSameTeamInvalid = false;

    Map<String, int> playersInSameTeam = new Map<String, int>();

    lineupSlots.where((player) => player != null).forEach((player) {
      String key = player["instanceSoccerPlayer"].soccerTeam.templateSoccerTeamId;
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

  void saveContestEntryFromJson(String key, String json) {
    window.localStorage[key] = json;
  }

  void saveContestEntry() {
    // Lo almacenamos localStorage.
    Map data = { 'formation' :  formationId, 'lineupSlots' : lineupSlots.where((player) => player != null).map((player) => player["id"]).toList()};

    saveContestEntryFromJson(_getKeyForCurrentUserContest, JSON.encode(data));
  }

  void restoreContestEntry() {
    if (window.localStorage.containsKey(_getKeyForCurrentUserContest)) {
      // print ("localStorage: key: " + _getKeyForCurrentUserContest + ": " + window.localStorage[_getKeyForCurrentUserContest]);
      Map loadedData = JSON.decode(window.localStorage[_getKeyForCurrentUserContest]);

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
    (contest.entryFee.isEnergy ? alertNotEnoughEnergyContent() : alertNotEnoughGoldContent())
    .then((_) {
      // Registramos dónde tendría que navegar al tener éxito en "add_funds"
      window.localStorage[contest.entryFee.isEnergy ? "add_energy_success" : "add_gold_success"] = window.location.href;

      _router.go(contest.entryFee.isEnergy ? 'shop' : 'shop', {});
    });

    _tutorialService.triggerEnter("alert-not-enough-resources");
  }

  Future alertNotEnoughGoldContent() {
    return modalShow(
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
          , onBackdropClick: true
          , closeButton: false
          , aditionalClass: "noGold"
        );
  }

  Future alertNotEnoughEnergyContent() {
    return modalShow(
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
          , onBackdropClick: true
          , closeButton: false
          , aditionalClass: "noGold"
        );
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
  ScreenDetectorService _scrDet;

  RouteHandle _routeHandle;

  bool _teamConfirmed = false;
  bool _isRestoringTeam = false;

  Element _rootElement;
  Element alertMaxplayerInSameTeam;
}