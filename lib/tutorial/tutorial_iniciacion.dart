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
import 'package:webclient/components/view_contest/view_contest_comp.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/utils/game_metrics.dart';

class TutorialIniciacion extends Tutorial {
  static String NAME = "TUTORIAL_INICIACION";
  static String STEP_1 = "1";
  static String STEP_2 = "2";
  static String STEP_3 = "3";
  static String STEP_4 = "4";

  String get PATH => "tutorial/iniciacion/";
  String get name => TutorialIniciacion.NAME;

  DateTime currentDate = new DateTime.now();

  TutorialIniciacion(Router router, ProfileService profileService) : super(router, profileService) {
    getContentJson(PATH + "instance_soccer_players.json").then((list) {
      InstanceSoccerPlayerList = list;

      Map<String, String> forwards = {
        "56260898c1f5fbc410f998b1": "Adnane Tighadouini",
        "5625d0edc1f5fbc410e6ee06": "Adrián",
        "5625d0edc1f5fbc410e6ecfe": "Aduriz",
        "5625d162c1f5fbc410e739c1": "Álvaro Negredo",
        "5625d0edc1f5fbc410e6efb6": "Álvaro Vázquez",
        "5625d0edc1f5fbc410e6ed18": "Ángel Correa",
        "5625d0edc1f5fbc410e6ef3c": "Antoine Griezmann",
        "5625d162c1f5fbc410e737c1": "Antonio Sanabria",
        "56260840c1f5fbc410f994c7": "Asdrúbal",
        "5625d162c1f5fbc410e73c00": "Bebé"
        // "5625d0edc1f5fbc410e6ef72": "Borja Bastón"
      };

      // Filtrar la lista de delanteros
      InstanceSoccerPlayerWithFilteredForwardsList = InstanceSoccerPlayerList.where((instance) {
        return (instance["fieldPos"] == "FORWARD") ? forwards.containsKey(instance["templateSoccerPlayerId"]) : true;
      }).toList();
    });

    getContentJson(PATH + "soccer_players.json").then((list) => SoccerPlayerList = list);

    var serverCallsWhenOficial = joinMaps([defaultServerCalls, {
      "get_active_contests" : (url, postData) => waitCompleter( () => OficialContestListWithFakes ),
      "get_active_contest" : (url, postData) => waitCompleter( () => OficialContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => OficialContestList ),
      "add_contest_entry": (url, postData) { return addContestEntry(postData); },
      "get_instance_soccer_player_info": (String url, postData) => url.contains("56260898c1f5fbc410f998b1") ? getContentJson(PATH + "stats-player-01.json") : getContentJson(PATH + "stats-player-02.json"),
      "get_simulator_state": (url, postData) => waitCompleter( () => {
        "init": true,
        "currentDate": currentDate.millisecondsSinceEpoch,
      })
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
      "get_instance_soccer_player_info": (url, postData) => getContentJson(PATH + "stats-player-03.json"),
      "add_contest_entry": (url, postData) { CurrentStepId = STEP_4; return addContestEntry(postData); },
      "buy_product": (String url, postData) {
        profileService.user.energyBalance.amount = User.MAX_ENERGY;
        profileService.user.goldBalance.amount = 0;
        return emptyContent();
      }
    }]);

    var serverCallsWhenVirtualContestEntry = joinMaps([defaultServerCalls, {
      "get_my_contest_entry": (url, postData) => waitCompleter( () => TrainingContestLive ),
      "get_my_active_contests": (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_my_active_contest": (url, postData) => waitCompleter( () => TrainingContestList ),
      "edit_contest_entry": (url, postData) => addContestEntry(postData),
      "get_my_live_contest": (url, postData) => waitCompleter( () => TrainingContestLive ),
      "get_my_history_contest": (url, postData) => waitCompleter( () => TrainingContestHistory ),
      "get_live_match_events": (url, postData) => waitCompleter( () => LiveMatchEventsResponse )
    }]);

    // Identificadores de los futbolistas a seleccionar
    String soccerPlayer0 = "#soccerPlayer187"; // "#soccerPlayer220";
    String soccerPlayer1 = "#soccerPlayer389"; // "#soccerPlayer464";
    String soccerPlayer2 = "#soccerPlayer292"; // "#soccerPlayer344";

    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            triggers: {
              'lobby': () async {
                
                GameMetrics.logEvent(GameMetrics.TUTORIAL_STARTED);
                
                // Bienvenido a Epic Eleven
                await openModal( text: () => getLocalizedText("msg-01") );

                // Comienza eligiendo un torneo oficial
                await openModal( text: () => getLocalizedText("msg-02") );

                if (!isCompleted) {
                  CurrentStepId = STEP_1;

                  // Selecciona este torneo
                  showTooltips([
                    new ToolTip("#activeContestList .contestSlot .action-section", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-02a"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                    new ToolTip("#activeContestList .contestSlot", highlight: true)
                  ]);
                }
              }
            },
            serverCalls: serverCallsWhenOficial
      ),
      STEP_1: new TutorialStep(
            triggers: {
              'enter_contest' : () async {
                
                GameMetrics.logEvent(GameMetrics.TUTORIAL_STEP_TEAM_SELECTION);
                
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                Map data = { 'formation' :  ContestEntry.FORMATION_442, 'lineupSlots' : oficialFantasyTeam};
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(data));

                // Los torneos oficiales se basan en partidos
                await openModal( text: () => getLocalizedText("msg-02b") );

                // Elige tu alineación ideal entre todos
                await openModal( text: () => getLocalizedText("msg-02c") );

                if (!isCompleted) {

                  // Esta es la lista de partidos de este torneo.
                  await onClick( [new ToolTip("matches-filter", tipText: getLocalizedText("msg-02d"), highlight: true, position: ToolTip.POSITION_TOP)] );

                  clearTooltips();
                  querySelector(".lineup-formation-selector-wrapper").click();

                  // Aquí puedes desplegar la lista de formaciones
                  await onClick( [new ToolTip(".lineup-formation-selector-wrapper", tipId: "formationsPanelTip", tipText: getLocalizedText("msg-02e"), highlight: true, position: ToolTip.POSITION_TOP)] );

                  // Éstas son las formaciones disponibles
                  await onClick( [new ToolTip("#formationsPanelRoot", tipText: getLocalizedText("msg-02f"), highlight: true, position: ToolTip.POSITION_TOP)] );

                  // Selecciona una formación
                  showTooltips([
                    new ToolTip("#formationsPanel .formation-element#formationElement433 label", tipId: 'formation443Tip',  tipText: getLocalizedText("msg-02g"), highlight: true, position: ToolTip.POSITION_TOP, allowClickOnElement: true),
                    new ToolTip("#formationsPanel .formation-element#formationElement433", highlight: true)
                  ]);
                };
              },
              'formation-433': () async {
                querySelector(".lineup-formation-selector-wrapper").click();

                // Al cambiar de formación, cambia el número
                await onClick( [new ToolTip(".enter-contest-lineup-wrapper", tipText: getLocalizedText("msg-02h"), highlight: true, position: ToolTip.POSITION_TOP)] );

                // Esta es la lista de jugadores disponibles
                await onClick( [new ToolTip(".enter-contest-soccer-players-wrapper", tipText: getLocalizedText("msg-02i"), highlight: true, position: ToolTip.POSITION_TOP)] );

                // Añade este jugador a tu alineación.
                showTooltips([
                  new ToolTip("$soccerPlayer0 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                  new ToolTip("$soccerPlayer0", highlight: true)
                ]);
              },
              'lineup-9': () async {
                clearTooltips();

                // Bien, ya has añadido tu primer jugador.
                await onClick( [new ToolTip(".posDEL", tipId: 'playerAddedTip', tipText: getLocalizedText("msg-03a"), highlight: true, position: ToolTip.POSITION_TOP)] );

                // Cuando añades un jugador su salario (".enter-contest-total-salary")
                await onClick( [new ToolTip(".enter-contest-lineup-wrapper", tipText: getLocalizedText("msg-03b"), highlight: true, position: ToolTip.POSITION_TOP)] );

                // Cada jugador además de su salario
                await onClick( [new ToolTip("$soccerPlayer1 .column-manager-level", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03c"), highlight: true, position: ToolTip.POSITION_BOTTOM, tipId: 'soccerManagerLevel')] );

                // Los jugadores marcados en rojo
                await onClick ( [new ToolTip("$soccerPlayer1", tipId: 'soccerPlayerRedStyle', tipText: getLocalizedText("msg-03d"), highlight: true, position: ToolTip.POSITION_TOP)] );

                clearTooltips();

                // Intenta seleccionar un jugador marcado en rojo.
                // showTooltip(new ToolTip("$soccerPlayer1", tipText: getLocalizedText("msg-11"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true));
                showTooltips([
                  new ToolTip("$soccerPlayer1 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03e"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                  new ToolTip("$soccerPlayer1", highlight: true)
                ]);
              },
              'alert-not-buy': () async {
                  clearTooltips();

                  // Necesitas subir tu nivel de manager compitiendo
                  await openModal( text: () => getLocalizedText("msg-03f") );

                  if (!isCompleted) {
                    CurrentStepId = STEP_2;
                    router.go("lobby", {});
                  }
              }
            },
            serverCalls: serverCallsWhenOficial
        ),
        STEP_2: new TutorialStep(
            triggers: {
              'lobby': () async {
                
                GameMetrics.logEvent(GameMetrics.TUTORIAL_STEP_LOBBY_TRAINING);
                
                // Puedes participar en torneos de entrenamiento
                await openModal( text: () => getLocalizedText("msg-04") );

                // Participa en los torneos de entrenamiento para ganar prestigio
                await onClick( [
                  new ToolTip(".fixed-user-stats .energy", tipId: 'energyTip', arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-04a"), highlight: true, position: ToolTip.POSITION_BOTTOM),
                  new ToolTip("main-menu-f2p", highlight: true)
                ] );

                // TODO: Puede que el tutorial haya sido cancelado en el paso anterior, ¿cómo salirse del flujo normal sin "hacks"?
                if (isActive) {
                  TutorialService.Instance.disableElementEvents('main-menu-f2p');
                }

                // Cada torneo tiene un coste de energia.
                await onClick( [new ToolTip(".entry-fee-box", tipText: getLocalizedText("msg-05"), highlight: true, position: ToolTip.POSITION_TOP)] );

                // Selecciona este torneo
                showTooltips([
                  new ToolTip("#activeContestList .contestSlot .action-section", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-06"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                  new ToolTip("#activeContestList .contestSlot", highlight: true)
                ]);
              },
              'enter_contest' : () async {
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                Map data = { 'formation' :  ContestEntry.FORMATION_442, 'lineupSlots' : virtualFantasyTeam};
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(data));

                // A diferencia de los torneos oficiales
                await openModal( text: () => getLocalizedText("msg-07") );

                // Esta vez hemos hecho la alineación por ti
                await openModal( text: () => getLocalizedText("msg-08") );

                // Añade un delantero
                showTooltips([
                  new ToolTip("$soccerPlayer2 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-09"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                  new ToolTip("$soccerPlayer2", highlight: true)
                ]);
              },
              'lineup-11': () async {
                clearTooltips();

                // Una vez completada una alineación se activa el botón de Continuar
                showTooltip(new ToolTip(".button-wrapper .btn-confirm-lineup-list", tipId: 'continueButton', tipText: getLocalizedText("msg-10"), highlight: true, position: ToolTip.POSITION_TOP, allowClickOnElement: true));
              },

              'alert-not-enough-resources': () async {
                clearTooltips();
                showTooltip(new ToolTip("#alertBox .panel", tipText: getLocalizedText("msg-10a"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true));
              },

              'shop': () {
                CurrentStepId = STEP_3;

                clearTooltips();

                // FIX !!!!
                profileService.user.goldBalance.amount += 3;

                // Compra una recarga de energía.
                showTooltip(new ToolTip(".energy-layout", tipText: getLocalizedText("msg-10b"), highlight: true, position: ToolTip.POSITION_TOP, allowClickOnElement: true));
              },
            },
            serverCalls: serverCallsWhenVirtual
        ),
        STEP_3: new TutorialStep(
            triggers: {
              'enter_contest': () async {
                clearTooltips();

                // Púlsalo para completar tu entrada en el torneo.
                showTooltip(new ToolTip(".button-wrapper .btn-confirm-lineup-list", tipId: 'continueButton', tipText: getLocalizedText("msg-10c"), highlight: true, position: ToolTip.POSITION_TOP, allowClickOnElement: true));
              }
            },
            serverCalls: serverCallsWhenVirtual
        ),
        STEP_4: new TutorialStep(
            triggers: {
              'view_contest_entry': () async {
                // Enhorabuena. Acabas de apuntarte a un torneo de práctica.
                await openModal( text: () => getLocalizedText("msg-11") );

                if (!isCompleted) {
                  router.go('live_contest', {"contestId": TrainingContestInstance["_id"], "parent": "my_contests"});
                }
              },
              'view_contest': () async {
                // Ésta es la pantalla de simulación
                await openModal( text: () => getLocalizedText("msg-12") );

                if (!isCompleted) {
                  // Aquí podrás ver los puntos conseguidos por tus jugadores
                  await onClick( [new ToolTip("fantasy-team", tipText: getLocalizedText("msg-13"), highlight: true, position: ToolTip.POSITION_TOP)] );

                  // Aquí puedes ver tu puntuación frente a los rivales
                  await onClick( [new ToolTip("#usersList", tipText: getLocalizedText("msg-14"), highlight: true, position: ToolTip.POSITION_TOP)]);
                }

                clearTooltips();

                ViewContestComp liveContest = context;
                liveContest.updateLive();

                // Enhorabuena, has ganado tu primer torneo!
                await openModal( text: () => getLocalizedText("msg-16"), onOk: StringUtils.translate("end", "tutorial") );

                // Ya estás preparado...
               // await openModal( text: () => getLocalizedText("msg-17") );

                if (!isCompleted) {
                  CurrentStepId = Tutorial.STEP_END;
                  
                  GameMetrics.logEvent(GameMetrics.TUTORIAL_COMPLETED);
                  
                  TutorialService.Instance.skipTutorial();
                }
              }
            },
            serverCalls: serverCallsWhenVirtualContestEntry
        ),
        Tutorial.STEP_END: new TutorialStep(
        )
    };
  }

  void activate() {
    DateTimeService.setFakeDateTime(currentDate);

    CurrentStepId = Tutorial.STEP_BEGIN;
    changeUser(TutorialPlayer(energyBalance: "JPY 0.00", goldBalance: "AUD 0.00"));

    // Inicialización del FantasyTeam
    FantasyTeam = [];

    loadContent();
  }

  Future loadContent() async {
    /*
    LiveMatchEventsList.add([]);
    LiveMatchEventsList.add( await getContentJson(PATH + "live-01.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-02.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-03.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-04.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-05.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-06.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-07.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-08.json") );
    LiveMatchEventsList.add( await getContentJson(PATH + "live-09.json") );
     */
    LiveMatchEventsList.add( await getContentJson(PATH + "live-10.json") );
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

  Map get TrainingContestHistory => {
    "contests": [
      TrainingContestInstanceHistory
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
        "instanceSoccerPlayers": InstanceSoccerPlayerWithFilteredForwardsList,
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "JPY 3",
        "prizeMultiplier": 3.3333,
        "prizeType": "TOP_3_GET_PRIZES",
        "startDate": currentDate.add(new Duration(minutes: 60)).millisecondsSinceEpoch,
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
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "JPY 3",
        "prizeMultiplier": 3.3333,
        "prizeType": "TOP_3_GET_PRIZES",
        "startDate": currentDate.add(new Duration(minutes: 60)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": true,
        "specialImage": "",
        "numEntries": ContestEntries.length,
        "_id":  "TRAINING-56331d69d4c6912cf152f201"
  };

  Map get TrainingContestInstanceHistory => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "HISTORY",
        "name": "Tutorial [Entrenamiento]",
        "contestEntries": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(ContestEntries, element: PlayerEntry) : ContestEntries,
        "templateMatchEventIds": TemplateMatchEventIds,
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "minEntries": 5,
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "JPY 3",
        "prizeMultiplier": 3.33,
        "prizeType": "TOP_3_GET_PRIZES",
        "startDate": currentDate.add(new Duration(minutes: 60)).millisecondsSinceEpoch,
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
        "instanceSoccerPlayers": InstanceSoccerPlayerWithFilteredForwardsList,
        "minEntries": 5,
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "AUD 2",
        "prizeMultiplier": 0.9,
        "prizeType": "WINNER_TAKES_ALL",
        "startDate": currentDate.add(new Duration(minutes: 120)).millisecondsSinceEpoch,
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
        "minEntries": 25,
        "maxEntries": 100,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 0.9,
        "prizeType": "TOP_3_GET_PRIZES",
        "startDate": currentDate.add(new Duration(minutes: 130)).millisecondsSinceEpoch,
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
        "minEntries": 25,
        "maxEntries": 100,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 0.9,
        "prizeType": "TOP_3_GET_PRIZES",
        "startDate": currentDate.add(new Duration(minutes: 140)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": false,
        "specialImage": "",
        "numEntries": 15,
        "_id":  "OFICIAL-FAKE2-56331d69d4c6912cf152f201"
  };

  Map get LiveMatchEventsResponse => {
    "content": LiveMatchEventsList[liveStep]
  };

  List get ContestEntries => [
    {
      "userId":"USER01-5625d093d4c6ebe295987fd1",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "soccerIds": ["5625d0edc1f5fbc410e6ef0a","5625d0edc1f5fbc410e6ed28","5625e993c1f5fbc410f0d80d","5625d104c1f5fbc410e6f75c","5625d106c1f5fbc410e6f802","5625d108c1f5fbc410e6f84b","5625d0f9c1f5fbc410e6f180","5625d0edc1f5fbc410e6ef58","5625d0edc1f5fbc410e6edd8","5625d0edc1f5fbc410e6effa","5625d162c1f5fbc410e73bee"],
      "_id":"56334440d4c657a07a9f890c"
    },
    {
      "userId":"USER02-5625d093d4c6ebe295987fd6",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "soccerIds": ["5625d0edc1f5fbc410e6efba","5625d0edc1f5fbc410e6ed02","5625d0edc1f5fbc410e6eef2","56260840c1f5fbc410f994ce","56260840c1f5fbc410f99506","5625d1bbc1f5fbc410e77439","5625d164c1f5fbc410e73df4","5625d0edc1f5fbc410e6eeac","5625d0f0c1f5fbc410e6f082","5625d499c1f5fbc410e937dd","5625d0edc1f5fbc410e6ee06"],
      "_id":"563337c0d4c657a07a9f8906"
    },
    {
      "userId":"USER03-5625d093d4c6ebe295987fd8",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "soccerIds": ["5626088bc1f5fbc410f996e1","5625d0edc1f5fbc410e6ee34","56260940c1f5fbc410f9bf8e","5625d0edc1f5fbc410e6edc4","5625d0edc1f5fbc410e6ef14","5625eac9c1f5fbc410f14235","56261affc1f5fbc410fc80af","5625d0edc1f5fbc410e6ed90","5625d106c1f5fbc410e6f80a","5625d0edc1f5fbc410e6ef88","56260898c1f5fbc410f998b1"],
      "_id":"56334c7bd4c657a07a9f890f"
    },
    {
      "userId":"USER04-5625d093d4c6ebe295987fdb",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "soccerIds": ["5625d0edc1f5fbc410e6ed9c","5625d0edc1f5fbc410e6ef76","5625d0edc1f5fbc410e6eef0","5625d104c1f5fbc410e6f752","5625d0edc1f5fbc410e6ee2c","5625ecb2c1f5fbc410f1e88d","5625d0edc1f5fbc410e6ef02","5625d108c1f5fbc410e6f84b","5626088bc1f5fbc410f996c2","5625d0edc1f5fbc410e6eefc","5625d0edc1f5fbc410e6ef86"],
      "_id":"56334fdfd4c657a07a9f8912"
    },
    {
      "userId":"USER05-5625d093d4c6ebe295987fde",
      "position":-1,
      "prize":"AUD 0.00",
      "fantasyPoints":0,
      "soccerIds": ["5625dd85c1f5fbc410ee72fa", "56260840c1f5fbc410f9951a", "56260d5ec1f5fbc410fae9dc", "5625d0edc1f5fbc410e6f00a", "5625d0edc1f5fbc410e6ef4e", "56260840c1f5fbc410f9953f", "5625f9d5c1f5fbc410f5deba", "56260840c1f5fbc410f9954d", "562608c1c1f5fbc410f99f83","5625d0edc1f5fbc410e6ef3c","5625d0edc1f5fbc410e6ee8c"],
      "_id":"56333853d4c657a07a9f8909"
    }
  ];

  List InstanceSoccerPlayerList = [];
  List InstanceSoccerPlayerWithFilteredForwardsList = [];
  List SoccerPlayerList = [];
  List FantasyTeam = [];
  List<List> LiveMatchEventsList = [];

  int liveStep = 0;

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
    "5625d0edc1f5fbc410e6edc2",
    "56260840c1f5fbc410f99549",
    "5625d0edc1f5fbc410e6ee48",
    "56260996c1f5fbc410f9d66f",
    "56260898c1f5fbc410f998a9",
    "56260999c1f5fbc410f9d7c7",
    "5625d0edc1f5fbc410e6ee52",
    "5625d0edc1f5fbc410e6ed52",
    "5625d101c1f5fbc410e6f6ba",
    "5625d0edc1f5fbc410e6ef3c"];
}