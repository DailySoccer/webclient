library live_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contest_service.dart';
import "package:webclient/models/user.dart";
import "package:webclient/models/soccer_player.dart";
import "package:webclient/models/soccer_team.dart";
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/contest_references.dart';

@Controller(
    selector: '[live-contest-ctrl]',
    publishAs: 'ctrl'
)
class LiveContestCtrl implements DetachAware {

    ScreenDetectorService scrDet;
    var mainPlayer;
    var selectedOpponent;
    var initialized;

    var updatedDate;

    Contest contest;
    List<ContestEntry> contestEntries = new List<ContestEntry>();
    List<User> usersInfo = new List<User>();

    LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._myContestService, this._profileService, this._flashMessage) {
      _contestId = routeProvider.route.parameters['contestId'];
      initialized = false;

      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

      if (_contestId != null) {
        initialize();
      }
      else {
        // TODO: Elegir uno de los contests

        // Mostrar el primer contest
        _myContestService.getUserContests()
          .then( (jsonObject) {
            ContestReferences contestReferences = new ContestReferences();
            List<Contest> contests = jsonObject.contests.map((jsonObject) => new Contest.fromJsonObject(jsonObject, contestReferences)).toList();
            if (contests != null && !contests.isEmpty) {
              _contestId = contests.first.contestId;
              initialize();
            }
          })
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });
      }
   }

    void initialize() {
       mainPlayer = _profileService.user.userId;

       _myContestService.getContest(_contestId)
           .then((jsonObject) {
             ContestReferences contestReferences = new ContestReferences();
             contest = new Contest.fromJsonObject(jsonObject.contest, contestReferences);
             var templateContest = new TemplateContest.fromJsonObject(jsonObject.template_contest, contestReferences);
             var matchEvents = jsonObject.match_events.map((jsonObject) => new MatchEvent.fromJsonObject(jsonObject, contestReferences)).toList();
              
             usersInfo = jsonObject.users_info.map((jsonObject) => new User.fromJsonObject(jsonObject)).toList();
             contestEntries = jsonObject.contest_entries.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject)).toList();

             updatedDate = new DateTime.now();

             _updateLive();

             // Comenzamos a actualizar la información
             const refreshSeconds = const Duration(seconds:3);
             _timer = new Timer.periodic(refreshSeconds, (Timer t) => _updateLive());

             initialized = true;
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
      for (MatchEvent match in contest.templateContest.templateMatchEvents) {
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
    
    int getSoccerPlayerScore(String soccerPlayerId) => _myContestService.getSoccerPlayerScore(soccerPlayerId);
    int getUserScore(ContestEntry contestEntry) => _myContestService.getUserScore(contestEntry);
    
    String getPrize(int index) {
      String prize = "-";
      switch(index) {
        case 0: prize = "€100,00"; break;
        case 1: prize = "€50,00"; break;
        case 2: prize = "€30,00"; break;
      }
      return prize;
    }

    void detach() {
      if (_timer != null)
        _timer.cancel();
    }

    void _updateLive() {
      // Actualizamos únicamente la lista de live MatchEvents
      _myContestService.getLiveMatchEvents(contest.templateContest.templateContestId)
          .then( (jsonObject) {
            updatedDate = new DateTime.now();
          })
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });
    }

    Timer _timer;

    Scope _scope;
    FlashMessagesService _flashMessage;
    MyContestService _myContestService;
    ProfileService _profileService;

    String _contestId;
}