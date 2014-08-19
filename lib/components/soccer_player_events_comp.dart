library soccer_player_events_comp;

import 'package:angular/angular.dart';

@Component(
    selector: 'soccer-player-events',
    templateUrl: 'packages/webclient/components/soccer_player_events.html',
    publishAs: 'comp',
    useShadowDom: false
)
class SoccerPlayerEventsComp{

  List<Map> soccerPlayerStats;

  @NgOneWay("data-source")
  set dataSource(List<Map> value) {
    soccerPlayerStats = value;
  }

  SoccerPlayerEventsComp();

}