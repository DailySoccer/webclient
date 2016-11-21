library terminus_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';

@Component(
   selector: 'terminus-info',
   templateUrl: 'terminus_info_comp.html'
)
class TerminusInfoComp {

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "terminus", substitutions);
  }
  
  TerminusInfoComp();
}