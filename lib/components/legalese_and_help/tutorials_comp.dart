library tutorials_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/services/tutorial_service.dart';

@Component(
    selector: 'tutorials-comp',
    templateUrl: 'packages/webclient/components/legalese_and_help/tutorials_comp.html',
    useShadowDom: false
)
class TutorialsComp {
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorials");
  }
  
  void goTutorial(String tutorial) {
    _tutorialService.restart(tutorial);
  }
  
  void goToPage(String page) {
    _router.go(page, {});
  }
  
  String get tutorialIniciacionName => TutorialIniciacion.NAME;

  TutorialsComp(this._tutorialService, this._router);
  
  TutorialService _tutorialService;
  Router _router;
}
