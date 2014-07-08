library live_contest_ctrl;

import 'package:angular/angular.dart';
import 'dart:async';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contest_service.dart';
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
    
    List<ContestEntry> contestEntries = new List<ContestEntry>();

    LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._contestService, this._profileService, this._flashMessage) {
      _contestId = routeProvider.route.parameters['contestId'];
      mainPlayer = _profileService.user.userId;
      
      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
      _contestService.getLiveContestEntries(_contestId)
          .then((jsonObject) {
            //print("liveContestCtrl FUTURE OK: " + jsonObject.toString());
            contestEntries = jsonObject.content.map((jsonObject) => new ContestEntry.fromJsonObject(jsonObject)).toList();
           })
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });
     }
    
    ContestEntry getContestEntry(String userId) {
      return contestEntries.firstWhere( (entry) => entry.userId == userId );
    }
    
    Scope _scope;
    FlashMessagesService _flashMessage;
    ContestService _contestService;
    ProfileService _profileService;
    
    String _contestId;
}