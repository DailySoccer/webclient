library template_contest;

import "package:webclient/models/match_event.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/instance_soccer_player.dart";
import "package:webclient/models/prize.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/prizes_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/services/template_service.dart';

class TemplateContest {
  // Tipos de Torneos (deducidos por las características del Contest: maxEntries ~ premios)
  static const TOURNAMENT_FREE            = "FREE";
  static const TOURNAMENT_HEAD_TO_HEAD    = "HEAD_TO_HEAD";
  static const TOURNAMENT_LEAGUE          = "LEAGUE";
  static const TOURNAMENT_FIFTY_FIFTY     = "FIFTY_FIFTY";

  static const COMPETITION_LEAGUE_ES_ID     = "23";
  static const COMPETITION_LEAGUE_UK_ID     = "8";
  static const COMPETITION_LEAGUE_UCL_ID    = "5";
  static const COMPETITION_WORLDCUP_ID      = "4";

  String templateContestId;

  String state;

  String get name {
    if (_name == null) {
      _name = _parsePattern(_namePattern);
    }
    return _name;
  }

  int maxEntries;

  int salaryCap;

  bool simulation = false;
  String specialImage;

  Money entryFee;
  String prizeType;
  num prizeMultiplier;

  Prize get prize {
    if (_prize == null) {
      _prize = PrizesService.getPrize(Prize.getKey(prizeType, maxEntries, _prizePool));
    }
    return _prize;
  }

  String optaCompetitionId;
  List<MatchEvent> matchEvents;

  DateTime startDate;

  Map jsonMapContest;
  static Map jsonMapRoot;
  
  Map<String, String> competitionTypeValues = {
    COMPETITION_LEAGUE_ES_ID:   "LEAGUE_ES"
    ,COMPETITION_LEAGUE_UK_ID:  "LEAGUE_UK"
    ,COMPETITION_LEAGUE_UCL_ID: "CHAMPIONS"
    ,COMPETITION_WORLDCUP_ID:   "WORLDCUP"
  };
  String get competitionType => optaCompetitionId.isNotEmpty ? competitionTypeValues[optaCompetitionId] : "";

  TemplateContest(this.templateContestId);

  TemplateContest.referenceInit(this.templateContestId);

  bool get isActive   => state == "ACTIVE";
  bool get isLive     => state == "LIVE";
  bool get isHistory  => state == "HISTORY";
  bool get isSimulation => simulation;
  bool get hasSpecialImage => specialImage != null && !specialImage.isEmpty;

  bool get needGold => entryFee.isGold;
  bool get needManagerPoints => entryFee.isManagerPoints;
  bool get needEnergy => entryFee.isEnergy;

  Money get prizePool => _prizePool;
  String get prizeTypeName => Prize.typeNames[prizeType];

  List get tournamentTypes => [TOURNAMENT_FREE, TOURNAMENT_HEAD_TO_HEAD, TOURNAMENT_LEAGUE, TOURNAMENT_FIFTY_FIFTY];

  Map<String,String> get tournamentTypeNames {
    return {
      TOURNAMENT_FREE: StringUtils.translate("contestfree", "contest"),
      TOURNAMENT_HEAD_TO_HEAD: StringUtils.translate("contestheadtohead", "contest"),
      TOURNAMENT_LEAGUE: StringUtils.translate("contestleague", "contest"),
      TOURNAMENT_FIFTY_FIFTY: StringUtils.translate("contestfifty", "contest")
    };
  }

  String get tournamentTypeName => tournamentTypeNames[tournamentType];

  String get tournamentType {
    String type;
    switch(prizeType) {
      case Prize.FREE:
        type = (maxEntries == 2) ? TOURNAMENT_HEAD_TO_HEAD : TOURNAMENT_FREE;
        break;
      case Prize.WINNER:
      case Prize.TOP_3:
      case Prize.TOP_THIRD:
        type = (maxEntries == 2) ? TOURNAMENT_HEAD_TO_HEAD : TOURNAMENT_LEAGUE;
        break;
      case Prize.FIFTY_FIFTY:
        type = TOURNAMENT_FIFTY_FIFTY;
        break;
    }
    return type;
  }

  String getPrize(int index) {
    Money prizeValue = prize.getValue(index);
    return (prizeValue.amount > 0) ? "${prizeValue}" : "_";
  }

  /*
   * Carga o un Contest o una LISTA de Contests a partir de JsonObjects
   */
  static List<TemplateContest> loadTemplateContestsFromJsonObject(Map jsonMapRoot) {
    var templateContests = new List<TemplateContest>();

    TemplateContest.jsonMapRoot = jsonMapRoot;
    
    TemplateReferences templateReferences = TemplateService.Instance.references;
    ContestReferences contestReferences = new ContestReferences();

    // Solo 1 contest
    if (jsonMapRoot.containsKey("template_contest")) {
      templateContests.add(new TemplateContest.fromJsonObject(jsonMapRoot["template_contest"], contestReferences));
    }
    // Array de contests
    else {
      templateContests = jsonMapRoot.containsKey("template_contests") ? jsonMapRoot["template_contests"].map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject, contestReferences)).toList() : [];

