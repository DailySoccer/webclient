library view_contest_entry_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/models/match_event.dart';
import 'dart:html';

@Component(
   selector: 'view-contest-entry',
   templateUrl: 'packages/webclient/components/view_contest_entry_comp.html',
   publishAs: 'viewContestEntry',
   useShadowDom: false
)

class ViewContestEntryComp {
  ScreenDetectorService scrDet;

  ContestEntry mainPlayer;
  dynamic selectedOpponent;

  String parent = "";

  DateTime updatedDate;

  List<String> matchesInvolved = [];

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  bool get isEnterContestMode => parent == "lobby";

  ViewContestEntryComp(RouteProvider routeProvider, this.scrDet, this._myContestsService, this._profileService, this._flashMessage, this._router) {

      // Identificamos cúal es la pantalla desde la que se ha llamado al view contest entry
      parent = routeProvider.route.parameters['parent'];

      _contestId = routeProvider.route.parameters['contestId'];

      _flashMessage.clearContext(FlashMessagesService.CONTEXT_VIEW);

      _myContestsService.refreshContest(_contestId)
        .then((jsonObject) {
          mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);

          updatedDate = DateTimeService.now;

          // generamos los partidos para el filtro de partidos
          matchesInvolved.clear();
          List<MatchEvent> matchEventsSorted = new List<MatchEvent>.from(contest.templateContest.matchEvents)
              .. sort((entry1, entry2) => entry1.startDate.compareTo(entry2.startDate))
              .. forEach( (match) {
                matchesInvolved.add(match.soccerTeamA.shortName + '-' + match.soccerTeamB.shortName + "<br>" + DateTimeService.formatDateTimeShort(match.startDate));
              });

        })
        .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));


  }

  void tabChange(String tab) {
    List<dynamic> allContentTab = document.querySelectorAll(".tab-pane");
    allContentTab.forEach((element) => element.classes.remove('active'));

    Element contentTab = document.querySelector("#" + tab);
    contentTab.classes.add("active");
  }

  void goTo(String screenParent) {
    _router.go(screenParent, {});
  }

  void cancelContestEntry() {
    _myContestsService.cancelContestEntry(mainPlayer.contestEntryId)
      .then((jsonObject) {
        print("cancelado contestEntry");
        _router.go(parent, {});
      });
  }

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  MyContestsService _myContestsService;

  String _contestId;

  Router _router;
}