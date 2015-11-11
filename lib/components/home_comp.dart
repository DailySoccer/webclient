library home_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';

@Component(
  selector: 'home',
  templateUrl: 'packages/webclient/components/home_comp.html',
  useShadowDom: false
)
class HomeComp  {

  HomeComp(this._router, TutorialService tutorialService);

  void onContestsClick() {
    _router.go('lobby', {});
  }
  void onScoutingClick() {

  }
  void onCreateContestClick() {

  }
  void onHistoryClick() {
    _router.go('my_contests', {'section':'history'});
  }
  void onLiveClick() {
    _router.go('my_contests', {'section':'live'});
  }
  void onBlogClick() {

  }
  void onTutorialClick() {
    _router.go('tutorial_list', {});
  }

  Router _router;

}