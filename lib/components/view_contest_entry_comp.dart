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

@Component(
   selector: 'view-contest-entry',
   templateUrl: 'packages/webclient/components/view_contest_entry_comp.html',
   publishAs: 'viewContestEntry',
   useShadowDom: false
)

class ViewContestEntryComp {
  ScreenDetectorService scrDet;

  dynamic mainPlayer;
  dynamic selectedOpponent;

  DateTime updatedDate;

  List<String> matchesInvolved = [];

  Contest get contest => _myContestsService.lastContest;
  List<ContestEntry> get contestEntries => (contest != null) ? contest.contestEntries : null;
  List<ContestEntry> get contestEntriesOrderByPoints => (contest != null) ? contest.contestEntriesOrderByPoints : null;

  ViewContestEntryComp(RouteProvider routeProvider, this.scrDet, this._myContestsService, this._profileService, this._flashMessage) {
      //contest = _contestService.getContestById(routeProvider.route.parameters['contestId']);

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

  FlashMessagesService _flashMessage;
  ProfileService _profileService;
  MyContestsService _myContestsService;

  String _contestId;

}