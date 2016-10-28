library notifications_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/achievement.dart';
import 'package:webclient/models/user_notification.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/leaderboards/achievement_comp.dart';
import 'package:webclient/services/facebook_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/services/app_state_service.dart';

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

  NotificationsComp(this._profileService, this._contestsService, this._appStateService) {
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
    GameMetrics.screenVisitEvent(GameMetrics.SCREEN_NOTIFICATIONS);
    ProfileService.instance.refreshUserProfile().then( (_) => refreshNotifications() );
  }

  void refreshNotifications() {
    notificationList = _profileService.user.notifications.map( (notification) { 
        Map<dynamic, dynamic> notificationItem = {
          "id": notification.id,
          "type" : notification.topic,
          "info" : notification.info,
          "name" : notification.name,
          "description" : "",
          "link": notification.link,
          "date" : DateTimeService.formatDateWithDayOfTheMonth(notification.createdAt).toUpperCase()
        };
        retrieveDescription(notification, notificationItem);
        return notificationItem;
    }).toList();

    //Refresh Sharing Info Cache
    sharingInfoCache = {};
    notificationList.forEach( sharingInfo );
    
    
    
    /* ************ TEST ***************
    
    List<UserNotification> notificationsTest = [
      new UserNotification.fromJsonObject({ 
        "_id": '0', 
        "topic" : UserNotification.ACHIEVEMENT_EARNED,   
        "name":  "nombre 1", 
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/leaderboard"}, 
        "info" : {"achievementKey" : "WON_1_VIRTUAL_CONTEST"}
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '1', 
        "topic" : UserNotification.CONTEST_FINISHED,     
        "name":  "Concurso finalizado", 
        "description": "CONTEST_FINISHED_DESCRIPTION<div>Has terminado en <span class='contest-position'>@POSITIONª </span></div><div>Premio <span class='contest-position'>@PRIZE monedas</span></div>", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "Ver resutados", "url": "http://127.0.0.1:3030/webclient/web/index.html#/history_contest/my_contests/"}, 
        "info" : {"contestId": "568b8bcbd4c6607310eafffa" }
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '2', 
        "topic" : UserNotification.CONTEST_FINISHED,     
        "name":  "Torneo final", 
        "description": "CONTEST_FINISHED_DESCRIPTION<div>Has terminado en <span class='contest-position'>@POSITIONª </span></div><div>Premio <span class='contest-position'>@PRIZE monedas</span></div>",  
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/history_contest/my_contests/"}, 
        "info" : {"contestId": "568117c5d4c6a23079efe89b" }
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '3', 
        "topic" : UserNotification.CONTEST_FINISHED,     
        "name":  "Torneo terminado", 
        "description": "CONTEST_FINISHED_DESCRIPTION<div>Has terminado en <span class='contest-position'>@POSITIONª </span></div><div>Premio <span class='contest-position'>@PRIZE monedas</span></div>",  
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/history_contest/my_contests/"}, 
        "info" : {"contestId": "568117c5d4c6a23079efe890" }
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '4', 
        "topic" : UserNotification.CONTEST_INVITATIONS,     
        "name":  "nombre 2", 
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}, 
        "info" : {"contestId": "---" }
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '5', 
        "topic" : UserNotification.MANAGER_LEVEL_DOWN,     
        "name":  "nombre 2", 
        "description": "", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}, 
        "info" : {"level": 2 }
      }),
      new UserNotification.fromJsonObject({ 
        "_id": '6', 
        "topic" : UserNotification.SKILL_LEVEL_DOWN,     
        "name":  "nombre 2", 
        "description": "", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}, 
        "info" : {"achievementKey" : "SKILL_LEVEL_DOWN"}
      }),
      new UserNotification.fromJsonObject({
        "_id": '7',
        "topic" : UserNotification.NEW_OFFER_ACTIVE,
        "name":  "nombre 2", 
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
        "date": "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}, 
        "info" : {"achievementKey" : "NEW_OFFER_ACTIVE"}
      }),
      new UserNotification.fromJsonObject({
        "_id": '8', 
        "topic" : UserNotification.OFICIAL_CONTEST_START,     
        "name":  "nombre 2", 
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
        "date":  "10 Nov. 2015", 
        "link":  {"name" : "link_name", "url": "http://127.0.0.1:3030/webclient/web/index.html#/notifications"}, 
        "info" : {"achievementKey" : "OFICIAL_CONTEST_START"}
      })
    ];  
 
    notificationList = notificationsTest.map( (notification) { 
      Map<dynamic, dynamic> notificationItem = {
        "id": notification.id,
        "type" : notification.topic,
        "info" : notification.info,
        "name" : notification.name,
        "description" : "",
        "link": notification.link,
        "date" : DateTimeService.formatDateWithDayOfTheMonth(notification.createdAt).toUpperCase()
      };
      retrieveDescription(notification, notificationItem);
      return notificationItem;
  }).toList();
  
  *************** TEST ***************/
  }
  
  void retrieveDescription(UserNotification notification, Map item) {
    String pos = "";
    String prize = "";
    String ret = "";
    ContestEntry  ce;
    if (notification.topic == "CONTEST_FINISHED") {
      item['description'] = "Cargando...";
      _contestsService.refreshMyHistoryContest(notification.info["contestId"])
        .then((_) {
          _contest = _contestsService.lastContest;
          ce = _contest.getContestEntryWithUser(_profileService.user.userId);
          pos = (ce.position +1).toString();
          prize = ce.prize.toString();
          ret = notification.description.replaceAll("@POSITION", pos);
          item['description'] = ret.replaceAll("@PRIZE", prize);
        })
        .catchError((ServerError error) {
          print("$error");
        });
    } else {
      item['description'] = notification.description;
    }
  }
  
  /*
  int getPositionInContest(String contestId) {
    if (_contest == null){ 
      _contest = _contestsService.getContestById(contestId);
    }
    
    ContestEntry  ce = _contest.getContestEntryWithUser(_profileService.user.userId);
    _userPositionInContest = _contest.getUserPosition(ce);
    
    return _userPositionInContest;
  }
  
  String getPrizeInContest(String contestId) {
    if (_contest == null){ 
      _contest = _contestsService.getContestById(contestId);
    }
    
    ContestEntry ce = _contest.getContestEntryWithUser(_profileService.user.userId);
   
    return _contest.getPrize(_userPositionInContest).toString();
  }
  */
  void closeNotification(String notificationId) {
    // print("Cerrando notificacion: $notificationId}");
    _profileService.removeNotification(notificationId).then((_) {
      notificationList.removeWhere((notification) => notification['id'] == notificationId);
      // refreshNotifications();
    });
  }

  void goToLink(String link) {
    _appStateService.notificationsActive = false;
    window.location.assign(link);
  }

  void onAction(String id) {
    Map n = notificationList.firstWhere((notification) => notification['id'] == id);

    if (n['type'] == UserNotification.ACHIEVEMENT_EARNED) {
      goToLink(n['link']['url']);
    }
  }
  
  Map sharingInfo(notification) {
    Map sharingMap;
    var id = notification['id'];
    
    switch(notification['type']) {
      case UserNotification.ACHIEVEMENT_EARNED:
        if (!sharingInfoCache.containsKey(id)) {
          sharingInfoCache[id] = FacebookService.winAchievement(notification['info']['achievement'], _profileService.user.userId);
          sharingInfoCache[id]['selector-prefix'] = '${sharingInfoCache[id]['selector-prefix']}$id';
        }
        sharingMap = sharingInfoCache[id];
      break;
      case UserNotification.MANAGER_LEVEL_UP:
        if (!sharingInfoCache.containsKey(id)) {
          sharingInfoCache[id] = FacebookService.managerLevelUp(int.parse(notification['info']['level'].toString()), _profileService.user.userId);
          sharingInfoCache[id]['selector-prefix'] = '${sharingInfoCache[id]['selector-prefix']}$id';
        }
        sharingMap = sharingInfoCache[id];
      break;
      default:
        sharingMap = emptyShareInfo;
    }
    return sharingMap;
  }
  
  bool shareEnabled(notification) {
    return sharingInfoCache.containsKey(notification['id']);
  }
  
  String getNotificationIcon(String nId) {
    String ret = "";
    
    switch(nId) {
      case UserNotification.ACHIEVEMENT_EARNED:
        ret = "icon-notification-achievement.png";
      break;
      case UserNotification.CONTEST_CANCELLED:
      case UserNotification.CONTEST_FINISHED:
      case UserNotification.CONTEST_INVITATIONS:
      case UserNotification.DAILY_CHALLENGE_ENABLED:
      case UserNotification.DUEL_FINISHED:
      case UserNotification.OFICIAL_CONTEST_START:
      case UserNotification.NEW_SPECIAL_EVENT_ACTIVE:
        ret = "icon-notification-contest.png";
      break;
      default:
        ret = "icon-notification-default.png";
      break;
    }
    
    return "images/notifications/" + ret;
  }
  
  void cleanNiotifications () {
    print ("Borrando todas las notificaciones");    
    notificationList.forEach((notif)  => closeNotification(notif['d']));
  }

  Map emptyShareInfo = {};
  Map<String, Map> sharingInfoCache = {};
  ProfileService _profileService;
  Contest _contest;
  int _userPositionInContest;
  ContestsService _contestsService;
  AppStateService _appStateService;
}