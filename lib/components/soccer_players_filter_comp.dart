library soccer_players_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'dart:html';

@Component(
    selector: 'soccer-players-filter',
    templateUrl: 'packages/webclient/components/soccer_players_filter_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayersFilterComp {

  List<FieldPos> posFilterList = [
      new FieldPos("GOALKEEPER"),
      new FieldPos("DEFENSE"),
      new FieldPos("MIDDLE"),
      new FieldPos("FORWARD")
    ];


  @NgTwoWay('field-pos-filter')
  void set fieldPosFilter(FieldPos value) {
    _fieldPosFilter = value;

    if (_fieldPosFilter == null) {
      _setPosFilterClass('TODOS');
    }
    else {
      _setPosFilterClass(_fieldPosFilter.abrevName);
    }
  }
  FieldPos get fieldPosFilter => _fieldPosFilter;


  @NgCallback("on-name-filter-change")
  Function onNameFilterChange;

  String nameFilter;

  void refreshNameFilter() {
    if (onNameFilterChange != null) {
      onNameFilterChange({"nameFilter": nameFilter});
    }
  }

  void onFieldPosFilterClick(FieldPos fieldPos) {
    fieldPosFilter = fieldPos;
  }

  void _setPosFilterClass(String abrevPosition) {
    List<ButtonElement> buttonsFilter = document.querySelectorAll(".button-filtro-position");

    buttonsFilter.forEach((element) {
      element.classes.remove("active");

      if (element.text == abrevPosition) {
        element.classes.add("active");
      }
    });
  }

  FieldPos _fieldPosFilter;
}