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
/*
  String firstName;
  String lastName;
  String nickName;
  String email;
  String password;
  String repeatPassword;
*/
  String country;
  String region;
  String city;

  UserProfileComp parent;

  Element nicknameError;
  Element emailError;
  Element passwordError;

  @NgTwoWay("is-pop-up")
   bool get isPopUp => _popUpStyle;
   void set isPopUp (bool value){
     _popUpStyle = value;
   }

  bool get acceptNewsletter => _acceptNewsletter;
  void set acceptNewsletter(bool value) {
    _acceptNewsletter = value;
    print('-EDIT_PERSONAL_DATA-: acceptNewsletter = ${_acceptNewsletter}');
  }

  bool get acceptGameAlerts => _acceptGameAlerts;
  void set acceptGameAlerts(bool value) {
    _acceptGameAlerts = value;
    print('-EDIT_PERSONAL_DATA-: acceptGameAlerts = ${_acceptGameAlerts}');
  }

  bool get acceptSoccerPlayerAlerts => _acceptSoccerPlayerAlerts;
  void set acceptSoccerPlayerAlerts(bool value) {
    _acceptSoccerPlayerAlerts = value;
    print('-EDIT_PERSONAL_DATA-: acceptSoccerPlayerAlerts = ${_acceptSoccerPlayerAlerts}');
  }

  dynamic get userData => _profileManager.user;

  bool get enabledSubmit => parent.nickName.isNotEmpty && parent.email.isNotEmpty && parent.password.isNotEmpty && _enabledSubmit;

  EditPersonalDataComp(this._profileManager, this.parent);

  @override
  void onShadowRoot(root) {
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
    nicknameError = querySelector('#nickNameError');
    nicknameError.parent.style.display = "none";

    emailError =    querySelector('#emailError');
    emailError.parent.style.display = "none";

    passwordError = querySelector('#passwordError');
    passwordError.parent.style.display = "none";
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
    if(parent.password != parent.repeatPassword) {
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

      if(!validatePassword()) {
        return;
      }
        _enabledSubmit = false;

        _profileManager.signup(parent.firstName, parent.lastName, parent.email, parent.nickName, parent.password)
            //Not implemented yet //.then((_) => _profileManager.saveUserData(firstName, lastName,acceptGameAlerts, /* nickName, */ email, password))
            .then((_) => closeModal())
            .catchError((Map error) {

              print("keys: ${error.keys.length} - ${error.keys.toString()}");

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
                  case "email":
                    passwordError
                      ..text = error[key][0]
                      ..classes.remove("errorDetected")
                      ..classes.add("errorDetected")
                      ..parent.style.display = "";
                  break;
                }
                print("-JOIN_COMP-: Error recibido: ${key}");
              });

              _enabledSubmit = true;
            });
  }

  void closeModal() {
    parent.endEditPersonalData();
    //JsUtils.runJavascript('#editPersonalDataModal', 'modal', 'hide');
  }

  ProfileService _profileManager;
  bool _acceptNewsletter;
  bool _acceptGameAlerts;
  bool _acceptSoccerPlayerAlerts;
  bool _enabledSubmit = false;
  bool _popUpStyle;
}
