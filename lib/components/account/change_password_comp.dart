library change_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/server_service.dart';

@Component(
    selector: 'change-password',
    templateUrl: 'packages/webclient/components/account/change_password_comp.html',
    useShadowDom: false
)
class ChangePasswordComp implements ShadowRootAware {

  String password = "";
  String rePassword = "";

  bool get enabledSubmit => rePassword.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  bool errorDetected = false;

  ChangePasswordComp(this._router, this._routeProvider, this._profileManager, this._rootElement) {
    GameMetrics.logEvent(GameMetrics.CHANGE_PASSWORD_ATTEMPTED);
    _stormPathTokenId = _routeProvider.route.parameters['tokenId'];
  }

  @override void onShadowRoot(emulatedRoot) {
    _rootElement.querySelector('#password').focus();
  }

  void verifyPasswordResetToken() {

    _enabledSubmit = false;
    if (password != rePassword) {
      _enabledSubmit = true;
      errorDetected = true;
      _errSection.text = "Los passwords no coinciden. Revisa la ortografía";
    }

    _profileManager.verifyPasswordResetToken(password, _stormPathTokenId)
        .then((_) => _router.go('lobby', {}))
        .catchError( (ConnectionError error) {
          _enabledSubmit = true;
          errorDetected = true;
          _errSection.text = error.toJson()["error"][0];
        });
  }

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }

    _router.go(routePath, parameters);
 }

  Router _router;
  RouteProvider _routeProvider;
  ProfileService _profileManager;
  Element _rootElement;
  Element _errSection;

  String _stormPathTokenId = "";
  bool _enabledSubmit = true;
}
