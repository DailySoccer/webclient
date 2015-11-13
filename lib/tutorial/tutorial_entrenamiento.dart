library tutorial_entrenamiento;

import 'package:webclient/utils/string_utils.dart';
import 'dart:async';
import 'dart:convert' show JSON;
import 'package:webclient/tutorial/tutorial.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/tooltip_service.dart';
import 'package:angular/angular.dart';

class TutorialEntrenamiento extends Tutorial {
  static String STEP_1 = "1";

  String get PATH => "tutorial/entrenamiento/";
  String get name => "TUTORIAL_ENTRENAMIENTO";

  TutorialEntrenamiento(Router router, ProfileService profileService) : super(router, profileService) {
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
                      image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeLobbyXs.jpg" : "welcomeLobbyDesktop.jpg")
                    ),
              'enter_contest': () => openModal(
                      title: () => getLocalizedText("title-entercontest"),
                      text: () => getLocalizedText("text-entercontest"),
                      image: ({String size: ''}) => "images/tutorial/" + (size == 'xs' ? "welcomeTeamXs.jpg" : "welcomeTeamDesktop.jpg")
                    ),
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

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorial_entrenamiento");
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
      ContestInstance
      ],
      "users_info": profileService.isLoggedIn && FantasyTeam.isNotEmpty ? joinLists(UsersInfo, element: PlayerInfo) : UsersInfo,
      "match_events": MatchEvents,
      "soccer_teams": SoccerTeams,
      "soccer_players": SoccerPlayerList
  };

  Map get ContestInstance => {
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
        "_id":  "TUTORIAL-56331d69d4c6912cf152f201"
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