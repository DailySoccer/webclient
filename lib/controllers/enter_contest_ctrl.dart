library enter_contest_ctrl;


import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/utils/string_utils.dart';

@Controller(
    selector: '[enter-contest-ctrl]',
    publishAs: 'ctrl'
)
class EnterContestCtrl implements DetachAware{

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  String get ALL_MATCHES => "all";

  ScreenDetectorService scrDet;

  Contest contest;

  bool isSelectingSoccerPlayer = false;

  final List<dynamic> lineupSlots = [];
  List<dynamic> availableSoccerPlayers = [];
  List<Map<String, String>> availableMatchEvents = [];

  String selectedSoccerPlayerId;

  int availableSalary = 0;

  String nameFilter;

  EnterContestCtrl(RouteProvider routeProvider, this._router, this.scrDet, this._profileService, this._activeContestService, this._myContestService, this._flashMessage) {

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });

    _editingContestEntry = (routeProvider.route.parameters['contestEntryId'] != null);

    //Nos subscribimos al evento de cambio de tamañano de ventana
    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));

    _activeContestService.refreshContest(routeProvider.route.parameters['contestId'])
      .then((_) {
        contest = _activeContestService.lastContest;

        // Al principio, todos disponibles
        initAllSoccerPlayers();
        availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);

        // Saldo disponible
        availableSalary = contest.templateContest.salaryCap;

        // Si nos viene el torneo para editar la alineación
        if (_editingContestEntry) {
          _contestEntryId = routeProvider.route.parameters['contestEntryId'];
          if (_contestEntryId != null) {
            ContestEntry contestEntry = _myContestService.lastContest.getContestEntry(_contestEntryId);
            // Insertamos en el lineup el jugador
            contestEntry.soccers.forEach((soccer) {
              onSoccerPlayerSelected(_allSoccerPlayers.firstWhere((slot) => slot["id"] == soccer.templateSoccerPlayerId));
            });
          }
        }

        // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
        sortListByField('Pos', invert: false);
      })
      .catchError((error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      });
  }

  void detach() {
    _streamListener.cancel();
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".enter-contest-wrapper .tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

    Element matchesFilter = document.querySelector('.match-teams-filter');
    if(tab == "contest-info-tab-content"){
      matchesFilter.style.display = "none";
    }
    else
    {
      matchesFilter.style.display = "block";
    }

  }

  void onScreenWidthChange(String value) {
    // Resetamos todos los filtros
    removeAllFilters();
    // Cuando se inicializa la lista de jugadores, esta se ordena por posicion
    sortListByField("Pos", invert: false);
    // Para que en la versión móvil aparezca la pantalla de lineup
    isSelectingSoccerPlayer = false;
    if(value == "desktop" || value == "sm") {
      Element matchesFilter = document.querySelector('.match-teams-filter');
      if(matchesFilter != null) {
        matchesFilter.style.display = "block";
      }
      if(value == "desktop") {
        // Reseteo las pestañas
        List<dynamic> allTabs = document.querySelectorAll(".enter-contest-tabs li");
        allTabs.forEach((element) => element.classes.remove('active'));
        allTabs[0].classes.add('active');
      }
    }
    else {
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
      if(availableSalary >= 0) {
        alertDismiss();
      }

    }
    else {
      isSelectingSoccerPlayer = true;
      setFieldPosFilter(new FieldPos(FieldPos.LINEUP[slotIndex]));
    }
  }

  void updateTextAvailableSalary(String availableSalaryText) {
    List<SpanElement> totalSalary = querySelectorAll(".total-salary-money");

    totalSalary.forEach((element) {
      element.text = availableSalaryText + "€";
      if(int.parse(availableSalaryText) < 0) {
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
    bool wasAdded = false;
    wasAdded = tryToAddSoccerPlayer(soccerPlayer);

    if(wasAdded) {
      // Comprobar cuantos jugadores me quedan por añadir de esa posicion
      //isSelectingSoccerPlayer = availableSoccerPlayer(soccerPlayer);
      isSelectingSoccerPlayer = false;
      availableSoccerPlayers.remove(soccerPlayer);
      calculateAvailableSalary(soccerPlayer["salary"]);
    }
  }

  void setPosFilterClass(String abrevPosition) {
    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-position");
    buttonsFilter.forEach((element) {
      element.classes.remove("active");
      if(element.text == abrevPosition) {
        element.classes.add("active");
      }
    });
  }

  void setFieldPosFilter(FieldPos filter) {
    if (filter == null) {
      removeFilter(FILTER_POSITION);
      setPosFilterClass('TODOS');
    }
    else {
      addFilter(FILTER_POSITION, filter.abrevName);
      setPosFilterClass(filter.abrevName);
    }
  }

  void refreshNameFilter() {
    addFilter(FILTER_NAME, nameFilter);
  }

  void setMatchFilterClass(String buttonId) {
    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-team");
    buttonsFilter.forEach((element) {
      element.classes.remove('active');
    });
    List<ButtonElement> button = querySelectorAll("#match-$buttonId");
    button.forEach((element) => element.classes.add("active"));
  }

  void setMatchFilter(String matchId) {
    setMatchFilterClass(matchId);
    if(matchId == ALL_MATCHES) {
        removeFilter(FILTER_MATCH);
        return;
    }
    addFilter(FILTER_MATCH, matchId);
  }

  void removeFilter(String filterName) {
    _filterList.remove(filterName);
    _refreshFilter();
  }

  void addFilter(String key, String valor) {
    _filterList[key] = valor;
    _refreshFilter();
  }

  void _refreshFilter() {
    if (_filterList.isEmpty && availableSoccerPlayers.length == _allSoccerPlayers.length)
      return;

    // Partimos siempre de la lista original de todos los players menos los seleccionados
    availableSoccerPlayers = _allSoccerPlayers.where( (soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();

    //Recorremos la lista de filtros
    _filterList.forEach( (String clave, String valor )  {

      switch(clave)
      {
        case FILTER_POSITION:
          availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"].abrevName == valor && !lineupSlots.contains(soccerPlayer)).toList();
        break;
        case FILTER_NAME:
          availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fullName"].toUpperCase().contains(valor.toUpperCase())).toList();
        break;
        case FILTER_MATCH:
          availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["matchId"].toString() == valor).toList();
        break;
      }
    });
    _refreshOrder();
  }

  void sortListByField(String fieldName, {bool invert : true}) {
    if (fieldName != _sortField) {
      _sortDir = false;
      _sortField = fieldName;
    }
    else if (invert) {
      _sortDir = !_sortDir;
    }
    _refreshOrder();
  }

  void _refreshOrder() {
    switch(_sortField)
      {
        case "Pos":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? player2["fieldPos"].sortOrder - player1["fieldPos"].sortOrder :
                                                                      player1["fieldPos"].sortOrder - player2["fieldPos"].sortOrder);
        break;
        case "Name":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? compareNameTo(player2, player1) : compareNameTo(player1, player2));
        break;
        case "DFP":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? player2["fantasyPoints"].compareTo(player1["fantasyPoints"]) :
                                                                      player1["fantasyPoints"].compareTo(player2["fantasyPoints"]));
        break;
        case "Played":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? player2["playedMatches"].compareTo(player1["playedMatches"]) :
                                                                      player1["playedMatches"].compareTo(player2["playedMatches"]));
        break;
        case "Salary":
          availableSoccerPlayers.sort((player1, player2) => _sortDir? player2["salary"].compareTo(player1["salary"]) :
                                                                      player1["salary"].compareTo(player2["salary"]));
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

  void _insertSoccerPlayer(MatchEvent matchEvent, SoccerTeam soccerTeam, SoccerPlayer soccerPlayer) {
    String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
    String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
    var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
        ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
        : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

    _allSoccerPlayers.add({
      "id": soccerPlayer.templateSoccerPlayerId,
      "fieldPos": soccerPlayer.fieldPos,
      "fullName": soccerPlayer.name,
      "matchId" : matchEvent.templateMatchEventId,
      "matchEventName": matchEventName,
      "remainingMatchTime": "70 MIN",
      "fantasyPoints": soccerPlayer.fantasyPoints,
      "playedMatches": soccerPlayer.playedMatches,
      "salary": soccerPlayer.salary
    });
  }

  void initAllSoccerPlayers() {
    List<MatchEvent> matchEvents = contest.templateContest.matchEvents;

    for (var matchEvent in matchEvents) {
      for (var player in matchEvent.soccerTeamA.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamA, player);
      }

      for (var player in matchEvent.soccerTeamB.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamB, player);
      }

      // generamos los partidos para el filtro de partidos
      availableMatchEvents.clear();
      for (MatchEvent match in matchEvents) {
        availableMatchEvents.add({
            "id": match.templateMatchEventId,
              "texto":match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate)
          });
      }
    }
  }

  void alertDismiss() {
    (querySelector(".alert-red-numbers") as DivElement).classes.remove('active');
  }

  void createFantasyTeam() {
    if (availableSalary < 0) {
      (querySelector(".alert-red-numbers") as DivElement).classes.add('active');
      return;
    }

    // TODO: Se tendría que redireccionar a la pantalla de hacer "Login"?
    if (!_profileService.isLoggedIn) {
      _router.go('login', {});
      return;
    }

    print("createFantasyTeam");
    lineupSlots.forEach((player) => print(player["fieldPos"].abrevName + ": " + player["fullName"] + " : " + player["id"]));

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    if (_editingContestEntry) {
      _myContestService.editContestEntry(_contestEntryId, lineupSlots.map((player) => player["id"]).toList())
        .then((_) => _router.go('view_contest_entry', {"contestId" : contest.contestId, "parent" : "edit"}))
        .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
    }
    else {
      _activeContestService.addContestEntry(contest.contestId, lineupSlots.map((player) => player["id"]).toList())
        .then((_) => _router.go('view_contest_entry', {"contestId" : contest.contestId, "parent" : "lobby"}))
        .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
    }
  }

  bool isFantasyTeamValid() {
    for (dynamic player in lineupSlots) {
      if (player == null) {
        return false;
      }
    }
    /* DEBUG ONLY*/
    //lineupSlots = {};
    return true;
  }

  void removeAllFilters() {
    setPosFilterClass('TODOS');
    setMatchFilterClass(ALL_MATCHES);
    InputElement txtfilterByName = querySelector(".name-player-input-filter");
    if (txtfilterByName != null)
        txtfilterByName.value = "";
    _filterList={};
    _refreshFilter();
  }

  void deleteFantasyTeam() {
    for (int i = 0; i < lineupSlots.length; ++i) {
      lineupSlots[i] = null;
    }
    // Reseteamos la lista para que aparezcan todos los jugadores borrados otra vez en la lista de disponibles
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);
    // Reseteamos el salario disponible
    availableSalary = contest.templateContest.salaryCap;
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
    // Permitimos añadir el juador solo en el caso de que exista hueco en el lineup (disabilitamos el botón de añadir)
    var selectedSoccerPlayer = availableSoccerPlayers.firstWhere(
            (soccerPlayer) => soccerPlayer["id"] == soccerPlayerId,
            orElse: () => null);
    if(selectedSoccerPlayer != null) {
      List<ButtonElement> btnAdd = querySelectorAll('.btn-add-soccer-player-info');
      if (availableSoccerPlayer(selectedSoccerPlayer))
        btnAdd.forEach((element) => element.disabled = false);
      else
        btnAdd.forEach((element) => element.disabled = true);
    }

    selectedSoccerPlayerId = soccerPlayerId;

    // Version Small or Desktop => sacamos la modal
    if(scrDet.isSmScreen || scrDet.isDesktop) {

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
    var selectedSoccerPlayer = availableSoccerPlayers.firstWhere(
        (soccerPlayer) => soccerPlayer["id"] == soccerPlayerId,
        orElse: () => null);
    if(selectedSoccerPlayer != null) {
      //Añado el jugador
      onSoccerPlayerSelected(selectedSoccerPlayer);
    }
    if(scrDet.isSmScreen || scrDet.isDesktop) {
      // hacemos una llamada de jQuery para ocultar la ventana modal
      JsUtils.runJavascript('#infoContestModal', 'modal', 'hide');
    }
    else
      closePlayerInfo();
  }

  String getMyTotalSalaryClasses() {
    String clases = "total-salary-money";
    if(availableSalary < 0)
      clases = "total-salary-money red-numbers";

    return clases;
  }

  List<dynamic> _allSoccerPlayers = new List();
  bool _sortDir = false;
  String _sortField = "";
  int _selectedLineupPosIndex = 0;
  bool _editingContestEntry = false;
  String _contestEntryId = null;

  Router _router;
  ActiveContestsService _activeContestService;
  MyContestsService _myContestService;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
  // Lista de filtros a aplicar
  Map<String,String> _filterList = {};
  var _streamListener;


}
