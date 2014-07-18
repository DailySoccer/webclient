library my_contests_comp;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/flash_messages_service.dart';



@Component(selector: 'my-contests',
           templateUrl: 'packages/webclient/components/my_contests_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class MyContestsComp {

  MyContestsService myContestsService;

  MyContestsComp(this.myContestsService, this._flashMessage) {
    myContestsService.refreshMyContests()
      .catchError((error) => _flashMessage.error("$error", context: FlashMessagesService.CONTEXT_VIEW));
  }

  FlashMessagesService _flashMessage;
}