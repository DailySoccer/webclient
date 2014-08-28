library template_match_event;

import "package:json_object/json_object.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/services/contest_references.dart';
import "package:webclient/models/soccer_player.dart";

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
    MatchEvent matchEvent = references.getMatchEventById(json.templateMatchEventId);
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
    soccerTeamA.soccerPlayers.forEach( (soccerPlayer) {
      JsonObject jsonObject = soccerFantasyPoints[soccerPlayer.templateSoccerPlayerId];
      soccerPlayer.currentLivePoints = jsonObject.points;
      jsonObject.events.forEach( (key, value) =>
          soccerPlayer.eventLivePoints[key] = value );
    });

    soccerTeamB.soccerPlayers.forEach( (soccerPlayer) {
      JsonObject jsonObject = soccerFantasyPoints[soccerPlayer.templateSoccerPlayerId];
      soccerPlayer.currentLivePoints = jsonObject.points;
      jsonObject.events.forEach( (key, value) => soccerPlayer.eventLivePoints[key] = value );
    });
  }

  MatchEvent _initFromJsonObject(JsonObject json, ContestReferences references) {
    assert(templateMatchEventId.isNotEmpty);
    soccerTeamA = new SoccerTeam.fromJsonObject(json.soccerTeamA, references)
      .. matchEvent = this;

    soccerTeamB = new SoccerTeam.fromJsonObject(json.soccerTeamB, references)
      .. matchEvent = this;

    period = json.period;
    minutesPlayed = json.minutesPlayed;

    startDate = new DateTime.fromMillisecondsSinceEpoch(json.startDate, isUtc: true);

    // Si el templateMatchEvent incluye la información "live", la actualizamos
    if (json.containsKey("liveFantasyPoints")) {
      _updateFantasyPoints(json.liveFantasyPoints);
    }

    return this;
  }
}