      // Aceptamos múltiples listas de contests (con mayor o menor información)
      for (int view=0; view<10 && jsonMapRoot.containsKey("template_contest_$view"); view++) {
        templateContests.addAll( jsonMapRoot["template_contest_$view"].map((jsonObject) => new TemplateContest.fromJsonObject(jsonObject, contestReferences)).toList() );
      }
    }

    if (jsonMapRoot.containsKey("soccer_teams")) {
      jsonMapRoot["soccer_teams"].map((jsonMap) => new SoccerTeam.fromJsonObject(jsonMap, templateReferences, contestReferences)).toList();
    }

    if (jsonMapRoot.containsKey("soccer_players")) {
      jsonMapRoot["soccer_players"].map((jsonMap) => new SoccerPlayer.fromJsonObject(jsonMap, templateReferences, contestReferences)).toList();
    }

    if (jsonMapRoot.containsKey("users_info")) {
      jsonMapRoot["users_info"].map((jsonMap) => new User.fromJsonObject(jsonMap, contestReferences)).toList();
    }

    // < FINAL > : Los partidos incluyen información ("liveFantasyPoints") que actualizarán a los futbolistas ("soccer_players")
    if (jsonMapRoot.containsKey("match_events")) {
      jsonMapRoot["match_events"].map((jsonMap) {
        MatchEvent matchEvent = new MatchEvent.fromJsonObject(jsonMap, contestReferences);
        
        // Asociar los soccerTeams
        new SoccerTeam.fromId(matchEvent.soccerTeamA.templateSoccerTeamId, templateReferences, contestReferences);
        new SoccerTeam.fromId(matchEvent.soccerTeamB.templateSoccerTeamId, templateReferences, contestReferences);
        
        return matchEvent;
      }).toList();
    }
    else {
      // Aceptamos múltiples listas de partidos (con mayor o menor información)
      for (int view=0; view<10 && jsonMapRoot.containsKey("match_events_$view"); view++) {
        jsonMapRoot["match_events_$view"].map((jsonMap) { 
          MatchEvent matchEvent = new MatchEvent.fromJsonObject(jsonMap, contestReferences);
          
          // Asociar los soccerTeams
          new SoccerTeam.fromId(matchEvent.soccerTeamA.templateSoccerTeamId, templateReferences, contestReferences);
          new SoccerTeam.fromId(matchEvent.soccerTeamB.templateSoccerTeamId, templateReferences, contestReferences);
          
          return matchEvent;
        }).toList();
      }
    }

    return templateContests;
  }

  /*
   * Factorias de creacion de un Contest
   */
  factory TemplateContest.fromJsonObject(Map jsonMap, ContestReferences references) {
    TemplateContest tContest = references.getTemplateContestById(jsonMap["_id"]);
    return references.getTemplateContestById(jsonMap["_id"])._initFromJsonObject(jsonMap, references);
  }

  /*
   * Inicializacion de los contenidos de un Contest
   */
  TemplateContest _initFromJsonObject(Map jsonMap, ContestReferences references) {
    assert(templateContestId.isNotEmpty);

    this.jsonMapContest = jsonMap;
    
    state = jsonMap.containsKey("state") ? jsonMap["state"] : "ACTIVE";
    _namePattern = jsonMap["name"];
    maxEntries = jsonMap["maxEntries"];
    salaryCap = jsonMap["salaryCap"];
    entryFee = new Money.fromJsonObject(jsonMap["entryFee"]);
    prizeType = jsonMap["prizeType"];
    prizeMultiplier = jsonMap.containsKey("prizeMultiplier") ? jsonMap["prizeMultiplier"] : 0.9;
    simulation = jsonMap.containsKey("simulation") ? jsonMap["simulation"] : false;
    specialImage = jsonMap.containsKey("specialImage") ? jsonMap["specialImage"] : null;

    startDate = DateTimeService.fromMillisecondsSinceEpoch(jsonMap["startDate"]);
    optaCompetitionId = jsonMap.containsKey("optaCompetitionId") && (jsonMap["optaCompetitionId"] != null) ? jsonMap["optaCompetitionId"] : "";
    matchEvents = jsonMap.containsKey("templateMatchEventIds") ? jsonMap["templateMatchEventIds"].map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList() : [];

    String prizeCurrency = entryFee.isEnergy ? Money.CURRENCY_MANAGER : Money.CURRENCY_GOLD;
    _prizePool = new Money.from(prizeCurrency, maxEntries * entryFee.amount * prizeMultiplier);

    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    return this;
  }
  
  String _parsePattern(String text) {
    return text
      .replaceAll("%StartDate", DateTimeService.formatDateWithDayOfTheMonth(startDate))
      .replaceAll("%MaxEntries", "$maxEntries")
      .replaceAll("%SalaryCap", "${(salaryCap ~/ 1000)}")
      .replaceAll("%PrizeType", prizeTypeName)
      .replaceAll("%EntryFee", "${entryFee}")
      .replaceAll("%MockUsers", "");
  }

  String _name;
  String _namePattern;
  Prize _prize;
  Money _prizePool;
}