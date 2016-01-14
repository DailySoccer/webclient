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
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/models/prize.dart';
import 'dart:math';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'create-contest',
  templateUrl: 'packages/webclient/components/create_contest_comp.html',
  useShadowDom: false
)
class CreateContestComp  {
  
  int MAX_LENGTH_CONTEST_NAME = 30;
  String _contestName;
  String get contestName => _contestName;
  void set contestName(String name) {
    _contestName = name.substring(0, min(MAX_LENGTH_CONTEST_NAME, name.length));
  }

  int selectedHour = 12;
  String selectedMinutesText = '00';
  DateTime selectedDate = null;
  
  static String S_TYPE_OFICIAL = "oficial";
  static String S_TYPE_TRAINING = "training";
  
  String TYPE_OFICIAL = S_TYPE_OFICIAL;
  String TYPE_TRAINING = S_TYPE_TRAINING;

  String STYLE_HEAD_TO_HEAD = Contest.TOURNAMENT_HEAD_TO_HEAD;
  String STYLE_LEAGUE = Contest.TOURNAMENT_LEAGUE;

  String LEAGUE_ES = Competition.LEAGUE_ES;
  String LEAGUE_UK = Competition.LEAGUE_UK;

  List<Map> dayList = new List<Map>();
  List<int> hourList = new List<int>();

  List<int> leaguePlayerCountList = [5, 10, 15, 20, 50, -1];
  int selectedLeaguePlayerCount = 10;
  int get maxEntries => (contestStyle == STYLE_HEAD_TO_HEAD) ? 2 : (selectedLeaguePlayerCount > 0) ? selectedLeaguePlayerCount : 100;

  TemplateContest get selectedTemplate => _selectedTemplate;
  void set selectedTemplate(TemplateContest val) {
    if (val != _selectedTemplate) {
      _selectedTemplate = val;
      updateDate();
      //JsUtils.runJavascript('#teamsPanel', 'collapse', "show");
    }
  }
  String get placeholderName => selectedTemplate != null? selectedTemplate.name : getLocalizedText("contest_name_placeholder");
  
  String get comboDefaultText {
    if (printableTemplateList.length == 0) {
      return getLocalizedText("select_competition_first");
    }
    return getLocalizedText("select_event");
  }

  List<TemplateContest> emptyListAuxiliar = [];
  List<TemplateContest> get printableTemplateList {
    return contestStyle != null? templatesPerStyle[contestStyle] : emptyListAuxiliar;
  }

  // Esta sin completar el formulario?
  bool get isComplete => _selectedTemplate != null;

  Money get entryFee => _selectedTemplate.entryFee;
  String get prizeType => Prize.typeNames[_selectedTemplate.prizeType].toUpperCase();
  int get computedPrize => prizePool.amount.toInt();

  CreateContestComp(this._router, this._contestsService) {
    contestType = TYPE_OFICIAL;
    contestStyle = STYLE_HEAD_TO_HEAD;

    generateDayList();
    for(int i = 1; i <= 24; i++) hourList.add(i);

    _contestsService.getActiveTemplateContests()
      .then((templateContests) {
        _templateContests = templateContests;
        
        selectedCompetition = null;
        _contestType = null;
        updateTemplatesPerType();
        
      });
    GameMetrics.logEvent(GameMetrics.CREATE_CONTEST);
  }

  num get prizeMultiplier => contestType == TYPE_OFICIAL ? _selectedTemplate.prizeMultiplier : 10;

  Money get prizePool => new Money.from(contestType == TYPE_OFICIAL ? Money.CURRENCY_GOLD : Money.CURRENCY_MANAGER, maxEntries * _selectedTemplate.entryFee.amount * prizeMultiplier);
  
  String getLocalizedText(key) {
    return StringUtils.translate(key, "createcontest");
  }

  void generateDayList() {
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
    updateHours();
  }

  void createContest() {
    if (isComplete) {
      Contest contest = new Contest.instance();
      contest.templateContestId = _selectedTemplate.templateContestId;
      contest.name = contestName != null && contestName.isNotEmpty ? contestName : _selectedTemplate.name;
      contest.simulation = (contestType == TYPE_TRAINING);
      contest.startDate = contest.simulation ? selectedDate.add(new Duration(hours:selectedHour)) : _selectedTemplate.startDate;
      contest.maxEntries = maxEntries;

      List<String> soccerPlayers = [];
      _contestsService.createContest(contest, soccerPlayers)
        .then((Contest contestCreated) {
          GameMetrics.logEvent(GameMetrics.CREATE_CONTEST_CREATED);
          _router.go('enter_contest', { "contestId": contestCreated.contestId, "parent": "create_contest", "contestEntryId": "none" });
        });
    }
  }
  
  void updateAll() {
    updateTemplatesPerType();
    updateDate();
  }

  void updateDate() {
    updateDayList();
    updateHours();
  }

  void updateDayList() {
    if (_contestType == TYPE_OFICIAL) {
      dayList.forEach( (d) => d['enabled'] = true );
      return;
    }

    if (_selectedTemplate == null) return;
    DateTime tStart = _selectedTemplate.startDate;
    selectedDate = selectedDate.subtract(new Duration(hours: selectedDate.hour, minutes: selectedDate.minute, seconds: selectedDate.second, milliseconds: selectedDate.millisecond));

    dayList.forEach( (d) => d['enabled'] = !d['date'].isAfter(tStart) );
  }

