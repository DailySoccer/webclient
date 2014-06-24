library contest_info_comp;

import 'package:angular/angular.dart';

@Component(selector: 'contest-info', templateUrl: 'packages/webclient/components/contest_info_comp.html', publishAs: 'contestInfo', useShadowDom: false)
class ContestInfoComp {
    Map contest = {
        'description': 'TORNEO MULTIJUGADOR (500) LIM. 60M',
        'name': 'CONQUISTA EUROPA',
        'entry': '€25',
        'prize': '€65.000'
    };

    ContestInfoComp(Scope scope, this._router) {
    }

    Router _router;
}
