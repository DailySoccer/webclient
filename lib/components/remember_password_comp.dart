library remember_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/server_service.dart';

@Component(
    selector: 'remember-password',
    templateUrl: 'packages/webclient/components/remember_password_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class RememberPasswordComp{

  int STATE_REQUEST   = 0;
  int STATE_REQUESTED = 1;

  String email = "";
  int state = 0;
  bool get enabledSubmit => isValidEmail(email) && _enabledSubmit;
  bool errorDetected = false;

  RememberPasswordComp(this._router, this._profileManager, this._serverService);

  void navigateTo(String route, Map parameters, event)
  {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(route, {});
  }

  void rememberMyPassword() {
    errorDetected = false;
    _enabledSubmit = false;

    _serverService.askForPasswordReset(email)
     .then((_) {
        state = STATE_REQUESTED;
    })
     .catchError( (error) {
        errorDetected = true;
        _enabledSubmit = true;
        print('-REMEMBER_PASSWORD-: error');
      }
    );
  }

  bool isValidEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool _enabledSubmit = true;
  Router _router;
  ProfileService _profileManager;
  Element _errSection;
  ServerService _serverService;
}