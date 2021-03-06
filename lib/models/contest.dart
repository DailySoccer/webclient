library contest;

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
import 'package:webclient/models/competition.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/models/template_soccer_team.dart';
import 'package:webclient/models/template_soccer_player.dart';

class Contest {
  static const MAX_PLAYERS_SAME_TEAM = 4;

  // Tipos de Torneos (deducidos por las características del Contest: maxEntries ~ premios)
  static const TOURNAMENT_FREE            = "FREE";
  static const TOURNAMENT_HEAD_TO_HEAD    = "HEAD_TO_HEAD";
  static const TOURNAMENT_LEAGUE          = "LEAGUE";
  static const TOURNAMENT_FIFTY_FIFTY     = "FIFTY_FIFTY";

  static const SALARY_LIMIT_FOR_BEGINNERS = 75000;
  static const SALARY_LIMIT_FOR_STANDARDS = 70000;
  static const SALARY_LIMIT_FOR_SKILLEDS  = 65000;

  static const TIER_BEGINNER              = "BEGINNER";
  static const TIER_STANDARD              = "STANDARD";
  static const TIER_SKILLED               = "SKILLEDS";

  String contestId;
  String templateContestId;

  String state;

  void set name(String aName) {
    _name = aName;
  }

  String get name {
    if (_name == null) {
      _name = _parsePattern(_namePattern);
    }
    return _name;
  }

  List<ContestEntry> contestEntries;
  int numEntries;

  int minEntries;
  int maxEntries;
  bool get isFull => contestEntries.length == maxEntries;

  int salaryCap;

  int minManagerLevel = 0;
  int maxManagerLevel = User.MAX_MANAGER_LEVEL;
  int minTrueSkill = -1;
  int maxTrueSkill = -1;

  bool simulation = false;
  String authorId = "";
  String specialImage;

  bool isAuthor(User user) => user != null && user.userId == authorId;
  bool isCustomContest() => contestEntries.any((contestEntry) => contestEntry.user.userId == authorId);

  String get printableSalaryCap => StringUtils.parseSalary(salaryCap);


  String get tier {
    if (salaryCap >= SALARY_LIMIT_FOR_BEGINNERS)
      return TIER_BEGINNER;
    else if (salaryCap < SALARY_LIMIT_FOR_BEGINNERS && salaryCap > SALARY_LIMIT_FOR_SKILLEDS)
      return TIER_STANDARD;
    else
      return TIER_SKILLED;
  }

  Money entryFee;
  String prizeType;
  num prizeMultiplier;

  Prize get prize {
    if (_prize == null) {
      _prize = new Prize.fromContest(this); //PrizesService.getPrize(Prize.getKey(prizeType, maxEntries, _prizePool));
    }
    return _prize;
  }

  String optaCompetitionId;
  List<MatchEvent> matchEvents;
  Map<String, InstanceSoccerPlayer> instanceSoccerPlayers = new Map<String, InstanceSoccerPlayer>();

  DateTime startDate;

  String get description  {
   // print("estado del concurso: ${state}");
    /* los partidos en vivo o en history no continen los participantes que tiene el concurso */
    if(isLive || isHistory) {
      return "${tournamentTypeName}";
    }
    return (maxEntries <= 0)
      ? "${tournamentTypeName}: ${numEntries} ${StringUtils.translate("contenders", "contest")} " +
        ((numEntries < minEntries) ? "(${StringUtils.translate("minimum-contenders", "contest", {'NUMERO': minEntries.toString()})})" : "")
      : "${tournamentTypeName}: ${numEntries} ${StringUtils.translate("of", "contest")} ${maxEntries} ${StringUtils.translate("contenders", "contest")} " +
        ((numEntries < minEntries) ? "(${StringUtils.translate("minimum-contenders", "contest", {'NUMERO': minEntries.toString()})})" : "");
  }

  List<ContestEntry> get contestEntriesOrderByPoints {
    List<ContestEntry> entries = new List<ContestEntry>.from(contestEntries);
    entries.sort((entry1, entry2) => entry2.currentLivePoints.compareTo(entry1.currentLivePoints));
    return entries;
  }

  String get competitionType => Competition.competitionType(optaCompetitionId);

  Contest(this.contestId, this.contestEntries);

  Contest.instance();

  Contest.referenceInit(this.contestId);

  Contest.fromInstancesSoccerPlayers(String id, List<InstanceSoccerPlayer> instanceSoccerPlayerList) {
    contestId = id;
    instanceSoccerPlayerList.forEach( (instance) => instanceSoccerPlayers[instance.id] = instance );
  }

