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
    String currentPath;
    String informacion;
    String contestants;
    String prizes;

    ContestInfoComp(Scope scope, this._router) {
        //contest = new Map();
        informacion = "";
        contestants = "//TODO Participantes";
        prizes = "//TODO premios";
    }

    Router _router;
}
