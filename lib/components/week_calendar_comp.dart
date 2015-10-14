library week_calendar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'week-calendar',
    templateUrl: 'packages/webclient/components/week_calendar_comp.html',
    useShadowDom: false
)

class WeekCalendar {

  @NgOneWay("dates")
  List<Map> dayList;// = new List<Map>();
  
  /*
  @NgOneWay("start-date")
  void set startDate(String value) {
    _firstDay = DateTimeService.now;
    updateDayList();
  }
  */
  @NgCallback("on-day-selected")
  void set onDayClickCallback(Function value) {
    _onDayClick = value;
    dayClick();
  }
  
  WeekCalendar() { }

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "weekcalendar", substitutions);
  }
  
  /*
  void updateDayList() {
    dayList = new List<Map>();
    DateTime current = _currentSelected = _firstDay;
    for(int i = 0; i < 7; i++) {
      dayList.add({"weekday": getLocalizedText(current.weekday.toString()), "monthday": current.day, "date": current});
      current = current.add(new Duration(days: 1));
    }
    dayClick();
  }
  */
  
  void selectDay(Event ev, Map weekElem) {
    if (!weekElem['enabled']) return;
    
    Element weekDayElem = ev.currentTarget;
    ElementList oldWeekDayElems = querySelectorAll(".week-day.active");
    oldWeekDayElems.classes.remove("active");
    weekDayElem.classes.add('active');
    _currentSelected = weekElem['date'];
    dayClick();
  }
  
  void dayClick() {
    if(_onDayClick != null) {
      _onDayClick({'day': _currentSelected});
    }
  }
  
  bool isCurrentSelected(DateTime date, int index) {
    if (_currentSelected == null) {
      return index == 0;
    }
    
    return (date.day == _currentSelected.day && 
            date.month == _currentSelected.month && 
            date.year == _currentSelected.year);
  }

  DateTime _currentSelected = null;
  Function _onDayClick;
}