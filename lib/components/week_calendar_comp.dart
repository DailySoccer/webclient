library week_calendar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'week-calendar',
    templateUrl: 'packages/webclient/components/week_calendar_comp.html',
    useShadowDom: false
)
class WeekCalendar {

  List<Map> dayList;
  
  @NgOneWay("dates")
  void set dates(List<Map> value) {
    if (value != null && value.isNotEmpty) {
      dayList = value;
      if (_currentSelected == null || _currentSelected.isBefore(value.first['date'])) {
        _currentSelected = value.first['date'];
      } else {
        Map dayTmp = value.firstWhere((c) => isCurrentSelected(c['date'], 0), orElse: () => null);
        if (dayTmp != null && !dayTmp['enabled']) {
          _currentSelected = value.first['date'];
        }
      }
    }
    dayClick();
  }
  
  @NgCallback("on-day-selected")
  void set onDayClickCallback(Function value) {
    _onDayClick = value;
    dayClick();
  }
  
  WeekCalendar() { }

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "weekcalendar", substitutions);
  }
  
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