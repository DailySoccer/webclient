library leaderboard_table_comp;

import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/user_ranking.dart';
//import 'package:webclient/utils/html_utils.dart';
//import 'package:webclient/services/screen_detector_service.dart';
//import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'leaderboard-table',
    templateUrl: 'packages/webclient/components/leaderboards/leaderboard_table_comp.html',
    useShadowDom: false
)

class LeaderboardTableComp {

  //ScreenDetectorService _scrDet;
  //var _streamListener;

  Map sharingInfo = null;
  @NgOneWay("share-info")
  void set info(Map allInfo) {
    sharingInfo = allInfo;
  }
  
  String type;
  @NgOneWay("ranking-type")
  void set rankingType(String value) {
    type = value;
  }
  
  
  bool isHeaded = true;
  String pointsColumnName = "Points";
  
  String playerHint = 'Eres un crack!!';
  
  bool isThePlayer(id) => id == profileService.user.userId;//highlightedElement['id'];
  //String get playerName => getLocalizedText("the-player");
  
  int rows = 0;
  List<UserRanking> tableElements = null;
  List<Map> shownElements = null;
  UserRanking highlightedElement = null;

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
      if (tableElements != null) {
       // shownElements = tableElements.take(rows).toList();
        shownElements = tableElements.take(rows).map( (UserRanking userRanking) =>
          {
            'position': type == "GOLD" ? userRanking.goldRank : userRanking.skillRank,
            'id': userRanking.userId,
            'name': userRanking.nickName,
            'points': type == "GOLD" ? userRanking.earnedMoney : userRanking.trueSkill
          }
        ).toList();
      }
    }
    else if (rows != 0 && tableElements != null && highlightedElement.userId != '') {
      // Necesitamos buscar la posición del elemento highlight en la tabla
      int pos = tableElements.map((user) => user.userId).toList().indexOf(highlightedElement.userId) + 1;
      //primera posicion calculada a partir del elemento iluminado
      int firstPosition = max(pos - ((rows-1) / 2).floor(), 1) - 1;
      //ultima posicion calculada a partir de la primera
      int lastPosition = min(firstPosition + rows, tableElements.length);
      //corrección de la primera posicion cuando esta cerca de las últimas posiciones
      firstPosition = max(min(firstPosition, lastPosition - rows), 0);
      // shownElements = tableElements.sublist(firstPosition, lastPosition);
      shownElements = tableElements.sublist(firstPosition, lastPosition).map( (UserRanking userRanking) =>
        {
          'position': type == "GOLD" ? userRanking.goldRank : userRanking.skillRank,
          'id': userRanking.userId,
          'name': userRanking.nickName,
          'points': type == "GOLD" ? userRanking.earnedMoney : userRanking.trueSkill
        }
      ).toList();
    }
  }
  
  @NgOneWay("show-header")
  void set showHeader(bool value) {
    isHeaded = value;
  }
  
  @NgOneWay("table-elements")
  void set tableValues(List<UserRanking> value) {
      tableElements = value;
      calculateShownElements();
  }
  
  @NgOneWay("highlight-element")
  void set playerInfo (UserRanking value) {
    highlightedElement = value;
    calculateShownElements();
  }
  
  @NgOneWay("points-column-label")
  void set pointsColumnLabel(String value) {
    pointsColumnName = value;
  }

  @NgOneWay("hint")
  void set hint(String value) {
    playerHint = value;
  }
  
  @NgOneWay("rows")
  void set rowsToShow(int value) {
    rows = value;
    calculateShownElements();
  }
  
  ProfileService profileService;
}