library lobby_f2p_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'lobbyf2p',
  templateUrl: 'packages/webclient/components/lobby_f2p_comp.html',
  useShadowDom: false
)
class LobbyF2PComp implements DetachAware {
  ContestsService contestsService;
  ScreenDetectorService scrDet;
  LoadingService loadingService;
  DateTime selectedDate;
  
  String get today => DateTimeService.today;

  LobbyF2PComp(this._router, this._refreshTimersService, this.contestsService, this.scrDet, this.loadingService, this._profileService) {

    GameMetrics.logEvent(GameMetrics.LOBBY);

    if (contestsService.activeContests.isEmpty) {
      loadingService.isLoading = true;
    }

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);

  }

  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    contestsService.refreshActiveContests()
      .then((_) {
        loadingService.isLoading = false;
      });
  }

  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    if (_profileService.isLoggedIn) {
      _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
    }
    else {
      _router.go('enter_contest.welcome', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
    }
  }
  
  void onSelectedDayChange(DateTime day) {
    selectedDate = day;
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if (scrDet.isDesktop) {
      _router.go('lobby.contest_info', { "contestId": contest.contestId });
    }
    else {
      onActionClick(contest);
    }
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST);
  }

  Router _router;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
}