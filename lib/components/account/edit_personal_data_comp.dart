library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/models/server_error.dart';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/account/edit_personal_data_comp.html',
    useShadowDom: false
)
class EditPersonalDataComp implements ShadowRootAware{

  String country;
  String region;
  String city;

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

  EditPersonalDataComp(this._profileManager, this.loadingService, this._router);

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
    editedEmail     = _profileManager.user.email;
    editedFirstName = _profileManager.user.firstName;
    editedLastName  = _profileManager.user.lastName;
    editedNickName  = _profileManager.user.nickName;
    editedPassword       = "";
    editedRepeatPassword = "";
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
    if (editedPassword != editedRepeatPassword) {
        passwordErrorText = "Los passwords no coinciden";
        hasPasswordError = true;
        retorno = false;
    }
    return retorno;
  }

  void saveChanges() {
      hideErrors();

      if (!validatePassword() ) {
        return;
      }

      String nickName  = (_profileManager.user.nickName   != editedNickName)  ? editedNickName   : "";
      String firstName = (_profileManager.user.firstName  != editedFirstName) ? editedFirstName  : "";
      String lastName  = (_profileManager.user.lastName   != editedLastName)  ? editedLastName   : "";
      String email     = (_profileManager.user.email      != editedEmail)     ? editedEmail      : "";

      String password  = editedPassword;

      if (nickName  == "" &&  firstName == "" &&
          lastName  == "" &&  email     == "" && password == "") {
          exit(null);
       }

      loadingService.isLoading = true;
      _profileManager.changeUserProfile(firstName, lastName, email, nickName, password)
        .then( (_) {
          editedEmail      = email     == "" ? editedEmail      : email;
          editedFirstName  = firstName == "" ? editedFirstName  : firstName;
          editedLastName   = lastName  == "" ? editedLastName   : lastName;
          editedNickName   = nickName  == "" ? editedNickName   : nickName;
          loadingService.isLoading = false;
          exit(null);
        })
        .catchError((ServerError error) {
          error.toJson().forEach( (key, value) {
            switch (key)
            {
              case "nickName":
                nicknameErrorText = value[0];
                hasNicknameError = true;

              break;
              case "email":
                emailErrorText = value[0];
                hasEmailError = true;
              break;
              case "password":
                passwordErrorText = value[0];
                hasPasswordError = true;
              break;
            }
          });
          loadingService.isLoading = false;
        });
  }

  void hideErrors() {
    hasNicknameError  = false;
    hasEmailError     = false;
    hasPasswordError  = false;
  }

  void exit(event) {
    if(event != null) {
      event.preventDefault();
    }
    _router.go('user_profile', {});
  }

  @override void onShadowRoot(emulatedRoot) {
    init();
  }

  ProfileService _profileManager;
  Router _router;
  bool _acceptNewsletter;
  bool _acceptGameAlerts;
  bool _acceptSoccerPlayerAlerts;
  bool _enabledSubmit = false;

  LoadingService loadingService;
}
