library top_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';
import 'dart:async';
import 'package:logging/logging.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/models/user.dart';

@Component(
    selector: 'top-bar',
    templateUrl: 'packages/webclient/components/navigation/top_bar_comp.html',
    useShadowDom: false
)
class TopBarComp {

  AppTopBarStateConfig _lastState;
  AppTopBarStateConfig get currentState {
    if (_lastState == _appStateService.appTopBarState.activeState) 
      return _lastState;
    
    return _lastState = _appStateService.appTopBarState.activeState;
  }
  
  String get layoutCssClass => currentState.leftColumn != AppTopBarState.EMPTY || currentState.rightColumn != AppTopBarState.EMPTY ? "three-columns" :
                               currentState.centerColumn != AppTopBarState.EMPTY ? "one-column" : "hidden-bar";
  
  bool get leftColumnIsBackButton => currentState.leftColumn == AppTopBarState.BACK_BUTTON;
  bool get notificationsActive => _appStateService.notificationsActive;
  void set notificationsActive(bool b) { _appStateService.notificationsActive = b; }
  bool get hasNotification => _profileService.isLoggedIn? _profileService.user.notifications.length > 0 : false;

  bool changeNameWindowShow = false;
  
  String get leftColumnHTML   => _columnHTML(currentState.leftColumn);
  String get centerColumnHTML => _columnHTML(currentState.centerColumn);
  String get rightColumnHTML  => _columnHTML(currentState.rightColumn);

  String get specialLayoutClass => currentState.layoutClass;

  String get searchValue {
    return currentState.searchValue;
  }
  void set searchValue(String val) {
    currentState.searchValue = val;
    currentState.onSearch(val);
  }
  
  String _columnHTML(String s) => s == AppTopBarState.EMPTY ? '' : 
                                  s == AppTopBarState.BACK_BUTTON ? "<i class='material-icons'>&#xE5C4;</i>" :
                                  s == AppTopBarState.SEARCH_BUTTON && !currentState.isSearching? "<i class='material-icons'>&#xE8B6;</i>" :
                                  s == AppTopBarState.SEARCH_BUTTON && currentState.isSearching? "" :
                                  s;
  
  TopBarComp(this._router, this._loadingService, this._view, this._rootElement, 
                this._dateTimeService, this._profileService, this._templateService, 
                this._catalogService, this._appStateService, this._scrDet) {
    
    _profileService.onRefreshProfile.listen(onProfileRefresh); 
    //editedNickName = _profileService.user.nickName;
  }

  void onLeftColumnClick() {
   // if (leftColumnIsBackButton) {
      _appStateService.appTopBarState.activeState.onLeftColumn();
   // }
  }
  void onCenterColumnClick() {
    if (currentState.centerColumn != AppTopBarState.EMPTY) {
      _appStateService.appTopBarState.activeState.onCenterColumn();
    }
  }
  void onRightColumnClick() {
    if (currentState.rightColumn != AppTopBarState.EMPTY) {
      _appStateService.appTopBarState.activeState.onRightColumn();
      if (currentState.rightColumn == AppTopBarState.SEARCH_BUTTON) {
        new Timer(new Duration(milliseconds: 100), ([_]) {
          var elem = document.getElementById("topBarSearchField");
          if (elem != null) elem.focus();
        });
      }
    }
  }

  void onProfileRefresh(User user) {
    _profileService.triggerEventualAction(ProfileService.FIRST_RUN_CHANGE_NAME, () {
      changeNameWindowShow = true;
    });
  }
  
  String _editedNickName = "";
  void set editedNickName(String s) {
    _editedNickName = s;
    validateNickname();
  }
  
  
  String get editedNickName => _editedNickName;
  String nicknameErrorText = "";
  int MIN_NICKNAME_LENGTH = 4;
  int MAX_NICKNAME_LENGTH = 30;
  
  void validateNickname() {
    bool valid = editedNickName != "" && editedNickName.length >= MIN_NICKNAME_LENGTH;
    nicknameErrorText = "";
    if (!valid) {
      nicknameErrorText = "Tamaño mínimo $MIN_NICKNAME_LENGTH caracteres";
    }
  }
  
