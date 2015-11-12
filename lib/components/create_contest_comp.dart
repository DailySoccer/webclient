library create_contest_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
  selector: 'create-contest',
  templateUrl: 'packages/webclient/components/create_contest_comp.html',
  useShadowDom: false
)
class CreateContestComp  {
  
  CreateContestComp(this._router);

  String getLocalizedText(key) {
    return StringUtils.translate(key, "mycontest");
  }
  
  Router _router;
  
}