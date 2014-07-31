library template_match_event;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

class TemplateMatchEvent {
  String templateMatchEventId;

  SoccerTeam soccerTeamA;
  SoccerTeam soccerTeamB;
  DateTime startDate;

  TemplateMatchEvent(this.templateMatchEventId, this.soccerTeamA, this.soccerTeamB, this.startDate);

  TemplateMatchEvent.referenceInit(this.templateMatchEventId);

  factory TemplateMatchEvent.fromJsonObject(JsonObject json, ContestReferences references) {
    TemplateMatchEvent matchEvent = references.getMatchEventById(json._id);
    return matchEvent._initFromJsonObject(json, references);
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = soccerTeamA.findSoccerPlayer(soccerPlayerId);
    if (soccerPlayer == null) {
      soccerPlayer = soccerTeamB.findSoccerPlayer(soccerPlayerId);
    }
    return soccerPlayer;
  }

  void updateFantasyPoints(Map<String, int> soccerPlayerToPoints) {
    soccerTeamA.soccerPlayers.forEach( (soccerPlayer) =>
        soccerPlayer.currentLivePoints = soccerPlayerToPoints[soccerPlayer.templateSoccerPlayerId]);

    soccerTeamB.soccerPlayers.forEach( (soccerPlayer) =>
        soccerPlayer.currentLivePoints = soccerPlayerToPoints[soccerPlayer.templateSoccerPlayerId]);
  }

  TemplateMatchEvent _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateMatchEventId.isNotEmpty);
    soccerTeamA = new SoccerTeam.fromJsonObject(json.soccerTeamA, references)
      .. matchEvent = this;

    soccerTeamB = new SoccerTeam.fromJsonObject(json.soccerTeamB, references)
      .. matchEvent = this;

    startDate = new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true);

    // Si el templateMatchEvent incluye la información "live", la actualizamos
    if (json.containsKey("livePlayerToPoints")) {
      updateFantasyPoints(json.livePlayerToPoints);
    }

    return this;
  }
}
