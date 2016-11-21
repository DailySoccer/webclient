library scoring_rules_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/services/scoring_rules_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/models/soccer_player.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/server_error.dart';

@Component(
  selector:     'scoring-rules',
  templateUrl:  'scoring_rules_comp.html'
)
class ScoringRulesComp {

  List<Map> AllPlayers;
  List<Map> GoalKeepers;
  List<Map> Defenders;
  List<Map> MidFielders;
  List<Map> Forwards;

  ScoringRulesComp(ScoringRulesService scoringRulesService, FlashMessagesService _flashMessage) {
    scoringRulesService.refreshScoringRules()
      .then((_) {
        _scoringPoints = scoringRulesService.scoringRules;
        _init();
      })
      .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
  }

  String getLocalizedText(key) {
    return StringUtils.translate(key, "scoringrules");
  }

  String getClassesIsNegative(String points) {
    return ( points == null || num.parse(points.replaceFirst(",", ".")) < 0 ) ? "negative": "";
  }

  void _init() {
    AllPlayers  = _allPlayerEvents.map((event)    => {"name": SoccerPlayer.getEventName(event), "points": StringUtils.parseFantasyPoints(_scoringPoints[event])}).toList();
    GoalKeepers = _goalKeeperEvents.map((event)   => {"name": SoccerPlayer.getEventName(event), "points": StringUtils.parseFantasyPoints(_scoringPoints[event])}).toList();
    Defenders   = _defendersEvents.map((event)    => {"name": SoccerPlayer.getEventName(event), "points": StringUtils.parseFantasyPoints(_scoringPoints[event])}).toList();
    MidFielders = _midFieldersEvents.map((event)  => {"name": SoccerPlayer.getEventName(event), "points": StringUtils.parseFantasyPoints(_scoringPoints[event])}).toList();
    Forwards    = _forwardEvents.map((event)      => {"name": SoccerPlayer.getEventName(event), "points": StringUtils.parseFantasyPoints(_scoringPoints[event])}).toList();
  }

  Map<String, int> _scoringPoints;

  List _allPlayerEvents   = [
                            "PASS_SUCCESSFUL"
                            ,"ATTEMPT_SAVED"
                            ,"POST"
                            ,"MISS"
                            ,"TAKE_ON"
                            ,"ASSIST"
                            ,"INTERCEPTION"
                            ,"CLEARANCE"
                            ,"SAVE_PLAYER"
                            ,"TACKLE_EFFECTIVE"
                            ,"FOUL_RECEIVED"
                            ,"PASS_UNSUCCESSFUL"
                            ,"DISPOSSESSED"
                            ,"FOUL_COMMITTED"
                            ,"CAUGHT_OFFSIDE"
                            ,"YELLOW_CARD"
                            ,"SECOND_YELLOW_CARD"
                            ,"RED_CARD"
                            ,"PENALTY_COMMITTED"
                            ,"PENALTY_FAILED"
                            ,"ERROR"
                            ,"DECISIVE_ERROR"
                            ,"OWN_GOAL"
                            ];

  List _goalKeeperEvents  = [
                             "GOAL_SCORED_BY_GOALKEEPER"
                            ,"PUNCH"
                            ,"CLAIM"
                            ,"SAVE_GOALKEEPER"
                            ,"GOALKEEPER_SAVES_PENALTY"
                            ,"CLEAN_SHEET"
                            ,"GOAL_CONCEDED"
                            ];

 List _defendersEvents    = [
                             "GOAL_SCORED_BY_DEFENDER"
                            ,"CLEAN_SHEET"
                            ,"GOAL_CONCEDED"
                            ];

  List _midFieldersEvents = [
                             "GOAL_SCORED_BY_MIDFIELDER"
                            ];

  List _forwardEvents     = [
                             "GOAL_SCORED_BY_FORWARD"
                            ];


}