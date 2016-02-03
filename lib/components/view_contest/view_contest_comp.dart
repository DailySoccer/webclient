library view_contest_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/match_event.dart';
import 'package:webclient/models/instance_soccer_player.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/models/soccer_team.dart';

@Component(
    selector: 'view-contest',
    templateUrl: 'packages/webclient/components/view_contest/view_contest_comp.html',
    useShadowDom: false)
class ViewContestComp implements DetachAware {

  ScreenDetectorService scrDet;
  LoadingService loadingService;

  ContestEntry mainPlayer;
  ContestEntry selectedOpponent;

  DateTime updatedDate;
  String lastOpponentSelected = "";
  bool isOpponentSelected = false;

  String contestId;
  Contest contest;

  String nameFilter;
  FieldPos fieldPosFilter;
  bool onlyFavorites = false;
  String matchFilter;
  List<dynamic> allSoccerPlayers;
  List<dynamic> favoritesPlayers = [];

  bool get isLive => _routeProvider.route.name.contains("live_contest");
  bool get showChanges => contest != null ? contest.isLive : false;
  bool isMakingChange = false;

  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  String get changingPlayerId => _changingPlayer != null? _changingPlayer.id : null;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "viewcontest");
  }

  ViewContestComp(this._routeProvider, this.scrDet, this._refreshTimersService,
      this._contestsService, this._profileService, this._flashMessage, this.loadingService, this._tutorialService) {
    loadingService.isLoading = true;
    lastOpponentSelected = getLocalizedText("opponent");

    contestId = _routeProvider.route.parameters['contestId'];

    _tutorialService.triggerEnter("view_contest", component: this);

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    (isLive ? _contestsService.refreshMyLiveContest(contestId) : _contestsService.refreshMyHistoryContest(contestId))
      .then((_) {
        loadingService.isLoading = false;
        contest = _contestsService.lastContest;

        if (_profileService.isLoggedIn && contest.containsContestEntryWithUser(_profileService.user.userId)) {
          mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
        }
        else {
          mainPlayer = contest.contestEntriesOrderByPoints.first;
        }
        updateSoccerPlayerStates();

        // En el caso de los tipos de torneo 1vs1 el oponente se autoselecciona
        if(contest.tournamentType == Contest.TOURNAMENT_HEAD_TO_HEAD) {
          selectedOpponent = contestEntries.firstWhere((contestEntry) => contestEntry.contestEntryId != mainPlayer.contestEntryId, orElse: () => null);
          if (selectedOpponent != null) {
            onUserClick(selectedOpponent, preventViewOpponent: true);
          }
        }

        updatedDate = DateTimeService.now;

        // Únicamente actualizamos los contests que estén en "live"
        if (_contestsService.lastContest.isLive) {
          _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE, updateLive);
          GameMetrics.logEvent(GameMetrics.LIVE_CONTEST_VISITED);
        } else if (_contestsService.lastContest.isHistory) {
          GameMetrics.logEvent(GameMetrics.VIEW_HISTORY);
        } else {
          GameMetrics.logEvent(GameMetrics.VIEW_CONTEST);
        }
      })
      .catchError((ServerError error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW), test: (error) => error is ServerError);
  }

  String getPrize(int index) => (contest != null) ? contest.getPrize(index) : "-";

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE);
  }

  void updateLive() {
    // Actualizamos únicamente la lista de live MatchEvents
    (_contestsService.lastContest.simulation
      ? _contestsService.refreshLiveMatchEvents(contestId: _contestsService.lastContest.contestId)
      : _contestsService.refreshLiveMatchEvents(templateContestId: _contestsService.lastContest.templateContestId))
        .then((_) {
          updatedDate = DateTimeService.now;

          // Actualizar al usuario principal (al que destacamos)
          if (!_profileService.isLoggedIn || !contest.containsContestEntryWithUser(_profileService.user.userId)) {
            mainPlayer = contest.contestEntriesOrderByPoints.first;
          }
          updateSoccerPlayerStates();
        })
        .catchError((ServerError error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        }, test: (error) => error is ServerError);
  }

  void updateSoccerPlayerStates() {
    mainPlayer.instanceSoccerPlayers.forEach( (i) {
      MatchEvent match = contest.matchEvents.firstWhere( (m) => m.containsTeam(i.soccerTeam));
      i.playState = match.isFinished ? InstanceSoccerPlayer.STATE_PLAYED  :
                    match.isStarted  ? InstanceSoccerPlayer.STATE_PLAYING :
                            /*Else*/   InstanceSoccerPlayer.STATE_NOT_PLAYED;
    });
  }

  void onUserClick(ContestEntry contestEntry, {preventViewOpponent: false}) {
    if (contestEntry.contestEntryId == mainPlayer.contestEntryId) {
      tabChange('userFantasyTeam');
    }
    else {
      switch (_routeProvider.route.name)
      {
        case "live_contest":
        case "history_contest":
          selectedOpponent = contestEntry;
          isOpponentSelected = true;
          lastOpponentSelected = contestEntry.user.nickName;

          AnchorElement tabLabel = querySelector("#opponentFantasyTeamTab");
          if(tabLabel != null) {
            tabLabel.text  = lastOpponentSelected;
          }
          if(!preventViewOpponent) {
            tabChange('opponentFantasyTeam');
         }
        break;
      }

      _tutorialService.triggerEnter("user_selected", component: this, activateIfNeeded: false);
    }
  }

  void tabChange(String tab) {
    if (tab == "opponentFantasyTeam" && !isOpponentSelected) {
      return;
    }
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");

    List<dynamic> allTabButtons = document.querySelectorAll("#liveContestTab li");
    allTabButtons.forEach((element) => element.classes.remove('active'));

    // activamos el tab button
    Element tabButton = document.querySelector("#" + tab + "Tab");
    if (tabButton != null) {
      tabButton.parent.classes.add("active");
    }
  }

  void onRequestChange(InstanceSoccerPlayer instanceSoccerPlayer) {
    isMakingChange = !isMakingChange;

    if (isMakingChange) {
      int intId = 0;
      //allSoccerPlayers = [];
      _changingPlayer = instanceSoccerPlayer;

      _contestsService.getSoccerPlayersAvailablesToChange(contest.contestId)
        .then((List<InstanceSoccerPlayer> instanceSoccerPlayers) {
          allSoccerPlayers = [];

          instanceSoccerPlayers.forEach((instanceSoccerPlayer) {
            if (mainPlayer != null && mainPlayer.isPurchased(instanceSoccerPlayer)) {
              instanceSoccerPlayer.level = 0;
            }

            MatchEvent matchEvent = instanceSoccerPlayer.soccerTeam.matchEvent;
            SoccerTeam soccerTeam = instanceSoccerPlayer.soccerTeam;

            String shortNameTeamA = matchEvent.soccerTeamA.shortName;
            String shortNameTeamB = matchEvent.soccerTeamB.shortName;

            var matchEventName = (instanceSoccerPlayer.soccerTeam.templateSoccerTeamId == matchEvent.soccerTeamA.templateSoccerTeamId)
                 ? "<strong>$shortNameTeamA</strong> - $shortNameTeamB"
                 : "$shortNameTeamA - <strong>$shortNameTeamB</strong>";

            if (instanceSoccerPlayer.soccerPlayer.name == null) {
              print(instanceSoccerPlayer.soccerPlayer.templateSoccerPlayerId);
            } else {
              print(instanceSoccerPlayer.soccerPlayer.name);
              allSoccerPlayers.add({
                "instanceSoccerPlayer": instanceSoccerPlayer,
                "id": instanceSoccerPlayer.id,
                "intId": intId++,
                "fieldPos": instanceSoccerPlayer.fieldPos,
                "fieldPosSortOrder": instanceSoccerPlayer.fieldPos.sortOrder,
                "fullName": instanceSoccerPlayer.soccerPlayer.name,
                "fullNameNormalized": StringUtils.normalize(instanceSoccerPlayer.soccerPlayer.name).toUpperCase(),
                "matchId" : matchEvent.templateMatchEventId,
                "matchEventName": matchEventName,
                "remainingMatchTime": "-",
                "fantasyPoints": instanceSoccerPlayer.soccerPlayer.getFantasyPointsForCompetition(contest.optaCompetitionId),
                "playedMatches": instanceSoccerPlayer.soccerPlayer.getPlayedMatchesForCompetition(contest.optaCompetitionId),
                "salary": instanceSoccerPlayer.salary
              });
            }
          });
        updateFavorites();
      });
    } else {
      _changingPlayer = null;
    }

    if (_changingPlayer != null) {
      fieldPosFilter = _changingPlayer.fieldPos;
    }
    print("CLICKED: ${instanceSoccerPlayer.soccerPlayer.name}");
  }

  void updateFavorites() {
    favoritesPlayers.clear();
    if (_profileService.isLoggedIn) {
      favoritesPlayers.addAll(_profileService.user.favorites.map((playerId) =>
          allSoccerPlayers.firstWhere( (player) => player['id'] == playerId, orElse: () => null)
        ).where( (d) => d != null));
    }
  }

  void onRowClick(String soccerPlayerId) {
    //print(soccerPlayerId);
  }

  void onSoccerPlayerActionButton(var soccerPlayer) {
    //print(soccerPlayer);
    /*InstanceSoccerPlayer instanceSoccerPlayer = soccerPlayer['instanceSoccerPlayer'];
    mainPlayer.instanceSoccerPlayers.removeWhere( (i) => i.id == _changingPlayer.id);
    mainPlayer.instanceSoccerPlayers.add(instanceSoccerPlayer);*/
  }

  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
  TutorialService _tutorialService;
  InstanceSoccerPlayer _changingPlayer;
}

