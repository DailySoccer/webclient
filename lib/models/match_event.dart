library template_match_event;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";
import 'package:webclient/services/datetime_service.dart';

class MatchEvent {
  String templateMatchEventId;

  SoccerTeam soccerTeamA;
  SoccerTeam soccerTeamB;
  String period;
  int minutesPlayed;
  DateTime startDate;

  MatchEvent(this.templateMatchEventId, this.soccerTeamA, this.soccerTeamB, this.startDate);

  MatchEvent.referenceInit(this.templateMatchEventId);

  bool get isStarted => period != "PRE_GAME";
  bool get isFirstHalf => period == "FIRST_HALF";
  bool get isSecondHalf => period == "SECOND_HALF";
  bool get isFinished => period == "POST_GAME";

  int get halfTimesLeft {
    int left = 2;
    switch (period) {
      case "SECOND_HALF": left = 1; break;
      case "POST_GAME":   left = 0; break;
    }
    return left;
  }

  int get minutesLeft {
    const int TOTAL_TIEMPO_PARTIDO = 90;
    const int TIEMPO_MITAD_PARTIDO = 45;

    int minutes = 0;
    if (isStarted) {
      if (isFirstHalf) {
        // Los minutos no pueden superar el tiempo asignado a la primera parte (45)
        //   por lo que al superarse dicho tiempo, devolvemos el tiempo restante de la segunda parte (45)
        minutes += (minutesPlayed <= 45) ? (TOTAL_TIEMPO_PARTIDO - minutesPlayed) : TIEMPO_MITAD_PARTIDO;
      }
      else if (isSecondHalf) {
        // Cuando los minutos superan al tiempo asignado a un partido, devolvemos un "tiempo extra" fijo de 1 minuto
        // que permanecerá tanto tiempo como se prolongue el partido
        minutes += (minutesPlayed <= TOTAL_TIEMPO_PARTIDO) ? (TOTAL_TIEMPO_PARTIDO - minutesPlayed) : 1;
      }
    }
    else {
      // Falta jugar todo el partido
      minutes += TOTAL_TIEMPO_PARTIDO;
    }
    return minutes;
  }

  factory MatchEvent.fromJsonObject(JsonObject json, ContestReferences references) {
    MatchEvent matchEvent = references.getMatchEventById(json.containsKey("templateMatchEventId") ? json.templateMatchEventId : json["_id"]);
    return matchEvent._initFromJsonObject(json, references);
  }

  SoccerPlayer findSoccerPlayer(String soccerPlayerId) {
    SoccerPlayer soccerPlayer = soccerTeamA.findSoccerPlayer(soccerPlayerId);
    if (soccerPlayer == null) {
      soccerPlayer = soccerTeamB.findSoccerPlayer(soccerPlayerId);
    }
    return soccerPlayer;
  }

  void updateLiveInfo(JsonObject jsonObject) {
    _updateFantasyPoints(jsonObject.liveFantasyPoints);

    period = jsonObject.period;
    minutesPlayed = jsonObject.minutesPlayed;
  }

  void _updateFantasyPoints(Map<String, JsonObject> soccerFantasyPoints) {
    [soccerTeamA, soccerTeamB].forEach((team) => team.soccerPlayers.forEach((soccerPlayer) {
      if (soccerFantasyPoints.containsKey(soccerPlayer.templateSoccerPlayerId)) {
        JsonObject jsonObject = soccerFantasyPoints[soccerPlayer.templateSoccerPlayerId];
        soccerPlayer.currentLivePoints = jsonObject.points;
        soccerPlayer.currentLivePointsPerOptaEvent = new Map<String, LiveEventInfo>();

        if (jsonObject.containsKey("events")) {
          jsonObject.events.forEach((key, jsonEventInfo) => soccerPlayer.currentLivePointsPerOptaEvent[key] = new LiveEventInfo.initFromJsonObject(jsonEventInfo));
        }
      }
    }));
  }

  MatchEvent _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateMatchEventId.isNotEmpty);
    soccerTeamA = references.getSoccerTeamById(json.templateSoccerTeamAId)
      .. matchEvent = this;

    soccerTeamB = references.getSoccerTeamById(json.templateSoccerTeamBId)
      .. matchEvent = this;

    period = json.containsKey("period") ? json.period : "PRE_GAME";
    minutesPlayed = json.containsKey("minutesPlayed") ? json.minutesPlayed : 0;

    startDate = json.containsKey("startDate") ? DateTimeService.fromMillisecondsSinceEpoch(json.startDate) : null;

    // Si el templateMatchEvent incluye la información "live", la actualizamos
    if (json.containsKey("liveFantasyPoints")) {
      _updateFantasyPoints(json.liveFantasyPoints);
    }

    return this;
  }
}
