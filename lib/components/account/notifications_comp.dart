library notifications_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';

@Component(
    selector: 'notifications',
    templateUrl: 'packages/webclient/components/account/notifications_comp.html',
    useShadowDom: false
)

class NotificationsComp {
  
  static const String  NEW_SPECIAL_EVENT_ACTIVE = "NEW_SPECIAL_EVENT_ACTIVE";
  static const String  NEW_OFFER_ACTIVE         = "NEW_OFFER_ACTIVE";
  static const String  CONTEST_FINISHED         = "CONTEST_FINISHED";
  static const String  DUEL_FINISHED            = "DUEL_FINISHED";
  static const String  DAILY_CHALLENGE_ENABLED  = "DAILY_CHALLENGE_ENABLED";
  static const String  OFICIAL_CONTEST_START    = "OFICIAL_CONTEST_START";
  static const String  CONTEST_INVITATIONS      = "CONTEST_INVITATIONS";
  static const String  CONTEST_CANCELLED        = "CONTEST_CANCELLED";
  static const String  MANAGER_LEVEL_UP         = "MANAGER_LEVEL_UP";
  static const String  SKILL_LEVEL_UP           = "SKILL_LEVEL_UP";
  static const String  MANAGER_LEVEL_DOWN       = "MANAGER_LEVEL_DOWN";
  static const String  SKILL_LEVEL_DOWN         = "SKILL_LEVEL_DOWN";
  static const String  ACHIVEMENT_OWNED         = "ACHIVEMENT_OWNED";
  
  
  
  List<Map> notificationList;
  
  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "notifications", substitutions);
  }
  
  NotificationsComp() {
    notificationList = [
      {"id": '0', "type" : 'ACHIVEMENT_OWNED',      "info" : {"date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/leaderboard", "achievementKey" : "WON_1_VIRTUAL_CONTEST"}},
      {"id": '1', "type" : 'CONTEST_FINISHED',      "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '2', "type" : 'CONTEST_INVITATIONS',   "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '3', "type" : 'MANAGER_LEVEL_DOWN',    "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '4', "type" : 'SKILL_LEVEL_DOWN',      "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '5', "type" : 'NEW_OFFER_ACTIVE',      "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '6', "type" : 'OFICIAL_CONTEST_START', "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}}
    ];
  }
  
  String getNotificationName(String id) {
    Map notif;
    try{
      notif = notificationList.firstWhere((notification) => notification['id'] == id);
    } catch (_) {
      print("ERROR EN: $id");
      return '';
    }
    if (notif['type'] == "ACHIVEMENT_OWNED") {
      Achievement a = Achievement.getAchievementWithKey(notif["info"]["achievementKey"]);
      String text = getLocalizedText('achievement_name', substitutions:{'NAME': a.name}); 
      return   text;
    }
    
    return "";
  }
  
  void closeNotification(String id) {
    print("Cerrando notificacion:" + id);
  }
}