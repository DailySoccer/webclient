library active_contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(selector: 'lobby',
           templateUrl: 'packages/webclient/components/lobby_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class LobbyComp implements DetachAware {

  ActiveContestsService activeContestsService;
  Contest selectedContest;

  LobbyComp(this._router, this.activeContestsService, this._scrDet) {
      activeContestsService.refreshActiveContests();

      const refreshSeconds = const Duration(seconds:10);
      _timer = new Timer.periodic(refreshSeconds, (Timer t) => activeContestsService.refreshActiveContests());
      _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg) );
  }

  void onScreenWidthChange(String msg)
  {
    if(msg == "xs"){
      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal'])
        .callMethod('modal', ['hide']);

      print('-LOBBY COMP- ...cerrada');
    }
  }

  void onRowClick(Contest contest) {
    if(!_scrDet.isXsScreen)
    {
      selectedContest = contest;

      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";

      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal'])
        .callMethod('modal');
        //.callMethod('show'); //[new js.JsObject.jsify({'show': 'true'})]);
    }
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
  ScreenDetectorService _scrDet;
}
