library lobby_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'lobby',
  templateUrl: 'packages/webclient/components/lobby_comp.html',
  useShadowDom: false
)
class LobbyComp implements DetachAware {

  ContestsService contestsService;
  ScreenDetectorService scrDet;
  LoadingService loadingService;

  // numero de torneos listados actualmente
  int contestsCount = 0;

  // Texto de la barra de información
  String infoBarText = "";

  // Lista de filtros a aplicar
  Map<String, dynamic> lobbyFilters = {};

  // Tipo de ordenación de la lista de partidos
  Map lobbySorting = {};

  // Concursos listados actualmente
  int contestCount = 0;

  LobbyComp(this._router, this._refreshTimersService, this.contestsService, this.scrDet, this.loadingService) {

    GameMetrics.logEvent(GameMetrics.LOBBY);

    if (contestsService.activeContests.isEmpty) {
      loadingService.isLoading = true;
    }

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);
    _nextTournamentInfoTimer = new Timer.periodic(new Duration(seconds: 1), (Timer t) => _calculateInfoBarText());

    _calculateInfoBarText();
  }

  /********* METHODS */
  void _calculateInfoBarText() {
    Contest nextContest = contestsService.getAvailableNextContest();
    infoBarText = nextContest == null? "" : "NEXT CONTEST: ${nextContest.name.toUpperCase()} - ${_calculateTimeToNextTournament()}";
  }

  String _calculateTimeToNextTournament() {
    return DateTimeService.formatTimeLeft(DateTimeService.getTimeLeft( contestsService.getAvailableNextContest().startDate ) );
  }

  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    contestsService.refreshActiveContests()
      .then((_) {
        loadingService.isLoading = false;
        contestsCount = contestsService.activeContests.length;
      });
  }

  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
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

  void onFilterChange(Map filterList) {
    lobbyFilters.addAll(filterList);
  }

  void onSortOrderChange(Map fieldName) {
    lobbySorting = fieldName;
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST);
    _nextTournamentInfoTimer.cancel();
  }

  Router _router;
  RefreshTimersService _refreshTimersService;
  Timer _nextTournamentInfoTimer;
}
