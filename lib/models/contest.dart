library contest;

import "package:webclient/models/match_event.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/instance_soccer_player.dart";
import 'package:webclient/services/contest_references.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/string_utils.dart';

class Contest {
  // Tipos de Premios (obtenidos del backend)
  static const PRIZE_FREE                 = "FREE";
  static const PRIZE_WINNER               = "WINNER_TAKES_ALL";
  static const PRIZE_TOP_3                = "TOP_3_GET_PRIZES";
  static const PRIZE_TOP_THIRD            = "TOP_THIRD_GET_PRIZES";
  static const PRIZE_FIFTY_FIFTY          = "FIFTY_FIFTY";

  // Tipos de Torneos (deducidos por las características del Contest: maxEntries ~ premios)
  static const TOURNAMENT_FREE            = "FREE";
  static const TOURNAMENT_HEAD_TO_HEAD    = "HEAD_TO_HEAD";
  static const TOURNAMENT_LEAGUE          = "LEAGUE";
  static const TOURNAMENT_FIFTY_FIFTY     = "FIFTY_FIFTY";

  static const SALARY_LIMIT_FOR_BEGINNERS = 70000;
  static const SALARY_LIMIT_FOR_STANDARDS = 65000;
  static const SALARY_LIMIT_FOR_SKILLEDS  = 60000;

  static const TIER_BEGINNER              = "BEGINNER";
  static const TIER_STANDARD              = "STANDARD";
  static const TIER_SKILLED               = "SKILLEDS";

  static const COMPETITION_LEAGUE_ES_ID     = "23";
  static const COMPETITION_LEAGUE_UK_ID     = "8";
  static const COMPETITION_LEAGUE_UCL_ID    = "5";
  static const COMPETITION_WORLDCUP_ID      = "4";

  String contestId;
  String templateContestId;

  String state;

  String get name {
    if (_name == null) {
      _name = _parsePattern(_namePattern);
    }
    return _name;
  }

  List<ContestEntry> contestEntries;
  int numEntries;

  int maxEntries;

  int salaryCap;

  String get tier {
    if (salaryCap >= SALARY_LIMIT_FOR_BEGINNERS)
      return TIER_BEGINNER;
    else if (salaryCap < SALARY_LIMIT_FOR_BEGINNERS && salaryCap > SALARY_LIMIT_FOR_SKILLEDS)
      return TIER_STANDARD;
    else
      return TIER_SKILLED;
  }

  int entryFee;
  String prizeType;
  List<int> prizes;

  String optaCompetitionId;
  List<MatchEvent> matchEvents;
  Map<String, InstanceSoccerPlayer> instanceSoccerPlayers = new Map<String, InstanceSoccerPlayer>();

  DateTime startDate;

  String get description  {
   // print("estado del concurso: ${state}");
    /* los partidos en vivo o en history no continen los participantes que tiene el concurso */
    if(isLive || isHistory) {
      return "${tournamentTypeName} - Límite de salario: ${salaryCap}";
    }
    return "${tournamentTypeName}: ${numEntries} de ${maxEntries} participantes - Límite de salario: ${salaryCap}";
  }

  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  Map<String, String> competitionTypeValues = {
    COMPETITION_LEAGUE_ES_ID:   "LEAGUE_ES"
    ,COMPETITION_LEAGUE_UK_ID:  "LEAGUE_UK"
    ,COMPETITION_LEAGUE_UCL_ID: "CHAMPIONS"
    ,COMPETITION_WORLDCUP_ID:   "WORLDCUP"
  };
  String get competitionType => optaCompetitionId.isNotEmpty ? competitionTypeValues[optaCompetitionId] : "";

  Contest(this.contestId, this.contestEntries);

  Contest.referenceInit(this.contestId);

