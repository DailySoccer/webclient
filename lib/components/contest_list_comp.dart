library contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contest_service.dart';
import 'package:webclient/models/contest.dart';



@Component(selector: 'contest-list',
           templateUrl: 'packages/webclient/components/contest_list_comp.html',
           publishAs: 'contestList',
           useShadowDom: false)
class ContestListComp {

  @NgOneWay("contestList")
  List<Contest> contestList;

  ContestListComp() {
  }
}
