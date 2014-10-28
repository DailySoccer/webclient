library change_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/loading_service.dart';

@Component(
    selector: 'change-password',
    templateUrl: 'packages/webclient/components/account/change_password_comp.html',
    useShadowDom: false
)
class ChangePasswordComp implements ShadowRootAware {
  static const String STATE_ENTERING        = 'STATE_ENTERING';
  static const String STATE_INVALID_URL     = 'STATE_INVALID_URL';
  static const String STATE_INVALID_TOKEN   = 'STATE_INVALID_TOKEN';
  static const String STATE_CHANGE_PASSWORD = 'STATE_CHANGE_PASSWORD';

  String state = STATE_ENTERING;

  String password = "";
  String rePassword = "";

  bool get enabledSubmit => rePassword.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  bool errorDetected = false;
  String errorMessage ="HA OCURRIDO UN ERROR. La contraseña no es válida.";

  ChangePasswordComp(this._router, this._routeProvider, this._profileManager, this._rootElement) {
    LoadingService.enabled = true;
    GameMetrics.logEvent(GameMetrics.CHANGE_PASSWORD_ATTEMPTED);
    //_stormPathTokenId = _routeProvider.route.parameters['tokenId'];
  }

  @override void onShadowRoot(emulatedRoot) {
    //Cogemos los parametros de la querystring esperando encontrar el parametro del token de stormPath
    String querystring = window.location.toString().substring(window.location.toString().indexOf('?') + 1);
    Map<String,String> params = Uri.splitQueryString(querystring);

    if (params != null) {
      _stormPathTokenId = params.containsKey('sptoken') ? params["sptoken"] : "";
      print("Encontrado el parámetro del token ${_stormPathTokenId}");

      if(_stormPathTokenId.isEmpty) {
        state = STATE_INVALID_URL;
        LoadingService.enabled = false;
        return;
      }

      _profileManager.verifyPasswordResetToken(_stormPathTokenId)
       .then((_) {
          state = STATE_CHANGE_PASSWORD;
          LoadingService.enabled = false;
          _rootElement.querySelector('#password').focus();
       })
       .catchError( (ConnectionError error) {
          state = STATE_INVALID_TOKEN;
          LoadingService.enabled = false;
       });
    }
  }

  void changePassword() {

    _enabledSubmit = false;
    if (password != rePassword) {
      _enabledSubmit = true;
      errorDetected = true;
      errorMessage = "Los passwords no coinciden. Revisa la ortografía";
      return;
    }

    _profileManager.verifyPasswordResetToken(_stormPathTokenId)
      .then((_) => _router.go('lobby', {}))
      .catchError( (ConnectionError error) {
        _enabledSubmit = true;
        errorDetected = true;
        errorMessage = error.toJson()["error"];
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
