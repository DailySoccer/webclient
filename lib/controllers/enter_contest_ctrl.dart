library enter_contest_ctrl;


import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:js' as js;
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/template_match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:intl/intl.dart';

@Controller(
    selector: '[enter-contest-ctrl]',
    publishAs: 'ctrl'
)
class EnterContestCtrl {

  int availableSalary = 0;

  ScreenDetectorService scrDet;

  Contest contest;

  bool isDesktopVersion = false;
  bool isSelectingSoccerPlayer = false;
  FieldPos lastUsedPosFilter;
  String lastUsedNameFilter = "";
  String oldMatchValue = "-1";
  String currentContestId = "";

  final List<dynamic> lineupSlots = new List();
  List<dynamic> availableSoccerPlayers = new List();
  List<Map<String, String>> availableMatchEvents = [];

  String selectedSoccerPlayerId;

  DateFormat timeDisplayFormat= new DateFormat("HH:mm");

  EnterContestCtrl(RouteProvider routeProvider, this._router, this.scrDet, this._profileService, this._contestService, this._flashMessage) {

    // Creamos los slots iniciales, todos vacios
    FieldPos.LINEUP.forEach((pos) {
      lineupSlots.add(null);
    });

    currentContestId = routeProvider.route.parameters['contestId'];

    contest = _contestService.getContestById(currentContestId);

    // Al principio, todos disponibles
    initAllSoccerPlayers();
    availableSoccerPlayers = new List<dynamic>.from(_allSoccerPlayers);
  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void cleanTheFilters() {
    InputElement inputText = document.querySelector("#name-player-filter");
    inputText.value = "";
    lastUsedNameFilter = "";
  }

  void onSlotSelected(int slotIndex) {

    cleanTheFilters();

    _selectedLineupPosIndex = slotIndex;

    if (lineupSlots[slotIndex] != null) {
      isSelectingSoccerPlayer = false;

      // Lo quitamos del slot
      lineupSlots[slotIndex] = null;

      // Reseteamos el filtro para volver a mostrarlo entre los disponibles
      setFieldPosFilter(null);
    } else {
      isSelectingSoccerPlayer = true;
      setFieldPosFilter(new FieldPos(FieldPos.LINEUP[slotIndex]));
    }
  }

  void onSoccerPlayerSelected(var soccerPlayer) {

    if (isSelectingSoccerPlayer) {
      isSelectingSoccerPlayer = false;
      lineupSlots[_selectedLineupPosIndex] = soccerPlayer;
      setFieldPosFilter(null);
      setPosFilterClass("TODOS");
    } else {
      bool wasAdded = tryToAddSoccerPlayer(soccerPlayer);

      if (wasAdded) availableSoccerPlayers.remove(soccerPlayer);
    }
  }

  void setNameFilter(String filter) {
    if(lastUsedNameFilter != filter)
      lastUsedNameFilter = filter;

    setFieldPosFilter(lastUsedPosFilter);
    if(oldMatchValue != "-1")
          setMatchFilter(oldMatchValue);
    availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["fullName"].toUpperCase().contains(filter.toUpperCase())).toList();
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
    if(lastUsedPosFilter != filter)
      lastUsedPosFilter = filter;

    if (filter != null) {
      setPosFilterClass(filter.abrevName);
      availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => soccerPlayer["fieldPos"] == filter && !lineupSlots.contains(soccerPlayer)).toList();
    }
    else {
      setPosFilterClass("TODOS");
      availableSoccerPlayers = _allSoccerPlayers.where((soccerPlayer) => !lineupSlots.contains(soccerPlayer)).toList();
    }
  }

  void setMatchFilterClass(String matchId, String matchText) {
    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-team");
    buttonsFilter.forEach((element) {
      element.classes.remove('active');
      if(element.text == matchText) {
        element.classes.add("active");
      }
    });
    setMatchFilter(matchId);
  }

  void setMatchFilter(String matchId) {

    if(oldMatchValue != matchId) {
      oldMatchValue = matchId;
      setNameFilter(lastUsedNameFilter);
    }

      if (matchId != "-1") {
        setFieldPosFilter(lastUsedPosFilter);
        availableSoccerPlayers = availableSoccerPlayers.where((soccerPlayer) => soccerPlayer["matchId"].toString() == matchId).toList();
      } else {
        setFieldPosFilter(lastUsedPosFilter);
      }

  }

  // Añade un futbolista a nuestro lineup si hay algun slot libre de su misma fieldPos. Retorna false si no pudo añadir
  bool tryToAddSoccerPlayer(var soccerPlayer) {

    // Buscamos el primer slot libre para la posicion que ocupa el soccer player
    FieldPos theFieldPos = soccerPlayer["fieldPos"];
    int c = 0;

    for ( ; c < lineupSlots.length; ++c) {
      if (lineupSlots[c] == null && FieldPos.LINEUP[c] == theFieldPos.fieldPos) {
        lineupSlots[c] = soccerPlayer;
        return true;
      }
    }

    return false;
  }

  void _insertSoccerPlayer(TemplateMatchEvent matchEvent, SoccerTeam soccerTeam, SoccerPlayer soccerPlayer) {
    String shortNameTeamA = soccerPlayer.team.matchEvent.soccerTeamA.shortName;
    String shortNameTeamB = soccerPlayer.team.matchEvent.soccerTeamB.shortName;
    var matchEventName = (soccerPlayer.team.templateSoccerTeamId == soccerPlayer.team.matchEvent.soccerTeamA.templateSoccerTeamId)
        ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
        : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

    _allSoccerPlayers.add({
      "id": soccerPlayer.templateSoccerPlayerId,
      "fieldPos": new FieldPos(soccerPlayer.fieldPos),
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
    List<TemplateMatchEvent> matchEvents = contest.templateContest.templateMatchEvents;

    for (var matchEvent in matchEvents) {
      for (var player in matchEvent.soccerTeamA.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamA, player);
      }

      for (var player in matchEvent.soccerTeamB.soccerPlayers) {
        _insertSoccerPlayer(matchEvent, matchEvent.soccerTeamB, player);
      }

      // generamos los partidos para el filtro de partidos
      availableMatchEvents.clear();
      for (TemplateMatchEvent match in matchEvents) {
        availableMatchEvents.add({
          "id": match.templateMatchEventId,
          "texto":match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + " " + timeDisplayFormat.format(match.startDate)
        });
      }

    }
  }

  void createFantasyTeam() {
    // TODO: Se tendría que redireccionar a la pantalla de hacer "Login"?
    if (!_profileService.isLoggedIn) {
      _router.go('login', {});
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

  void deleteFantasyTeam() {
    int i = 0;
    for ( ; i < lineupSlots.length; ++i) {
      lineupSlots[i] = null;
    }
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
  int _selectedLineupPosIndex = 0;
  Router _router;
  ActiveContestsService _contestService;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
}
