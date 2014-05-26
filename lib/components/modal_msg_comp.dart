library modal_msg_comp;

import 'package:angular/angular.dart';


@Component(
    selector: 'modal-msg',
    templateUrl: 'packages/webclient/components/modal_msg_comp.html',
    publishAs: 'modalMsg'
)
class ModalMsgComp {

  String hello = "Hello";

  ModalMsgComp(Scope scope, this._router) {

  }

  Router _router;
}