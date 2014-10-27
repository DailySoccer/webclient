library remember_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'remember-password',
    templateUrl: 'packages/webclient/components/account/remember_password_comp.html',
    useShadowDom: false
)
class RememberPasswordComp{

  static const String STATE_REQUEST   = 'STATE_REQUEST';
  String STATE_REQUESTED = 'STATE_REQUESTED';

  String email = "";
  String state = STATE_REQUEST;
  bool get enabledSubmit => StringUtils.isValidEmail(email) && _enabledSubmit;
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
      }
    );
  }



  bool _enabledSubmit = true;
  Router _router;
  ProfileService _profileManager;
  Element _errSection;
  ServerService _serverService;
}