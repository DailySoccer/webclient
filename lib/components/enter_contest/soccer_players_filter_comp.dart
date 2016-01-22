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
  
  @NgTwoWay('only-favorites')
  bool get onlyFavorites => _onlyFavorites;
  void set onlyFavorites(bool value) {
    _onlyFavorites = value;
  }
  
  @NgOneWay('show-on-xs')
  void set showOnXs(bool value) {
    _showOnXs = value;
  }
  bool get showFilterByPosition => _showOnXs || scrDet.isNotXsScreen;

  bool _showFavorites = true;
  @NgOneWay('show-favorites-button')
  void set showFavoritesButton(bool fav) {
    _showFavorites = fav;
  }
  bool get showFavoritesButton => _showFavorites; 

  String getLocalizedText(key, {group: "soccerplayerpositions"}) {
    return StringUtils.translate(key, group);
  }

  SoccerPlayersFilterComp(this.scrDet);


  @override void attach() {
    posFilterList = [
        null,
        new FieldPos(getLocalizedText("goalkeeper")),
        new FieldPos(getLocalizedText("defense")),
        new FieldPos(getLocalizedText("middle")),
        new FieldPos(getLocalizedText("forward"))
      ];
    // En movil podemos empezar directamente filtrados
    if (scrDet.isXsScreen) {
      _fieldPosFilter = new FieldPos(getLocalizedText("goalkeeper"));
    }
    else {
      // Tentativamente vamos a empezar con los delanteros en desktop
      //_fieldPosFilter = new FieldPos("FORWARD");
    }
    scrDet.mediaScreenWidth.listen((msg) { 
      if (msg == "xs" && _fieldPosFilter == null) {
        _fieldPosFilter = new FieldPos(getLocalizedText("goalkeeper"));
      }
    });
  }
  
  void switchFavorites() {
    onlyFavorites = !onlyFavorites;
  }

  bool isActiveFieldPos(FieldPos fieldPos) => fieldPos == fieldPosFilter;
  String getTextForFieldPos(FieldPos fieldPos)  => fieldPos == null? StringUtils.translate("all", "soccerplayerpositions") : fieldPos.abrevName;

  FieldPos _fieldPosFilter;
  bool _showOnXs = false;
  bool _onlyFavorites;
}