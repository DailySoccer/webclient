library verify_account_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/server_error.dart';
import 'package:webclient/utils/uri_utils.dart';

@Component(
    selector: 'verify-account',
    templateUrl: 'packages/webclient/components/account/verify_account_comp.html',
    useShadowDom: false
)
class VerifyAccountComp implements ShadowRootAware {
  static const String STATE_ENTERING        = 'STATE_ENTERING';
  static const String STATE_INVALID_URL     = 'STATE_INVALID_URL';
  static const String STATE_INVALID_TOKEN   = 'STATE_INVALID_TOKEN';
  //static const String STATE_VERIFIED        = 'STATE_VERIFIED';

  String state = STATE_ENTERING;

  bool errorDetected = false;
  String errorMessage = "";

  bool get isLoading => _loadingService.isLoading;



  VerifyAccountComp(this._router, this._routeProvider, this._profileManager, this._rootElement, this._loadingService) {
    _loadingService.isLoading = true;
  }

  @override void onShadowRoot(emulatedRoot) {
    //Cogemos los parametros de la querystring esperando encontrar el parametro del token de stormPath
    Uri uri = Uri.parse(window.location.toString());
    if (uri.queryParameters.containsKey("sptoken")) {
      _stormPathTokenId = uri.queryParameters["sptoken"];

      UriUtils.removeQueryParameters(uri, ["sptoken"]);

      _profileManager.verifyAccountToken(_stormPathTokenId)
       .then((_) {
          //state = STATE_VERIFIED;
          print("El estado es [${state}]");
          GameMetrics.logEvent(GameMetrics.VERIFIED_ACCOUNT);
          _router.go('login',{});
          _loadingService.isLoading = false;

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
  Element _errContainer;
  Element _errLabel;

  String _stormPathTokenId = "";
  bool _enabledSubmit = true;
}
