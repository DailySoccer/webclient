library profile_service;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/models/transaction_info.dart';
import 'package:webclient/services/server_service.dart';
import 'package:logging/logging.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/models/money.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/user_notification.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/components/achievement_comp.dart';
import 'package:webclient/utils/string_utils.dart';

@Injectable()
class ProfileService {

  User user = null;
  bool get isLoggedIn => user != null;
  String get info => isLoggedIn ? user.mainMenuInfo : "";

  bool get isWelcoming => !_hasDoneLogin;

  static ProfileService get instance => _instance;  // Si te peta en esta linea te obliga a pensar, lo que es Una Buena Cosa™.
                                                    // Una pista... quiza te ha pasado pq has quitado componentes del index?

  ProfileService(this._server) {
    _instance = this;
    _tryProfileLoad();
  }

  Future<Map> verifyPasswordResetToken(String stormPathTokenId) {
    return _server.verifyPasswordResetToken(stormPathTokenId);
  }

  Future<Map> resetPassword(String password, String stormPathTokenId) {
    return _server.resetPassword(password, stormPathTokenId).then(_onLoginResponse);
  }

  Future<Map> signup(String firstName, String lastName, String email, String nickName, String password) {
    if (isLoggedIn)
      throw new Exception("WTF 4234 - We shouldn't be logged in when signing up");

    GameMetrics.aliasMixpanel(email);
    GameMetrics.peopleSet({"\$email": email, "\$created": new DateTime.now()});

    return _server.signup(firstName, lastName, email, nickName, password);
   }

  Future<Map> login(String email, String password) {
    return _server.login(email, password).then(_onLoginResponse);
  }

  Future<Map> facebookLogin(String accessToken, String id, String name, String email) {
    return _server.facebookLogin(accessToken, id, name, email).then(_onLoginResponse);
  }

  Future<Map> _onLoginResponse(Map loginResponseJson) {


    _server.setSessionToken(loginResponseJson["sessionToken"]); // to make the getUserProfile call succeed
    return _server.getUserProfile()
                      .then((jsonMap) => _setProfile(loginResponseJson["sessionToken"], jsonMap, true));
  }

  Future<Map> refreshUserProfile() {
    return _server.getUserProfile()
                      .then((jsonMap) => _setProfile(_sessionToken, jsonMap, true));
  }

  Future<List<User>> getFacebookProfiles(List<String> facebookIds) {
    return _server.getFacebookProfiles(facebookIds)
                      .then((jsonMap) {
        List<User> users = [];
        if (jsonMap.containsKey("users_info")) {
          users = jsonMap["users_info"].map((jsonMap) => new User.fromJsonObject(jsonMap)).toList();
        }
        return users;
    });
  }

  Future<Map> changeUserProfile(String firstName, String lastName, String email, String nickName, String password) {

    if (!isLoggedIn)
      throw new Exception("WTF 4288 - We should be logged in when change User Profile");

    return _server.changeUserProfile(firstName, lastName, email, nickName, password)
        .then((jsonMap) => _setProfile(_sessionToken, jsonMap, true));
  }

  Future<Map> logout() {

    if (!isLoggedIn) {
      throw new Exception("WTF 444 - We should be logged in when loging out");
    }
    _setProfile(null, null, true);
    _server.cancelAllAndReload();

    return new Future.value(true);
  }

  Future<List<TransactionInfo>> getTransactionHistory() {
    return _server.getTransactionHistory()
        .then((jsonMap) {
          Money balance = new Money.zero();
          return jsonMap["transactions"].map((jsonObject) {
            TransactionInfo transactionInfo = new TransactionInfo.fromJsonObject(jsonObject);

            // Calcular el balance de la transaccion
            balance = balance.plus(transactionInfo.value);
            transactionInfo.balance = balance;

            return transactionInfo;
          }).toList();
        });
  }

  Future<Map> removeNotification(String notificationId) {
    user.removeNotification(notificationId);
    return _server.removeNotification(notificationId);
  }

  void updateProfileFromJson(Map jsonMap) {
    var storedSessionToken = window.localStorage['sessionToken'];
    if (storedSessionToken != null) {
      _setProfile(storedSessionToken, jsonMap, true);
    }
  }

  Map _setProfile(String theSessionToken, Map jsonMap, bool bSave) {

    if (theSessionToken != null && jsonMap != null) {
      user = new User.fromJsonObject(jsonMap);
      GameMetrics.identifyMixpanel(user.email);
      GameMetrics.peopleSet({"\$email": user.email, "\$last_login": new DateTime.now()});
    }
    else {
      user = null;
    }

    _sessionToken = theSessionToken;
    _server.setSessionToken(_sessionToken);

    if (bSave) {
      _saveProfile();
    }

    return jsonMap;
  }

