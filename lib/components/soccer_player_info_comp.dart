library soccer_player_info_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'package:webclient/models/soccer_player_info.dart';
import 'package:webclient/models/field_pos.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';


@Component(
    selector: 'soccer-player-info',
    templateUrl: 'packages/webclient/components/soccer_player_info_comp.html',
    publishAs: 'soccerPlayerInfo',
    useShadowDom: false
)

class SoccerPlayerInfoComp {

  EnterContestCtrl enterContestCtrl;

  @NgTwoWay("soccerPlayerData")
      String get soccerPlayerData => _soccerPlayerIdData;
      void set soccerPlayerData(String value) {
        _soccerPlayerIdData = value;
        if(value != null){
          updateSoccerPlayerInfo(value);
        }
    }

    Map currentInfoData;
    List partidos  = new List();

    SoccerPlayerInfoComp(this._router, this._soccerPlayerService, this._flashMessage, this.enterContestCtrl) {

      currentInfoData = {
        'id'              : '<id>',
        'fieldPos'        : '<fieldPos>',
        'team'            : '<team>',
        'name'            : '<name>',
        'fantasyPoints'   : '<fantasyPoints>',
        'matches'         : '<matches>',
        'salary'          : '<salary>'
      };
    }

    updateSoccerPlayerInfo(String soccerPlayerId) {
      _soccerPlayerService.refreshSoccerPlayerInfo(soccerPlayerId)
        .then((_) {
          updateSoccerPlayerInfoFromService();
        })
        .catchError((error) {
          _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
        });
    }

    updateSoccerPlayerInfoFromService() {
      currentInfoData['id'] = _soccerPlayerIdData;
      currentInfoData['fieldPos'] = _soccerPlayerService.soccerPlayerInfo.fieldPos;
      currentInfoData['name'] = _soccerPlayerService.soccerPlayerInfo.name.toUpperCase();
      currentInfoData['fantasyPoints'] =_soccerPlayerService.soccerPlayerInfo.fantasyPoints;
      currentInfoData['matches'] =_soccerPlayerService.soccerPlayerInfo.stats.length;
      currentInfoData['salary'] =_soccerPlayerService.soccerPlayerInfo.salary;

      partidos.clear();

      for (SoccerPlayerStats stats in _soccerPlayerService.soccerPlayerInfo.stats){
        partidos.add({
          'stats' : stats
        });
      }
    }

    void tabChange(String tab) {
      List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
      allContentTab.forEach((element) => element.classes.remove('active'));

      Element contentTab = document.querySelector("#" + tab);
      if(contentTab != null) {
        contentTab.classes.add("active");
      }
    }

    Router _router;
    SoccerPlayerService _soccerPlayerService;
    FlashMessagesService _flashMessage;

    String _soccerPlayerIdData;

}