library notifications_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/models/user_notification.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/achievement_comp.dart';

@Component(
    selector: 'notifications',
    templateUrl: 'packages/webclient/components/account/notifications_comp.html',
    useShadowDom: false
)

class NotificationsComp {
  List<Map> notificationList;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "notifications", substitutions);
  }

  NotificationsComp(this._profileService) {

    /* TEST: Incluir notificaciones al usuario
    if (_profileService.isLoggedIn) {
      _profileService.user.notifications = [
        { "_id": '0', "topic": UserNotification.ACHIEVEMENT_EARNED, "info" : { "achievement": Achievement.WON_OFFICIAL_CONTESTS_LEVEL_1 } },
        { "_id": '1', "topic": UserNotification.CONTEST_FINISHED,   "info" : { "contestId": "---" } },
        { "_id": '2', "topic": UserNotification.CONTEST_CANCELLED,  "info" : { "contestId": "---" } },
        { "_id": '3', "topic": UserNotification.MANAGER_LEVEL_UP,   "info" : { "level": 2 } },
        { "_id": '4', "topic": UserNotification.MANAGER_LEVEL_DOWN, "info" : { "level": 1 } }
      ].map((jsonMap) => new UserNotification.fromJsonObject(jsonMap) ).toList();
    }
    */

    ProfileService.instance.refreshUserProfile().then( (_) => refreshNotifications() );
  }

  void refreshNotifications() {
    notificationList = _profileService.user.notifications.map( (notification) => {
      "id": notification.id,
      "type" : notification.topic,
      "info" : notification.info,
      "name" : notification.name,
      "description" : notification.description,
      "link": notification.link,
      "date" : DateTimeService.formatDateWithDayOfTheMonth(notification.createdAt).toUpperCase()
    }).toList();

    /*
    notificationList = [
      {"id": '0', "type" : UserNotification.ACHIEVEMENT_EARNED,   "info" : {"date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/leaderboard", "achievementKey" : "WON_1_VIRTUAL_CONTEST"}},
      {"id": '1', "type" : UserNotification.CONTEST_FINISHED,     "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '2', "type" : UserNotification.CONTEST_INVITATIONS,  "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '3', "type" : UserNotification.MANAGER_LEVEL_DOWN,   "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '4', "type" : UserNotification.SKILL_LEVEL_DOWN,     "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '5', "type" : UserNotification.NEW_OFFER_ACTIVE,     "info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}},
      {"id": '6', "type" : UserNotification.OFICIAL_CONTEST_START,"info" : {"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel enim finibus cursus. Sed aliquam felis turpis, et suscipit neque dignissim tempus.", "date": "10 Nov. 2015", "link": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}}
    ];
   */
}

  void closeNotification(String notificationId) {
    // print("Cerrando notificacion: $notificationId}");
    _profileService.removeNotification(notificationId).then((_) {
      notificationList.removeWhere((notification) => notification['id'] == notificationId);
      // refreshNotifications();
    });
  }

  void goToLink(String link) {
    window.location.assign(link);
  }

  void onAction(String id) {
    Map n = notificationList.firstWhere((notification) => notification['id'] == id);

    if (n['type'] == UserNotification.ACHIEVEMENT_EARNED) {
      goToLink(n['link']['url']);
    }
  }
  
  ProfileService _profileService;
}