library tutorial_iniciacion;

import 'package:webclient/utils/string_utils.dart';
import 'dart:async';
import 'dart:convert' show JSON;
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/tooltip_service.dart';

class TutorialIniciacion extends Tutorial {
  static String STEP_1 = "1";

  String get PATH => "tutorial/iniciacion/";

  TutorialIniciacion(ProfileService profileService) : super(profileService) {
    getContentJson(PATH + "instance_soccer_players.json").then((list) => InstanceSoccerPlayerList = list);
    getContentJson(PATH + "soccer_players.json").then((list) => SoccerPlayerList = list);

    var serverCallsWhenActive = joinMaps([defaultServerCalls, {
      "get_active_contests" : (url, postData) => waitCompleter( () => ContestList ),
      "get_active_contest" : (url, postData) => waitCompleter( () => ContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => ContestList ),
      "add_contest_entry": (url, postData) { CurrentStepId = STEP_1; return addContestEntry(postData); }
    }]);

    var serverCallsWhenContestEntry = joinMaps([defaultServerCalls, {
      "get_my_contest_entry": (url, postData) => waitCompleter( () => ContestList ),
      "get_my_active_contests": (url, postData) => waitCompleter( () => ContestList ),
      "get_contest_info" : (url, postData) => waitCompleter( () => ContestList ),
      "get_my_active_contest": (url, postData) => waitCompleter( () => ContestList ),
      "edit_contest_entry": (url, postData) => addContestEntry(postData)
    }]);

    tutorialSteps = {
      Tutorial.STEP_BEGIN: new TutorialStep(
            triggers: {
              'lobby': () => openModal(
                      title: () => getLocalizedText("title-lobby"),
                      text: () => getLocalizedText("text-lobby"),
                      image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg"),
                      onOk: getLocalizedText("next", context: "tutorial")
                    )
                    .then((_) => openModal(
                        title: () => "ORO",
                        text: () => "Participar en torneos cuesta oro. Por ahora comienzas con 5 de Oro, suficiente para entrar en un primer torneo.",
                        image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
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
                        changeTrigger("lobby", () => showTooltip(new ToolTip("#activeContestList .contestSlot", tipText: "Entra en este Torneo", highlight: true)));
                        triggerEnter("lobby");
                        // removeEnter("lobby");
                    }),
              'enter_contest' : () => openModal(
                      title: () => getLocalizedText("title-entercontest"),
                      text: () => getLocalizedText("text-entercontest"),
                      image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    )
                    .then((_) {
                        //showTooltip(new ToolTip("#activeContestList .train", tipText: "Torneo Entrenamiento", delay: new Duration(seconds: 1), duration: new Duration(seconds: 1), highlight: true));
                        //showTooltip(new ToolTip("#activeContestList .real", tipText: "Torneo Oficial", delay: new Duration(seconds: 2), duration: new Duration(seconds: 1), highlight: true));
                        showTooltip(new ToolTip(".totalSalary", tipText: "Entra en este Torneo", delay: new Duration(seconds: 3), duration: new Duration(seconds: 1), highlight: true));
                    }),
              'view_contest_entry': () => openModal(
                      title: () => getLocalizedText("title-viewcontestentry"),
                      text: () => getLocalizedText("text-viewcontestentry"),
                      image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeSuccessXs.jpg" : "welcomeSuccessDesktop.jpg")
                    )
            },
            serverCalls: serverCallsWhenActive
        ),
        STEP_1: new TutorialStep(
            triggers: {
            },
            serverCalls: serverCallsWhenContestEntry
        )
    };
  }

  void activate() {
    CurrentStepId = Tutorial.STEP_BEGIN;
    changeUser(TutorialPlayer(goldBalance: "AUD 5.00"));
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

  Map get ContestList => {
    "contests": [
      TrainingContestInstance,
      OficialContestInstance
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

  Map get OficialContestInstance => {
        "templateContestId": "56331d4dd4c6912cf152f1f4",
        "state": "ACTIVE",
        "name": "Tutorial [Oficial]",
        "contestEntries": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(ContestEntries, element: PlayerEntry) : ContestEntries,
        "templateMatchEventIds": TemplateMatchEventIds,
        "instanceSoccerPlayers": InstanceSoccerPlayerList,
        "maxEntries": 20,
        "salaryCap": 70000,
        "entryFee": "JPY 1",
        "prizeMultiplier": 10.0,
        "prizeType": "FIFTY_FIFTY",
        "startDate": new DateTime.now().add(new Duration(minutes: 120)).millisecondsSinceEpoch,
        "optaCompetitionId": "23",
        "simulation": false,
        "specialImage": "",
        "numEntries": ContestEntries.length,
        "_id":  "OFICIAL-56331d69d4c6912cf152f201"
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
}