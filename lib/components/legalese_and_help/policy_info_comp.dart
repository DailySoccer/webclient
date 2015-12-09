library policy_info_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'policy-info',
   templateUrl: 'packages/webclient/components/legalese_and_help/policy_info_comp.html',
   useShadowDom: false
)
class PolicyInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "privacy", substitutions);
  }
  
  PolicyInfoComp();
}