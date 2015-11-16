library create_contest_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/template_contest.dart';

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
  
  List<Map<String, String>> templatesList = [{'name': getLocalizedText("select_date"),
                                              'id': _DEFAULT_SELECT_DATE_TEXT
                                             },
                                             {'name': 'Supersábado de Clásico',
                                              'id': '12a34asfl324524jk'
                                             },
                                             {'name': 'GESDVSV ds fsad  asdf',
                                              'id': '22a34ashsd23424jk'
                                             },
                                             {'name': 'blau blau',
                                              'id': '32a6734fvxbfnrg4524jk'
                                             },
                                             {'name': 'pues eso',
                                              'id': '42fbw4fr524jk'
                                             }];
  


  String get optionsSelectorValue => selectedOption == null? _DEFAULT_SELECT_DATE_TEXT : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == _DEFAULT_SELECT_DATE_TEXT)? null : val;  }

  String contestName;

  CreateContestComp(this._router, this._contestsService) {
    _contestsService.getActiveTemplateContests()
      .then((templateContests) {
        _templateContests = templateContests;
      });
  }

  static String getLocalizedText(key) {
    return StringUtils.translate(key, "createcontest");
  }

  static final String _DEFAULT_SELECT_DATE_TEXT = '';
  String _selectedOption;

  Router _router;

  List<TemplateContest> _templateContests;
  ContestsService _contestsService;
}