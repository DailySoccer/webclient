library soccer_players_filter_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'soccer-players-filter',
    templateUrl: 'packages/webclient/components/enter_contest/soccer_players_filter_comp.html',
    useShadowDom: false
)
class SoccerPlayersFilterComp implements AttachAware {

  ScreenDetectorService scrDet;

  List<FieldPos> posFilterList;

  @NgTwoWay("name-filter")
  String nameFilter;

  @NgTwoWay('field-pos-filter')
  FieldPos get fieldPosFilter => _fieldPosFilter;
  void     set fieldPosFilter(FieldPos value) {
    _fieldPosFilter = value;
  }

  String GetLocalizedText(key) {
    return StringUtils.Translate(key, "soccerplayerpositions");
  }

  SoccerPlayersFilterComp(this.scrDet);


  @override void attach() {
    posFilterList = [
        null,
        new FieldPos(GetLocalizedText("goalkeeper")),
        new FieldPos(GetLocalizedText("defense")),
        new FieldPos(GetLocalizedText("middle")),
        new FieldPos(GetLocalizedText("forward"))
      ];
    // En movil podemos empezar directamente filtrados
    if (scrDet.isXsScreen) {
      _fieldPosFilter = new FieldPos(GetLocalizedText("goalkeeper"));
    }
    else {
      // Tentativamente vamos a empezar con los delanteros en desktop
      //_fieldPosFilter = new FieldPos("FORWARD");
    }
  }

  String getClassForFieldPos(FieldPos fieldPos) => fieldPos == fieldPosFilter? "active" : "";
  String getTextForFieldPos(FieldPos fieldPos)  => fieldPos == null? StringUtils.Translate("all", "soccerplayerpositions") : fieldPos.abrevName;

  FieldPos _fieldPosFilter;
  String _nameFilter;
}