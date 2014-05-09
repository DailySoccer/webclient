library contest_pack;

import "package:json_object/json_object.dart";
import "package:webclient/models/contest.dart";
import "package:webclient/models/match_event.dart";


class ContestsPack {
   List<Contest> contests = new List<Contest>();
   List<MatchEvent> matchEvents = new List<MatchEvent>();

   ContestsPack(this.contests, this.matchEvents);

   ContestsPack.fromJsonObject(JsonObject json) {
     json.contests.forEach((x) => contests.add(new Contest.fromJsonObject(x)));
     json.matchEvents.forEach((x) => matchEvents.add(new MatchEvent.fromJsonObject(x)));
   }

   ContestsPack.fromJsonString(String json) : this.fromJsonObject(new JsonObject.fromJsonString(json));
}