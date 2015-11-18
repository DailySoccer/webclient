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
  String _contestType;

  String get contestType => _contestType;
  void set contestType(String val) {
    _contestType = val;
    updateDate();
  }
  void updateDate() {
    if (_contestType == TYPE_OFICIAL && _selectedTemplate != null) {
      DateTime t = _selectedTemplate.startDate;
      selectedHour = t.hour;
      selectedMinText = t.minute < 10? "0${t.minute}": "${t.minute}";
      selectedDate = t;
    } else {
      selectedMinText = '00';
    }
  }

  int selectedHour = 12;
  String selectedMinText = '00';
  DateTime selectedDate = null;

  String TYPE_OFICIAL = "oficial";
  String TYPE_TRAINING = "training";

  String leagueES_val = Competition.LEAGUE_ES;
  String leagueUK_val = Competition.LEAGUE_UK;

  List<Map> dayList = new List<Map>();
  List<int> hourList = new List<int>();

  List<int> leaguePlayerCountList = [5, 10, 15, 20, 50, -1];
  int selectedLeaguePlayerCount = 10;

  TemplateContest get selectedTemplate => _selectedTemplate;
  void set selectedTemplate(TemplateContest val) {
    if (val != _selectedTemplate) {
      _selectedTemplate = val;
      updateDate();
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

    // Set de la hora a las 00:00
    current = current.subtract(new Duration(hours: current.hour, minutes: current.minute, seconds: current.second, milliseconds: current.millisecond));

    for(int i = 0; i < 7; i++) {
      dayList.add({"weekday": current.weekday.toString(), "monthday": current.day, "date": current, "enabled": true});
      current = current.add(new Duration(days: 1));
    }

    if (selectedDate == null) {
      selectedDate = dayList[0]['date'];
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
      contest.simulation = (contestType == TYPE_TRAINING);
      contest.startDate = contest.simulation ? selectedDate.add(new Duration(hours:selectedHour)) : _selectedTemplate.startDate;
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

