library view_public_contest_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/models/contest.dart';

@Component(
    selector: 'view-public-contest',
    useShadowDom: false)
class ViewPublicContestComp {

  String contestId;
  String userId;

  bool get isPublic => _routeProvider.route.name.contains("view_public_contest");

  ViewPublicContestComp(this._routeProvider, this._contestsService, this._router) {
    contestId = _routeProvider.route.parameters['contestId'];
    userId = _routeProvider.route.parameters['userId'];

    if (isPublic) {
      _contestsService.getContest(contestId).then((Contest contest) {
        if (contest.isActive) {
          _router.go('enter_contest', {"contestId": contestId, "parent": "lobby", "contestEntryId": "none"});
        }
        else if (contest.isHistory) {
          _router.go('history_contest', {"contestId": contestId, "parent": "lobby", "userId": userId});

        }
        else if (contest.isLive) {
          _router.go('live_contest', {"contestId": contestId, "parent": "lobby", "userId": userId});

        }
      });
    }
  }


  RouteProvider _routeProvider;
  ContestsService _contestsService;
  Router _router;
}