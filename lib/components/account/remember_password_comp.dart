library remember_password_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';

@Component(
    selector: 'remember-password',
    templateUrl: 'remember_password_comp.html'
)
class RememberPasswordComp implements OnInit {


  static const String STATE_REQUEST   = 'STATE_REQUEST';
  static const String STATE_REQUESTED = 'STATE_REQUESTED';

  String email = "";
  String state = STATE_REQUEST;
  bool get enabledSubmit => StringUtils.isValidEmail(email) && _enabledSubmit;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "rememberpass");
  }

  RememberPasswordComp(this._router, this._profileManager, this.loadingService, this._serverService, this._rootElement);

  void navigateTo(String route, Map parameters, event)
  {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.navigate([route, {}]);
  }

  void rememberMyPassword() {
    loadingService.isLoading = true;
    hideErrors();
    _enabledSubmit = false;

    _serverService.askForPasswordReset(email)
      .then((_) {
        state = STATE_REQUESTED;
        loadingService.isLoading = false;
      })
      .catchError((ServerError error) {
        error.toJson().forEach( (key, value) {
          switch (key) {
            case "email":
              _errLabel
                ..classes.remove("errorDetected")
                ..classes.add("errorDetected")
                ..text = value; //"Algo ha ido mal, comprueba que la dirección esté bien escrita";
              _errSection.style.display = "";
            break;
          }
        });
        _enabledSubmit = true;
        loadingService.isLoading = false;
      }, test: (error) => error is ServerError);
  }

  void backToLanding() {
    _router.navigate(["lobby",{}]);
  }

  void hideErrors() {
    _errSection.style.display = 'none';
    _errLabel.text = "";
  }

  @override void ngOnInit() {
    _errSection = _rootElement.nativeElement.querySelector('#errContainer');
    _errLabel = _rootElement.nativeElement.querySelector('#errLabel');
    hideErrors();
  }

  bool _enabledSubmit = true;
  Router _router;
  ProfileService _profileManager;

  ElementRef _rootElement;
  Element _errSection;
  Element _errLabel;

  ServerService _serverService;

  LoadingService loadingService;
}