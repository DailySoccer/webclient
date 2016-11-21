library rules_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'rules-comp',
    templateUrl: 'rules_comp.html'
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
