library policy_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'policy-info',
   templateUrl: 'policy_info_comp.html'
)
class PolicyInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "privacy", substitutions);
  }
  
  PolicyInfoComp();
}