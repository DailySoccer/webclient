library ranking_comp;

import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'ranking',
    templateUrl: 'packages/webclient/components/ranking_comp.html',
    useShadowDom: false
)

class RankingComp {
 
  bool isThePlayer(id) => id == _profileService.user.userId;
  String getLocalizedText(key, [group = "ranking"]) {
    return StringUtils.translate(key, group);
  }
  
  RankingComp (this._profileService) {
  }
  
  ProfileService _profileService;
}