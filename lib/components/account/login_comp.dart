 library login_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/server_error.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'login',
    templateUrl: 'packages/webclient/components/account/login_comp.html',
    useShadowDom: false
)
class LoginComp implements ShadowRootAware {

  String emailOrUsername = "";
  String password = "";
  String rememberMe;

  bool get enabledSubmit => StringUtils.isValidEmail(emailOrUsername) && password.isNotEmpty && _enabledSubmit;

  LoginComp(this._router, this._profileManager, this.loadingService, this._rootElement, this._scrDet) {
    _fbLogin = new FBLogin(_router, _profileManager);
  }

  @override void onShadowRoot(emulatedRoot) {
    _errSection = _rootElement.querySelector("#mailPassError");
    _errSection.parent.parent.style.display = 'none';
    //_scrDet.scrollTo('.panel-heading', offset: 0, duration:  500, smooth: true, ignoreInDesktop: false);
  }

  void login() {
    loadingService.isLoading = true;
    GameMetrics.logEvent(GameMetrics.LOGIN_ATTEMPTED);

    _errSection.parent.parent.style.display = "none";
    _enabledSubmit = false;

    _profileManager.login(emailOrUsername, password)
        .then((_) {
          GameMetrics.logEvent(GameMetrics.LOGIN_SUCCESSFUL);
          loadingService.isLoading = false;
          _router.go('lobby', {});
        })
        .catchError( (ServerError error) {
          loadingService.isLoading = false;
          _enabledSubmit = true;
          _errSection
            ..text = error.toJson()["email"][0]
            ..classes.remove("errorDetected")
            ..classes.add("errorDetected")
            ..parent.parent.style.display = '';
        });
  }

  void navigateTo(String routePath, Map parameters, event) {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(routePath, parameters);
  }

  FBLogin _fbLogin;

  Router _router;
  ProfileService _profileManager;
  Element _rootElement;
  Element _errSection;

  bool _enabledSubmit = true;
  ScreenDetectorService _scrDet;
  LoadingService loadingService;
}
