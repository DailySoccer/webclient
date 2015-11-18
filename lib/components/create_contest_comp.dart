library create_contest_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/template_contest.dart';
import 'package:webclient/models/competition.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/datetime_service.dart';

@Component(
  selector: 'create-contest',
  templateUrl: 'packages/webclient/components/create_contest_comp.html',
  useShadowDom: false
)
class CreateContestComp  {

  String selectedCompetition;
  String contestName;
  
  int selectedHour = 12;
  DateTime selectedDate = null;

  String TYPE_OFICIAL = "oficial";
  String TYPE_TRAINING = "training";

  String leagueES_val = Competition.LEAGUE_ES;
  String leagueUK_val = Competition.LEAGUE_UK;

  List<Map> dayList = new List<Map>();
  List<int> hourList = new List<int>();

  @NgOneWay("contestType")
  String contestType ;

  TemplateContest get selectedTemplate => _selectedTemplate;
    void set selectedTemplate(TemplateContest val) {
    if (val != _selectedTemplate) {
      _selectedTemplate = val;
    }
  }

  String get comboDefaultText {
    if (printableTemplateList.length == 0) {
      return getLocalizedText("select_competition_first");
    }
    return getLocalizedText("select_event");
  }

  List<TemplateContest> emptyListAuxiliar = [];
  List<TemplateContest> get printableTemplateList {
    if(templatesFilteredList.containsKey(selectedCompetition)) {
      return templatesFilteredList[selectedCompetition];
    }
    return emptyListAuxiliar;
  }

  // Esta sin completar el formulario?
  bool get isNotComplete => false;

  CreateContestComp(this._router, this._contestsService) {
    contestType = TYPE_OFICIAL;

    updateDayList();
    for(int i = 1; i <= 24; i++) hourList.add(i);
    
    _contestsService.getActiveTemplateContests()
      .then((templateContests) {
        _templateContests = templateContests;

        selectedCompetition = null;
        if(_templateContests.length > 0) {

          templatesFilteredList.forEach( (String key, List<TemplateContest> list) {
            list.clear();
            list.addAll(_templateContests.where((t) => t.competitionType == key));
            if (selectedCompetition == null && list.isNotEmpty) selectedCompetition = key;
          });
        }

      });
  }

  static String getLocalizedText(key) {
    return StringUtils.translate(key, "createcontest");
  }
  
  void updateDayList() {
    dayList = new List<Map>();
    DateTime current = DateTimeService.now;

    for(int i = 0; i < 7; i++) {
      dayList.add({"weekday": current.weekday.toString(), "monthday": current.day, "date": current, "enabled": true});
      current = current.add(new Duration(days: 1));
    }
  }
  
  void onSelectedDayChange(DateTime day) {
    selectedDate = day;
  }
  
  void createContest() {
    if (_selectedTemplate != null) {
      Contest contest = new Contest.instance();
      contest.templateContestId = _selectedTemplate.templateContestId;
      contest.name = contestName != null ? contestName : _selectedTemplate.name;
      contest.startDate = _selectedTemplate.startDate;
      contest.simulation = contestType == TYPE_TRAINING;
      contest.maxEntries = _selectedTemplate.maxEntries;

      List<String> soccerPlayers = [];
      _contestsService.createContest(contest, soccerPlayers)
        .then((Contest contestCreated) {
          _router.go('enter_contest', { "contestId": contestCreated.contestId, "parent": "create_contest", "contestEntryId": "none" });
        });
    }
  }

  TemplateContest _selectedTemplate;
  Map<String, List<TemplateContest>> templatesFilteredList = {
    Competition.LEAGUE_ES: [],
    Competition.LEAGUE_UK: []
  };

  List<TemplateContest> _templateContests;
  ContestsService _contestsService;

  Router _router;
}

