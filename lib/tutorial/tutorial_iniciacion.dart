library tutorial_iniciacion;

import 'package:webclient/utils/string_utils.dart';
import 'dart:async';
import 'dart:convert' show JSON;
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/tooltip_service.dart';
import 'package:angular/angular.dart';
import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/models/field_pos.dart';

class TutorialIniciacion extends Tutorial {
  static String STEP_1 = "1";
  static String STEP_2 = "2";

  String get PATH => "tutorial/iniciacion/";

  TutorialIniciacion(Router router, ProfileService profileService) : super(router, profileService) {
    getContentJson(PATH + "instance_soccer_players.json").then((list) => InstanceSoccerPlayerList = list);
    getContentJson(PATH + "soccer_players.json").then((list) => SoccerPlayerList = list);

    var serverCallsWhenOficial = joinMaps([defaultServerCalls, {
      "get_active_contests" : (url, postData) => waitCompleter( () => OficialContestListWithFakes ),
      "get_active_contest" : (url, postData) => waitCompleter( () => OficialContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => OficialContestList ),
      "add_contest_entry": (url, postData) { return addContestEntry(postData); }
    }]);

    var serverCallsWhenOficialContestEntry = joinMaps([defaultServerCalls, {
      "get_my_contest_entry": (url, postData) => waitCompleter( () => OficialContestList ),
      "get_my_active_contests": (url, postData) => waitCompleter( () => OficialContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => OficialContestList ),
      "get_my_active_contest": (url, postData) => waitCompleter( () => OficialContestList ),
      "edit_contest_entry": (url, postData) => addContestEntry(postData)
    }]);

    var serverCallsWhenVirtual = joinMaps([defaultServerCalls, {
      "get_active_contests" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_active_contest" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "add_contest_entry": (url, postData) { CurrentStepId = STEP_2; return addContestEntry(postData); }
    }]);

    var serverCallsWhenVirtualContestEntry = joinMaps([defaultServerCalls, {
      "get_my_contest_entry": (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_my_active_contests": (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_my_active_contest": (url, postData) => waitCompleter( () => TrainingContestList ),
      "edit_contest_entry": (url, postData) => addContestEntry(postData),
      "get_my_live_contest": (url, postData) => waitCompleter( () => TrainingContestLive )
    }]);

    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            triggers: {
              'lobby': () =>
                openModal(
                  title: () => "", //getLocalizedText("title-lobby"),
                  text: () => "En Epic Eleven podrás crear equipos virtuales, con jugadores reales de los equipos que participan en la Liga Española, la Premier League y la Champion's League.",
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) => openModal(
                    title: () => "",
                    text: () => "Vamos a jugar nuestro primer torneo. Participar en los torneos cuesta oro, pero no te preocupes hemos añadido suficiente oro para que puedas participar.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                )
                .then((_) => openModal(
                    title: () => "",
                    text: () => "Los torneos reales están asociados a eventos reales, se juegan en tiempo real, en la fecha del evento de la vida real.<br><br>Los resultados de los torneos están basados en las valoraciones de los jugadores durante el partido o partidos pertenecientes al torneo.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                )
                .then((_) {
                    //showTooltip(new ToolTip("#activeContestList .train", tipText: "Torneo Entrenamiento", delay: new Duration(seconds: 1), duration: new Duration(seconds: 1), highlight: true));
                    //showTooltip(new ToolTip("#activeContestList .real", tipText: "Torneo Oficial", delay: new Duration(seconds: 2), duration: new Duration(seconds: 1), highlight: true));
                    //showTooltip(new ToolTip("#activeContestList .contestSlot", tipText: "Entra en este Torneo", highlight: true));

                    /*
                    changeTrigger("lobby", () {
                      showTooltip(new ToolTip("#activeContestList .contestSlot", tipText: "Entra en este Torneo", duration: new Duration(seconds: 1)));
                      showTooltip(new ToolTip("#activeContestList .contestSlot", highlight: true));
                    });
                    */

                    changeTrigger("lobby", () => showTooltip(new ToolTip("#activeContestList .contestSlot", tipText: "Selecciona este torneo", highlight: true)));
                    triggerEnter("lobby");
                    //removeEnter("lobby");
                }),
              'enter_contest' : () {
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(oficialFantasyTeam));

                openModal(
                  title: () => "", //getLocalizedText("title-entercontest"),
                  text: () => "Haz tu equipo ideal a partir de los jugadores que participan en este torneo.<br><br>Ten en cuenta que cada jugador tiene un salario y debes mantenerte dentro del presupuesto.", //getLocalizedText("text-entercontest"),
                  image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) {
                  showTooltip(new ToolTip("#soccerPlayer220", tipText: "Añade este jugador a tu alineación.", highlight: true, position: ToolTip.POSITION_BOTTOM));
                });
              },
              'lineup-10': () {
                clearTooltips();

                openModal(
                  title: () => "",
                  text: () => "Bien, ya has añadido tu primer jugador.",
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) =>
                  openModal(
                    title: () => "",
                    text: () => "Cuando añades un jugador su salario se descuenta de tu presupuesto.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                )
                .then((_) =>
                  openModal(
                    title: () => "",
                    text: () => "Cada jugador además de su salario tiene un requerimiento de nivel de entrenador.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                )
                .then((_) =>
                  openModal(
                    title: () => "",
                    text: () => "Los jugadores marcados en rojo, son jugadores con un nivel de entrenador superior a tu nivel actual.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                )
                .then((_) {
                  showTooltip(new ToolTip("#soccerPlayer464", tipText: "Intenta seleccionar un jugador marcado en rojo.", highlight: true, position: ToolTip.POSITION_BOTTOM));
                })
                .then((_) {
                });
              },
              'alert-not-buy': () {
                  clearTooltips();
                  openModal(
                    title: () => "",
                    text: () => "Como has podido ver no puedes alinearlo, a no ser que utilices oro o subas tu nivel de manager.<br><br>Para mejorar tu nivel de entrenador, deberás ganar experiencia compitiendo en torneos virtuales.",
                    image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                  .then((_) => openModal(
                      title: () => "",
                      text: () => "Los torneos virtuales, se pueden jugar en cualquier momento, no cuestan sino energía y al participar en ellos, ganarás puntos de prestigio que harán subir tu nivel de manager.<br><br>Los torneos virtuales, están basados en las estadísticas históricas de los jugadores y el resultado de un avanzado algoritmo de simulación.",
                      image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                      onOk: getLocalizedText("next", context: "tutorial")
                   ))
                  .then((_) {
                    CurrentStepId = STEP_1;
                    router.go("lobby", {});
                  });
              },
              'view_contest_entry': () =>
                openModal(
                  title: () => getLocalizedText("title-viewcontestentry"),
                  text: () => getLocalizedText("text-viewcontestentry"),
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                  onOk: getLocalizedText("next", context: "tutorial")
                )
            },
            serverCalls: serverCallsWhenOficial
        ),
        STEP_1: new TutorialStep(
            triggers: {
              'lobby': () {
                  openModal(
                    title: () => "", //getLocalizedText("title-entercontest"),
                    text: () => "Para participar en los torneos virtuales necesitarás energía.", //getLocalizedText("text-entercontest"),
                    image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  )
                  .then ((_) => showTooltip(new ToolTip("#activeContestList .contestSlot", tipText: "Selecciona este torneo", highlight: true)));
                },
              'enter_contest' : () {
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(virtualFantasyTeam));

                openModal(
                  title: () => "", //getLocalizedText("title-entercontest"),
                  text: () => "A diferencia de los Torneos Reales, en los Virtuales no existe una limitación por nivel de manager, por lo tanto todos los jugadores estarán disponibles.<br><br>Así que la única limitación será tu presupuesto.", //getLocalizedText("text-entercontest"),
                  image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) =>
                  openModal(
                    title: () => "", //getLocalizedText("title-entercontest"),
                    text: () => "Hemos hecho la alineación por ti, solo necesitas alinear un delantero.", //getLocalizedText("text-entercontest"),
                    image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  ))
                .then((_) {
                  showTooltip(new ToolTip("#soccerPlayer344", tipText: "Añade un delantero.", highlight: true, position: ToolTip.POSITION_BOTTOM));
                });
              },
              'lineup-11': () {
                clearTooltips();

                openModal(
                  title: () => "",
                  text: () => "Una vez completada una alineación se activa el botón de Continuar. Púlsalo.",
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                  onOk: getLocalizedText("next", context: "tutorial")
                );
              }
            },
            serverCalls: serverCallsWhenVirtual
        ),
        STEP_2: new TutorialStep(
            triggers: {
              'view_contest_entry': () {
                openModal(
                  title: () => "",
                  text: () => "Acabas de entrar en un Torneo Virtual.",
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) {
                  router.go('live_contest', {"contestId": TrainingContestInstance["_id"], "parent": "my_contests"});
                });
              },
              'view_contest': () {
                openModal(
                  title: () => "",
                  text: () => "Ésta es la pantalla de simulación, donde podrás ver en tiempo real cómo se desarrolla el partido y tu clasificación en ese torneo virtual.",
                  image: null, //({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                  onOk: getLocalizedText("next", context: "tutorial")
                )
                .then((_) =>
                  openModal(
                    title: () => "", //getLocalizedText("title-entercontest"),
                    text: () => "También podrás ver las alineaciones de tus rivales.", //getLocalizedText("text-entercontest"),
                    image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  ))
                .then((_) =>
                  openModal(
                    title: () => "", //getLocalizedText("title-entercontest"),
                    text: () => "Aqui se ve la simulación.", //getLocalizedText("text-entercontest"),
                    image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  ))
                .then((_) =>
                  openModal(
                    title: () => "", //getLocalizedText("title-entercontest"),
                    text: () => "¡¡¡ Enhorabuena, subes de nivel !!!", //getLocalizedText("text-entercontest"),
                    image: null, // ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    onOk: getLocalizedText("next", context: "tutorial")
                  ))
                .then((_) {
                  CurrentStepId = Tutorial.STEP_END;
                  router.go("home", {});
                });
              }
            },
            serverCalls: serverCallsWhenVirtualContestEntry
        ),
        Tutorial.STEP_END: new TutorialStep(
        )
    };
  }

  void activate() {
    CurrentStepId = Tutorial.STEP_BEGIN;
    changeUser(TutorialPlayer(goldBalance: "AUD 1.00"));
  }

  Future addContestEntry(Map postData) {
    FantasyTeam = JSON.decode(postData["soccerTeam"]);
    return emptyContent();
  }

  String getLocalizedText(key, {String context: "tutorial_iniciacion"}) {
    return StringUtils.translate(key, context);
  }

  Map get PlayerInfo => {
      "userId": profileService.isLoggedIn ? profileService.user.userId : "PLAYER",
      "nickName": profileService.isLoggedIn ? profileService.user.nickName : "Player",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    };

  Map get PlayerEntry => {
    "userId": profileService.isLoggedIn ? profileService.user.userId : "PLAYER",
    "position":-1,
    "prize":"AUD 0.00",
    "fantasyPoints":0,
    "soccerIds": FantasyTeam,
    "_id":"PLAYER-56334440d4c657a07a9f890c"
    };

  Map get OficialContestList => {
    "contests": [
      OficialContestInstance
      ],
      "users_info": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(UsersInfo, element: PlayerInfo) : UsersInfo,
      "match_events": MatchEvents,
      "soccer_teams": SoccerTeams,
      "soccer_players": SoccerPlayerList
  };

  Map get OficialContestListWithFakes => {
    "contests": [
      OficialContestInstance,
      OficialContestFake1,
      OficialContestFake2
      ],
      "users_info": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(UsersInfo, element: PlayerInfo) : UsersInfo,
      "match_events": MatchEvents,
      "soccer_teams": SoccerTeams,
      "soccer_players": SoccerPlayerList
  };

  Map get TrainingContestList => {
    "contests": [
      TrainingContestInstance
      ],
      "users_info": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(UsersInfo, element: PlayerInfo) : UsersInfo,
      "match_events": MatchEvents,
      "soccer_teams": SoccerTeams,
      "soccer_players": SoccerPlayerList
  };

  Map get TrainingContestLive => {
    "contests": [
      TrainingContestInstanceLive
      ],
      "users_info": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(UsersInfo, element: PlayerInfo) : UsersInfo,
      "match_events": MatchEvents,
      "soccer_teams": SoccerTeams,
      "soccer_players": SoccerPlayerList
  };

  Map get TrainingContestInstance => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "ACTIVE",
        "name": "Tutorial [Entrenamiento]",
        "contestEntries": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(ContestEntries, element: PlayerEntry) : ContestEntries,
        "templateMatchEventIds": TemplateMatchEventIds,
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "JPY 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 60)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": true,
        "specialImage": "",
        "numEntries": ContestEntries.length,
        "_id":  "TRAINING-56331d69d4c6912cf152f201"
  };

  Map get TrainingContestInstanceLive => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "LIVE",
        "name": "Tutorial [Entrenamiento]",
        "contestEntries": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(ContestEntries, element: PlayerEntry) : ContestEntries,
        "templateMatchEventIds": TemplateMatchEventIds,
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "JPY 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 60)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": true,
        "specialImage": "",
        "numEntries": ContestEntries.length,
        "_id":  "TRAINING-56331d69d4c6912cf152f201"
  };

  Map get OficialContestInstance => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "ACTIVE",
        "name": "Tutorial [Oficial]",
        "contestEntries": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(ContestEntries, element: PlayerEntry) : ContestEntries,
        "templateMatchEventIds": TemplateMatchEventIds,
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "AUD 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 120)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": false,
        "specialImage": "",
        "numEntries": ContestEntries.length,
        "_id":  "OFICIAL-56331d69d4c6912cf152f201"
  };

