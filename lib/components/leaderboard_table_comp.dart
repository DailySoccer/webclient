library leaderboard_table_comp;

import 'dart:html';
import 'package:angular/angular.dart';
//import 'package:webclient/utils/html_utils.dart';
//import 'package:webclient/services/screen_detector_service.dart';
//import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'leaderboard-table',
    templateUrl: 'packages/webclient/components/leaderboard_table_comp.html',
    useShadowDom: false
)

class LeaderboardTableComp {

  //ScreenDetectorService _scrDet;
  //var _streamListener;
  
  bool isHeaded = true;
  String pointsColumnName = "Points";
  
  String playerHint = 'Eres un crack!!';
  
  bool isThePlayer(id) => id == '123b'/*get del singleton*/;
  
  List<Map> tableElements;

  LeaderboardTableComp () {
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
  
  @NgOneWay("show-header")
  void set showHeader(bool value) {
    isHeaded = value;
  }
  
  @NgOneWay("table-elements")
  void set tableValues(List<Map> value) {
    tableElements = value;
  }
  
  @NgOneWay("points-column-label")
  void set pointsColumnLabel(String value) {
    pointsColumnName = value;
  }

  @NgOneWay("hint")
  void set hint(String value) {
    playerHint = value;
  }
  
}