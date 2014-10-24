library enter_contest_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import "package:json_object/json_object.dart";
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/field_pos.dart';
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'enter-contest',
    templateUrl: 'packages/webclient/components/enter_contest/enter_contest_comp.html',
    useShadowDom: false
)
class EnterContestComp implements DetachAware {

  static final String ERROR_RETRY_OP = "ERROR_RETRY_OP";

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  ScreenDetectorService scrDet;

  Contest contest;
  String contestEntryId = null;

  bool isSelectingSoccerPlayer = false;

  final List<dynamic> lineupSlots = [];
  List<dynamic> availableSoccerPlayers = [];

  InstanceSoccerPlayer selectedInstanceSoccerPlayer;

  int availableSalary = 0;

  bool get isLoaded => !LoadingService.enabled;
  bool get isBigScreenVersion   => scrDet.isSmScreen || scrDet.isDesktop;
  bool get isSmallScreenVersion => !isBigScreenVersion;


  EnterContestComp(this._routeProvider, this._router, this.scrDet, this._activeContestService, this._myContestService, this._flashMessage) {
    LoadingService.enabled = true;

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });

    _editingContestEntry = (_routeProvider.route.parameters['contestEntryId'] != null);

    // Nos subscribimos al evento de cambio de tamañano de ventana
    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));

    Future refreshContest = _editingContestEntry
        ? _myContestService.refreshMyContest(_routeProvider.route.parameters['contestId'])
        : _activeContestService.refreshContest(_routeProvider.route.parameters['contestId']);

    refreshContest
      .then((_) {
        LoadingService.enabled = false;

        contest = _editingContestEntry ? _myContestService.lastContest : _activeContestService.lastContest;

        // Al principio, todos disponibles
        availableSoccerPlayers = initAllSoccerPlayers();

        // Saldo disponible
        availableSalary = contest.salaryCap;

        // Si nos viene el torneo para editar la alineación
        if (_editingContestEntry) {
          contestEntryId = _routeProvider.route.parameters['contestEntryId'];

          ContestEntry contestEntry = _myContestService.lastContest.getContestEntry(contestEntryId);

          // Insertamos en el lineup el jugador
          contestEntry.instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
            onSoccerPlayerSelected(_allSoccerPlayers.firstWhere((slot) => slot["id"] == instanceSoccerPlayer.id));
          });
        }

        // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
        sortListByField('Pos', invert: false);
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  void detach() {
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      _retryOpTimer.cancel();
    }
    _streamListener.cancel();
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".enter-contest-wrapper .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void onScreenWidthChange(String value) {

    // Resetamos todos los filtros
    removeAllFilters();

    // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
    sortListByField("Pos", invert: false);

    // Para que en la versión móvil aparezca la pantalla de lineup
    isSelectingSoccerPlayer = false;

    if (value == "desktop") {
        // Reseteo las pestañas
        List<dynamic> allTabs = document.querySelectorAll(".enter-contest-tabs li");
        allTabs.forEach((element) => element.classes.remove('active'));
        allTabs[0].classes.add('active');
    }
    else if (value != "sm") {
      // hacemos una llamada de jQuery para ocultar la ventana modal
      JsUtils.runJavascript('#infoContestModal','modal', 'hide');
      // Para cerrar el soccer player info una vez que cambiamos a otra resolución
      closePlayerInfo();
    }
  }

  void onSlotSelected(int slotIndex) {

    _selectedLineupPosIndex = slotIndex;

    if (lineupSlots[slotIndex] != null) {
      // Al borrar el jugador seleccionado en el lineup, sumamos su salario al total
      calculateAvailableSalary(-lineupSlots[slotIndex]["salary"]);

      isSelectingSoccerPlayer = false;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Refrescamos los filtros para volver a mostrarlo entre los disponibles
      _refreshFilter();

      // Quitamos la modal de números rojos si no hay salario disponible
      if (availableSalary >= 0) {
        alertDismiss();
      }
    }
    else {
      isSelectingSoccerPlayer = true;

      // Cuando seleccionan un slot del lineup cambiamos siempre el filtro de la soccer-player-list, especialmente
      // en movil que cambiamos de vista a "solo ella".
      // El componente hijo se entera de que le hemos cambiado el filtro a traves del two-way binding.
      fieldPosFilter = new FieldPos(FieldPos.LINEUP[slotIndex]);
    }
  }

  void updateTextAvailableSalary(String availableSalaryText) {
    List<SpanElement> totalSalary = querySelectorAll(".total-salary-money");

    totalSalary.forEach((element) {
      element.text = availableSalaryText + "€";
      if (int.parse(availableSalaryText) < 0) {
        element.classes.add("red-numbers");
      }
      else {
        element.classes.remove("red-numbers");
      }
    });
  }

  void calculateAvailableSalary(int soccerPrice) {
    availableSalary = availableSalary - soccerPrice;
    // Pintamos en la caja de texto el total
    updateTextAvailableSalary(availableSalary.toString());
  }

  void onSoccerPlayerSelected(var soccerPlayer) {
    bool wasAdded = tryToAddSoccerPlayer(soccerPlayer);

    if (wasAdded) {
      // Comprobar cuantos jugadores me quedan por añadir de esa posicion
      isSelectingSoccerPlayer = false;
      availableSoccerPlayers.remove(soccerPlayer);
      calculateAvailableSalary(soccerPlayer["salary"]);
    }
  }

  FieldPos get fieldPosFilter => new FieldPos(_filterList[FILTER_POSITION]);
  void     set fieldPosFilter(FieldPos fieldPos) => setFilter(FILTER_POSITION, fieldPos != null? fieldPos.value : null);

  String get nameFilter => _filterList[FILTER_NAME];
  void   set nameFilter(String val) => setFilter(FILTER_NAME, val);

  String get matchFilter => _filterList[FILTER_MATCH];
  void   set matchFilter(String matchId) => setFilter(FILTER_MATCH, matchId);

  void setFilter(String key, String valor) {
    _filterList[key] = valor;
    _refreshFilter();
  }

  void _refreshFilter() {
    if (_filterList.isEmpty && availableSoccerPlayers.length == _allSoccerPlayers.length)
      return;

    // Partimos siempre de la lista original de todos los players menos los ya seleccionados en el lineup
    availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();

    // Recorremos la lista de filtros y aplicamos los que no sean nulos
    _filterList.forEach((String clave, String valor) {
      if (valor != null) {
        switch(clave) {
          case FILTER_POSITION:
            availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"].value == valor && !lineupSlots.contains(soccerPlayer)).toList();
          break;
          case FILTER_NAME:
            availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fullName"].toUpperCase().contains(valor.toUpperCase())).toList();
          break;
          case FILTER_MATCH:
            availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["matchId"] == valor).toList();
          break;
        }
      }
    });
    _refreshOrder();
  }

  void sortListByField(String fieldName, {bool invert : true}) {
    if (fieldName != _primarySort) {
      _sortDir = false;
      _secondarySort = _primarySort;
      _primarySort = fieldName;
    }
    else if (invert) {
      _sortDir = !_sortDir;
    }
    _refreshOrder();
  }

  dynamic compare(String field, var playerA, var playerB) {
    int compResult;
    switch(field) {
      case "fieldPos":
        compResult = playerA["fieldPos"].sortOrder - playerB["fieldPos"].sortOrder;
      break;
      case "Name":
        compResult = compareNameTo(playerA, playerB);
      break;
      default:
        compResult = playerA[field].compareTo(playerB[field]);
      break;
    }

    if (_secondarySort != "" && compResult == 0) {
      switch(_secondarySort) {
        case "Pos":
          compResult = playerB["fieldPos"].sortOrder - playerA["fieldPos"].sortOrder;
        break;
        case "Name":
          compResult = compareNameTo(playerA, playerB);
        break;
        case "DFP":
          compResult = playerA["fantasyPoints"].compareTo(playerB["fantasyPoints"]);
        break;
        case "Played":
          compResult = playerA["playedMatches"].compareTo(playerB["playedMatches"]);
        break;
        case "Salary":
          compResult = playerA["salary"].compareTo(playerB["salary"]);
        break;
      }
    }
    return compResult;
  }

  void _refreshOrder() {
    switch(_primarySort)
      {
        case "Pos":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? compare("fieldPos", player2, player1) : compare("fieldPos", player1, player2));
        break;
        case "Name":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? compare("Name", player2, player1) : compare("Name", player1, player2));
        break;
        case "DFP":
          availableSoccerPlayers.sort((player1, player2) => !_sortDir? compare("fantasyPoints", player2, player1): compare("fantasyPoints", player1, player2));
        break;
        case "Played":
          availableSoccerPlayers.sort((player1, player2) => !_sortDir? compare("playedMatches", player2, player1): compare("playedMatches", player1, player2));
        break;
        case "Salary":
          availableSoccerPlayers.sort((player1, player2) => !_sortDir? compare("salary", player2, player1): compare("salary", player1, player2));
        break;
      }
  }


  int compareNameTo(playerA, playerB){
     int comp = StringUtils.normalize(playerA["fullName"]).compareTo(StringUtils.normalize(playerB["fullName"]));
     return comp != 0 ? comp : playerA["id"].compareTo(playerB["id"]);
   }

  bool availableSoccerPlayer(var soccerPlayer) {
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

  // Añade un futbolista a nuestro lineup si hay algun slot libre de su misma fieldPos. Retorna false si no pudo añadir
  bool tryToAddSoccerPlayer(var soccerPlayer) {

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];
    int c = 0;
    if (lineupSlots.contains(soccerPlayer)) {
      return false;
    }
    for ( ; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.value) {
        lineupSlots[c] = soccerPlayer;
        return true;
      }
    }

    return false;
  }

  List<dynamic> initAllSoccerPlayers() {
    contest.instanceSoccerPlayers.forEach((templateSoccerId, instanceSoccerPlayer) {
      _insertSoccerPlayer(instanceSoccerPlayer.soccerTeam.matchEvent, instanceSoccerPlayer.soccerTeam, instanceSoccerPlayer);
    });

    return new List<dynamic>.from(_allSoccerPlayers);
  }

  void _insertSoccerPlayer(MatchEvent matchEvent, SoccerTeam soccerTeam, InstanceSoccerPlayer instanceSoccerPlayer) {

    String shortNameTeamA = matchEvent.soccerTeamA.shortName;
    String shortNameTeamB = matchEvent.soccerTeamB.shortName;

    var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == matchEvent.soccerTeamA.templateSoccerTeamId)
         ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
         : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

    _allSoccerPlayers.add({
      "instanceSoccerPlayer": instanceSoccerPlayer,
      "id": instanceSoccerPlayer.id,
      "fieldPos": instanceSoccerPlayer.fieldPos,
      "fullName": instanceSoccerPlayer.soccerPlayer.name,
      "matchId" : matchEvent.templateMatchEventId,
      "matchEventName": matchEventName,
      "remainingMatchTime": "-",
      "fantasyPoints": instanceSoccerPlayer.soccerPlayer.fantasyPoints,
      "playedMatches": instanceSoccerPlayer.soccerPlayer.playedMatches,
      "salary": instanceSoccerPlayer.salary
    });
  }

  void alertDismiss() {
    (querySelector(".alert-red-numbers") as DivElement).classes.remove('active');
  }

  void createFantasyTeam() {
    if (availableSalary < 0) {
      (querySelector(".alert-red-numbers") as DivElement).classes.add('active');
      return;
    }

    // No permitimos la reentrada de la solicitud (hasta que termine el timer de espera para volver a reintentarlo)
    if (_retryOpTimer != null && _retryOpTimer.isActive) {
      return;
    }

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    if (_editingContestEntry) {
      _myContestService.editContestEntry(contestEntryId, lineupSlots.map((player) => player["id"]).toList())
        .then((_) => _router.go('view_contest_entry', {"contestId": contest.contestId, "parent":
                                                       _routeProvider.parameters["parent"],
                                                       "viewContestEntryMode": "edited"
                                                      }))
        .catchError((error) => _errorCreating(error));
    }
    else {
      _activeContestService.addContestEntry(contest.contestId, lineupSlots.map((player) => player["id"]).toList())
        .then((contestId) => _router.go('view_contest_entry', {"contestId": contestId,
                                        "parent": _routeProvider.parameters["parent"],
                                        "viewContestEntryMode": contestId == contest.contestId? "created" : "swapped"
                                         }))
        .catchError((error) => _errorCreating(error));
    }
  }

  void _errorCreating(JsonObject jsonObject) {
    if (jsonObject.containsKey("error")) {
      if (jsonObject.error.contains(ERROR_RETRY_OP)) {
        _retryOpTimer = new Timer(const Duration(seconds:3), () => createFantasyTeam());
      }
      else {
        _flashMessage.error("$jsonObject", context: FlashMessagesService.CONTEXT_VIEW);
      }
    }
  }

  bool isFantasyTeamValid() {
    for (dynamic player in lineupSlots) {
      if (player == null) {
        return false;
      }
    }

    return true;
  }

  void removeAllFilters() {
    fieldPosFilter = null;
    nameFilter = null;
    matchFilter = null;

    _filterList = {};
    _refreshFilter();
  }

  void deleteFantasyTeam() {

    for (int i = 0; i < lineupSlots.length; ++i) {
      lineupSlots[i] = null;
    }
    // Reseteamos la lista para que aparezcan todos los jugadores borrados otra vez en la lista de disponibles
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);

    // Reseteamos el salario disponible
    availableSalary = contest.salaryCap;
    updateTextAvailableSalary(availableSalary.toString());

    // Resetamos todos los filtros
    removeAllFilters();

    // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
    sortListByField("Pos", invert: false);

    // Quito la modal de alerta de números rojos
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

  void closePlayerInfo() {
    DivElement enterContestWrapper = querySelector('.enter-contest-wrapper');
    enterContestWrapper.style.display = "block";
    DivElement soccerPlayerInfoWrapper = querySelector('.soccer-player-info-wrapper');
    if (soccerPlayerInfoWrapper != null)
      soccerPlayerInfoWrapper.style.display = "none";
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(String soccerPlayerId) {
    // Permitimos añadir el jugador solo en el caso de que exista hueco en el lineup (disabilitamos el botón de añadir)
    var selectedSoccerPlayer = availableSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId,
                                                                 orElse: () => null);
    if (selectedSoccerPlayer != null) {
      List<ButtonElement> btnAdd = querySelectorAll('.btn-add-soccer-player-info');

      if (availableSoccerPlayer(selectedSoccerPlayer))
        btnAdd.forEach((element) => element.disabled = false);
      else
        btnAdd.forEach((element) => element.disabled = true);

      selectedInstanceSoccerPlayer = selectedSoccerPlayer["instanceSoccerPlayer"];
    }

    // Version Small or Desktop => sacamos la modal
    if (scrDet.isSmScreen || scrDet.isDesktop) {

      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";

      // Con esto llamamos a funciones de jQuery
      JsUtils.runJavascript('#infoContestModal', 'modal', null);
    }
    else { // Resto de versiones => mostramos el componente soccer_player_info_comp
      DivElement enterContestWrapper = querySelector('.enter-contest-wrapper');
      enterContestWrapper.style.display = "none";
      DivElement soccerPlayerInfoWrapper = querySelector('.soccer-player-info-wrapper');
      soccerPlayerInfoWrapper.style.display = "block";
    }
  }

  void addSoccerPlayerToLineup(String soccerPlayerId) {
    var selectedSoccerPlayer = availableSoccerPlayers.firstWhere((soccerPlayer) => soccerPlayer["id"] == soccerPlayerId,
                                                                 orElse: () => null);
    if (selectedSoccerPlayer != null) {
      onSoccerPlayerSelected(selectedSoccerPlayer);
    }

    if (scrDet.isSmScreen || scrDet.isDesktop) {
      JsUtils.runJavascript('#infoContestModal', 'modal', 'hide');
    }
    else {
      closePlayerInfo();
    }
  }

  String getMyTotalSalaryClasses() {

    String clases = null;

    if (availableSalary < 0)
      clases = "total-salary-money red-numbers";
    else
      clases = "total-salary-money";

    return clases;
  }

  Router _router;
  RouteProvider _routeProvider;

  ActiveContestsService _activeContestService;
  MyContestsService _myContestService;
  FlashMessagesService _flashMessage;

  List<dynamic> _allSoccerPlayers = new List();

  bool _sortDir = false;
  String _primarySort = "";
  String _secondarySort = "";

  int _selectedLineupPosIndex = 0;
  bool _editingContestEntry = false;

  // Lista de filtros a aplicar
  Map<String, String> _filterList = {};
  var _streamListener;

  Timer _retryOpTimer;
}
