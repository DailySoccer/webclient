library facebook_service;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';
import 'package:webclient/models/achievement.dart';

@Injectable()
class FacebookService {

  static String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "facebook_service", substitutions);
  }
  
  FacebookService() {
    if (_instance != null)
      throw new Exception("WTF 1233");

    _instance = this;
  }
  
  static String get _rootUrl => window.location.toString().split("#")[0];

  static Map inscribeInContest(String contestId) {
    return _buildShareMap('contest_inscription', "$_rootUrl#/sec/${contestId}");
  }

  static Map historyContest(Contest contest, int position) {
    String url = "$_rootUrl#/shc/${contest.contestId}";
    if (position == 0) {
      return _buildShareMap('contest_win', url);
    } else {
      return _buildShareMap('contest_history', url, substitutions: {'USER_POS': '${position + 1}'});
    }
  }

  static Map liveContest(String contestId) {
    return _buildShareMap('contest_live', "$_rootUrl#/slc/${contestId}");
  }

  static Map managerLevelUp(int managerLevel, String userId) {
    Map shareMap = _buildShareMap('manager_level_up', "$_rootUrl#/sla/$userId", substitutions: {'MANAGER_LEVEL': managerLevel < 10? "0$managerLevel" : managerLevel });
    return shareMap;
  }

  static Map createdContest(String contestId) {
    return _buildShareMap('created_contest', "$_rootUrl#/sec/${contestId}");
  }

  static Map leaderboardGold(String userId) {
    Map shareMap = _buildShareMap('leadeboard_gold', "$_rootUrl#/slm/$userId");
    shareMap['selector-prefix'] = '${shareMap['selector-prefix']}_gold';
    return shareMap;
  }

  static Map leaderboardTrueskill(String userId)  {
    Map shareMap = _buildShareMap('leadeboard_trueskill', "$_rootUrl#/slp/$userId");
    shareMap['selector-prefix'] = '${shareMap['selector-prefix']}_trueskill';
    return shareMap;
  }
  
  static Map _buildShareMap(String prefix, String link, {Map substitutions: null}) {
    return {
          'description': getLocalizedText('${prefix}_description', substitutions),
          'caption': '',
          'hashtag': getLocalizedText('${prefix}_hastag', substitutions),
          'url': link,
          'title': getLocalizedText('${prefix}_title', substitutions),
          'image': "$_rootUrl/images/${getLocalizedText('${prefix}_img', substitutions)}",
          'selector-prefix': '#shareWrapper'
        };
  }

  static Map winAchievement(achievementId, String userId) {
    Achievement achievement = Achievement.getAchievementWithKey(achievementId);
    Map shareMap = _buildShareMap('win_achievement', "$_rootUrl#/sla/$userId", substitutions: {
                                                          'ACHIEV_NAME' : achievement.name, 
                                                          'ACHIEV_IMG_KEY' : achievement.shareImage
                                                       });
    shareMap['selector-prefix'] = '${shareMap['selector-prefix']}${achievementId}';
    return shareMap;
  }
  
  /********* Constest Headers in Live and History *********/
  static String titleByContest(Contest contest, dynamic userId) {
    if (contest.isLive) {
      return getLocalizedText('contest_live_title');
    } else if (contest.isHistory) {
      int userPos = contest.getUserPosition(contest.getContestEntryWithUser(userId));
      return getLocalizedText('contest_history_title', { "USER_POS": userPos } );
    } else {
      return getLocalizedText('default_title');
    }
  }
  static String descriptionByContest(Contest contest, dynamic userId) {
    if (contest.isLive) {
      return getLocalizedText('contest_live_description');
    } else if (contest.isHistory) {
      return getLocalizedText('contest_history_description');
    } else {
      return getLocalizedText('contest_invite');
    }
  }
  static String imageByContest(Contest contest, dynamic userId) {
    int userPos = contest.getUserPosition(contest.getContestEntryWithUser(userId));
    if (contest.isLive) {
      switch(userPos) {
        case 1:  return getLocalizedText('contest_live_img_first');
        case 2:  return getLocalizedText('contest_live_img_second');
        case 3:  return getLocalizedText('contest_live_img_third');
        default: return getLocalizedText('contest_live_img_other');
      }
    } else  if (contest.isHistory) {
      switch(userPos) {
        case 1:  return getLocalizedText('contest_history_img_first');
        case 2:  return getLocalizedText('contest_history_img_second');
        case 3:  return getLocalizedText('contest_history_img_third');
        default: return getLocalizedText('contest_history_img_other');
      }
    } else {
      return getLocalizedText('contest_img_invite');
    }
  }
  static String captionByContest(Contest contest, dynamic userId) {
    return (contest != null) ? contest.name : "";
  }
  

  /********* Constest Headers in Live and History *********/
  static String titleOfInscription() => getLocalizedText('contest_inscription_title');
  static String descriptionOfInscription() => getLocalizedText('contest_inscription_description');
  static String imageOfInscription() => getLocalizedText('contest_inscription_img');
  
  
  static FacebookService _instance;
}