  void saveChanges() {
      String nickName  = (_profileService.user.nickName   != editedNickName)  ? editedNickName   : "";

      if (nickName  == "") {
         changeNameWindowShow = false;
      }
      
      _profileService.changeUserProfile(_profileService.user.firstName, _profileService.user.lastName, 
                                        _profileService.user.email, nickName, "").then( (_) {
            _profileService.user.nickName = editedNickName;
            changeNameWindowShow = false;
            _profileService.eventualActionCompleted(ProfileService.FIRST_RUN_CHANGE_NAME);
          }).catchError((ServerError error) {
            error.toJson().forEach( (key, value) {
              switch (key)  {
                case "nickName":
                  if(value[0] == "ERROR_NICKNAME_TAKEN") {
                    nicknameErrorText = "El nombre ya está seleccionado"; 
                  } else {
                    nicknameErrorText = "Error de nombre desconocido";
                  }
                break;
                default: nicknameErrorText = "Error Desconocido";
              }
            });
          }, test: (error) => error is ServerError);
  }
  
  void cancelNicknameChange() {
    changeNameWindowShow = false;
  }
  
  
  // LAYOUT ELEMENTS
  /*
  String _backButton([String clas = ""]) {
    return "<div class='back-button $clas'><i class='material-icons'>&#xE5C4;</i></div>";
  }
  String _titleLabel([String clas = ""]) {
    return "<div class='title-label $clas'>${configParameters["title"]}</div>";
  }
  String _empty([String clas = ""]) {
    return "<div class='empty-element $clas'></div>";
  }
  String _userCurrencies([String clas = ""]) {
    return '''
              <div class='user-currencies $clas'>
                <div class="energy-currency currency">
                  <span class="enery-icon">E</span>
                  <span class="enery-counter">$_userEnergyPoints</span>
                </div>
                <div class="gold-currency currency">
                  <span class="gold-icon">G</span>
                  <span class="gold-counter">$_userGold</span>
                </div>
                <div class="manager-level currency">
                  <span class="manager-icon">M</span>
                  <span class="manager-counter">$_userManagerPoints</span>
                </div>
              </div>
          ''';
  }
  String _createContestButton([String clas = ""]) {
    return "<button class='create-contest $clas'>( + )</button>";
  }
  String _liveContestButton([String clas = ""]) {
    return "<button class='live-contest $clas'>Y</button>";
  }
  
  String _getHtmlModule(String s) {
    Map<String, Function> modules = { AppTopBarState.CREATE_CONTEST_BUTTON: _createContestButton,
                                      AppTopBarState.LIVE_CONTESTS: _liveContestButton,
                                      AppTopBarState.BACK_BUTTON: _backButton,
                                      AppTopBarState.USER_CURRENCIES: _userCurrencies,
                                      AppTopBarState.TITLE_LABEL: _titleLabel,
                                      AppTopBarState.EMPTY: _empty
                                    };
    
    return modules[s]();
  }
  
  String get _userEnergyPoints {
    if (!_profileService.isLoggedIn) {
      return "";
    }
    return "${_profileService.user.Energy}";
  }
  
  String get _userManagerPoints {
    if (!_profileService.isLoggedIn) {
      return "";
    }
    return '''<span class='current-manager'>${_profileService.user.ManagerPoints.toString()}</span>
              <span class='max-manager'>/${_profileService.user.pointsToNextLevel}</span>''';
  }
  
  String get _userManagerLevel {
    if (!_profileService.isLoggedIn) {
      return "";
    }
    return _profileService.user.managerLevel.toInt().toString();
  }

  String get _userGold {
    if (!_profileService.isLoggedIn) {
      return "";
    }

    int gold = _profileService.user.Gold;
    String goldString = gold.toString();

    if(gold > 9999) {
      gold ~/= 1000;
      goldString = '${gold}k';

      if(gold > 999) {
        gold ~/= 1000;
        goldString = '${gold}M';
      }
    }

    return goldString;
  }
  */
  
  Element _rootElement;
  View _view;
  Router _router;
  ScreenDetectorService _scrDet;
  
  DateTimeService _dateTimeService;
  LoadingService _loadingService;

  TemplateService _templateService;
  CatalogService _catalogService;
  ProfileService _profileService;
  AppStateService _appStateService;
}