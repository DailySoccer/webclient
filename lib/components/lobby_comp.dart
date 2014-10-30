library lobby_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/js_utils.dart';

@Component(
  selector: 'lobby',
  templateUrl: 'packages/webclient/components/lobby_comp.html',
  useShadowDom: false
)
class LobbyComp implements DetachAware {

  ActiveContestsService activeContestsService;
  String selectedContestId;
  ScreenDetectorService scrDet;
  LoadingService loadingService;

  // numero de torneos listados actualmente
  int contestsCount = 0;

  // Texto de la barra de información
  String infoBarText = "";

  // Lista de filtros a aplicar
  Map<String, dynamic> lobbyFilters = {};

  // Tipo de ordenación de la lista de partidos
  String lobbySorting = "";

  // Concursos listados actualmente
  int contestCount = 0;

  LobbyComp(this._router, this._refreshTimersService, this.activeContestsService, this.scrDet, this.loadingService) {
    loadingService.isLoading = true;
    activeContestsService.clear();

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);
    _nextTournamentInfoTimer = new Timer.periodic(new Duration(seconds: 1), (Timer t) =>  _calculateInfoBarText());

    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));

    _calculateInfoBarText();
  }

  /********* METHODS */
  void _calculateInfoBarText() {
    Contest nextContest = activeContestsService.getAvailableNextContest();
    infoBarText = nextContest == null? "" : "SIGUIENTE TORNEO: ${nextContest.name.toUpperCase()} - ${_calculateTimeToNextTournament()}";
  }

  String _calculateTimeToNextTournament() {
    return DateTimeService.formatTimeLeft(DateTimeService.getTimeLeft( activeContestsService.getAvailableNextContest().startDate ) );
  }

  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    activeContestsService.refreshActiveContests()
      .then((_) {
        loadingService.isLoading = false;
        contestsCount = activeContestsService.activeContests.length;
      });
  }

  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby" });
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if (scrDet.isDesktop) {
      selectedContestId = contest.contestId;

      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";
      JsUtils.runJavascript('#infoContestModal', 'modal', null);
    }
    else {
      onActionClick(contest);
    }
  }

  void onFilterChange(Map filterList) {
    lobbyFilters.addAll(filterList);
  }

  void onSortOrderChange(String fieldName) {
    lobbySorting = fieldName;
  }

  // Handler que recibe cual es la nueva mediaquery aplicada según el ancho de la pantalla.
  void onScreenWidthChange(String msg) {
    if (msg != "desktop") {
      // Ocultamos la ventana modal
      JsUtils.runJavascript('#infoContestModal', 'modal', 'hide');
    }
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST);
    _nextTournamentInfoTimer.cancel();
    _streamListener.cancel();
  }

  dynamic _streamListener;
  Router _router;
  RefreshTimersService _refreshTimersService;
  Timer _nextTournamentInfoTimer;
}
