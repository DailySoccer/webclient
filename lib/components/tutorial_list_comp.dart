library tutorial_list_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/services/tutorial_service.dart';

@Component(
  selector: 'tutorial-list',
  templateUrl: 'tutorial_list_comp.html'
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