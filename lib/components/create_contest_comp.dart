library create_contest_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/models/competition.dart';

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

  String _selectedCompetition = '';
  void set selectedCompetition(String comp) {
    _selectedCompetition = comp;
    updatePrintableList();
  }
  String get selectedCompetition => _selectedCompetition;

  List<Map<String, String>> _templatesFilteredList = [placeholderNotSelected];
  List<Map<String, String>> _templatesList = [{'name': 'Supersábado de Clásico',
                                                'id': '12a34asfl324524jk',
                                                'competition': Competition.LEAGUE_ES
                                               },
                                               {'name': 'GESDVSV ds fsad  asdf',
                                                'id': '22a34ashsd23424jk',
                                                'competition': Competition.LEAGUE_ES
                                               },
                                               {'name': 'blau blau',
                                                'id': '32a6734fvxbfnrg4524jk',
                                                'competition': Competition.LEAGUE_UK
                                               },
                                               {'name': 'pues eso',
                                                'id': '42fbw4fr524jk',
                                                'competition': Competition.LEAGUE_UK
                                               }];

  List<Map<String, String>> get printableTemplateList => _templatesFilteredList;

  static Map<String, String> placeholderTemplate     = { 'name': getLocalizedText("select_date"),
                                                         'id': '',
                                                         'competition': '' };
  static Map<String, String> placeholderNotSelected  = { 'name': getLocalizedText("select_competition_first"),
                                                         'id': '',
                                                         'competition': '' };
  static Map<String, String> placeholderEmpty        = { 'name': getLocalizedText("select_competition_first"),
                                                         'id': '',
                                                         'competition': '' };

  void updatePrintableList() {
    List<Map<String, String>> filteredList = _templatesList.where( (t) => t['competition'] ==  selectedCompetition).toList();
    _templatesFilteredList.clear();

    if (selectedCompetition == null || selectedCompetition == '') {
      _templatesFilteredList.add(placeholderNotSelected);
    } else if (filteredList.isEmpty) {
      _templatesFilteredList.add(placeholderEmpty);
    } else {
      _templatesFilteredList.add(placeholderTemplate);
      _templatesFilteredList.addAll(filteredList);
    }
    selectedOption = null;
  }


  String get optionsSelectorValue => selectedOption == null? placeholderTemplate['id'] : selectedOption;
  void   set optionsSelectorValue(String val) {  selectedOption = (val == placeholderTemplate['id'])? null : val;  }

  bool get isNotComplete => false;

  String contestName;

  CreateContestComp(this._router, this._contestsService) {
    _contestsService.getActiveTemplateContests()
      .then((templateContests) {
        _templateContests = templateContests;

        if (_templateContests.isNotEmpty) {
          _templatesList = [];
          for (TemplateContest templateContest in _templateContests) {
            _templatesList.add( {
              'name': templateContest.name,
              'id': templateContest.templateContestId,
              'competition': templateContest.competitionType,
              'instanceTemplateContest': templateContest
            });
          }
        }
      });
  }

  static String getLocalizedText(key) {
    return StringUtils.translate(key, "createcontest");
  }

  void createContest() {
    print("Dandole a crear contest, boton lo linkeado.");
  }

  String _selectedOption;

  Router _router;

  List<TemplateContest> _templateContests;
  ContestsService _contestsService;
}