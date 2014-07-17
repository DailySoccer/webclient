library user_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';

@Component(
    selector: 'users-list',
    templateUrl: 'packages/webclient/components/users_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class UsersListComp {

  var users = new List();

  @NgTwoWay("selectedUser")
  var selectedUser = null;

  UsersListComp() {

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
  }

  void onUserClick(var user) {
    selectedUser = user;
  }

}
