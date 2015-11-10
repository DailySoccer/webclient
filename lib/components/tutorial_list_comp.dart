library tutorial_list_comp;

import 'dart:async';
import 'package:angular/angular.dart';

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
  }
  
  Router _router;
  
}