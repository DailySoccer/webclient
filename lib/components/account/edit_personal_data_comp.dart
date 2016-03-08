library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:html';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/account/edit_personal_data_comp.html',
    useShadowDom: false
)
class EditPersonalDataComp implements ShadowRootAware{

  int MIN_PASSWORD_LENGTH = 8;
  int MIN_NICKNAME_LENGTH = 4;
  int MAX_NICKNAME_LENGTH = 30;
  int MAX_NAME_LENGTH = 15;
  int MAX_SURNAME_LENGTH = 20;

  String country;
  String region;
  String city;

  String get editedFirstName => _editedFirstName;
  void set editedFirstName(String val) { _editedFirstName = val; }
  
  String get editedLastName => _editedLastName;
  void set editedLastName(String val) { _editedLastName = val; }
  
  String get editedNickName => _editedNickName;
  void set editedNickName(String val) {
    _editedNickName = val;
    validateAll();
  }
  
  String get editedEmail => _editedEmail;
  void set editedEmail(String val) {
    _editedEmail = val;
    validateAll();
  }
  
  String get editedPassword => _editedPassword;
  void set editedPassword(String val) {
    _editedPassword = val;
    validateAll();
  }
  
  String get editedRepeatPassword => _editedRepeatPassword;
  void set editedRepeatPassword(String val) {
    _editedRepeatPassword = val;
    validateAll();
  }

  String _editedFirstName;
  String _editedLastName;
  String _editedNickName;
  String _editedEmail;
  String _editedPassword = "";
  String _editedRepeatPassword = "";

  String nicknameErrorText = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  
  bool canSave = true;

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

  String getLocalizedText(key, {Map sustitutions: null}) {
    return StringUtils.translate(key, "editprofile", sustitutions);
  }

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
    _editedEmail     = _profileManager.user.email;
    _editedFirstName = _profileManager.user.firstName;
    _editedLastName  = _profileManager.user.lastName;
    _editedNickName  = _profileManager.user.nickName;
    _editedPassword       = "";
    _editedRepeatPassword = "";
    validateAll();
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
    passwordErrorText = "";
    // Verificación del password
    if ( ! (editedPassword == '' && editedRepeatPassword == '') 
      && (editedPassword != editedRepeatPassword || editedPassword.length < MIN_PASSWORD_LENGTH)) {
      if (editedPassword.length < MIN_PASSWORD_LENGTH) {
        passwordErrorText = getLocalizedText('passwordshort', sustitutions: {'MIN_PASSWORD_LENGTH': MIN_PASSWORD_LENGTH});//"Password must be at least ${MIN_PASSWORD_LENGTH} characters long.";
        retorno = false;
      } else if (editedPassword != editedRepeatPassword) {
        passwordErrorText = getLocalizedText('passwordnotmatch');//"Passwords don't match.";
        retorno = false;
      }
    }
    return retorno;
  }
  
  bool validateEmail() {
    bool valid = StringUtils.isValidEmail(editedEmail);
    emailErrorText = "";
    
    if (!valid) {
      emailErrorText = getLocalizedText('emailnotvalid');//"Email is not valid.";
    }
    return valid;
  }
  
  bool validateNickname() {
    bool valid = editedNickName != "" && editedNickName.length > MIN_NICKNAME_LENGTH;
    nicknameErrorText = "";
    
    if (!valid) {
      nicknameErrorText = getLocalizedText('nicknameerrortext', sustitutions: {'MIN_NICKNAME_LENGTH': MIN_NICKNAME_LENGTH});//"Username must be at least ${MIN_NICKNAME_LENGTH} characters long.";
    }
    return valid;
  }
  
  bool validateAll() {
    //hideErrors();
    bool validNick = validateNickname();
    bool validEmail = validateEmail();
    bool validPass = validatePassword();
    canSave = validNick && validEmail && validPass;
    return canSave;
  }

  void saveChanges() {
      if (!validateAll()) {
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
            switch (key)  {
              case "nickName": nicknameErrorText = value[0]; break;
              case "email":    emailErrorText = value[0];    break;
              case "password": passwordErrorText = value[0]; break;
            }
          });
          loadingService.isLoading = false;
        }, test: (error) => error is ServerError);
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
