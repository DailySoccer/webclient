library competition;

class Competition {
  static const LEAGUE_ES_ID     = "23";
  static const LEAGUE_UK_ID     = "8";
  static const LEAGUE_UCL_ID    = "5";
  static const WORLDCUP_ID      = "4";

  static Map<String, String> competitionTypeValues = {
    LEAGUE_ES_ID:   "LEAGUE_ES"
    ,LEAGUE_UK_ID:  "LEAGUE_UK"
    ,LEAGUE_UCL_ID: "CHAMPIONS"
    ,WORLDCUP_ID:   "WORLDCUP"
  };

  static String competitionType(String optaCompetitionId) => competitionTypeValues.containsKey(optaCompetitionId) ? competitionTypeValues[optaCompetitionId] : "";
}