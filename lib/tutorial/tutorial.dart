library tutorial;

import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/tooltip_service.dart';
import 'package:webclient/models/user.dart';
import 'package:angular/angular.dart';

class TutorialStep {
  Map<String, Function> triggers;
  Map<String, Function> serverCalls;
  TutorialStep({this.triggers: null, this.serverCalls: null});

  bool hasTrigger(String path) => triggers != null && triggers.containsKey(path);
  void removeTrigger(String path) { if (hasTrigger(path)) triggers.remove(path); }
}

abstract class Tutorial {
  static String INITIATION = "initiation";
  static String OFICIAL_CONTESTS = "oficialContests";
  static String CREATING_CONTESTS = "creatingContests";

  static String KEY_POPUP = "popup";
  static String KEY_TOOLTIPS = "tooltips";

  static String STEP_BEGIN = "begin";
  static String STEP_END = "end";

  String CurrentStepId = STEP_BEGIN;
  TutorialStep get CurrentStep => tutorialSteps[CurrentStepId];

  bool get isCompleted => CurrentStepId == STEP_END;

  void skipTutorial() { CurrentStepId = STEP_END; }

  Tutorial(this.router, this.profileService);

  void activate();

  Future emptyContent({Map content: null}) {
    return new Future.value(content != null ? content : {});
  }

  Map get defaultServerCalls => {
    "get_user_profile": (url, postData) => emptyContent(),
    "get_active_contests" : (url, postData) => emptyContent(),
    "get_active_contest" : (url, postData) => emptyContent(),
    "get_contest_info" : (url, postData) => emptyContent(),
    "get_instance_soccer_player_info": (url, postData) => emptyContent(),
    "get_my_active_contests": (url, postData) => emptyContent(),
    "get_my_live_contests": (url, postData) => emptyContent(),
    "get_my_history_contests": (url, postData) => emptyContent(),
    "add_contest_entry": (url, postData) => emptyContent(),
    "get_my_contest_entry": (url, postData) => emptyContent(),
    "get_my_active_contest": (url, postData) => emptyContent(),
    "count_my_live_contests": (url, postData) => emptyContent(),
    "get_live_match_events": (url, postData) => emptyContent(content: { "content": [] })
  };

  Map joinMaps(List<Map> maps) {
    Map result = {};
    for (Map map in maps) {
      result.addAll(map);
    }
    return result;
  }

  List joinLists(List<Map> maps, {Map element: null}) {
    List result = [];
    for (Map map in maps) {
      result.add(map);
    }
    if (element != null) {
      result.add(element);
    }
    return result;
  }

  String bodyDefault(String text(), String image({String size})) =>
      (image == null)
      ? '''
        <div class="tut-title">${text()}</div>
      '''
      : '''
        <div class="tut-title">${text()}</div>
        <img class="tut-image-xs" src="${image(size:'xs')}"/>
        <img class="tut-image" src="${image()}"/>
      ''';

  Future openModal({String title(): null, String text(): null, String image({String size}): null, String body(): null, String onOk: null}) {
    return modalShow(title != null ? title() : "", body != null ? body() : bodyDefault(text, image), type: 'welcome', modalSize: "md", onOk: onOk != null ? onOk : StringUtils.translate("next", "tutorial"));
  }

  void clearTooltips() {
    ToolTipService.instance.clear();
  }

  void showTooltip(ToolTip tooltip) {
    ToolTipService.instance.tipElement(tooltip, hideOnClick: (tooltip.hasDuration || tooltip.isClickable));
  }

  void triggerEnter(String trigger, {Object component: null}) {
    if (CurrentStep.hasTrigger(trigger) && CurrentStep.triggers[trigger] != null) {
      context = component;
      CurrentStep.triggers[trigger]();

      /*
      ToolTip firstTip = new ToolTip("#activeContestList .contestSlot",
                                              tipText: "Tip sin highlight",
                                              delay: new Duration(seconds: 1),
                                              highlight: false);

      ToolTip secondTip_1 = new ToolTip("week-calendar .week-calendar", tipText: "Tip dependiente de la primera", delay: new Duration(milliseconds: 200));
      ToolTip secondTip_2 = new ToolTip("#activeContestList .contestSlot", tipText: "Tip simultanea y con retardo", delay: new Duration(seconds: 2), position: "bottom");

      ToolTipService.instance.tipElement(firstTip, hideOnClick: true);
      firstTip.onHide.listen((_) => ToolTipService.instance.tipMultipleElement([secondTip_1, secondTip_2], hideAllOnClick: true));
       */

      // CurrentStep.removeEnter(stage);
    }
  }

