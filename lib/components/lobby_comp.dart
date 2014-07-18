library active_contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/contest.dart';


@Component(selector: 'lobby',
           templateUrl: 'packages/webclient/components/lobby_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class LobbyComp implements DetachAware {

  ActiveContestsService activeContestsService;
  Contest selectedContest;

  LobbyComp(this._router, this.activeContestsService) {
      activeContestsService.refreshActiveContests();

      const refreshSeconds = const Duration(seconds:10);
      _timer = new Timer.periodic(refreshSeconds, (Timer t) => activeContestsService.refreshActiveContests());
  }

  void onRowClick(Contest contest) {
    selectedContest = contest;

    // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
    var modal = querySelector('#infoContestModal');
    modal.style.display = "block";

    // Con esto llamamos a funciones de jQuery
    js.context.callMethod(r'$', ['#infoContestModal'])
      .callMethod('modal', [new js.JsObject.jsify({'show': 'true'})]);

  }

  void onActionClick(Contest contest) {
    selectedContest = contest;
    _router.go('enter_contest', { "contestId": contest.contestId });
  }

  void detach() {
    _timer.cancel();
  }

  Timer _timer;
  Router _router;
}
