library live_match_day;

import "package:json_object/json_object.dart";
import "package:webclient/models/template_match_event.dart";
import "package:webclient/models/soccer_team.dart";

class LiveMatchEvent {
  String templateMatchEventId;

  // Asocia un soccerPlayerId con fantasyPoints
  var soccerPlayerToPoints = new Map<String, int>();

  LiveMatchEvent(this.templateMatchEventId, this.soccerPlayerToPoints);

  LiveMatchEvent.fromJsonObject(JsonObject json) {
    templateMatchEventId = json.templateMatchEventId;
    soccerPlayerToPoints = json.soccerPlayerToPoints;
  }

  void updateFantasyPoints(TemplateMatchEvent matchEvent) {
    _updateFantasyPoints(matchEvent.soccerTeamA);
    _updateFantasyPoints(matchEvent.soccerTeamB);
  }

  void _updateFantasyPoints(SoccerTeam soccerTeam) {
    soccerTeam.soccerPlayers.forEach( (soccerPlayer) =>
        soccerPlayer.currentLivePoints = soccerPlayerToPoints[soccerPlayer.templateSoccerPlayerId]);
  }

}