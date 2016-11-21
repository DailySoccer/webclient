library contest_info_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'dart:html';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/prize.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:logging/logging.dart';

@Component(
  selector: 'contest-info',
  templateUrl: 'contest_info_comp.html'
)
class ContestInfoComp {

  
  @Input("the-contest")
  void set setContest(Contest value) {
    if (value != null) {
      contest = value;
      /*************************/
      //TODO: Borrar lo siguiente si hay que refrescar el concurso
      updateContestInfo();
      /*************************/
    }
  }
  bool isModal = false;
  Map currentInfoData;
  Contest contest = null;
  String contestId;
  LoadingService loadingService;

  String getLocalizedText(key) {
    return StringUtils.translate(key, "contestinfo");
  }

  ContestInfoComp(RouteParams routeParams, this.loadingService, this._router, this._contestsService, this._profileService, this._flashMessage) {

    // TODO Angular 2
    isModal = false; //(_router.activePath.length > 0) && (_router.activePath.first.name == 'lobby');

    currentInfoData = {
      'description'     : '',
      'name'            : '',
      'entry'           : '',
      'prize'           : '',
      'rules'           : getLocalizedText("rulestip"),
      'startDateTime'   : '', // 'COMIENZA EL DOM. 15/05 19:00',
      'matchesInvolved' : null,
      'legals'          : '',
      'contestants'     : [],
      'prizes'          : []
    };

    contestId = routeParams.get('contestId');

    /*************************/
    //TODO: Borrar lo siguiente si hay que refrescar el concurso
    //loadingService.isLoading = true;
//    updateContestInfo();
    /*************************/

    //TODO: Repasar esto. A lo mejor hay que forzar el refresco de las contest entries de este concurso. cuando se refresque el concurso.
/*
    loadingService.isLoading = true;

    _contestsService.refreshContestInfo(contestId)
      .then((_) {
        updateContestInfo();
      })
      .catchError((ServerError error) {
        _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW);
      }, test: (error) => error is ServerError);
*/
  }

  void updateContestInfo() {
    // Logger.root.info("ContestInfoComp --> updateContestInfo");

    //loadingService.isLoading = false;

    //contest = _contestsService.lastContest;
    List contestants = [];

    for (ContestEntry contestEntry in contest.contestEntries) {
      contestants.add({
        'name'  : contestEntry.user.nickName,
        'trueSkill'  : StringUtils.parseTrueSkill(contestEntry.user.trueSkill)
      });
    }

    // Logger.root.info("ContestInfoComp --> updateContestInfo 1");
    
    currentInfoData["name"]           = contest.name;
    currentInfoData["description"]    = contest.description;
    currentInfoData["entry"]          = contest.entryFee.toString();
    currentInfoData["prize"]          = contest.prizePool.toString();
    currentInfoData["startDateTime"]  = DateTimeService.formatDateTimeLong(contest.startDate).toUpperCase();
    currentInfoData["contestants"]    = contestants;
    currentInfoData["prizeType"]      = getThePrizeTypeName(contest.prizeTypeName, contest.prizeType);
    currentInfoData["prizes"]         = contest.prize.getValues();
    currentInfoData["matchesInvolved"]= contest.matchEvents;
  }

  String getThePrizeTypeName(String prizeDesc, String prizeType) {
    int count = 0;
    String fullDesc = "";
    switch(prizeType) {
      case Prize.FREE:
      case Prize.WINNER:
        fullDesc = prizeDesc;
      break;
      case Prize.TOP_THIRD:
        count = contest.prize.numPrizes;
        fullDesc = count == 1 ? getLocalizedText("winnertakesall") : prizeDesc.replaceAll('#', count.toString());
       break;

      case Prize.FIFTY_FIFTY:
        count = contest.prize.numPrizes;
        fullDesc = count == 1 ? getLocalizedText("winnertakesall") : prizeDesc.replaceAll('#', count.toString());
      break;
    }

    return fullDesc;
  }

  void enterContest() {
    Logger.root.info("ContestInfoComp --> enterContest");
    _router.navigate(['enter_contest', { "contestId": contestId, "parent": "lobby", "contestEntryId": "none" }]);
  }

  String formatMatchDate(DateTime date) {
    return DateTimeService.formatDateTimeShort(date);
  }

  void tabChange(String tab) {
    Logger.root.info("ContestInfoComp --> tabChange");
    querySelectorAll(".tab-pane").classes.remove('active');

    Element contentTab = querySelector("#" + tab);
    if (contentTab != null) {
      contentTab.classes.add("active");
    }
    Logger.root.info("ContestInfoComp --> tabChange end");
  }
  
  String getContestCoinIcon(Money money) {
    if(money.currencyUnit == Money.CURRENCY_GOLD) return 'gold';
    if(money.currencyUnit == Money.CURRENCY_ENERGY) return 'energy';
    if(money.currencyUnit == Money.CURRENCY_MANAGER) return 'manager';

    Logger.root.severe("ContestList - Unknown Currency Symbol detected");
    return 'unknown';
  }
    
  Money getPrizeToShow(Contest contest) {
    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory || contest.isLive) {
      return getMyPrize(contest);
    }

    return contest.prizePool;
  }
  
  Money getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
  }
 
  Router _router;

  ContestsService _contestsService;
  ProfileService _profileService;
  FlashMessagesService _flashMessage;
}