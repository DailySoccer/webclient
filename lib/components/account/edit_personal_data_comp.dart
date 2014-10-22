library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/components/account/user_profile_comp.dart';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/account/edit_personal_data_comp.html',
    useShadowDom: false
)
class EditPersonalDataComp implements ShadowRootAware{

  String country;
  String region;
  String city;

  UserProfileComp parent;

  bool get acceptNewsletter => _acceptNewsletter;
  void set acceptNewsletter(bool value) {
    _acceptNewsletter = value;
    //print('-EDIT_PERSONAL_DATA-: acceptNewsletter = ${_acceptNewsletter}');
  }

  bool get acceptGameAlerts => _acceptGameAlerts;
  void set acceptGameAlerts(bool value) {
    _acceptGameAlerts = value;
    //print('-EDIT_PERSONAL_DATA-: acceptGameAlerts = ${_acceptGameAlerts}');
  }

  bool get acceptSoccerPlayerAlerts => _acceptSoccerPlayerAlerts;
  void set acceptSoccerPlayerAlerts(bool value) {
    _acceptSoccerPlayerAlerts = value;
   //print('-EDIT_PERSONAL_DATA-: acceptSoccerPlayerAlerts = ${_acceptSoccerPlayerAlerts}');
  }

  dynamic get userData => _profileManager.user;

  //TODO: pensar si Esto debería estar siempre habilitado y hacerlas comprobaciones antes de enviar los cambios.
  //bool get enabledSubmit => parent.editedNickName.isNotEmpty && parent.editedEmail.isNotEmpty && parent.editedRepeatPassword.isNotEmpty && parent.editedPassword.isNotEmpty && _enabledSubmit;

  EditPersonalDataComp(this._profileManager, this.parent) {
  }

  void init() {
    //switch NEWSLETTER/OFERTAS ESPECIALES
    JsUtils.runJavascript("[name='switchNewsletter']", 'bootstrapSwitch', {         'size'          : 'mini',
                                                                                    'state'         : acceptNewsletter,
                                                                                    'disabled'      : 'true',
                                                                                    'onColor'       : 'primary',
                                                                                    'offColor'      : 'default',
                                                                                    'onSwitchChange': onNewsLetterSwitchChange
                                                                           });

    //switch NOTIFICACIONES DE JUEGO
    JsUtils.runJavascript("[name='switchGameAlerts']", 'bootstrapSwitch', {         'size'          : 'mini',
                                                                                    'state'         : _acceptGameAlerts,
                                                                                    'disabled'      : 'true',
                                                                                    'onColor'       : 'primary',
                                                                                    'offColor'      : 'default',
                                                                                    'onSwitchChange': onGameAlertsSwitchChange
                                                                          });

    //switch NOTIFICACIONES DE TUS FICHAJES
    JsUtils.runJavascript("[name='switchsoccerPlayerAlerts']", 'bootstrapSwitch', { 'size'          : 'mini',
                                                                                    'state'         : _acceptSoccerPlayerAlerts,
                                                                                    'disabled'      : 'true',
                                                                                    'onColor'       : 'primary',
                                                                                    'offColor'      : 'default',
                                                                                    'onSwitchChange': onSoccerPlayerAlertsSwitchChange
                                                                                  });
      hideErrors();

  }

  void onNewsLetterSwitchChange(event, state) {
    acceptNewsletter = state;
  }

  void onGameAlertsSwitchChange(event, state) {
    acceptGameAlerts = state;
  }

  void onSoccerPlayerAlertsSwitchChange(event, state) {
    acceptSoccerPlayerAlerts = state;
  }


  bool validatePassword() {
    bool retorno = true;
    // Verificación del password
    if (parent.editedPassword != parent.editedRepeatPassword) {
        parent
          ..passwordErrorText = "Los passwords no coinciden"
          ..hasPasswordError = true;
        retorno = false;
      }

    return retorno;
  }

  void saveChanges() {

      hideErrors();

      if (!validatePassword() ) {
        return;
      }
      //_enabledSubmit = false;
      String firstName = _profileManager.user.firstName  != parent.editedFirstName ? parent.editedFirstName  : "";
      String lastName  = _profileManager.user.lastName   != parent.editedLastName  ? parent.editedLastName   : "";
      String email     = _profileManager.user.email      != parent.editedEmail     ? parent.editedEmail      : "";

      // El nickname de momento no sabemos si le daremos permisos al usuario para que lo cambie a placer.
      String nickName  = "";
      String password  = parent.editedPassword;

      _profileManager.changeUserProfile(firstName, lastName, email, nickName, password)
        //Not implemented yet //.then((_) => _profileManager.saveUserData(firstName, lastName,acceptGameAlerts, /* nickName, */ email, password))
        .then((_) => closeModal())
        .catchError((Map error) {

          error.keys.forEach( (key) {
            switch (key)
            {
              case "nickName":
                parent
                  ..nicknameErrorText = error[key][0]
                  ..hasNicknameError = true;

              break;
              case "email":
                parent
                  ..emailErrorText = error[key][0]
                  ..hasEmailError = true;
              break;
              case "password":
                parent
                  ..passwordErrorText = error[key][0]
                ..hasPasswordError = true;
              break;
            }
          });

        });
  }

  void hideErrors() {
    parent
    ..hasNicknameError  = false
    ..hasEmailError     = false
    ..hasPasswordError  = false;
  }


  void closeModal() {
    _profileManager.refreshUserProfile();
    parent.endEditPersonalData();
    JsUtils.runJavascript('#editPersonalDataModal', 'modal', 'hide');
  }

  ProfileService _profileManager;
  bool _acceptNewsletter;
  bool _acceptGameAlerts;
  bool _acceptSoccerPlayerAlerts;
  bool _enabledSubmit = false;
  bool _popUpStyle;

  @override
  void onShadowRoot(emulatedRoot) {
    init();
  }
}
