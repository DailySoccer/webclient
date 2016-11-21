library soccer_players_filter_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'soccer-players-filter',
    templateUrl: 'soccer_players_filter_comp.html'
)
class SoccerPlayersFilterComp implements OnInit {

  ScreenDetectorService scrDet;

  List<FieldPos> posFilterList;

  @Input("name-filter")
  String nameFilter;

  @Input('field-pos-filter')
  FieldPos get fieldPosFilter => _fieldPosFilter;

  @Output('field-pos-filter')
  void     set fieldPosFilter(FieldPos value) {
    _fieldPosFilter = value;
  }
  
  @Input('only-favorites')
  bool get onlyFavorites => _onlyFavorites;

  @Output('only-favorites')
  void set onlyFavorites(bool value) {
    _onlyFavorites = value;
  }

  @Input('show-on-xs')
  void set showOnXs(bool value) {
    _showOnXs = value;
  }
  bool get showFilterByPosition => _showOnXs || scrDet.isNotXsScreen;

  bool showFavorites = true;
  @Input('show-favorites-button')
  void set showFavoritesButton(bool fav) {
    showFavorites = fav;
  }
  
  @Input('show-title')
  bool showTitle = true;

  @Input('position-filters-enabled')
  bool positionFiltersEnabled = true;
  
  String getLocalizedText(key, {group: "soccerplayerpositions"}) {
    return StringUtils.translate(key, group);
  }

  SoccerPlayersFilterComp(this.scrDet);


  @override void ngOnInit() {
    posFilterList = [
        null,
        new FieldPos(getLocalizedText("goalkeeper")),
        new FieldPos(getLocalizedText("defense")),
        new FieldPos(getLocalizedText("middle")),
        new FieldPos(getLocalizedText("forward"))
      ];
    // En movil podemos empezar directamente filtrados
    if (scrDet.isSmScreen || scrDet.isXsScreen) {
      _fieldPosFilter = new FieldPos(getLocalizedText("goalkeeper"));
    }
    else {
      // Tentativamente vamos a empezar con los delanteros en desktop
      //_fieldPosFilter = new FieldPos("FORWARD");
    }
    scrDet.mediaScreenWidth.listen((msg) { 
      if ((msg == "sm" || msg == "xs") && _fieldPosFilter == null) {
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
  bool _onlyFavorites = false;
}