  void _tryProfileLoad() {
    var storedSessionToken = window.localStorage['sessionToken'];
    var storedUser = window.localStorage['user'];

    if (storedSessionToken != null && storedUser != null) {
      _setProfile(storedSessionToken, JSON.decode(storedUser), false);

      // Cuando se resetea la DB, los logins siguen siendo validos (stormpath) pero se vuelven a crear los usuarios.
      // Esto quiere decir que tanto nuestro token como nuestro user.UserId (que es directamente el ObjectId de mongo)
      // no es valido ya. Ademas, durante desarrollo, podemos borrar la DB. El token seguira siendo valido (puesto que
      // es el email), pero el userId no.
      _server.getUserProfile().then((jsonMap) {
        // Puede que recibamos la información del perfil, cuando el usuario esté "log out" o esté activo el tutorial
        if (user != null && !TutorialService.isActivated) {
          // Si nuestro usuario ya no es el mismo pero no ha dado un error, el sessionToken sigue siendo valido y lo
          // unico que tenemos que hacer es anotar el nuevo User
          if (jsonMap["_id"] != user.userId) {
            Logger.root.warning("ProfileService: Se borro la DB y pudimos reusar el sessionToken.");
          }
          // En cualquier caso, refrescamos el profile para obtener el ultimo dinero
          _setProfile(storedSessionToken, jsonMap, true);
        }
      })
      .catchError((ServerError error) {
        // No se ha podido refrescar: Tenemos que salir y pedir que vuelva a hacer login
        window.localStorage.clear();
        Logger.root.warning("ProfileService: Se borro la DB y necesitamos volver a hacer login.");
        window.location.reload();
      }, test: (error) => error is ServerError);
    }
  }

  void _saveProfile() {
    if (user != null && _sessionToken != null) {
      window.localStorage['sessionToken'] = _sessionToken;
      window.localStorage['user'] = JSON.encode(user);
    }
    else {
      window.localStorage.remove('sessionToken');
      window.localStorage.remove('user');
    }
  }

  void triggerNotificationsPopUp(Router router) {
    if (_wasLoggedInForTriggerPopUp != ProfileService.instance.isLoggedIn) {
      ProfileService.instance.refreshUserProfile().then( (_) {

        String getLocalizedText(key, {substitutions: null}) {
          return StringUtils.translate(key, "notificationsmodal", substitutions);
        }

        if(!_wasLoggedInForTriggerPopUp && ProfileService.instance.isLoggedIn) {
          List<UserNotification> achievementNotifs = ProfileService.instance.user.notifications.where( (notif) => notif.topic == 'ACHIEVEMENT_EARNED').toList();

          if (achievementNotifs.length == 0) { return; }
          UserNotification shown = achievementNotifs[0];
          int aditionalCount = achievementNotifs.length - 1;
          String aditionalAchievemetsKey = aditionalCount > 1? 'aditional-achievements' : 'aditional-achievement-single';

          modalShow(""
                   , '''
                    <div class="content-wrapper">
                      <h1 class="alert-content-title large">
                        ${getLocalizedText("congratulations")}
                      </h1>
                      <h1 class="alert-content-title">
                        ${getLocalizedText("you-earned")}
                      </h1>
                      <div class="achievment-earned-icon-wrapper">
                        ${AchievementComp.toHtml(shown.info['achievement'])}
                      </div>
                      ${aditionalCount > 0? "<h2 class='alert-content-subtitle'>${getLocalizedText(aditionalAchievemetsKey, substitutions: {'NUM_ACHIEVEMENTS': aditionalCount})}</h2>" : ''}
                    </div>
                    '''
                   , onOk: getLocalizedText('go-notifications')
                   , onBackdropClick: false
                   , closeButton: true
                   , aditionalClass: "achievementEarned"
                 )
                 .then((_) => router.go('notifications', {}))
                 .catchError((_) => print('error'));

        }
        _wasLoggedInForTriggerPopUp = ProfileService.instance.isLoggedIn;
      });
    }
  }

  bool _wasLoggedInForTriggerPopUp = false;

  bool get _hasDoneLogin => window.localStorage.containsKey('user');

  static ProfileService _instance;

  ServerService _server;
  String _sessionToken;
}