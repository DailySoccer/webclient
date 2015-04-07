library edit_personal_data_comp;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/server_error.dart';
import 'dart:html';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/components/base_comp.dart';

@Component(
    selector: 'edit-personal-data',
    templateUrl: 'packages/webclient/components/account/edit_personal_data_comp.html',
    useShadowDom: false
)
class EditPersonalDataComp extends BaseComp implements ShadowRootAware{

  int MIN_PASSWORD_LENGTH = 8;
  int MIN_NICKNAME_LENGTH = 4;
  int MAX_NICKNAME_LENGTH = 30;

  String country;
  String region;
  String city;

  String editedFirstName;
  String editedLastName;
  String editedNickName;
  String editedEmail;
  String editedPassword = "";
  String editedRepeatPassword = "";

  String nicknameErrorText;
  String emailErrorText;

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

  EditPersonalDataComp(this._profileManager, this.loadingService, this._router, this._rootElement);

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
    return (editedPassword == editedRepeatPassword) && (editedPassword.length >= MIN_PASSWORD_LENGTH);
  }

  void saveChanges() {
      hideErrors();
      bool valid_Data = true;

      if (editedNickName != "" && editedNickName.length < MIN_NICKNAME_LENGTH) {
         _nickNameErrorContainer
           ..classes.remove("errorDetected")
           ..classes.add("errorDetected")
           ..style.display = '';

         _nickNameErrorLabel.text = T.nicknameHelper(MIN_NICKNAME_LENGTH, MAX_NICKNAME_LENGTH);
         valid_Data = false;
       }

       if (!StringUtils.isValidEmail(editedEmail)) {
         _emailErrorContainer
           ..classes.remove("errorDetected")
           ..classes.add("errorDetected")
           ..style.display = '';

         _emailErrorLabel.text = T.emailIsNotValid;
         valid_Data = false;
       }
      if (!validatePassword() ) {
        _passwordErrorContainer
          ..classes.remove("errorDetected")
          ..classes.add("errorDetected")
          ..style.display = '';

        _passwordErrorLabel.text = (editedPassword != editedRepeatPassword) ? T.passwordsDontMatch : T.passwordHelper(MIN_PASSWORD_LENGTH);
        valid_Data = false;
      }

      if (!valid_Data) {
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
                _nickNameErrorContainer
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..style.display = '';

                _nickNameErrorLabel = value[0];
              break;
              case "email":
                _emailErrorContainer
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..style.display = '';

                _emailErrorLabel = value[0];
              break;
              case "password":
                _passwordErrorContainer
                  ..classes.remove("errorDetected")
                  ..classes.add("errorDetected")
                  ..style.display = '';

                _passwordErrorLabel = value[0];
              break;
            }
          });
          loadingService.isLoading = false;
        }, test: (error) => error is ServerError);
  }

  void hideErrors() {
    _nickNameErrorContainer.style.display = 'none';
    _passwordErrorLabel.text = "";

    _emailErrorContainer.style.display = 'none';
    _emailErrorLabel.text = "";

    _passwordErrorContainer.style.display = 'none';
    _passwordErrorLabel.text = "";
  }

  void exit(event) {
    if(event != null) {
      event.preventDefault();
    }
    _router.go('user_profile', {});
  }

  @override void onShadowRoot(emulatedRoot) {
    init();
    _nickNameErrorContainer = _rootElement.querySelector('#nickNameErrorContainer');
    _nickNameErrorLabel     = _rootElement.querySelector('#nickNameErrorLabel');

    _emailErrorContainer    = _rootElement.querySelector('#emailErrorContainer');
    _emailErrorLabel        = _rootElement.querySelector('#emailErrorLabel');

    _passwordErrorContainer = _rootElement.querySelector('#passwordErrorContainer');
    _passwordErrorLabel     = _rootElement.querySelector('#passwordErrorLabel');

    hideErrors();
  }

  ProfileService _profileManager;
  Router _router;
  bool _acceptNewsletter;
  bool _acceptGameAlerts;
  bool _acceptSoccerPlayerAlerts;
  bool _enabledSubmit = false;

  LoadingService loadingService;

  Element _rootElement;
  Element _nickNameErrorContainer;
  Element _nickNameErrorLabel;
  Element _emailErrorContainer;
  Element _emailErrorLabel;
  Element _passwordErrorContainer;
  Element _passwordErrorLabel;
}
