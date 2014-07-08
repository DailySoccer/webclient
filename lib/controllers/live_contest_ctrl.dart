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
    List<MatchEvent> liveMatchEvents = new List<MatchEvent>();

    LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._contestService, this._profileService, this._flashMessage) {
      _contestId = routeProvider.route.parameters['contestId'];
      if (_contestId != null) {
        _contest = _contestService.getContestById(_contestId);
      }
      else {
        _contest = _contestService.activeContests.firstWhere((contest) => contest.currentUserIds.length > 0);
        _contestId = _contest.contestId;
        
        print("autoselect contest: $_contestId");
      }
      
      mainPlayer = _profileService.user.userId;
      
      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
      Future.wait([_contestService.getLiveContestEntries(_contestId), _contestService.getLiveMatchEvents(_contest.templateContestId)])
          .then((List responses) {
            usersInfo = responses[0].users_info.map((jsonObject) => new User.fromJsonObject(jsonObject)).toList();
            contestEntries = responses[0].contest_entries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject)).toList();
            liveMatchEvents = responses[1].content.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject)).toList();
          })
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });      
     }
    
    ContestEntry getContestEntryWithUser(String userId) {
      return contestEntries.firstWhere( (entry) => entry.userId == userId, orElse: () => null );
    }
    
    SoccerPlayer getSoccerPlayer(String soccerPlayerId) {
      SoccerPlayer soccerPlayer = null;
      
      // Buscar en la lista de partidos del contest
      for (MatchEvent match in liveMatchEvents) {
        soccerPlayer = match.soccerTeamA.findSoccerPlayer(soccerPlayerId);
        if (soccerPlayer == null) {
          soccerPlayer = match.soccerTeamB.findSoccerPlayer(soccerPlayerId);
        }
        
        // Lo hemos encontrado?
        if (soccerPlayer != null)
          break;
      }
      
      return soccerPlayer;
    }
    
    int getUserPosition(ContestEntry contestEntry) {
      for (int i=0; i<contestEntries.length; i++) {
        if (contestEntries[i].contestEntryId == contestEntry.contestEntryId)
          return i+1;
      }
      return -1;
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
    
    int getUserScore(ContestEntry contestEntry) {
      int points = 0;
      for (String soccerPlayerId in contestEntry.soccerIds) {
        SoccerPlayer soccerPlayer = getSoccerPlayer(soccerPlayerId);
        points += soccerPlayer.fantasyPoints;
      }
      return points;
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
    Contest _contest;
}