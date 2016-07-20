library soccerPlayerListItem;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/models/soccer_team.dart';

class SoccerPlayerListItem {
  InstanceSoccerPlayer get instanceSoccerPlayer => _instanceSoccerPlayer;

  String get id => _instanceSoccerPlayer.id;
  FieldPos get fieldPos => _instanceSoccerPlayer.fieldPos;
  int get fieldPosSortOrder => _instanceSoccerPlayer.fieldPos.sortOrder;
  String get fullName => instanceSoccerPlayer.soccerPlayer.name;
  String get fullNameNormalized => _fullNameNormalized;
  String get matchId => _matchEvent.templateMatchEventId;
  String get matchEventNameHTML => _matchEventNameHTML;
  SoccerTeam get soccerTeam => _instanceSoccerPlayer.soccerTeam;

  //String get remainingMatchTime => "";
  int get fantasyPoints => _fantasyPoints;
  int get playedMatches => _playedMatches;
  int get salary => instanceSoccerPlayer.salary;
  int get level => instanceSoccerPlayer.level;
  Money get moneyToBuy => instanceSoccerPlayer.moneyToBuy(_contest, _playerManagerLevel);

  SoccerPlayerListItem(this._instanceSoccerPlayer, this._playerManagerLevel, this._contest) {
    _optaCompetitionId = _contest.optaCompetitionId;
    _fullNameNormalized = StringUtils.normalize(instanceSoccerPlayer.soccerPlayer.name).toUpperCase();
    _matchEvent = _instanceSoccerPlayer.soccerTeam.matchEvent;
    
    String shortNameTeamA = _matchEvent.soccerTeamA.shortName;
    String shortNameTeamB = _matchEvent.soccerTeamB.shortName;
    _matchEventNameHTML = (_instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == _matchEvent.soccerTeamA.templateSoccerTeamId)
               ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
               : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

    _fantasyPoints = instanceSoccerPlayer.soccerPlayer.getFantasyPointsForCompetition(_optaCompetitionId);
    _playedMatches = instanceSoccerPlayer.soccerPlayer.getPlayedMatchesForCompetition(_optaCompetitionId);
  }

  InstanceSoccerPlayer _instanceSoccerPlayer = null;
  String _fullNameNormalized = null;
  String _matchEventNameHTML = null;
  String _optaCompetitionId = null;
  num _playerManagerLevel = null;
  Contest _contest = null;
  MatchEvent _matchEvent = null;
  
  int _fantasyPoints = 0;
  int _playedMatches = 0;
}