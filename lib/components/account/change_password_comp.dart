library change_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/server_error.dart';
import 'package:webclient/utils/uri_utils.dart';

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

  int MIN_PASSWORD_LENGTH = 8;

  String state = STATE_ENTERING;

  String password = "";
  String rePassword = "";

  String get thePassword => password;
  void set thePassword (String value) {
    password = value;
    validatePassword();
  }

  String get theRePassword => rePassword;
  void set theRePassword (String value) {
    rePassword = value;
    validateRePassword();
  }

  bool get enabledSubmit => password.length >= MIN_PASSWORD_LENGTH && password == rePassword;
  bool errorDetected = false;
  String errorMessage = "";

  ChangePasswordComp(this._router, this._routeProvider, this._profileManager, this._rootElement, this._loadingService) {
    _loadingService.isLoading = true;
    GameMetrics.logEvent(GameMetrics.CHANGE_PASSWORD_ATTEMPTED);
    _profileManager.logout();
    //_stormPathTokenId = _routeProvider.route.parameters['tokenId'];
  }

  @override void onShadowRoot(emulatedRoot) {
    //Cogemos los parametros de la querystring esperando encontrar el parametro del token de stormPath
    Uri uri = Uri.parse(window.location.toString());
    if (uri.queryParameters.containsKey("sptoken")) {
      _stormPathTokenId = uri.queryParameters["sptoken"];

      UriUtils.removeQueryParameters(uri, ["sptoken"]);

      _profileManager.verifyPasswordResetToken(_stormPathTokenId)
       .then((_) {
          state = STATE_CHANGE_PASSWORD;
          _loadingService.isLoading = false;
          print("El estado es [${state}]");
       })
       .catchError( (ServerError error) {
          state = STATE_INVALID_TOKEN;
          _loadingService.isLoading = false;
          print("El estado es [${state}]");
       });
    }
    else {
      _loadingService.isLoading = false;
      state = STATE_INVALID_URL;
    }
  }

  void hideErrors() {
    if(_errContainer == null) {
      _errContainer = _rootElement.querySelector("#errorContainer");
    }
    if ( _errLabel== null ) {
      _errLabel = _rootElement.querySelector('#errorLabel');
      _errLabel.classes.remove('errorDetected');
    }
  }

  void changePassword() {

    hideErrors();
    _enabledSubmit = false;

    _profileManager.resetPassword(password, _stormPathTokenId)
      .then((_) => _router.go('lobby', {}))
      .catchError( (ServerError error) {
        _enabledSubmit = true;
        errorDetected = true;
        errorMessage = error.toJson().containsKey("password")? error.toJson()["password"] : error.toJson()["error"];
        _errLabel.classes.add('errorDetected');
    });
  }

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(routePath, parameters);
  }

  void validatePassword() {
    if(passwordElement == null) {
      passwordElement = _rootElement.querySelector('#passwordInputGroup');
    }
    passwordElement.classes.removeAll(['valid', 'not-valid']);
    // Validación del password
    if (password.length >= MIN_PASSWORD_LENGTH) {
      passwordElement.classes.add('valid');
    }
    else {
      passwordElement.classes.add('not-valid');
    }
  }

  void validateRePassword() {
    if(rePasswordElement == null) {
      rePasswordElement = _rootElement.querySelector('#rePasswordInputGroup');
    }
    rePasswordElement.classes.removeAll(['valid', 'not-valid']);
    //Validación de la confirmación del password
    if (password == rePassword) {
      rePasswordElement.classes.add('valid');
    }
    else {
      rePasswordElement.classes.add('not-valid');
    }
  }

  Router _router;
  RouteProvider _routeProvider;
  ProfileService _profileManager;
  LoadingService _loadingService;

  Element _rootElement;
  Element _errContainer;
  Element _errLabel;

  Element passwordElement;
  Element rePasswordElement;

  String _stormPathTokenId = "";
  bool _enabledSubmit = true;
}
