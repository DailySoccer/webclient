library enter_contest_ctrl;


import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:js' as js;
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:intl/intl.dart';

@Controller(
    selector: '[enter-contest-ctrl]',
    publishAs: 'ctrl'
)
class EnterContestCtrl {

  static const String FILTER_POSITION = "FILTER_POSITION";
  static const String FILTER_NAME = "FILTER_NAME";
  static const String FILTER_MATCH = "FILTER_MATCH";

  ScreenDetectorService scrDet;

  Contest contest;

  bool isSelectingSoccerPlayer = false;

  final List<dynamic> lineupSlots = new List();
  List<dynamic> availableSoccerPlayers = new List();
  List<Map<String, String>> availableMatchEvents = [];

  String selectedSoccerPlayerId;

  int availableSalary;

  EnterContestCtrl(RouteProvider routeProvider, this._router, this.scrDet, this._profileService, this._contestService, this._flashMessage) {

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });

    contest = _contestService.getContestById(routeProvider.route.parameters['contestId']);

    // Al principio, todos disponibles
    initAllSoccerPlayers();
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);

    //Saldo disponible
    availableSalary = contest.templateContest.salaryCap;

    //Nos subscribimos al evento de cambio de tamañano de ventana
    scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
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
    if(value == "desktop") {
      Element matchesFilter = document.querySelector('.match-teams-filter');
      if(matchesFilter != null) {
        matchesFilter.style.display = "block";
        tabChange('lineup-tab-content');
      }
    }
  }

  void onSlotSelected(int slotIndex) {

    _selectedLineupPosIndex = slotIndex;

    if (lineupSlots[slotIndex] != null) {
      //Al borrar el jugador seleccionado en el lineup, sumamos su salario al total
      calculateAvailableSalary(-lineupSlots[slotIndex]["salary"]);

      isSelectingSoccerPlayer = false;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Reseteamos el filtro para volver a mostrarlo entre los disponibles
      setFieldPosFilter(null);

      //Quitamos la modal de números rojos si no hay salario disponible
      if(availableSalary >= 0) {
        alertDismiss();
      }

    } else {
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
      } else {
        element.classes.remove("red-numbers");
      }
    });
  }

  void calculateAvailableSalary(int soccerPrice) {
    availableSalary = availableSalary - soccerPrice;
    //Pintamos en la caja de texto el total
    updateTextAvailableSalary(availableSalary.toString());
  }

  void onSoccerPlayerSelected(var soccerPlayer) {

    if (isSelectingSoccerPlayer) {
      isSelectingSoccerPlayer = false;
      lineupSlots[_selectedLineupPosIndex] = soccerPlayer;
      //setFieldPosFilter(null);

      calculateAvailableSalary(soccerPlayer["salary"]);
    } else {
      bool wasAdded = tryToAddSoccerPlayer(soccerPlayer);

      if(wasAdded) {
        calculateAvailableSalary(soccerPlayer["salary"]);
      }

      if (wasAdded) availableSoccerPlayers.remove(soccerPlayer);
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
    if(filter == null) {
      removeFilter(FILTER_POSITION);
      setPosFilterClass('TODOS');
      return;
    }
    addFilter(FILTER_POSITION, filter.abrevName);
    setPosFilterClass(filter.abrevName);
  }

  void setNameFilter(String filter) {
    addFilter(FILTER_NAME, filter);
  }

  void setMatchFilterClass(String matchText) {

    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-team");
    buttonsFilter.forEach((element) {
      element.classes.remove('active');
      if(element.text.contains(matchText)) {
        element.classes.add("active");
      }
    });
  }
  void setMatchFilter(String matchId, String matchText) {
      if(matchId == "-1") {
          removeFilter(FILTER_MATCH);
          setMatchFilterClass("Todos");
          return;
      }
      addFilter(FILTER_MATCH, matchId);
      var firstWord = matchText.split('<br>')[0];
      setMatchFilterClass(firstWord);
    }

  void removeFilter(String filterName) {
    _filterList.remove(filterName);
    _refreshFilter();
  }

  void addFilter(String key, String valor) {
    //Si existew esta clave, la borramos
    if(_filterList.containsKey(key)) {
      _filterList.remove(key);
    }
    //Como no se actualiza en el componente lista al modificar los valores... hay que crear siempre la lista 'filterListClone 'de cero:
    //1-Creamos un mapa nuevo
    Map<String, String> _filterListClone = {};
    //2- El mapa nuevo lo iniciamos con los valores de filterList para que no sea una referencia
    _filterListClone.addAll(_filterList);
    //3-Creamos el nuevo filtro...
    Map<String, String> tmpMap = { key: valor };
    //... y lo añadimos a la lista temporal que tendrá los valores anteriores + este nuevo
    _filterListClone.addAll(tmpMap);
    //4-Por ultimo igualamos el filterList con el temporal que hemos construidos.
    _filterList = _filterListClone;

    //Refrescsamos los filtros
    _refreshFilter();
  }

  void _refreshFilter() {
    if (_filterList == null)
      return;

    //Partimos siempre de la lista original de todos los players
    availableSoccerPlayers = _allSoccerPlayers;

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
  }

  void shortListByField(String fieldName) {
    if(fieldName != _currentField) {
      _currentDir = 0;
      _currentField = fieldName;
    }
    else {
      _currentDir++;
      if(_currentDir >= _shortDir.length) {
        _currentDir = 0;
      }
    }
    _shortBy = fieldName + "_" + _shortDir[_currentDir];

    _refreshOrder();
  }

  void _refreshOrder() {
    if(_shortBy == null || _shortBy.isEmpty) {
      return;
    }
    List<String> params = _shortBy.split("_");

    switch(params[0])
      {
        case "Pos":
          availableSoccerPlayers.sort(( player1, player2) => (params[1] == "asc") ? player1["fieldPos"].abrevName.compareTo(player2["fieldPos"].abrevName):
                                                                                    player2["fieldPos"].abrevName.compareTo(player1["fieldPos"].abrevName) );
          break;
        case "Name":
          availableSoccerPlayers.sort(( soccerPlayer1, soccerPlayer2) => (params[1] == "asc") ? soccerPlayer1["fullName"].compareTo(soccerPlayer2["fullName"]):
                                                                                                soccerPlayer2["fullName"].compareTo(soccerPlayer1["fullName"]) );
          break;
        case "DFP":
          availableSoccerPlayers.sort(( soccerPlayer1, soccerPlayer2) => (params[1] == "asc") ? soccerPlayer1["fantasyPoints"].compareTo(soccerPlayer2["fantasyPoints"]):
                                                                                                soccerPlayer2["fantasyPoints"].compareTo(soccerPlayer1["fantasyPoints"]) );
          break;
        case "Played":
          availableSoccerPlayers.sort(( soccerPlayer1, soccerPlayer2) => (params[1] == "asc") ? soccerPlayer1["playedMatches"].compareTo(soccerPlayer2["playedMatches"]):
                                                                                                soccerPlayer2["playedMatches"].compareTo(soccerPlayer1["playedMatches"]) );
          break;
        case "Salary":
          availableSoccerPlayers.sort(( soccerPlayer1, soccerPlayer2) => (params[1] == "asc") ? soccerPlayer1["salary"].compareTo(soccerPlayer2["salary"]):
                                                                                                soccerPlayer2["salary"].compareTo(soccerPlayer1["salary"]) );
          break;
      }
  }

  // Añade un futbolista a nuestro lineup si hay algun slot libre de su misma fieldPos. Retorna false si no pudo añadir
  bool tryToAddSoccerPlayer(var soccerPlayer) {

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];
    int c = 0;

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
              "texto":match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + _timeDisplayFormat.format(match.startDate) + "h."
          });
      }
    }
  }

  void alertDismiss() {
    List<DivElement> alerta = querySelectorAll(".alert-red-numbers");
    alerta.forEach((element) => element.classes.remove('active'));
  }

  void createFantasyTeam() {
    // TODO: Se tendría que redireccionar a la pantalla de hacer "Login"?
    if (!_profileService.isLoggedIn) {
      _router.go('login', {});
      return;
    }

    if (availableSalary < 0) {
      List<DivElement> alerta = querySelectorAll(".alert-red-numbers");
      alerta.forEach((element) => element.classes.add('active'));
      return;
    }

    print("createFantasyTeam");
    lineupSlots.forEach((player) => print(player["fieldPos"].fieldPos + ": " + player["fullName"] + " : " + player["id"]));

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
    _contestService.addContestEntry(contest.contestId, lineupSlots.map((player) => player["id"]).toList())
      .then((_) => _router.go('lobby', {}))
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
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
    setPosFilterClass('TODOS');
    setMatchFilterClass('Todos los partidos');
    List<InputElement> nameInput = querySelectorAll(".name-player-input-filter");
    nameInput.forEach((element) => element.value = "");
    _filterList={};
    _refreshFilter();
  }

  void deleteFantasyTeam() {
    int i = 0;
    for ( ; i < lineupSlots.length; ++i) {
      lineupSlots[i] = null;
    }
    //Reseteamos la lista para que aparezcan todos los jugadores borrados otra vez en la lista de disponibles
    initAllSoccerPlayers();
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);
    //Reseteamos el salario disponible
    availableSalary = contest.templateContest.salaryCap;
    updateTextAvailableSalary(availableSalary.toString());
    //Resetamos todos los filtros
    removeAllFilters();
    //Quito la modal de alerta de números rojos
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

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(String soccerPlayerId) {
    selectedSoccerPlayerId = soccerPlayerId;

    // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
    var modal = querySelector('#infoContestModal');
    modal.style.display = "block";

    // Con esto llamamos a funciones de jQuery
    js.context.callMethod(r'$', ['#infoContestModal'])
      .callMethod('modal');
  }

  var _allSoccerPlayers = new List();
  List<String> _shortDir = ["asc", "desc"];
  int _currentDir = 0;
  String _currentField = "";
  int _selectedLineupPosIndex = 0;
  Router _router;
  ActiveContestsService _contestService;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
  DateFormat _timeDisplayFormat= new DateFormat("E, HH:mm", "es_ES");
  // Lista de filtros a aplicar
  Map<String,String> _filterList = {};
  // Ordenes
  String _shortBy;
}
