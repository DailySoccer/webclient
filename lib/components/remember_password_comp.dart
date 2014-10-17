library remember_password_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/server_service.dart';

@Component(
    selector: 'remember-password',
    templateUrl: 'packages/webclient/components/remember_password_comp.html',
    useShadowDom: false
)
class RememberPasswordComp implements ShadowRootAware {

  bool enabledSubmit = true;
  String email = "";
  String state = "REQUEST";
  bool get isEnabledSubmit => email.isNotEmpty && enabledSubmit;

  RememberPasswordComp(this._router, this._profileManager, ServerService _serverService);

  void navigateTo(String route, Map parameters, event)
  {
    if (event.target.id != "btnSubmit") {
      event.preventDefault();
    }
    _router.go(route, {});
  }

  void rememberMyPassword() {
    _serverService.askForPasswordReset(email)
     .then((_) {
        state = "REQUESTED";
      //  print('-REMEMBER_PASSWORD-: Se ha enviado correctamente');
    })
     .catchError( (error) {
          print('-REMEMBER_PASSWORD-: error');
      }
    );
  }

  @override void onShadowRoot(emulatedRoot) {
 //   _errSection = rootElement.querySelector("#errLabel");
 //   _errSection.parent.parent.style.display = 'none';
 //   rootElement.querySelector('#email').focus();
  }

  Router _router;
  ProfileService _profileManager;
  Element _errSection;
  ServerService _serverService;
}