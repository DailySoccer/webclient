library user_profile_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'dart:html';

@Component(
    selector: 'user-profile',
    templateUrl: 'packages/webclient/components/account/user_profile_comp.html',
    useShadowDom: false
)
class UserProfileComp implements ShadowRootAware, DetachAware {

  bool isEditingProfile = false;

  String editedFirstName;
  String editedLastName;
  String editedNickName;
  String editedEmail;
  String editedPassword;
  String editedRepeatPassword;

  bool hasNicknameError;
  bool hasEmailError;
  bool hasPasswordError;

  String nicknameErrorText;
  String emailErrorText;
  String passwordErrorText;

  dynamic get userData => _profileManager.user;

  UserProfileComp(this._profileManager, this._scrDet) {
    _streamListener = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void onScreenWidthChange(String msg) {
    updateUserProfileContent();
  }

  void editPersonalData() {
    isEditingProfile = true;
    updateUserProfileContent();
  }
  void endEditPersonalData() {
      isEditingProfile = false;
      updateUserProfileContent();
  }

  void updateUserProfileContent() {

    _elmntViewProfile.style.display = isEditingProfile ? 'none' : '';
    editContent();
  }

  void editContent() {
    if (isEditingProfile) {
      //La versión Desktop para editar los datos personales se muestran en una ventana modal
      if (_scrDet.isDesktop) {
        Element modal = querySelector ('#editPersonalDataModal');
        // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
        modal.style.display = "block";
        JsUtils.runJavascript('#editPersonalDataModal', 'modal', null);
      }
      else { // Resto de versiones para editar los datos personales se muestran en pantalla completa
        _elmntEditProfile.style.display = '';
        JsUtils.runJavascript('#editPersonalDataModal', 'modal', 'hide');
      }
    }
    else {
      _elmntEditProfile.style.display = 'none';
      JsUtils.runJavascript('#editPersonalDataModal', 'modal', 'hide');
      setUserVariables();
    }
  }

  void setUserVariables() {
    editedFirstName       = _profileManager.user.firstName;
    editedLastName        = _profileManager.user.lastName;
    editedNickName        = _profileManager.user.nickName;
    editedEmail           = _profileManager.user.email;
    editedPassword        = "";
    editedRepeatPassword  = "";

    hasNicknameError      = false;
    hasEmailError         = false;
    hasPasswordError      = false;

    nicknameErrorText     = "";
    emailErrorText        = "";
    passwordErrorText     = "";
  }

  @override void onShadowRoot(emulatedRoot) {

    _elmntViewProfile = querySelector('#viewProfileContent');
    _elmntEditProfile = querySelector('#editProfileContent');

    setUserVariables();
    updateUserProfileContent();
  }

  @override void detach() {
    _streamListener.cancel();
  }

  Element _elmntViewProfile;
  Element _elmntEditProfile;

  ScreenDetectorService _scrDet;
  ProfileService _profileManager;
  var _streamListener;
}