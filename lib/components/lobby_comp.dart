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
  Contest selectedContest;
  ScreenDetectorService scrDet;

  // numero de torneos listados actualmente
  int contestsCount = 0;

  // Texto de la barra de información
  String infoBarText = "";

  // Lista de filtros a aplicar
  Map<String, dynamic> lobbyFilters = {};

  // Tipo de ordenación de la lista de partidos
  String lobbySorting = "";

  LobbyComp(this._router, this._refreshTimersService, this.activeContestsService, this.scrDet) {
    LoadingService.enabled = true;
    activeContestsService.clear();

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);
    _nextTournamentInfoTimer = new Timer.periodic(new Duration(seconds: 1), (Timer t) =>  _calculateInfoBarText());

    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));

    _calculateInfoBarText();
  }

  void _calculateInfoBarText() {
    Contest nextContest = activeContestsService.getAvailableNextContest();
    String tmp = nextContest == null ? "Pronto habrá nuevos Torneos disponibles" : "SIGUIENTE TORNEO: ${nextContest.name.toUpperCase()} - ${_calculateTimeToNextTournament()}";
    if (tmp.compareTo(infoBarText) != 0) {
      infoBarText = tmp;
    }
  }

  String _calculateTimeToNextTournament() {
    return DateTimeService.formatTimeLeft(DateTimeService.getTimeLeft( activeContestsService.getAvailableNextContest().startDate ) );
  }

  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    activeContestsService.refreshActiveContests()
      .then((_) {
        contestsCount = activeContestsService.activeContests.length;
      });
  }

  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    selectedContest = contest;
    _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby" });
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if (scrDet.isDesktop) {
      selectedContest = contest;
      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";
      // Con esto llamamos a funciones de jQuery
      JsUtils.runJavascript('#infoContestModal', 'modal', null);
    }
    else {
      onActionClick(contest);
    }
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

  bool isFirstTimeListFill = true;
  bool _firstTime;
}
