library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/components/user_profile_comp.dart';
import 'dart:html';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/edit_personal_data_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class EditPersonalDataComp implements ShadowRootAware {

  String country;
  String region;
  String city;

  UserProfileComp parent;

  Element nicknameError;
  Element emailError;
  Element passwordError;

  bool isPopUp;

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

  EditPersonalDataComp(this._profileManager, this.parent);

  @override
  void onShadowRoot(root) {
    HtmlElement htmlRoot = root as HtmlElement;


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

      nicknameError = htmlRoot.querySelector('#nickNameError');
      emailError    = htmlRoot.querySelector('#emailError');
      passwordError = htmlRoot.querySelector('#passwordError');

      hideErrors();

      isPopUp = htmlRoot.id == 'modalEditPersonalDataForm';
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

  void hideErrors() {
    nicknameError.parent.style.display  = "none";
    emailError.parent.style.display     = "none";
    passwordError.parent.style.display  = "none";
  }

  bool validatePassword() {
    bool retorno = true;
    // Verificación del password
    if (parent.editedPassword != parent.editedRepeatPassword) {
        passwordError
          ..text = "Los passwords no coinciden"
          ..classes.remove("errorDetected")
          ..classes.add("errorDetected")
          ..parent.style.display = "";
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

             // print("keys: ${error.keys.length} - ${error.keys.toString()}");

              error.keys.forEach( (key) {
                switch (key)
                {
                  case "nickName":
                    nicknameError
                      ..text = error[key][0]
                      ..classes.remove("errorDetected")
                      ..classes.add("errorDetected")
                      ..parent.style.display = "";

                  break;
                  case "email":
                    emailError
                      ..text = error[key][0]
                      ..classes.remove("errorDetected")
                      ..classes.add("errorDetected")
                      ..parent.style.display = "";
                  break;
                  case "password":
                    passwordError
                      ..text = error[key][0]
                      ..classes.remove("errorDetected")
                      ..classes.add("errorDetected")
                      ..parent.style.display = "";
                  break;
                }
             //   print("-EDIT_PERSONAL_DATA_COMP-: Error recibido: ${key}");
              });
             //_enabledSubmit = true;
            });
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
}
