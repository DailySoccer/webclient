library contests_list_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';


@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

  @NgOneWay("contestsList")
  List<Contest> contestsList;

  ContestsListComp();
}
