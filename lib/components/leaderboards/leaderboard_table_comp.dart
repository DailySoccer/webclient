library leaderboard_table_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'dart:math';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
//import 'package:webclient/utils/html_utils.dart';
//import 'package:webclient/services/screen_detector_service.dart';
//import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'leaderboard-table',
    templateUrl: 'leaderboard_table_comp.html'
)

class LeaderboardTableComp {

  //ScreenDetectorService _scrDet;
  //var _streamListener;

  Map sharingInfo = null;
  @Input("share-info")
  void set info(Map allInfo) {
    sharingInfo = allInfo;
  }
  
  bool isHeaded = true;
  String pointsColumnName = "Points";
  
  String playerHint = 'Eres un crack!!';
  
  bool isThePlayer(id) => id == profileService.user.userId;//highlightedElement['id'];
  //String get playerName => getLocalizedText("the-player");
  
  int rows = 0;
  List<Map> tableElements = null;
  List<Map> shownElements = null;
  Map highlightedElement = null;

  String getLocalizedText(key, [group = "leaderboard"]) {
    return StringUtils.translate(key, group);
  }
  
  LeaderboardTableComp (this.profileService) {
    //_streamListener = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }
  /*
  int smallNameWidth = 140;
  int bigNameWidth = 215;

  void onScreenWidthChange(String value) {
    print("###################" + value);
    
    int width = value == 'xs' || value == 'sm'? smallNameWidth : bigNameWidth;
    ElementList<Element> userNameElementList = querySelectorAll('.leaderboard-table-name');
    
    print(userNameElementList.length);
    
    for(int i = 0; i < userNameElementList.length; i++) {
      Element e = userNameElementList.elementAt(i);
      print(width);
      e.text = trimStringToPx(e, width);
      print(i);
    }
    
  }
  */
  
  void calculateShownElements() {
    if (highlightedElement == null) {
      if (tableElements != null)
       shownElements = tableElements.take(rows).toList();
    }
    else if (rows != 0 && tableElements != null && highlightedElement['id'] != '') {
      int pos = highlightedElement['id'] != ''? highlightedElement['position'] : 0;
      //primera posicion calculada a partir del elemento iluminado
      int firstPosition = max(pos - ((rows-1) / 2).floor(), 1) - 1;
      //ultima posicion calculada a partir de la primera
      int lastPosition = min(firstPosition + rows, tableElements.length);
      //corrección de la primera posicion cuando esta cerca de las últimas posiciones
      firstPosition = max(min(firstPosition, lastPosition - rows), 0);
      shownElements = tableElements.sublist(firstPosition, lastPosition);
    }
  }
  
  @Input("show-header")
  void set showHeader(bool value) {
    isHeaded = value;
  }
  
  @Input("table-elements")
  void set tableValues(List<Map> value) {
      tableElements = value;
      calculateShownElements();
  }
  
  @Input("highlight-element")
  void set playerInfo (Map value) {
    highlightedElement = value;
    calculateShownElements();
  }
  
  @Input("points-column-label")
  void set pointsColumnLabel(String value) {
    pointsColumnName = value;
  }

  @Input("hint")
  void set hint(String value) {
    playerHint = value;
  }
  
  @Input("rows")
  void set rowsToShow(int value) {
    rows = value;
    calculateShownElements();
  }
  
  ProfileService profileService;
  
}