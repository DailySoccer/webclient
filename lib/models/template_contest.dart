library template_contest;

import "package:json_object/json_object.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class TemplateContest {
  // Tipos de Premios (obtenidos del backend)
  static const PRIZE_FREE                 = "FREE";
  static const PRIZE_WINNER               = "WINNER_TAKES_ALL";
  static const PRIZE_TOP_3                = "TOP_3_GET_PRIZES";
  static const PRIZE_TOP_THIRD            = "TOP_THIRD_GET_PRIZES";
  static const PRIZE_FIFTY_FIFTY          = "FIFTY_FIFTY";

  // Tipos de Torneos (deducidos por las características del TemplateContest: maxEntries ~ premios)
  static const TOURNAMENT_FREE            = "FREE";
  static const TOURNAMENT_HEAD_TO_HEAD    = "HEAD_TO_HEAD";
  static const TOURNAMENT_LEAGUE          = "LEAGUE";
  static const TOURNAMENT_FIFTY_FIFTY     = "FIFTY_FIFTY";

  static const SALARY_LIMIT_FOR_BEGGINERS = 90000;
  static const SALARY_LIMIT_FOR_STANDARDS = 80000;
  static const SALARY_LIMIT_FOR_SKILLEDS  = 70000;

  static const TIER_BEGGINER              = "BEGGINER";
  static const TIER_STANDARD              = "STANDARDS";
  static const TIER_SKILLED               = "SKILLEDS";

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

  String get tier {

    if (salaryCap >= SALARY_LIMIT_FOR_BEGGINERS)
      return TIER_BEGGINER;
    else if (salaryCap < SALARY_LIMIT_FOR_BEGGINERS && salaryCap > SALARY_LIMIT_FOR_SKILLEDS)
      return TIER_STANDARD;
    else
      return TIER_SKILLED;
  }

  int entryFee;
  String prizeType;
  List<int> prizes;

  List<MatchEvent> matchEvents;

  TemplateContest(this.templateContestId, this._namePattern, this.maxEntries,
          this.salaryCap, this.entryFee, this.prizeType, this.matchEvents);

  TemplateContest.referenceInit(this.templateContestId);

  bool get isActive => state == "ACTIVE";
  bool get isLive => state == "LIVE";
  bool get isHistory => state == "HISTORY";

  Map<String, String> prizeTypeNames = {
    PRIZE_FREE: "Free",
    PRIZE_WINNER: "Winner takes all",
    PRIZE_TOP_3: "Top 3 get prizes",
    PRIZE_TOP_THIRD: "Top third get prizes",
    PRIZE_FIFTY_FIFTY: "50/50"
  };

  int get prizePool => ((maxEntries * entryFee) * 0.90).toInt();
  String get prizeTypeName => prizeTypeNames[prizeType];

  List get tournamentTypes => [TOURNAMENT_FREE, TOURNAMENT_HEAD_TO_HEAD, TOURNAMENT_LEAGUE, TOURNAMENT_FIFTY_FIFTY];

  Map<String,String> get tournamentTypeNames {
    return {
      TOURNAMENT_FREE: "Free",
      TOURNAMENT_HEAD_TO_HEAD: "Head-to-head",
      TOURNAMENT_LEAGUE: "Liga",
      TOURNAMENT_FIFTY_FIFTY: "50/50"
    };
  }

  String get tournamentTypeName => tournamentTypeNames[tournamentType];

  String get tournamentType {
    String type;
    switch(prizeType) {
      case TemplateContest.PRIZE_FREE:
        type = TOURNAMENT_FREE;
        break;
      case TemplateContest.PRIZE_WINNER:
      case TemplateContest.PRIZE_TOP_3:
      case TemplateContest.PRIZE_TOP_THIRD:
        type = (maxEntries == 2) ? TOURNAMENT_HEAD_TO_HEAD : TOURNAMENT_LEAGUE;
        break;
      case TemplateContest.PRIZE_FIFTY_FIFTY:
        type = TOURNAMENT_FIFTY_FIFTY;
        break;
    }
    return type;
  }

  DateTime get startDate => matchEvents.map((matchEvent) => matchEvent.startDate)
                                               .reduce((val, elem) => val.isBefore(elem)? val : elem);

  factory TemplateContest.fromJsonObject(JsonObject json, ContestReferences references) {
    return references.getTemplateContestById(json._id)._initFromJsonObject(json, references);
  }

  factory TemplateContest.fromJsonString(String json, ContestReferences references) {
    return new TemplateContest.fromJsonObject(new JsonObject.fromJsonString(json), references);
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = null;

    // Buscar en la lista de partidos del contest
    for (MatchEvent match in matchEvents) {
      soccerPlayer = match.findSoccerPlayer(soccerPlayerId);

      // Lo hemos encontrado?
      if (soccerPlayer != null)
        break;
    }

    return soccerPlayer;
  }

  TemplateContest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateContestId.isNotEmpty);
    state = json.state;
    _namePattern = json.name;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    prizes = json.containsKey("prizes") ? json.prizes : [];
    matchEvents = json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList();

    // print( "TemplateContest: id($templateContestId) name($name) maxEntries($maxEntries) salaryCap($salaryCap) entryFee($entryFee) prizeType($prizeType) templateMatchEventIds($templateMatchEventIds)");
    return this;
  }

  String _parsePattern(String text) {
    return text
      .replaceAll("%StartDate", DateTimeService.formatDateWithDayOfTheMonth(startDate))
      .replaceAll("%MaxEntries", "$maxEntries")
      .replaceAll("%SalaryCap", "${(salaryCap ~/ 1000)}")
      .replaceAll("%PrizeType", prizeTypeName)
      .replaceAll("%EntryFee", "${entryFee}");
  }

  String _name;
  String _namePattern;
}