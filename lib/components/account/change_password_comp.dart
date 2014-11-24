library change_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/connection_error.dart';
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

  String state = STATE_ENTERING;

  String password = "";
  String rePassword = "";

  bool get enabledSubmit => rePassword.isNotEmpty && password.isNotEmpty && _enabledSubmit;

  bool errorDetected = false;
  String errorMessage ="HA OCURRIDO UN ERROR. La contraseña no es válida.";

  ChangePasswordComp(this._router, this._routeProvider, this._profileManager, this._rootElement, this._loadingService) {
    _loadingService.isLoading = true;
    GameMetrics.logEvent(GameMetrics.CHANGE_PASSWORD_ATTEMPTED);
    //_stormPathTokenId = _routeProvider.route.parameters['tokenId'];
  }


  void replaceUri(Uri uri) {
    Map<String, String> newQueryParams = new Map.fromIterable(
        uri.queryParameters.keys.where((param) => !param.startsWith("sptoken")),
        key: (item) => item,
        value: (item) => uri.queryParameters[item]);

    window.history.replaceState(null, // Pasamos null porque el getter de state no funciona en Dart:
                                      // https://groups.google.com/a/dartlang.org/forum/#!msg/bugs/zvNSxQMQ5FY/6D4mo0IAbxcJ
        window.document.documentElement.title, new Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: (newQueryParams.length > 0)? newQueryParams : null,
        fragment: (uri.fragment.length > 0)? uri.fragment : null ).toString());
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
       })
       .catchError( (ConnectionError error) {
          state = STATE_INVALID_TOKEN;
          _loadingService.isLoading = false;
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

    _profileManager.resetPassword(password, _stormPathTokenId)
      .then((_) => _router.go('lobby', {}))
      .catchError( (ConnectionError error) {
        _enabledSubmit = true;
        errorDetected = true;
        errorMessage = error.toJson().containsKey("password")? error.toJson()["password"] : error.toJson()["error"];
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
  LoadingService _loadingService;

  Element _rootElement;
  Element _errSection;

  String _stormPathTokenId = "";
  bool _enabledSubmit = true;
}