  void changeUser(Map userJsonMap) {
    userBackup = profileService.isLoggedIn ? profileService.user : null;
    profileService.user = new User.fromJsonObject(userJsonMap);
  }

  void restoreUser() {
    profileService.user = userBackup;
  }

  void changeTrigger(String trigger, Function function) {
    CurrentStep.triggers[trigger] = function;
  }

  void removeTrigger(String stage) {
    CurrentStep.removeTrigger(stage);
  }

  Future getContentJson(String fileName) {
    var completer = new Completer();
    HttpRequest.getString(fileName).then((json) {
        completer.complete(JSON.decode(json));
      });
    return completer.future;
  }

  Future waitCompleter(Function callback) {
    // TODO: Cuando estamos en desarrollo y el simulador no está activo, se tarda tiempo en configurar el fakeTime
    if (DateTimeService.isReady) {
      return new Future.value(callback());
    }
    else {
      var completer = new Completer();
      new Timer.periodic(new Duration(milliseconds: 100), (Timer t) {
        if (DateTimeService.isReady) {
          completer.complete(callback());
          t.cancel();
        }
      });
      return completer.future;
    }
  }

  final String ATHLETIC_CLUB = "5625d0ecc1f5fbc410e6ec7a";
  final String ATLETICO_MADRID = "5625d0ecc1f5fbc410e6ec7c";
  final String BARCELONA = "5625d0edc1f5fbc410e6ec7e";
  final String CELTA_DE_VIGO = "5625d0edc1f5fbc410e6ec80";
  final String DEPORTIVO_CORUNYA = "5625d0edc1f5fbc410e6ec84";
  final String EIBAR = "5625d0edc1f5fbc410e6ec86";
  final String ESPANYOL = "5625d0edc1f5fbc410e6ec8a";
  final String GETAFE = "5625d0edc1f5fbc410e6ec8c";
  final String GRANADA = "5625d0edc1f5fbc410e6ec8e";
  final String LEVANTE = "5625d0edc1f5fbc410e6ec90";
  final String MALAGA = "5625d0edc1f5fbc410e6ec92";
  final String RAYO_VALLECANO = "5625d0edc1f5fbc410e6ec94";
  final String REAL_MADRID = "5625d0edc1f5fbc410e6ec96";
  final String REAL_SOCIEDAD = "5625d0edc1f5fbc410e6ec98";
  final String SEVILLA = "5625d0edc1f5fbc410e6ec9a";
  final String VALENCIA = "5625d0edc1f5fbc410e6ec9c";
  final String VILLARREAL = "5625d0edc1f5fbc410e6ec9e";
  final String LAS_PALMAS = "56260840c1f5fbc410f99492";
  final String REAL_BETIS = "56260840c1f5fbc410f99494";
  final String SPORTING_GIJON = "56260840c1f5fbc410f99496";

  String get KeyLocalStorage => TutorialPlayer()["userId"]+"#23";

  Map TutorialPlayer({String goldBalance: null}) => {
    "userId":"PLAYER-5625d093d4c6ebe295987fd1",
    "firstName": "Player",
    "lastName": "XXX",
    "nickName":"Player",
    "email": "player@epiceleven.com",
    "wins":0,
    "trueSkill":0,
    "earnedMoney": "AUD 0.00",
    "goldBalance": goldBalance != null ? goldBalance : "AUD 0.00"
  };

  List get UsersInfo => [
    {
      "userId":"USER01-5625d093d4c6ebe295987fd1",
      "nickName":"User01",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    },
    {
      "userId":"USER02-5625d093d4c6ebe295987fd6",
      "nickName":"User02",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    },
    {
      "userId":"USER03-5625d093d4c6ebe295987fd8",
      "nickName":"User03",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    },
    {
      "userId":"USER04-5625d093d4c6ebe295987fdb",
      "nickName":"User04",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    },
    {
      "userId":"USER05-5625d093d4c6ebe295987fde",
      "nickName":"User05",
      "wins":0,
      "trueSkill":0,
      "earnedMoney":"AUD 0.00"
    }
    ];

