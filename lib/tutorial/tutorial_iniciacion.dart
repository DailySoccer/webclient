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

class TutorialIniciacion extends Tutorial {
  static String NAME = "TUTORIAL_INICIACION";
  static String STEP_1 = "1";
  static String STEP_2 = "2";
  static String STEP_3 = "3";

  String get PATH => "tutorial/iniciacion/";
  String get name => TutorialIniciacion.NAME;

  DateTime currentDate = new DateTime.now();

  TutorialIniciacion(Router router, ProfileService profileService) : super(router, profileService) {
    getContentJson(PATH + "instance_soccer_players.json").then((list) => InstanceSoccerPlayerList = list);
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
      "add_contest_entry": (url, postData) { CurrentStepId = STEP_3; return addContestEntry(postData); }
    }]);

    var serverCallsWhenVirtualContestEntry = joinMaps([defaultServerCalls, {
      "get_my_contest_entry": (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_my_active_contests": (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => TrainingContestList ),
      "get_my_active_contest": (url, postData) => waitCompleter( () => TrainingContestList ),
      "edit_contest_entry": (url, postData) => addContestEntry(postData),
      "get_my_live_contest": (url, postData) => waitCompleter( () => TrainingContestLive ),
      "get_live_match_events": (url, postData) => waitCompleter( () => LiveMatchEventsResponse )
    }]);

    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            triggers: {
              'lobby': () =>
                openModal(
                  text: () => getLocalizedText("msg-01") // Bienvenido a Epic Eleven
                )
                .then((_) => openModal(
                    text: () => getLocalizedText("msg-02") // Comienza eligiendo un torneo oficial
                  )
                )
                .then((_) {
                    CurrentStepId = STEP_1;

                    //Selecciona este torneo
                    showTooltips([
                      new ToolTip("#activeContestList .contestSlot .action-section", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-02a"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                      new ToolTip("#activeContestList .contestSlot", highlight: true)
                    ]);
                })
                .catchError((e) {
                })
            },
            serverCalls: serverCallsWhenOficial
      ),
      STEP_1: new TutorialStep(
            triggers: {
              'enter_contest' : () {
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(oficialFantasyTeam));

                openModal(
                  text: () => getLocalizedText("msg-02b") // Los torneos oficiales se basan en partidos
                )
                .then((_) =>
                  openModal(
                    text: () => getLocalizedText("msg-02c") // Elige tu alineación ideal entre todos
                  ))
                .then((_) {
                  Completer completer = new Completer();

                  // Esta es la lista de partidos de este torneo.
                  showTooltip(
                    new ToolTip("matches-filter", tipText: getLocalizedText("msg-02d"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                      clearTooltips();

                      // Esta es la lista de jugadores disponibles
                      showTooltip(
                        new ToolTip(".enter-contest-soccer-players-wrapper", tipText: getLocalizedText("msg-02e"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                          completer.complete(true);
                        })
                      );
                    })
                  );

                  return completer.future;
                })
                .then((_) {
                  showTooltips([
                    new ToolTip("#soccerPlayer220 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true), //Añade este jugador a tu alineación.
                    new ToolTip("#soccerPlayer220", highlight: true)
                  ]);
                })
                .catchError((e) {
                });
              },
              'lineup-10': () {
                clearTooltips();

                //Bien, ya has añadido tu primer jugador.
                showTooltip(new ToolTip(".posDEL", tipText: getLocalizedText("msg-03a"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                  //Cuando añades un jugador su salario (".enter-contest-total-salary")
                  showTooltip(new ToolTip(".enter-contest-lineup-wrapper", tipText: getLocalizedText("msg-03b"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                    //Cada jugador además de su salario
                    showTooltip(new ToolTip("#soccerPlayer464 .column-manager-level", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03c"), highlight: true, position: ToolTip.POSITION_BOTTOM, tipId: 'soccerManagerLevel', onClickCb: (_) {
                      //Los jugadores marcados en rojo
                      showTooltip(new ToolTip("#soccerPlayer464", tipId: 'soccerPlayerRedStyle', tipText: getLocalizedText("msg-03d"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                        clearTooltips();

                        //Intenta seleccionar un jugador marcado en rojo.
                        // showTooltip(new ToolTip("#soccerPlayer464", tipText: getLocalizedText("msg-11"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true));
                        showTooltips([
                          new ToolTip("#soccerPlayer464 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-03e"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                          new ToolTip("#soccerPlayer464", highlight: true)
                        ]);
                      }));
                    }));
                  }));
                }));
              },
              'alert-not-buy': () {
                  clearTooltips();
                  openModal(
                    text: () => getLocalizedText("msg-03f") //Necesitas subir tu nivel de manager compitiendo
                  )
                  .then((_) {
                    CurrentStepId = STEP_2;
                    router.go("lobby", {});
                  })
                  .catchError((e) {
                  });
              },
              '**view_contest_entry': () =>
                openModal(
                  text: () => getLocalizedText("text-viewcontestentry"),
                  onOk: getLocalizedText("next", context: "tutorial")
                )
            },
            serverCalls: serverCallsWhenOficial
        ),
        STEP_2: new TutorialStep(
            triggers: {
              'lobby': () {
                openModal(
                  text: () => getLocalizedText("msg-04") //Puedes participar en torneos de entrenamiento siempre que quieras
                )
                .then((_) {
                  //Para participar en los torneos virtuales necesitarás energía
                  showTooltip(new ToolTip(".entry-fee-box", tipText: getLocalizedText("msg-05"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                    //Selecciona este torneo
                    showTooltips([
                      new ToolTip("#activeContestList .contestSlot .action-section", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-06"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                      new ToolTip("#activeContestList .contestSlot", highlight: true)
                    ]);
                  }));
                });
                  /*
                  openModal(
                    text: () => getLocalizedText("msg-18") //Para participar en los torneos virtuales necesitarás energía
                  )
                  .then ((_) {
                    //Selecciona este torneo
                    showTooltips([
                      new ToolTip("#activeContestList .contestSlot .action-section", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-19"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                      new ToolTip("#activeContestList .contestSlot", highlight: true)
                    ]);
                  });
                   */
                },
              'enter_contest' : () {
                EnterContestComp enterContest = context;
                enterContest.fieldPosFilter = FieldPos.FORWARD;
                enterContest.saveContestEntryFromJson(KeyLocalStorage, JSON.encode(virtualFantasyTeam));

                openModal(
                  text: () => getLocalizedText("msg-07") //A diferencia de los torneos oficiales
                )
                .then((_) =>
                  openModal(
                    text: () => getLocalizedText("msg-08") //Esta vez hemos hecho la alineación por ti
                  ))
                .then((_) {
                  //Añade un delantero
                  //showTooltip(new ToolTip("#soccerPlayer344 .action-button", tipText: getLocalizedText("msg-24"), highlight: true, arrowPosition: ToolTip.POSITION_RIGHT, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true));
                  showTooltips([
                    new ToolTip("#soccerPlayer344 .action-button", arrowPosition: ToolTip.POSITION_RIGHT, tipText: getLocalizedText("msg-09"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true),
                    new ToolTip("#soccerPlayer344", highlight: true)
                  ]);
                })
                .catchError((e) {
                });
              },
              'lineup-11': () {
                clearTooltips();

                //Una vez completada una alineación se activa el botón de Continuar
                showTooltip(new ToolTip(".button-wrapper .btn-confirm-lineup-list", tipId: 'continueButton', tipText: getLocalizedText("msg-10"), highlight: true, position: ToolTip.POSITION_TOP, allowClickOnElement: true));

                /*
                openModal(
                  text: () => getLocalizedText("msg-25") //Una vez completada una alineación se activa el botón de Continuar
                );
                 */
              }
            },
            serverCalls: serverCallsWhenVirtual
        ),
        STEP_3: new TutorialStep(
            triggers: {
              'view_contest_entry': () {
                openModal(
                  text: () => getLocalizedText("msg-11") //Enhorabuena. Acabas de apuntarte a un torneo de práctica.
                )
                .then((_) {
                  router.go('live_contest', {"contestId": TrainingContestInstance["_id"], "parent": "my_contests"});
                })
                .catchError((e) {
                });
              },
              'view_contest': () {
                ViewContestComp liveContest = context;

                openModal(
                  text: () => getLocalizedText("msg-12") //Ésta es la pantalla de simulación
                )
                .then((_) {
                  var completer = new Completer();

                  //Aquí podrás ver los puntos conseguidos por tus jugadores
                  showTooltip(new ToolTip("fantasy-team", tipText: getLocalizedText("msg-13"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                    //Aquí puedes ver tu puntuación frente a los rivales
                    showTooltip(new ToolTip("#usersList", tipText: getLocalizedText("msg-14"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                      //Haz click...
                      showTooltip(new ToolTip(".user-row", tipId: 'compareUserPoints', tipText: getLocalizedText("msg-14"), highlight: true, position: ToolTip.POSITION_BOTTOM, allowClickOnElement: true, onClickCb: (_) {
                        completer.complete(true);
                      }));
                    }));
                  }));

                  return completer.future;

                  /*
                  openModal(
                    text: () => getLocalizedText("msg-27") //También podrás ver las alineaciones de tus rivales
                  );
                   */
                })
                /*
                .then((_) =>
                  openModal(
                    text: () => getLocalizedText("msg-28") //Aqui se ve la simulación.
                  ))
                   */
                .then((_) {
                  var completer = new Completer();

                  clearTooltips();

                  new Timer(new Duration(seconds: 3), () {
                    if (liveStep + 1 < LiveMatchEventsList.length) {
                      liveStep++;
                      liveContest.updateLive();

                      //Fijate, uno de tus jugadores acaba de conseguir sus primeros puntos
                      showTooltip(new ToolTip(".soccer-player-row[data-id='56260840c1f5fbc410f99549']", delay: new Duration(seconds: 1), tipText: getLocalizedText("msg-15"), highlight: true, position: ToolTip.POSITION_TOP, onClickCb: (_) {
                        new Timer.periodic(new Duration(seconds: 3), (Timer t) {
                            if (liveStep + 1 < LiveMatchEventsList.length) {
                              liveStep++;
                              liveContest.updateLive();
                            }
                            else {
                              completer.complete(true);
                              t.cancel();
                            }
                        });
                      }));

                    }
                  });

                  return completer.future;
                })
                .then((_) =>
                  openModal(
                    text: () => getLocalizedText("msg-16") //Enhorabuena, has ganado tu primer torneo!
                  ))
                .then((_) =>
                  openModal(
                    text: () => getLocalizedText("msg-17") //Esta vez hemos hecho la alineación por ti
                  ))
                .then((_) {
                  CurrentStepId = Tutorial.STEP_END;
                  TutorialService.Instance.skipTutorial(routePath: "join");
                })
                .catchError((e) {
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
    DateTimeService.setFakeDateTime(currentDate);

    CurrentStepId = Tutorial.STEP_BEGIN;
    changeUser(TutorialPlayer(goldBalance: "AUD 1.00"));

    LiveMatchEventsList.add([]);

    getContentJson(PATH + "live-01.json").then((list) {
      LiveMatchEventsList.add(list);
    })
    .then((_) =>
      getContentJson(PATH + "live-02.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-03.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-04.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-05.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-06.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-07.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-08.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-09.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .then((_) =>
      getContentJson(PATH + "live-10.json").then((list) {
        LiveMatchEventsList.add(list);
      })
    )
    .catchError((e) {
    });
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
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "JPY 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
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
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "maxEntries": 10,
        "salaryCap": 70000,
        "entryFee": "AUD 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
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
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
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
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "AUD 10",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
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