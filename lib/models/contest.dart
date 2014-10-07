library contest;

import "package:json_object/json_object.dart";
import "package:webclient/models/match_event.dart";
import "package:webclient/models/user.dart";
import "package:webclient/models/contest_entry.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import "package:webclient/models/field_pos.dart";
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

  static const SALARY_LIMIT_FOR_BEGGINERS = 70000;
  static const SALARY_LIMIT_FOR_STANDARDS = 65000;
  static const SALARY_LIMIT_FOR_SKILLEDS  = 60000;

  static const TIER_BEGGINER              = "BEGGINER";
  static const TIER_STANDARD              = "STANDARD";
  static const TIER_SKILLED               = "SKILLEDS";

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
  Map<String, InstanceSoccerPlayer> instanceSoccerPlayers = new Map<String, InstanceSoccerPlayer>();

  DateTime startDate;

  String get description => "${tournamentTypeName}: ${numEntries} de ${maxEntries} jugadores - Límite de salario: ${salaryCap}";

  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  Contest(this.contestId, this.contestEntries);

  Contest.referenceInit(this.contestId);

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

  bool isSoccerPlayerValid(SoccerPlayer soccerPlayer) {
    return instanceSoccerPlayers.containsKey(soccerPlayer.templateSoccerPlayerId);
  }

  int getSalary(SoccerPlayer soccerPlayer) {
    return instanceSoccerPlayers[soccerPlayer.templateSoccerPlayerId].salary;
  }

  FieldPos getFieldPos(SoccerPlayer soccerPlayer) {
    return instanceSoccerPlayers[soccerPlayer.templateSoccerPlayerId].fieldPos;
  }

  /*
   * Carga o un Contest o una LISTA de Contests a partir de JsonObjects
   */
  static List<Contest> loadContestsFromJsonObject(JsonObject jsonRoot) {
    var contests = new List<Contest>();

    ContestReferences contestReferences = new ContestReferences();

    // Solo 1 contest
    if (jsonRoot.containsKey("contest")) {
      contests.add(new Contest.fromJsonObject(jsonRoot.contest, contestReferences));
    }
    // Array de contests
    else {
      contests = jsonRoot.containsKey("contests") ? jsonRoot.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList() : [];

      // Aceptamos múltiples listas de contests (con mayor o menor información)
      for (int view=0; view<10 && jsonRoot.containsKey("contests_$view"); view++) {
          contests.addAll( jsonRoot["contests_$view"].map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList() );
      }
    }

    if (jsonRoot.containsKey("soccer_teams")) {
      jsonRoot.soccer_teams.map((jsonObject) => new SoccerTeam.fromJsonObject(jsonObject, contestReferences)).toList();
    }

    if (jsonRoot.containsKey("soccer_players")) {
      jsonRoot.soccer_players.map((jsonObject) => new SoccerPlayer.fromJsonObject(jsonObject, contestReferences)).toList();
    }

    if (jsonRoot.containsKey("users_info")) {
      jsonRoot.users_info.map((jsonObject) => new User.fromJsonObject(jsonObject, contestReferences)).toList();
    }

    // < FINAL > : Los partidos incluyen información ("liveFantasyPoints") que actualizarán a los futbolistas ("soccer_players")
    if (jsonRoot.containsKey("match_events")) {
      jsonRoot.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
    }
    else {
      // Aceptamos múltiples listas de partidos (con mayor o menor información)
      for (int view=0; view<10 && jsonRoot.containsKey("match_events_$view"); view++) {
          jsonRoot["match_events_$view"].map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
      }
    }

    return contests;
  }

  /*
   * Factorias de creacion de un Contest
   */
  factory Contest.fromJsonObject(JsonObject json, ContestReferences references) {
    return references.getContestById(json._id)._initFromJsonObject(json, references);
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

  /*
   * Inicializacion de los contenidos de un Contest
   */
  Contest _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(contestId.isNotEmpty);

    templateContestId = json.templateContestId;

    contestEntries = json.containsKey("contestEntries") ? json.contestEntries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject, references) .. contest = this ).toList() : [];
    numEntries = json.containsKey("numEntries") ? json.numEntries : contestEntries.length;

    state = json.containsKey("state") ? json.state : "ACTIVE";
    _namePattern = json.name;
    maxEntries = json.maxEntries;
    salaryCap = json.salaryCap;
    entryFee = json.entryFee;
    prizeType = json.prizeType;
    prizes = json.containsKey("prizes") ? json.prizes : [];
    startDate = DateTimeService.fromMillisecondsSinceEpoch(json.startDate);
    matchEvents = json.containsKey("templateMatchEventIds") ? json.templateMatchEventIds.map( (matchEventId) => references.getMatchEventById(matchEventId) ).toList() : [];

    instanceSoccerPlayers = {};
    if (json.containsKey("instanceSoccerPlayers")) {
      json.instanceSoccerPlayers.forEach((jsonObject) {
        InstanceSoccerPlayer instanceSoccerPlayer =  new InstanceSoccerPlayer.initFromJsonObject(jsonObject);
        instanceSoccerPlayers[instanceSoccerPlayer.templateSoccerPlayerId] = instanceSoccerPlayer;
      });
    }

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
      .replaceAll("%EntryFee", "${entryFee}");
  }

  String _name;
  String _namePattern;
}