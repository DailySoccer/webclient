library home_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
  selector: 'home',
  templateUrl: 'packages/webclient/components/home_comp.html',
  useShadowDom: false
)
class HomeComp  {

  HomeComp(this._router, this._profileService, TutorialService tutorialService);

  void onContestsClick() {
    _router.go('lobby', {});
  }

  void onScoutingClick() {
    if (!userIsLogged) return;
  }

  void onCreateContestClick() {
    if (!userIsLogged) return;
    _router.go('create_contest', {});
  }

  void onHistoryClick() {
    if (!userIsLogged) return;
    _router.go('my_contests', {'section':'history'});
  }

  void onLiveClick() {
    if (!userIsLogged) return;
    _router.go('my_contests', {'section':'live'});
  }

  void onBlogClick() {

  }
  void onTutorialClick() {
    _router.go('tutorial_list', {});
  }

  bool get userIsLogged => _profileService.isLoggedIn;

  ProfileService _profileService;
  Router _router;

}