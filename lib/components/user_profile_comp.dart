library user_profile_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/user_profile_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class UserProfileComp {

  dynamic get userData => _profileManager.user;

  UserProfileComp(this._profileManager);

  ProfileService _profileManager;

}