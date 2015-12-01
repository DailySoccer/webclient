library tutorials_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'tutorials-comp',
    templateUrl: 'packages/webclient/components/legalese_and_help/tutorials_comp.html',
    useShadowDom: false
)
class TutorialsComp {

  String getLocalizedText(key) {
    return StringUtils.translate(key, "tutorials");
  }

  TutorialsComp();
}
