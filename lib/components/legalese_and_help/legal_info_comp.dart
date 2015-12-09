library legal_info_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'legal-info',
   templateUrl: 'packages/webclient/components/legalese_and_help/legal_info_comp.html',
   useShadowDom: false
)
class LegalInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "legals", substitutions);
  }
  
  LegalInfoComp();
}