  bool get isActive   => state == "ACTIVE";
  bool get isLive     => state == "LIVE";
  bool get isHistory  => state == "HISTORY";

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
      TOURNAMENT_FREE: "Gratuito",
      TOURNAMENT_HEAD_TO_HEAD: "1 contra 1",
      TOURNAMENT_LEAGUE: "Liga",
      TOURNAMENT_FIFTY_FIFTY: "50/50"
    };
  }

  String get tournamentTypeName => tournamentTypeNames[tournamentType];

  String get tournamentType {
    String type;
    switch(prizeType) {
      case Contest.PRIZE_FREE:
        type = (maxEntries == 2) ? TOURNAMENT_HEAD_TO_HEAD : TOURNAMENT_FREE;
        break;
      case Contest.PRIZE_WINNER:
      case Contest.PRIZE_TOP_3:
      case Contest.PRIZE_TOP_THIRD:
        type = (maxEntries == 2) ? TOURNAMENT_HEAD_TO_HEAD : TOURNAMENT_LEAGUE;
        break;
      case Contest.PRIZE_FIFTY_FIFTY:
        type = TOURNAMENT_FIFTY_FIFTY;
        break;
    }
    return type;
  }

  bool containsContestEntryWithUser(String userId) {
    return getContestEntryWithUser(userId) != null;
  }

  ContestEntry getContestEntry(String contestEntryId) {
    return contestEntries.firstWhere( (entry) => entry.contestEntryId == contestEntryId, orElse: () => null );
  }

  ContestEntry getContestEntryWithUser(String userId) {
    return contestEntries.firstWhere( (entry) => entry.user.userId == userId, orElse: () => null );
  }

  int getUserPosition(ContestEntry contestEntry) {
    List<ContestEntry> contestsEntries = contestEntriesOrderByPoints;
    for (int i=0; i<contestsEntries.length; i++) {
      if (contestsEntries[i].contestEntryId == contestEntry.contestEntryId)
        return i+1;
    }
    return -1;
  }

  int getPercentOfUsersThatOwn(SoccerPlayer soccerPlayer) {
    int numOwners = contestEntries.fold(0, (prev, contestEntry) => contestEntry.contains(soccerPlayer) ? (prev + 1) : prev );
    return (numOwners * 100 / contestEntries.length).truncate();
  }

  InstanceSoccerPlayer getInstanceSoccerPlayer(String instanceSoccerPlayerId) {
    return instanceSoccerPlayers.containsKey(instanceSoccerPlayerId) ? instanceSoccerPlayers[instanceSoccerPlayerId] : null;
  }

  String getPrize(int index) {
    String prizeText = "-";
    if (index < prizes.length) {
      prizeText = "${prizes[index]}€";
    }
    return prizeText;
  }

  /*
   * Carga o un Contest o una LISTA de Contests a partir de JsonObjects
   */
  static List<Contest> loadContestsFromJsonObject(Map jsonMapRoot) {
    var contests = new List<Contest>();

    ContestReferences contestReferences = new ContestReferences();

    // Solo 1 contest
    if (jsonMapRoot.containsKey("contest")) {
      contests.add(new Contest.fromJsonObject(jsonMapRoot["contest"], contestReferences));
    }
    // Array de contests
    else {
      contests = jsonMapRoot.containsKey("contests") ? jsonMapRoot["contests"].map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList() : [];

      // Aceptamos múltiples listas de contests (con mayor o menor información)
      for (int view=0; view<10 && jsonMapRoot.containsKey("contests_$view"); view++) {
          contests.addAll( jsonMapRoot["contests_$view"].map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList() );
      }
    }

    if (jsonMapRoot.containsKey("soccer_teams")) {
      jsonMapRoot["soccer_teams"].map((jsonMap) => new SoccerTeam.fromJsonObject(jsonMap, contestReferences)).toList();
    }

    if (jsonMapRoot.containsKey("soccer_players")) {
      jsonMapRoot["soccer_players"].map((jsonMap) => new SoccerPlayer.fromJsonObject(jsonMap, contestReferences)).toList();
    }

    if (jsonMapRoot.containsKey("users_info")) {
      jsonMapRoot["users_info"].map((jsonMap) => new User.fromJsonObject(jsonMap, contestReferences)).toList();
    }

    // < FINAL > : Los partidos incluyen información ("liveFantasyPoints") que actualizarán a los futbolistas ("soccer_players")
    if (jsonMapRoot.containsKey("match_events")) {
      jsonMapRoot["match_events"].map((jsonMap) => new MatchEvent.fromJsonObject(jsonMap, contestReferences)).toList();
    }
    else {
      // Aceptamos múltiples listas de partidos (con mayor o menor información)
      for (int view=0; view<10 && jsonMapRoot.containsKey("match_events_$view"); view++) {
        jsonMapRoot["match_events_$view"].map((jsonMap) => new MatchEvent.fromJsonObject(jsonMap, contestReferences)).toList();
      }
    }

    return contests;
  }

  /*
   * Factorias de creacion de un Contest
   */
  factory Contest.fromJsonObject(Map jsonMap, ContestReferences references) {
    return references.getContestById(jsonMap["_id"])._initFromJsonObject(jsonMap, references);
  }

  /*
   * Inicializacion de los contenidos de un Contest
   */
  Contest _initFromJsonObject(Map jsonMap, ContestReferences references) {
    assert(contestId.isNotEmpty);

    templateContestId = jsonMap["templateContestId"];

    state = jsonMap.containsKey("state") ? jsonMap["state"] : "ACTIVE";
    _namePattern = jsonMap["name"];
    maxEntries = jsonMap["maxEntries"];
    salaryCap = jsonMap["salaryCap"];
    entryFee = jsonMap["entryFee"];
    prizeType = jsonMap["prizeType"];
    prizes = jsonMap.containsKey("prizes") ? jsonMap["prizes"] : [];
    startDate = DateTimeService.fromMillisecondsSinceEpoch(jsonMap["startDate"]);
    optaCompetitionId = jsonMap.containsKey("optaCompetitionId") && (jsonMap["optaCompetitionId"] != null) ? jsonMap["optaCompetitionId"] : "";
    matchEvents = jsonMap.containsKey("templateMatchEventIds") ? jsonMap["templateMatchEventIds"].map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList() : [];

    instanceSoccerPlayers = {};
    if (jsonMap.containsKey("instanceSoccerPlayers")) {
      jsonMap["instanceSoccerPlayers"].forEach((jsonObject) {
        InstanceSoccerPlayer instanceSoccerPlayer =  new InstanceSoccerPlayer.initFromJsonObject(jsonObject, references);
        instanceSoccerPlayers[instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId] = instanceSoccerPlayer;
      });
    }

    // <FINAL> : Necesita acceso a los instanceSoccerPlayers
    contestEntries = jsonMap.containsKey("contestEntries") ? jsonMap["contestEntries"].map((jsonMap) => new ContestEntry.initFromJsonObject(jsonMap, references, this) ).toList() : [];
    numEntries = jsonMap.containsKey("numEntries") ? jsonMap["numEntries"] : contestEntries.length;

    // print("Contest: id($contestId) name($name) currentUserIds($currentUserIds) templateContestId($templateContestId)");
    return this;
  }

  int compareNameTo(Contest contest){
    int comp = StringUtils.normalize(name).compareTo(StringUtils.normalize(contest.name));
    return comp != 0 ? comp : contestId.compareTo(contest.contestId);
  }

  int compareEntryFeeTo(Contest contest){
    int comp = entryFee.compareTo(contest.entryFee);
    return comp != 0 ? comp : contestId.compareTo(contest.contestId);
  }

  int compareStartDateTo(Contest contest){
    int comp = startDate.compareTo(contest.startDate);
    return comp != 0 ? comp : contestId.compareTo(contest.contestId);
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
}