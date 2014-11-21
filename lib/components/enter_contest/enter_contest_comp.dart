library enter_contest_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/connection_error.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/game_metrics.dart';


@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest/enter_contest_comp.html',
    useShadowDom: false
)
class EnterContestComp implements DetachAware {

  ScreenDetectorService scrDet;
  LoadingService loadingService;

  Contest contest;
  String contestId;
  String contestEntryId;

  List<dynamic> allSoccerPlayers;
  List<dynamic> lineupSlots;

  FieldPos fieldPosFilter;
  String nameFilter;
  String matchFilter;

  bool isSelectingSoccerPlayer = false;
  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  int get theAvailableSalary {
   // Poner el fondo de las cajas de version movil en rojo si estoy en numeros rojos.
    _totalSalaryTexts = scrDet.isXsScreen? querySelectorAll('.total-salary') : querySelectorAll('.total-salary .total-salary-money');

    _totalSalaryTexts.forEach( (element) { updateRedNumbers(element);});
    /*if (_totalSalaryTexts != null && _totalSalaryTexts.isNotEmpty) {
      updateRedNumbers(_totalSalaryTexts);
    }*/
    return _availableSalary;
  }

  void updateRedNumbers(elem) {
    if (_availableSalary < 0)
    {
      if (!elem.classes.contains('red-numbers')) {
        elem.classes.add('red-numbers');
      }
    }
    else {
      if (elem.classes.contains('red-numbers')) {
        elem.classes.remove('red-numbers');
      }
    }
  }

  bool get isInvalidFantasyTeam => lineupSlots.any((player) => player == null);
  bool get editingContestEntry => contestEntryId != "none";

  bool contestInfoFirstTimeActivation = false;  // Optimizacion para no compilar el contest_info hasta que no sea visible la primera vez

  EnterContestComp(this._routeProvider, this._router, this.scrDet, this._contestsService, this._flashMessage, this.loadingService) {
    loadingService.isLoading = true;

    resetLineup();

    contestId = _routeProvider.route.parameters['contestId'];
    contestEntryId = _routeProvider.route.parameters['contestEntryId'];

    GameMetrics.logEvent(GameMetrics.ENTER_CONTEST);

    Future refreshContest = editingContestEntry? _contestsService.refreshMyContest(contestId) : _contestsService.refreshPublicContest(contestId);
    refreshContest
      .then((_) {
        loadingService.isLoading = false;

        contest = _contestsService.lastContest;
        _availableSalary = contest.salaryCap;

        initAllSoccerPlayers();

        // Si nos viene el torneo para editar la alineación
        if (editingContestEntry) {
          ContestEntry contestEntry = contest.getContestEntry(contestEntryId);

          // Insertamos en el lineup el jugador
          contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
            addSoccerPlayerToLineup(instanceSoccerPlayer.id);
          });
        }
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });

    _routeHandle = _routeProvider.route.newHandle();
    _routeHandle.onPreLeave.listen((RoutePreLeaveEvent event) {
      event.route.dontLeaveOnParamChanges;
      //bool decision = window.confirm('Estas seguro que quieres salir? Si pulsas en aceptar perderas los cambios realizados en esta alineación y abandonaras el torneo.');
      //event.allowLeave(new Future.value(decision));
    });
  }

  void resetLineup() {
    lineupSlots = new List<dynamic>();

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });
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
      _availableSalary += lineupSlots[slotIndex]["salary"];

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Quitamos la modal de números rojos si ya hay salario disponible
      if (_availableSalary >= 0) {
        alertDismiss();
      }
    }
    else {
      isSelectingSoccerPlayer = true;

      scrollToElement('.enter-contest-tabs', scrDet.isXsScreen);

      // Cuando seleccionan un slot del lineup cambiamos siempre el filtro de la soccer-player-list, especialmente
      // en movil que cambiamos de vista a "solo ella".
      // El componente hijo se entera de que le hemos cambiado el filtro a traves del two-way binding.
      fieldPosFilter = new FieldPos(FieldPos.LINEUP[slotIndex]);
    }
  }

  void addSoccerPlayerToLineup(String soccerPlayerId) {
    _tryToAddSoccerPlayerToLineup(allSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId));
  }

  void onSoccerPlayerActionButton(var soccerPlayer) {

    int indexOfPlayer = lineupSlots.indexOf(soccerPlayer);
    if (indexOfPlayer != -1) {
      onLineupSlotSelected(indexOfPlayer);  // Esto se encarga de quitarlo del lineup
    }
    else {
      _tryToAddSoccerPlayerToLineup(soccerPlayer);
    }
  }

  void _tryToAddSoccerPlayerToLineup(var soccerPlayer) {
    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];

    for (int c = 0; c < lineupSlots.length; ++c) {
       if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.value) {

         lineupSlots[c] = soccerPlayer;

         isSelectingSoccerPlayer = false;
         _availableSalary -= soccerPlayer["salary"];
         nameFilter = null;
         scrollToElement('.enter-contest-tabs', scrDet.isXsScreen);

         break;
       }
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
      if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.value)
        return true;
    }
    return false;
  }

  void initAllSoccerPlayers() {

    int intId = 0;
    allSoccerPlayers = new List<dynamic>();

    contest.instanceSoccerPlayers.forEach((templateSoccerId, instanceSoccerPlayer) {
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

  void alertDismiss() {
    (querySelector(".alert-red-numbers") as DivElement).classes.remove('active');
  }

  void createFantasyTeam() {
    if (_availableSalary < 0) {
      (querySelector(".alert-red-numbers") as DivElement).classes.add('active');
      return;
    }

    // No permitimos la reentrada de la solicitud (hasta que termine el timer de espera para volver a reintentarlo)
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      return;
    }

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    if (editingContestEntry) {
      _contestsService.editContestEntry(contestEntryId, lineupSlots.map((player) => player["id"]).toList())
        .then((_) => _router.go('view_contest_entry', {
                                        "contestId": contest.contestId,
                                        "parent": _routeProvider.parameters["parent"],
                                        "viewContestEntryMode": "edited"
                                        }))
        .catchError((error) => _errorCreating);
    }
    else {
      _contestsService.addContestEntry(contest.contestId, lineupSlots.map((player) => player["id"]).toList())
        .then((contestId) {
          GameMetrics.logEvent(GameMetrics.TEAM_CREATED);
          _router.go('view_contest_entry', {
                              "contestId": contestId,
                              "parent": _routeProvider.parameters["parent"],
                              "viewContestEntryMode": contestId == contest.contestId? "created" : "swapped"
                               });
        })
        .catchError((error) => _errorCreating);
    }
  }

  void _errorCreating(ConnectionError error) {
    if (error.isRetryOpError) {
      _retryOpTimer = new Timer(const Duration(seconds:3), () => createFantasyTeam());
    }
    else {
      _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
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
    _availableSalary = contest.salaryCap;
    alertDismiss();
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
  }

  void onRowClick(String soccerPlayerId) {
    _router.go("enter_contest.soccer_player_info",  { "instanceSoccerPlayerId": soccerPlayerId });
  }

  void scrollToElement(String selector, bool bResolutionFilter) {
    if (bResolutionFilter) {
      window.scrollTo(0, querySelector(selector).offsetTop);
    }
  }

  int _availableSalary = 0;

  Router _router;
  RouteProvider _routeProvider;

  ContestsService _contestsService;
  FlashMessagesService _flashMessage;

  var _streamListener;
  ElementList<dynamic> _totalSalaryTexts;

  Timer _retryOpTimer;
  RouteHandle _routeHandle;
}