library soccer_players_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'soccer-players-filter',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_filter_comp.html',
    useShadowDom: false
)
class SoccerPlayersFilterComp implements AttachAware {

  ScreenDetectorService scrDet;

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

  SoccerPlayersFilterComp(this.scrDet);


  @override void attach() {
    // En movil podemos empezar directamente filtrados
    if (scrDet.isXsScreen) {
      _fieldPosFilter = new FieldPos("GOALKEEPER");
    }
    else {
      // Tentativamente vamos a empezar con los delanteros en desktop
      //_fieldPosFilter = new FieldPos("FORWARD");
    }
  }

  String getClassForFieldPos(FieldPos fieldPos) => fieldPos == fieldPosFilter? "active" : "";
  String getTextForFieldPos(FieldPos fieldPos)  => fieldPos == null? "TODOS" : fieldPos.abrevName;

  FieldPos _fieldPosFilter;
  String _nameFilter;
}