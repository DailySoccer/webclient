library user_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';
import 'package:webclient/models/contest_entry.dart';

@Component(
    selector: 'users-list',
    templateUrl: 'packages/webclient/components/users_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class UsersListComp {

  List users = new List();

  LiveContestCtrl liveContestCtrl;
  
  @NgTwoWay("selectedUser")
  var selectedUser = null;

  UsersListComp(this.liveContestCtrl) {
  }

  
  String getUserName(ContestEntry contestEntry) {
    return contestEntry.userId;
  }
  
  String getUserRemainingTime(ContestEntry contestEntry) {
    return "1";
  }
  
  String getUserScore(ContestEntry contestEntry) {
    return "0";
  }
  
  String getPrize(int index) {
    String prize = "-";
    switch(index) {
      case 0: prize = "€100,00"; break;
      case 1: prize = "€50,00"; break;
      case 2: prize = "€30,00"; break;
    }
    return prize;
  }

  void onUserClick(var user) {
    selectedUser = user;
  }
}
