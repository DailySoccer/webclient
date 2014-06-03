library main_menu_comp;


import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';


@Component(
    selector: 'main-menu',
    templateUrl: 'packages/webclient/components/main_menu_comp.html',
    publishAs: 'mainMenu',
    useShadowDom: false
)
class MainMenuComp implements AttachAware {
  bool   isLoggedIn = false;
  String fullName = "";
  String nickName = "";

  MainMenuComp(Scope scope, this._router, this._profileService) {
    isLoggedIn  = _profileService.isLoggedIn;

    scope.watch("isLoggedIn", (value, _) {
      isLoggedIn = value;

      if (isLoggedIn) {
        fullName = _profileService.user.fullName;
        nickName = _profileService.user.nickName;
      }
    }, context: _profileService);
  }

  void attach() {
    if (isLoggedIn) {
      _router.go('lobby', {});
    }
  }

  void logOut() {
    _profileService.logout();
  }

  void gameMenuClicked(event) {
    querySelector("#game-menu-collapse").querySelector(".active").classes.remove("active");
    event.target.parent.classes.add("active");
  }

  Router _router;
  ProfileService _profileService;
}