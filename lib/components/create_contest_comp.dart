library create_contest_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'create-contest',
  templateUrl: 'packages/webclient/components/create_contest_comp.html',
  useShadowDom: false
)
class CreateContestComp  {
  
  @NgTwoWay("selected-option")
  String get selectedOption => _selectedOption;
  void   set selectedOption(String val) {
    if (val != _selectedOption) {
      _selectedOption = val;
    }
  }
  
  List<Map<String, String>> contestDates = [{'dateText': getLocalizedText("select_date"),
                                             'contestId': _DEFAULT_SELECT_DATE_TEXT
                                            },
                                            {'dateText': 'Supersábado de Clásico',
                                             'contestId': '12a34asfl324524jk'
                                            },
                                            {'dateText': 'GESDVSV ds fsad  asdf',
                                             'contestId': '22a34ashsd23424jk'
                                            },
                                            {'dateText': 'blau blau',
                                             'contestId': '32a6734fvxbfnrg4524jk'
                                            },
                                            {'dateText': 'pues eso',
                                             'contestId': '42fbw4fr524jk'
                                            }];
  
  String get optionsSelectorValue => selectedOption == null? _DEFAULT_SELECT_DATE_TEXT : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == _DEFAULT_SELECT_DATE_TEXT)? null : val;  }
  
  String contestName;
  
  
  CreateContestComp(this._router);
  
  static String getLocalizedText(key) {
    return StringUtils.translate(key, "createcontest");
  }
  
  static final String _DEFAULT_SELECT_DATE_TEXT = '';
  String _selectedOption;
  
  Router _router;
  
}