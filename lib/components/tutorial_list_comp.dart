library tutorial_list_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';

@Component(
  selector: 'tutorial-list',
  templateUrl: 'packages/webclient/components/tutorial_list_comp.html',
  useShadowDom: false
)
class TutorialListComp  {

  TutorialListComp(this._router) {

  }

  void onTutorialClick(String tutorialName) {
    print("tutorial $tutorialName clicked");
    TutorialService.Instance.start(tutorialName);
  }

  Router _router;

}