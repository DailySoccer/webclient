library facebook_service;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:html';

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

  static Map inscribeInContest(String contestId) {
    String rootUrl = window.location.toString().split("#")[0];
    String inviteUrl = "$rootUrl#/enter_contest/lobby/${contestId}/none";
    //String inviteUrl = "jugar.epiceleven.com/#/enter_contest/lobby/${contest.contestId}/none";
    
    return {
      'description': getLocalizedText('contest_inscription_description'),
      'caption': '',
      'hashtag': getLocalizedText('contest_inscription_hastag'),
      'url': inviteUrl,
      'title': getLocalizedText('contest_inscription_title'),
      'image': "$rootUrl/images/${getLocalizedText('contest_inscription_img')}"
    };
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