  bool get isActive   => state == "ACTIVE";
  bool get isLive     => state == "LIVE";
  bool get isHistory  => state == "HISTORY";
  bool get isSimulation => simulation;
  bool get hasSpecialImage => specialImage != null && !specialImage.isEmpty;

  bool get needGold => entryFee.isGold;
  bool get needManagerPoints => entryFee.isManagerPoints;
  bool get needEnergy => entryFee.isEnergy;

  Money get prizeMin => _prizeMin;
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
    Money prizeValue = prize.getValue(index);
    return (prizeValue.amount > 0) ? "${prizeValue}" : "_";
  }

  /*
   * Carga o un Contest o una LISTA de Contests a partir de JsonObjects
   */
  static List<Contest> loadContestsFromJsonObject(Map jsonMapRoot) {
    var contests = new List<Contest>();

    TemplateReferences templateReferences = TemplateService.Instance.references;
    ContestReferences contestReferences = new ContestReferences();

    // Solo 1 contest
    if (jsonMapRoot.containsKey("contest")) {
      contests.add(new Contest.fromJsonObject(jsonMapRoot["contest"], templateReferences, contestReferences));
    }
    // Array de contests
    else {
      contests = jsonMapRoot.containsKey("contests") ? jsonMapRoot["contests"].map((jsonObject) => new Contest.fromJsonObject(jsonObject, templateReferences, contestReferences)).toList() : [];

      // Aceptamos múltiples listas de contests (con mayor o menor información)
      for (int view=0; view<10 && jsonMapRoot.containsKey("contests_$view"); view++) {
          contests.addAll( jsonMapRoot["contests_$view"].map((jsonObject) => new Contest.fromJsonObject(jsonObject, templateReferences, contestReferences)).toList() );
      }
    }

    //TODO: El tutorial necesita especificar Equipos "especiales"
    if (jsonMapRoot.containsKey("soccer_teams")) {
      jsonMapRoot["soccer_teams"].map((jsonMap) {
        new SoccerTeam.fromJsonObject(jsonMap, templateReferences, contestReferences);
        new TemplateSoccerTeam.fromJsonObject(jsonMap, templateReferences);
      }).toList();
    }

    //TODO: El tutorial necesita especificar Players "especiales"
    if (jsonMapRoot.containsKey("soccer_players")) {
      jsonMapRoot["soccer_players"].map((jsonMap) {
        new SoccerPlayer.fromJsonObject(jsonMap, templateReferences, contestReferences);
        new TemplateSoccerPlayer.fromJsonObject(jsonMap, templateReferences);
      }).toList();
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

    return contests;
  }

  /*
   * Factorias de creacion de un Contest
   */
  factory Contest.fromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    return contestReferences.getContestById(jsonMap["_id"])._initFromJsonObject(jsonMap, templateReferences, contestReferences);
  }

  void updateContestEntriesFromJsonObject(Map jsonMapRoot) {
    contestEntries = jsonMapRoot["contest_entries"].map((jsonMap) => new ContestEntry.initFromJsonObject(jsonMap, _contestReferences, this) ).toList();
    
    // FIX: ContestEntries: Puede que tengan alineaciones inválidas (por copiar una alineación en un torneo)
    // contestEntries.removeWhere( (contestEntry) => contestEntry.instanceSoccerPlayers.any( (instance) => instance == null) );
    
    if (jsonMapRoot.containsKey("soccer_players")) {
      jsonMapRoot["soccer_players"].map((jsonObject) => new SoccerPlayer.fromJsonObject(jsonObject, TemplateService.Instance.references, _contestReferences)).toList();
    }
  }
  
  /*
   * Inicializacion de los contenidos de un Contest
   */
  Contest _initFromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    assert(contestId.isNotEmpty);

    templateContestId = jsonMap["templateContestId"];

    state = jsonMap.containsKey("state") ? jsonMap["state"] : "ACTIVE";
    _namePattern = jsonMap["name"];
    minEntries = jsonMap.containsKey("minEntries") ? jsonMap["minEntries"] : 2;
    maxEntries = jsonMap["maxEntries"];
    salaryCap = jsonMap["salaryCap"];
    entryFee = new Money.fromJsonObject(jsonMap["entryFee"]);
    prizeType = jsonMap["prizeType"];
    prizeMultiplier = jsonMap.containsKey("prizeMultiplier") ? jsonMap["prizeMultiplier"] : 0.9;
    simulation = jsonMap.containsKey("simulation") ? jsonMap["simulation"] : false;
    authorId = jsonMap.containsKey("authorId") ? jsonMap["authorId"] : "";
    specialImage = jsonMap.containsKey("specialImage") ? jsonMap["specialImage"] : null;

    minManagerLevel = jsonMap.containsKey("minManagerLevel") && jsonMap["minManagerLevel"] != null ? jsonMap["minManagerLevel"] : 0;
    maxManagerLevel = jsonMap.containsKey("maxManagerLevel") && jsonMap["maxManagerLevel"] != null ? jsonMap["maxManagerLevel"] : User.MAX_MANAGER_LEVEL;
    minTrueSkill = jsonMap.containsKey("minTrueSkill") && jsonMap["minTrueSkill"] != null ? jsonMap["minTrueSkill"] : -1;
    maxTrueSkill = jsonMap.containsKey("maxTrueSkill") && jsonMap["maxTrueSkill"] != null ? jsonMap["maxTrueSkill"] : -1;

    startDate = DateTimeService.fromMillisecondsSinceEpoch(jsonMap["startDate"]);
    optaCompetitionId = jsonMap.containsKey("optaCompetitionId") && (jsonMap["optaCompetitionId"] != null) ? jsonMap["optaCompetitionId"] : "";
    matchEvents = jsonMap.containsKey("templateMatchEventIds") ? jsonMap["templateMatchEventIds"].map( (matchEventId) => contestReferences.getMatchEventById(matchEventId) ).toList() : [];

    instanceSoccerPlayers = {};
    if (jsonMap.containsKey("instanceSoccerPlayers")) {
      jsonMap["instanceSoccerPlayers"].forEach((jsonObject) {
        InstanceSoccerPlayer instanceSoccerPlayer =  new InstanceSoccerPlayer.initFromJsonObject(jsonObject, contestReferences);
        
        // Asociar el soccerPlayer
        new SoccerPlayer.fromId(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId, instanceSoccerPlayer.soccerTeam.templateSoccerTeamId, templateReferences, contestReferences);
        
        instanceSoccerPlayers[instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId] = instanceSoccerPlayer;
      });
    }
    
    // <FINAL> : Necesita acceso a los instanceSoccerPlayers
    contestEntries = jsonMap.containsKey("contestEntries") ? jsonMap["contestEntries"].map((jsonMap) => new ContestEntry.initFromJsonObject(jsonMap, contestReferences, this) ).toList() : [];
    
    // FIX: ContestEntries: Puede que tengan alineaciones inválidas (por copiar una alineación en un torneo)
    // contestEntries.removeWhere( (contestEntry) => contestEntry.instanceSoccerPlayers.any( (instance) => instance == null) );
    
    numEntries = jsonMap.containsKey("numEntries") ? jsonMap["numEntries"] : contestEntries.length;

    String prizeCurrency = entryFee.isEnergy ? Money.CURRENCY_MANAGER : Money.CURRENCY_GOLD;

    if (jsonMap.containsKey("prizePool") && jsonMap["prizePool"] != null) {
      _prizePool = new Money.fromJsonObject(jsonMap["prizePool"]);
    }
    if (_prizePool == null || _prizePool.amount.toInt() == 0) {
      _prizePool = new Money.from(prizeCurrency, (numEntries < minEntries ? minEntries : numEntries) * entryFee.amount * prizeMultiplier);
    }

    // TODO: Premios como "enteros"
    // _prizePool.amount = _prizePool.toInt();

    _prizeMin = new Money.from(prizeCurrency, minEntries * entryFee.amount * prizeMultiplier);

    // Registramos las referencias usadas para inicializar el torneo
    _contestReferences = contestReferences;
    
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


  bool hasManagerLevel(int userManagerLevel) => (minManagerLevel == 0 || userManagerLevel >= minManagerLevel) &&
                                                userManagerLevel <= maxManagerLevel;

  bool hasTrueSkill(int userTrueSkill) => userTrueSkill >= minTrueSkill &&
                                          (maxTrueSkill == -1 || userTrueSkill <= maxTrueSkill);

  bool hasLevel(int userManagerLevel, int userTrueSkill) => hasManagerLevel(userManagerLevel) && hasTrueSkill(userTrueSkill);

  bool userIsRegistered(String userId) {
    return getContestEntryWithUser(userId) != null;
  }

  bool canEnter(User user) {
    return !isFull && hasLevel(user.managerLevel.toInt(), user.trueSkill);
  }

  String _name;
  String _namePattern;
  Prize _prize;
  Money _prizePool;
  Money _prizeMin;
  ContestReferences _contestReferences;
}