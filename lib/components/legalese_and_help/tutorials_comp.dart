library tutorials_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'dart:html';

@Component(
    selector: 'tutorials-comp',
    templateUrl: 'tutorials_comp.html'
)
class TutorialsComp {
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorials");
  }
  
  void goTutorial(String tutorial) {
    //GameMetrics.logEvent(GameMetrics.TUTORIAL_FROM_HELP, {'value': tutorial});
    _tutorialService.restart(tutorial);
  }
  
  void goToPage(String page) {
    _router.navigate([page, {}]);
  }
  
  void goToHowToPlay() {
    window.open("http://www.futbolcuatro.com/ayuda/", '_system');
  }
  
  String get tutorialIniciacionName => TutorialIniciacion.NAME;

  TutorialsComp(this._tutorialService, this._router);
  
  TutorialService _tutorialService;
  Router _router;
}
