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
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

@Controller(
    selector: '[live-contest-ctrl]', 
    publishAs: 'ctrl'
)
class LiveContestCtrl {

    ScreenDetectorService scrDet;
    var selectedOpponent;

    LiveContestCtrl(RouteProvider routeProvider, this._scope, this.scrDet, this._contestService, this._flashMessage) {
      _contestId = routeProvider.route.parameters['contestId'];
      
      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);
      _contestService.getLiveContestEntries(_contestId)
          .then((response) => print("liveContestCtrl FUTURE OK: " + response.toString()))
          .catchError((error) {
            _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
          });
    }

    Scope _scope;
    FlashMessagesService _flashMessage;
    ContestService _contestService;
    
    String _contestId;
}