  Map get OficialContestFake1 => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "ACTIVE",
        "name": "Tutorial 1",
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 130)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": false,
        "specialImage": "",
        "numEntries": 18,
        "_id":  "OFICIAL-FAKE1-56331d69d4c6912cf152f201"
  };

  Map get OficialContestFake2 => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "ACTIVE",
        "name": "Tutorial 2",
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 140)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": false,
        "specialImage": "",
        "numEntries": 15,
        "_id":  "OFICIAL-FAKE2-56331d69d4c6912cf152f201"
  };

  List get ContestEntries => [
    {
      "userId":"USER01-5625d093d4c6ebe295987fd1",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "_id":"56334440d4c657a07a9f890c"
    },
    {
      "userId":"USER02-5625d093d4c6ebe295987fd6",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "_id":"563337c0d4c657a07a9f8906"
    },
    {
      "userId":"USER03-5625d093d4c6ebe295987fd8",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "_id":"56334c7bd4c657a07a9f890f"
    },
    {
      "userId":"USER04-5625d093d4c6ebe295987fdb",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "_id":"56334fdfd4c657a07a9f8912"
    },
    {
      "userId":"USER05-5625d093d4c6ebe295987fde",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "_id":"56333853d4c657a07a9f8909"
    }
  ];

  List InstanceSoccerPlayerList = [];
  List SoccerPlayerList = [];
  List FantasyTeam = [];

  List oficialFantasyTeam = [
    "5625dd85c1f5fbc410ee72fa",
    "56260840c1f5fbc410f9951a",
    "56260d5ec1f5fbc410fae9dc",
    "5625d0edc1f5fbc410e6f00a",
    "5625d0edc1f5fbc410e6ef4e",
    "56260840c1f5fbc410f9953f",
    "5625f9d5c1f5fbc410f5deba",
    "56260840c1f5fbc410f9954d",
    "562608c1c1f5fbc410f99f83"
    ];

  List virtualFantasyTeam = [
    "5625dd85c1f5fbc410ee72fa",
    "56260840c1f5fbc410f9951a",
    "56260d5ec1f5fbc410fae9dc",
    "5625d0edc1f5fbc410e6f00a",
    "5625d0edc1f5fbc410e6ef4e",
    "56260840c1f5fbc410f9953f",
    "5625f9d5c1f5fbc410f5deba",
    "56260840c1f5fbc410f9954d",
    "562608c1c1f5fbc410f99f83",
    "56260898c1f5fbc410f998b1"
    ];
}