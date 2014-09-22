library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/edit_personal_data_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class EditPersonalDataComp {

  String password;
  String repeatPassword;
  String country;
  String region;
  String city;

  dynamic get userData => _profileManager.user;

  EditPersonalDataComp(this._profileManager);

  ProfileService _profileManager;
}