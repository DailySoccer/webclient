library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';

@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

  @NgOneWay("contestsList")
  List<Contest> contestsList;

  @NgOneWay("actionButtonTitle")
  String actionButtonTitle = "Ver";

  @NgCallback("onRowClick")
  Function onRowClick;

  @NgCallback("onActionClick")
  Function onActionClick;

  ContestsListComp();

  void onRow(Contest contest) {
    if (onRowClick != null)
      onRowClick({"contest":contest});
  }

  void onAction(Contest contest) {
    if (onActionClick != null)
      onActionClick({"contest":contest});
  }
}