  void updateHours() {
    selectedMinutesText = '00';

    if (_selectedTemplate == null) return;

    if (_contestType == TYPE_OFICIAL) {
      DateTime tStart = _selectedTemplate.startDate;
      selectedHour = tStart.hour;
      selectedMinutesText = tStart.minute < 10? "0${tStart.minute}": "${tStart.minute}";
      selectedDate = tStart;
      hourList.clear();
      for(int i = 0; i <= 24; i++) hourList.add(i);
      return;
    }


    DateTime tStart = _selectedTemplate.startDate;

    bool isStartDay(DateTime day) {
      return (tStart.day == day.day &&
              tStart.month == day.month &&
              tStart.year == day.year);
    }

    int maxHour = isStartDay(selectedDate)? _selectedTemplate.startDate.hour : 24;
    int minHour = selectedDate == dayList[0]['date']? DateTimeService.now.hour + 1 : 1;

    hourList.clear();
    for(int i = minHour; i <= maxHour; i++) hourList.add(i);

    if (selectedHour < hourList[0]) selectedHour = hourList[0];
    if (selectedHour > hourList.last) selectedHour = hourList.last;
  }
  
  Map<String, List<TemplateContest>> templatesPerTypeList = {
    S_TYPE_OFICIAL: [],
    S_TYPE_TRAINING: []
  };
  void updateTemplatesPerType() {
    templatesPerTypeList.forEach( (String key, List<TemplateContest> list) {
      list.clear();
      // Este filtra por tipo de torneo (real, virtual) 
      list.addAll(_templateContests.where((t) => (key == S_TYPE_TRAINING) == t.isSimulation));
      // Este permite usar los reales como virtuales y viceversa.
      //list.addAll(_templateContests);
    });
    updateSelectedContestType();
    updateTemplatesPerCompetition();
  }
  void updateSelectedContestType() {
    if (_contestType != null && templatesPerTypeList[_contestType].isEmpty) {
      _contestType = null;
    }
    if (_contestType == null) {
      _contestType = templatesPerTypeList[S_TYPE_OFICIAL ].isNotEmpty? S_TYPE_OFICIAL : 
                     templatesPerTypeList[S_TYPE_TRAINING].isNotEmpty? S_TYPE_TRAINING : 
                     /*else*/ null;
    }
  }
  String get contestType => _contestType;
  void set contestType(String val) {
    _contestType = val;
    updateSelectedContestType();
    updateTemplatesPerCompetition();
  }
  
  
  Map<String, List<TemplateContest>> templatesPerCompetitionList = {
    Competition.LEAGUE_ES: [],
    Competition.LEAGUE_UK: []
  };
  void updateTemplatesPerCompetition() {
    templatesPerCompetitionList.forEach( (String key, List<TemplateContest> list) {
      list.clear();
      if(contestType != null) {
        list.addAll(templatesPerTypeList[contestType].where((t) => t.competitionType == key));
      }
    });
    updateSelectedCompetition();
    updateTemplatesPerStyle();
  }
  void updateSelectedCompetition() {
    if (_selectedCompetition != null && templatesPerCompetitionList[_selectedCompetition].isEmpty) {
      _selectedCompetition = null;
    }
    if (_selectedCompetition == null) {
      _selectedCompetition = templatesPerCompetitionList[Competition.LEAGUE_ES].isNotEmpty? Competition.LEAGUE_ES : 
                             templatesPerCompetitionList[Competition.LEAGUE_UK].isNotEmpty? Competition.LEAGUE_UK : 
                             /*else*/ null; 
    }
  }
  String get selectedCompetition => _selectedCompetition;
  void set selectedCompetition(String val) {
    _selectedCompetition = val;
    updateSelectedCompetition();
    updateTemplatesPerStyle();
  }
  
  
  Map<String, List<TemplateContest>> templatesPerStyle = {
    Contest.TOURNAMENT_HEAD_TO_HEAD: [],
    Contest.TOURNAMENT_LEAGUE: []
  };
  void updateTemplatesPerStyle() {
    String h2h = TemplateContest.TOURNAMENT_HEAD_TO_HEAD;
    templatesPerStyle.forEach( (String key, List<TemplateContest> list) {
      list.clear();
      if(selectedCompetition != null) {
        list.addAll(templatesPerCompetitionList[selectedCompetition].where((t) => (t.tournamentType == h2h) == (h2h == key)));
      }
    });
    updateSelectedStyle();
    updateSelectedTemplate();
  }
  void updateSelectedStyle() {
    if (_contestStyle != null && templatesPerStyle[_contestStyle].isEmpty) {
      _contestStyle = null;
    }
    if (_contestStyle == null) {
      _contestStyle = templatesPerStyle[Contest.TOURNAMENT_HEAD_TO_HEAD].isNotEmpty? Contest.TOURNAMENT_HEAD_TO_HEAD : 
                      templatesPerStyle[Contest.TOURNAMENT_LEAGUE].isNotEmpty? Contest.TOURNAMENT_LEAGUE : 
                     /*else*/ null;
    }
  }
  String get contestStyle => _contestStyle;
  void set contestStyle(String val) {
    _contestStyle = val;
    updateSelectedStyle();
    updateSelectedTemplate();
  }
  void updateSelectedTemplate() {
    if (selectedTemplate != null && !templatesPerStyle[_contestStyle].contains(selectedTemplate)) {
      selectedTemplate = null;
    }
    if (selectedTemplate == null && _contestStyle != null) {
      selectedTemplate = templatesPerStyle[_contestStyle].first;
    }
  }
  
  String _contestType;
  String _contestStyle;
  String _selectedCompetition;
  //List<TemplateContest> _templatesFilteredList = [];

  TemplateContest _selectedTemplate;
  List<TemplateContest> _templateContests;
  ContestsService _contestsService;

  Router _router;
}

