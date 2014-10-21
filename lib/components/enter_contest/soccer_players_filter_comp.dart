library soccer_players_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';

@Component(
    selector: 'soccer-players-filter',
    templateUrl: '/packages/webclient/components/enter_contest/soccer_players_filter_comp.html',
    useShadowDom: false
)
class SoccerPlayersFilterComp {

  List<FieldPos> posFilterList = [
      null,
      new FieldPos("GOALKEEPER"),
      new FieldPos("DEFENSE"),
      new FieldPos("MIDDLE"),
      new FieldPos("FORWARD")
    ];

  @NgTwoWay("name-filter")
  String nameFilter;

  @NgTwoWay('field-pos-filter')
  FieldPos get fieldPosFilter => _fieldPosFilter;
  void     set fieldPosFilter(FieldPos value) {
    _fieldPosFilter = value;
  }

  String getClassForFieldPos(FieldPos fieldPos) => fieldPos == fieldPosFilter? "active" : "";
  String getTextForFieldPos(FieldPos fieldPos)  => fieldPos == null? "TODOS" : fieldPos.abrevName;

  FieldPos _fieldPosFilter;
  String _nameFilter;
}