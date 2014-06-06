library modal_contest_comp;

import 'package:angular/angular.dart';


@Component(
   selector: 'modal-contest',
   templateUrl: 'packages/webclient/components/modal_contest_comp.html',
   publishAs: 'modalContest',
   useShadowDom: false
)

class ModalContestComp {
  
  String informacion;
  String participantes;
  String premios;

 ModalContestComp(Scope scope, this._router) {
   informacion    = "";
   participantes  = "//TODO Participantes";
   premios        = "//TODO premios";
 }

 Router _router;
}