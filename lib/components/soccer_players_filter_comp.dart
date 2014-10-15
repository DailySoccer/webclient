library soccer_players_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';

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

  String nameFilter;

  @NgCallback("on-field-pos-change")
  Function onFieldPosChange;

  @NgCallback("on-name-filter-change")
  Function onNameFilterChange;

  void onFieldPosFilterClick(FieldPos fieldPos) {
    if (onFieldPosChange != null) {
      onFieldPosChange({"fieldPos": fieldPos});
    }
  }

  void refreshNameFilter() {
    if (onNameFilterChange != null) {
      onNameFilterChange({"nameFilter": nameFilter});
    }
  }
}