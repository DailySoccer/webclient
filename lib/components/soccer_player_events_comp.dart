library soccer_player_events_comp;

import 'package:angular/angular.dart';

@Component(
    selector: 'soccer-player-events',
    templateUrl: 'packages/webclient/components/soccer_player_events_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayerEventsComp{

  List<Map> soccerPlayerStats = [];
  int vez = 0;

  @NgOneWay("data-source")
  set dataSource(List<Map> value) {
    if(value != null) {
      soccerPlayerStats = value;
      vez = 0;
      print('reseteo contador');
    }
    else {
      print('me viene nulo x ${vez}');
      vez++;
    }
  }

  bool get hasData => soccerPlayerStats.length > 0 ? true: false;

  SoccerPlayerEventsComp();

}