library rules_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'rules-comp',
    templateUrl: 'packages/webclient/components/legalese_and_help/rules_comp.html',
    useShadowDom: false
)
class RulesComp {

  String getLocalizedText(key) {
    return StringUtils.translate(key, "rules");
  }

  RulesComp();

  List<String> _titleList = [];
  Map<String, String> _sectionList = {};
  int get _numRules => int.parse(getLocalizedText('num-rules'));
  

  List<String> get titleList {
    _refreshSections();
    return _titleList;
  }

  Map<String, String> get sectionList {
    _refreshSections();
    return _sectionList;
  }
  
  void _refreshSections() {
    int countRules = _numRules;
    if (_numRules != _titleList.length) {
      _sectionList.clear();
      for (int i = 1; i <= countRules; i++) {
        _sectionList[getLocalizedText('$i-title')] = getLocalizedText('$i-text');
      }
      _titleList = _sectionList.keys.toList();
    }
  }
}
