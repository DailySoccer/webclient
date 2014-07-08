library live_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contest_service.dart';
import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[live-contest-ctrl]', 
    publishAs: 'ctrl'
)
class LiveContestCtrl {

    ScreenDetectorService scrDet;
    var mainPlayer;
    var selectedOpponent;
    
    List<User> usersInfo = new List<User>();
    List<ContestEntry> contestEntries = new List<ContestEntry>();

    LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._contestService, this._profileService, this._flashMessage) {
      _contestId = routeProvider.route.parameters['contestId'];
      if (_contestId == null) {
        Contest contest = _contestService.activeContests.firstWhere((contest) => contest.currentUserIds.length > 0);
        _contestId = contest.contestId;
        
        print("autoselect contest: $_contestId");
      }
      
      mainPlayer = _profileService.user.userId;
      
      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
      Future.wait([_contestService.getLiveContestEntries(_contestId), _contestService.getLiveMatchEvents(_contestId)])
          .then((List responses) {
            usersInfo = responses[0].users_info.map((jsonObject) => new User.fromJsonObject(jsonObject)).toList();
            contestEntries = responses[0].contest_entries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject)).toList();
          })
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });      
     }
    
    ContestEntry getContestEntry(String userId) {
      return contestEntries.firstWhere( (entry) => entry.userId == userId, orElse: () => null );
    }
    
    SoccerPlayer getSoccerPlayer(String soccerPlayerId) {
      // TODO Tendria que buscarse el soccerPlayer en los liveMatchEvents (que se registraran en este controller)
      return _contestService.getSoccerPlayerInContest(_contestId, soccerPlayerId);
    }
    
    String getUserName(ContestEntry contestEntry) {
      User userInfo = usersInfo.firstWhere((user) => user.userId == contestEntry.userId, orElse: () => null);
      return (userInfo != null) ? userInfo.fullName : "";
    }
    
    String getUserNickname(ContestEntry contestEntry) {
      User userInfo = usersInfo.firstWhere((user) => user.userId == contestEntry.userId, orElse: () => null);
      return (userInfo != null) ? userInfo.nickName : "";
    }
    
    String getUserRemainingTime(ContestEntry contestEntry) {
      return "1";
    }
    
    String getUserScore(ContestEntry contestEntry) {
      return "0";
    }
    
    String getPrize(int index) {
      String prize = "-";
      switch(index) {
        case 0: prize = "€100,00"; break;
        case 1: prize = "€50,00"; break;
        case 2: prize = "€30,00"; break;
      }
      return prize;
    }
    
    Scope _scope;
    FlashMessagesService _flashMessage;
    ContestService _contestService;
    ProfileService _profileService;
    
    String _contestId;
}