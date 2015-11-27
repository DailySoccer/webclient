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
    name = _generateName();
    description = _generateDescription();
    link = {
      "url": _generateLinkUrl(),
      "name" : _generateLinkName()
    };
  }

  String _generateName() {
    String result = null;

    switch(topic) {
      case ACHIEVEMENT_EARNED:
        result = getLocalizedText(topic, substitutions:{'NAME': Achievement.getAchievementWithKey(info["achievement"]).name});
        break;
      default:
        result = getLocalizedText(topic, substitutions:{'NAME': topic});
    }

    return result;
  }

  String _generateDescription() {
    String result = null;
    switch(topic) {
      case CONTEST_FINISHED:
        result = getLocalizedText(topic + "_DESCRIPTION", substitutions:{'NAME': info["contestName"]});
        break;

      default:
        result = "Lorem fistrum te voy a borrar el cerito condemor tiene musho peligro mamaar sexuarl.";
    }
    return result;
  }

  String _generateLinkUrl() {
    String result = null;
    switch(topic) {
      case ACHIEVEMENT_EARNED:
        result = "#/leaderboard";
        break;
      case CONTEST_FINISHED:
        result = "#/history_contest/my_contests/${info['contestId']}";
        break;

      case CONTEST_CANCELLED:
      case MANAGER_LEVEL_UP:
      case MANAGER_LEVEL_DOWN:
        break;
    }
    return result;
  }

  String _generateLinkName() {
    return "Ir";
  }
}