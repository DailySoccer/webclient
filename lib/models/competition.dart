library competition;

class Competition {
  static const String LEAGUE_ES_ID     = "23";
  static const String LEAGUE_UK_ID     = "8";
  static const String LEAGUE_UCL_ID    = "5";
  static const String WORLDCUP_ID      = "4";

  static const String LEAGUE_ES      = "LEAGUE_ES";
  static const String LEAGUE_UK      = "LEAGUE_UK";
  static const String LEAGUE_UCL     = "CHAMPIONS";
  static const String WORLDCUP       = "WORLDCUP";

  static Map<String, String> competitionTypeValues = {
    LEAGUE_ES_ID:   LEAGUE_ES
    ,LEAGUE_UK_ID:  LEAGUE_UK
    ,LEAGUE_UCL_ID: LEAGUE_UCL
    ,WORLDCUP_ID:   WORLDCUP
  };

  static String competitionType(String optaCompetitionId) => competitionTypeValues.containsKey(optaCompetitionId) ? competitionTypeValues[optaCompetitionId] : "";
}