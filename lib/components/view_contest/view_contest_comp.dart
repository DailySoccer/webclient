library view_contest_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

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
  String lastOpponentSelected = "Adversario";
  bool isOpponentSelected = false;

  String contestId;
  Contest contest;

  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;


  ViewContestComp(this._routeProvider, this.scrDet, this._refreshTimersService, this._myContestsService, this._profileService, this._flashMessage, this.loadingService) {
    loadingService.isLoading = true;

    contestId = _routeProvider.route.parameters['contestId'];

    _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

    _myContestsService.refreshViewContest(contestId)
      .then((jsonMap) {
        loadingService.isLoading = false;
        contest = _myContestsService.lastContest;
        mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

        updatedDate = DateTimeService.now;

        // Únicamente actualizamos los contests que estén en "live"
        if (_myContestsService.lastContest.isLive) {
          _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE, _updateLive);

          //if(_myContestsService.lastContest.competitionType == Contest.TOURNAMENT_HEAD_TO_HEAD) {
            // TODO: Es un partido headh to seleccionar como oponente al adversario
            //print("TOURNAMENT_HEAD_TO_HEAD: " + (_myContestsService.lastContest.tournamentType == Contest.TOURNAMENT_HEAD_TO_HEAD).toString());
          //}
        }
      })
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  String getPrize(int index) {
    String prizeText = "-";
    if (index < _prizes.length) {
      prizeText = "${_prizes[index]}€";
    }
    return prizeText;
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_LIVE);
  }

  void _updateLive() {
    // Actualizamos únicamente la lista de live MatchEvents
    _myContestsService.refreshLiveMatchEvents(_myContestsService.lastContest.templateContestId)
        .then((jsonObject) {
          updatedDate = DateTimeService.now;
        })
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
  }

  void onUserClick(ContestEntry contestEntry) {
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
          setTabNameAndShowIt(contestEntry.user.nickName);
        break;
      }
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

  void setTabNameAndShowIt(String name)
  {
    lastOpponentSelected = name;
    Element anchor = querySelector("#opponentFantasyTeamTab");

    if (anchor != null) {
      anchor.text = lastOpponentSelected;
      tabChange("opponentFantasyTeam");

      // Tenemos que cambiar a mano tb la clase del tab para que aparezca con el estilo seleccionado.
      List<Element> lis = querySelectorAll("#liveContestTab li");
      lis.forEach( (element) => element.classes.remove('active'));
      anchor.parent.classes.add("active");
    }
  }

  FlashMessagesService _flashMessage;
  RouteProvider _routeProvider;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  MyContestsService _myContestsService;

  List<int> get _prizes => (contest != null) ? contest.prizes : []; // TODO: Chapucioso, no crear un array nuevo
}

