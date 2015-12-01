library week_calendar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'dart:math';

@Component(
    selector: 'week-calendar',
    templateUrl: 'packages/webclient/components/week_calendar_comp.html',
    useShadowDom: false
)
class WeekCalendar {

  List<Map> dayList;
  int get firstEnabledPos => max(dayList.indexOf(dayList.firstWhere((c) => c['enabled'], orElse: () => {})), 0);

  @NgOneWay("disabled")
  void set disabled(bool isDisabled) {
    _isDisabled = isDisabled;
  }
  
  @NgOneWay("selected-date")
  void set currentSelectedDate(DateTime t) {
    if  (t == null) return;
    
    _currentSelected = {"weekday": t.weekday.toString(), "monthday": t.day, "date": t, "enabled": true};
  }
  
  @NgOneWay("dates")
  void set dates(List<Map> value) {
    if (value != null && value.isNotEmpty) {
      dayList = value;

      // si no se ha seleccionado o la fecha es antigua
      if (_currentSelected == null || _currentDate.isBefore(value.first['date'])) {
        _currentSelected = value[firstEnabledPos];
      } else {
        _currentSelected = value.firstWhere((c) => isCurrentSelected(c['date'], 0), orElse: () => null);
        // miramos si en la nueva información nos dicen que ya no esta enabled.
        if ((_currentSelected != null && !_currentSelected['enabled']) ||_currentSelected == null) {
          _currentSelected = value[firstEnabledPos];
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
    if (_isDisabled) return;
    if (!weekElem['enabled']) return;

    Element weekDayElem = ev.currentTarget;
    ElementList oldWeekDayElems = querySelectorAll(".week-day.active");
    oldWeekDayElems.classes.remove("active");
    weekDayElem.classes.add('active');
    _currentSelected = weekElem;
    dayClick();
  }

  void dayClick() {
    if(_onDayClick != null && _currentDate != null) {
      _onDayClick({'day': _currentDate});
    }
  }

  bool isCurrentSelected(DateTime date, int index) {
    if (_currentSelected == null) {
      return index == firstEnabledPos;
    }

    return (date.day == _currentDate.day &&
            date.month == _currentDate.month &&
            date.year == _currentDate.year);
  }

  bool _isDisabled = false;
  Map _currentSelected = null;
  DateTime get _currentDate => _currentSelected != null? _currentSelected['date'] : null;
  Function _onDayClick;
}