library main_menu_comp;


import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'main-menu',
    templateUrl: 'packages/webclient/components/main_menu_comp.html',
    publishAs: 'mainMenu',
    useShadowDom: false
)

class MainMenuComp {
  bool   isLoggedIn = false;
  //String fullName = "";
  String nickName = "";

  ScreenDetectorService scrDet;

  MainMenuComp(Scope scope, this.scrDet, this._router, this._profileService) {
    isLoggedIn  = _profileService.isLoggedIn;

    scope.watch("user", (value, _) {
      isLoggedIn = _profileService.isLoggedIn;

      if (isLoggedIn) {
        //fullName = _profileService.user.fullName;
        nickName = _profileService.user.nickName;
      }
    }, context: _profileService);
  }

  void logOut() {
    _profileService.logout();
  }

  void gameMenuClicked(event) {
    querySelector("#gameMenuCollapse").querySelector(".active").classes.remove("active");
    event.target.parent.classes.add("active");
  }


  Router _router;
  ProfileService _profileService;
}