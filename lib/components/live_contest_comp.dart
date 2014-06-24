library live_contest_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(selector: 'live-contest', templateUrl: 'packages/webclient/components/live_contest_comp.html', publishAs: 'liveContest', useShadowDom: false)
class LiveContestComp {

    ScreenDetectorService scrDet;
    var selectedOpponent;

    LiveContestComp(this._scope, this.scrDet) {
    }

    Scope _scope;
}
