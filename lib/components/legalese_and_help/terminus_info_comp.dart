library terminus_info_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'terminus-info',
   templateUrl: 'packages/webclient/components/legalese_and_help/terminus_info_comp.html',
   useShadowDom: false
)
class TerminusInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "terminus", substitutions);
  }
  
  TerminusInfoComp();
}