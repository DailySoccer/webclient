library user_notification;
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/utils/string_utils.dart';

class UserNotification {
  static const String  NEW_SPECIAL_EVENT_ACTIVE = "NEW_SPECIAL_EVENT_ACTIVE";
  static const String  NEW_OFFER_ACTIVE         = "NEW_OFFER_ACTIVE";

  static const String  CONTEST_FINISHED         = "CONTEST_FINISHED";
  static const String  DUEL_FINISHED            = "DUEL_FINISHED";
  static const String  CONTEST_CANCELLED        = "CONTEST_CANCELLED";

  static const String  DAILY_CHALLENGE_ENABLED  = "DAILY_CHALLENGE_ENABLED";
  static const String  OFICIAL_CONTEST_START    = "OFICIAL_CONTEST_START";
  static const String  CONTEST_INVITATIONS      = "CONTEST_INVITATIONS";
  static const String  SKILL_LEVEL_UP           = "SKILL_LEVEL_UP";
  static const String  SKILL_LEVEL_DOWN         = "SKILL_LEVEL_DOWN";

  static const String  MANAGER_LEVEL_UP         = "MANAGER_LEVEL_UP";
  static const String  MANAGER_LEVEL_DOWN       = "MANAGER_LEVEL_DOWN";
  static const String  ACHIEVEMENT_EARNED       = "ACHIEVEMENT_EARNED";

  String id;
  String topic;
  Map<String, String> info;
  DateTime createdAt;
  String name;
  String description;
  Map link = {"url": null, "name": ""};

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "notifications", substitutions);
  }

  
  UserNotification.fromJsonObject(Map jsonMap) {
    id = jsonMap["_id"];
    topic = jsonMap["topic"];
    info = jsonMap.containsKey("info") ? jsonMap["info"] : {};
    createdAt = jsonMap.containsKey("createdAt") ? DateTimeService.fromMillisecondsSinceEpoch(jsonMap["createdAt"]) : DateTimeService.now;

    // Cuando el contest únicamente lo compone 2 usuarios, lo trataremos como un "Duelo"
    if (topic == CONTEST_FINISHED && info.containsKey("numEntries") && info["numEntries"] == "2") {
      topic = DUEL_FINISHED;
    }

    name = _generateName();
    description = _generateDescription();
    link = {
      "url": _generateLinkUrl(),
      "name" : _generateLinkName(topic)
    };    
  }

  String _generateName() {
    String name = "";

    switch(topic) {
      case ACHIEVEMENT_EARNED:
        Achievement achievement = Achievement.getAchievementWithKey(info["achievement"]);
        if (achievement != null) {
          name = achievement.name;
        }
        break;
      default:
        name = topic;
    }

    return getLocalizedText(topic, substitutions:{'NAME': name});
  }

  String _generateDescription() {
    if (info == null)
      return "";
    
    String name = "";

    switch(topic) {
      case CONTEST_FINISHED:
      case CONTEST_CANCELLED:
      case DUEL_FINISHED:
        if (info.containsKey("contestName"))
          name = info["contestName"].trim();
        
        break;
    }

    return getLocalizedText(topic + "_DESCRIPTION", substitutions:{'NAME': name});
  }

  String _generateLinkUrl() {
    String result = null;

    switch(topic) {
      case ACHIEVEMENT_EARNED:
        result = "#/leaderboard/achievements/me";
        break;
      case CONTEST_FINISHED:
      case DUEL_FINISHED:
        result = "#/history_contest/my_contests/${info['contestId']}";
        break;
      default:
        result = '#/lobby';
    }

    return result;
  }

  String _generateLinkName(String topic) {
    return getLocalizedText(topic + "_BTN");
  }
  
}