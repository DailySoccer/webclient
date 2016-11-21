library legal_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'legal-info',
   templateUrl: 'legal_info_comp.html'
)
class LegalInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "legals", substitutions);
  }
  
  LegalInfoComp();
}