  List get TemplateMatchEventIds => [
    "56459d29d4c67b6c0b0ada5c", //"56331d69d4c6912cf152f1f7",
    "56459d29d4c67b6c0b0ada5d", //"56331d69d4c6912cf152f1f8",
    "56459d29d4c67b6c0b0ada5e", //"56331d69d4c6912cf152f1f9",
    "56459d29d4c67b6c0b0ada5f", //"56331d69d4c6912cf152f1fa",
    "56459d29d4c67b6c0b0ada60", //"56331d69d4c6912cf152f1fb",
    "56459d29d4c67b6c0b0ada61", //"56331d69d4c6912cf152f1fc",
    "56459d29d4c67b6c0b0ada62", //"56331d69d4c6912cf152f1fd",
    "56459d29d4c67b6c0b0ada63", //"56331d69d4c6912cf152f1fe",
    "56459d29d4c67b6c0b0ada64", //"56331d69d4c6912cf152f1ff",
    "56459d29d4c67b6c0b0ada65"  //"56331d69d4c6912cf152f200"
  ];

  List get MatchEvents => [
    {
      "templateSoccerTeamAId":RAYO_VALLECANO,
      "templateSoccerTeamBId":ESPANYOL,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[0]
    },
    {
      "templateSoccerTeamAId":CELTA_DE_VIGO,
      "templateSoccerTeamBId":REAL_MADRID,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[1]
    },
    {
      "templateSoccerTeamAId":GRANADA,
      "templateSoccerTeamBId":REAL_BETIS,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[2]
    },
    {
      "templateSoccerTeamAId":SEVILLA,
      "templateSoccerTeamBId":GETAFE,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[3]
    },
    {
      "templateSoccerTeamAId":MALAGA,
      "templateSoccerTeamBId":DEPORTIVO_CORUNYA,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[4]
    },
    {
      "templateSoccerTeamAId":LEVANTE,
      "templateSoccerTeamBId":REAL_SOCIEDAD,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[5]
    },
    {
      "templateSoccerTeamAId":LAS_PALMAS,
      "templateSoccerTeamBId":VILLARREAL,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[6]
    },
    {
      "templateSoccerTeamAId":BARCELONA,
      "templateSoccerTeamBId":EIBAR,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[7]
    },
    {
      "templateSoccerTeamAId":ATLETICO_MADRID,
      "templateSoccerTeamBId":VALENCIA,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[8]
    },
    {
      "templateSoccerTeamAId":ATHLETIC_CLUB,
      "templateSoccerTeamBId":SPORTING_GIJON,
      "period":"PRE_GAME",
      "minutesPlayed":0,
      "startDate":1445335200000,
      "_id":TemplateMatchEventIds[9]
     }
  ];

  List get SoccerTeams => [
    {"name":"Athletic Club","shortName":"ATH","_id":ATHLETIC_CLUB},
    {"name":"Atlético de Madrid","shortName":"ATM","_id":ATLETICO_MADRID},
    {"name":"Barcelona","shortName":"BCN","_id":BARCELONA},
    {"name":"Celta de Vigo","shortName":"CEL","_id":CELTA_DE_VIGO},
    {"name":"Deportivo de La Coruña","shortName":"DEP","_id":DEPORTIVO_CORUNYA},
    {"name":"Eibar","shortName":"EIB","_id":EIBAR},
    {"name":"Espanyol","shortName":"ESP","_id":ESPANYOL},
    {"name":"Getafe","shortName":"GET","_id":GETAFE},
    {"name":"Granada CF","shortName":"GRA","_id":GRANADA},
    {"name":"Levante","shortName":"LEV","_id":LEVANTE},
    {"name":"Málaga","shortName":"MAL","_id":MALAGA},
    {"name":"Rayo Vallecano","shortName":"RAY","_id":RAYO_VALLECANO},
    {"name":"Real Madrid","shortName":"RMD","_id":REAL_MADRID},
    {"name":"Real Sociedad","shortName":"RSO","_id":REAL_SOCIEDAD},
    {"name":"Sevilla","shortName":"SEV","_id":SEVILLA},
    {"name":"Valencia CF","shortName":"VAL","_id":VALENCIA},
    {"name":"Villarreal","shortName":"VIL","_id":VILLARREAL},
    {"name":"Las Palmas","shortName":"LPA","_id":LAS_PALMAS},
    {"name":"Real Betis","shortName":"BET","_id":REAL_BETIS},
    {"name":"Sporting de Gijón","shortName":"SPG","_id":SPORTING_GIJON}
  ];

  HashMap<String, TutorialStep> tutorialSteps;
  User userBackup;

  Object context;
  ProfileService profileService;
  Router router;
}