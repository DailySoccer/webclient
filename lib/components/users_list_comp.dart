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

  UsersListComp(this._scope, this.liveContestCtrl) {
 
    _scope.watch("contestEntries", (newValue, oldValue) {
      refresh(); 
    }, context: liveContestCtrl, collection: true);
    
    /*
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"1800'", "score":"150.00", "prize":"€100,00"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"120'", "score":"120.00", "prize":"€50,00"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"100.00", "prize":"€30,00"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"90.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"63.21", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"50.02", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"24.23", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"23.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"14.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"12.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"10.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"9.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"8.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"0.00", "prize":"-"});
    users.add({"name":"JUAN CARLOS RUIZ", "remainingTime":"60'", "score":"0.00", "prize":"-"});
    */
  }
  
  void refresh() {
    users.clear();
    for (var contestEntry in liveContestCtrl.contestEntries) {
      users.add({
        "contestEntryId" : contestEntry.contestEntryId,
        "name": getUserName(contestEntry), 
        "remainingTime": getUserRemainingTime(contestEntry),
        "score": getUserScore(contestEntry)
      });
    }
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

  Scope _scope;
}
