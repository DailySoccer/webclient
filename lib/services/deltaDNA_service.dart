library deldaDNA_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/server_error.dart';
import 'package:webclient/utils/host_server.dart';
import 'dart:html';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/competition.dart';
import 'package:webclient/components/navigation/deprecated_version_screen_comp.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'dart:math';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/utils/game_info.dart';
import 'package:webclient/utils/string_utils.dart';

@Injectable()
class DeltaDNAService {

  static const String DEV_KEY = "72891174095194552870731883714660";
  static const String LIVE_KEY = "72891177097061902669292778914660";
  
  /*
  // Setting the URL
  var envKey = '22079697190426055695055037414340'
  var collectURL = 'http://collect9102tstpp.deltadna.net/collect/api/'
  //var collectURL = 'http://127.0.0.1:8080/';
  var url = collectURL + envKey + '/bulk';
  console.log('URL used: ' + url);
  var eventList = [];
  */
  /*$.ajax({
      type: 'POST',
      url: url,
      data: JSON.stringify({
        eventList: recordedEvents
      }),
      success: function() {
        console.log('Events successfully sent');
      },
      error: function() {
        //there was an error sending the events, so we add the events back to the eventList (at the beginning).
        eventList = $.extend(recordedEvents, eventList )
        console.log('Error sending events, will retry on next sendEvents()', arguments)
      }
    });*/
  static DeltaDNAService instance = null;
  
  DeltaDNAService(this._http, this._dateTimeService) {
    instance = this;
  }

  void sendEvent(String eventName, [Map params = null]) {
    Map completeEvent = _constructEvent(eventName, params);
    
    Map headers = {};
    headers["Content-Type"] = "application/json";
    
    print(JSON.encode(completeEvent));
    
    _http.post(
        _collectURL, 
        JSON.encode(completeEvent), 
        headers: headers
      ).then((httpResponse) {
        
      }).catchError((error) {
        Logger.root.warning("Error sending event");
      });
  }

  void screenEvent(String eventName, [Map params = null]) {
    if(params == null) params = {};
    params['from'] = _lastVisitedScreen;
    _lastVisitedScreen = eventName;
    
    sendEvent(eventName, params);
  }
  
  void contestScreenEvent(String eventName, Contest contest, [Map params = null]) {
    if(params == null) params = {};
    
    params.addAll(_contestData(contest));
    
    screenEvent(eventName, params);
  }

  void actionEvent(String eventName, String screen, [Map params = null]) {
    if(params == null) params = {};
    
    params['screen'] = screen;
     
    sendEvent(eventName, params);
  }


  void contestActionEvent(String eventName, String screen, Contest contest, [Map params = null]) {
    if(params == null) params = {};

    params.addAll(_contestData(contest));
     
    actionEvent(eventName, screen, params);
  }
  
  void sendMoneyTransactionEvent() {
    /*
    Map exampleEvent = {
          'eventName': 'transaction',
          'eventParams': {
            'action': "purchase",
            'transactionName': "IAP - Large Treasure Chest",
            'transactionType': "PURCHASE",
            'productID': "4019",
            'productsReceived': {
              'virtualCurrencies': [{
                'virtualCurrency': {
                  'virtualCurrencyName': "Gold",
                  'virtualCurrencyType': "PREMIUM",
                  'virtualCurrencyAmount': 100
                }
              }],
              'items': [{
                'item': {
                  'itemName': "Golden Battle Axe",
                  'itemType': "Weapon",
                  'itemAmount': 1
                }
              }, {
                'item': {
                  'itemName': "Mighty Flaming Sword of the First Age",
                  'itemType': "Legendary Weapon",
                  'itemAmount': 1
                }
              }, {
                'item': {
                  'itemName': "Jewel Encrusted Shield",
                  'itemType': "Armour",
                  'itemAmount': 1
                }
              }]
            },
            'productsSpent': {
              'realCurrency': {
                'realCurrencyType': "USD",
                'realCurrencyAmount': 499
              }
            }
          }
        };
    */
  }
  
  String get _userId {
    return _profileService != null && _profileService.isLoggedIn? _profileService.user.userId: defaultUserId;
  }
  
  Map _constructEvent(String eventName, [Map params = null]) {
    Map extendedParams = {};
    
    if (params != null) extendedParams.addAll(params);
    extendedParams.addAll(_userData());
    extendedParams["platform"] = HostServer.platform.toUpperCase();
    
    List<String> splitedEventName = eventName.split(' ');
    splitedEventName[0] = splitedEventName[0].toLowerCase();
    eventName = splitedEventName.join('');
    
    return {
      "eventName": eventName,
      "userID": _userId,
      "sessionID": _sessionId,
      "eventUUID": _generateUUID(),
      "eventTimestamp": GameMetrics.eventsDateString(),
      "eventParams": extendedParams
    };
  }

  Map _userData() {
    Map params = {};
    if (ProfileService.instance == null || !ProfileService.instance.isLoggedIn) {
      params['userGold'] = -1;
      params['userXP'] = -1;
      params['userScore'] = -1;
    } else {
      ProfileService p = ProfileService.instance;
      params['userGold'] = p.user.balance.amount;
      params['userXP'] = p.user.ManagerPoints;
      params['userScore'] = p.user.trueSkill;
    }
    return params;
  }
  Map _contestData(Contest contest) {
    return {
      "tournamentName": contest.name,
      "tournamentId": contest.contestId,
      "tournamentPrize": contest.prizePool.amount,
      "tournamentCost": contest.entryFee.amount,
      "tournamentCapacity": contest.maxEntries,
      "tournamentStart": DateTimeService.formatTimestamp(contest.startDate),
      "createdByUser": contest.isCustomContest(),
      "isAuthor": _profileService.isLoggedIn && contest.isAuthor(_profileService.user)
    };
  }
  
  String get _sessionId {
    if (!GameInfo.contains('sessionToken')) {
      GameInfo.assign('sessionToken', _generateUUID());
      sendEvent('gameStarted', { 'clientVersion': 'v0.1' });
      sendEvent('clientDevice', { 'operatingSystemVersion': HostServer.platform });
    }
    return GameInfo.get('sessionToken');
    /*
    if (sessionID == null) {
      //if the sessionID was equal to null we need to create a new session
      console.log('New session generated');
      sessionID = generateUUID();
      sessionStorage.setItem('sessionID', sessionID);

      // Record clientDevice and gameStarted event since we start a new session
      recordEvent({
        eventName: 'gameStarted',
        eventParams: {
          clientVersion: 'v0.1'
        }
      });
      recordEvent({
        eventName: 'clientDevice',
        eventParams: {
          operatingSystemVersion: navigator.platform
        }
      });

    }
    return sessionID;
    */
  }
  
  String _generateUUID() {
    var d = DateTimeService.now.millisecondsSinceEpoch;
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replaceAllMapped(new RegExp(r'[xy]'), (c) {
      var r = (d + _rnd.nextDouble() * 16).toInt() % 16;
      d = (d / 16).floor();
      return (c == 'x' ? r : (r & 0x3 | 0x8)).toRadixString(16);
    });
  }
  
  Random _rnd = new Random();
  String _defaultUserId = null;
  String get defaultUserId {
    if(_defaultUserId == null) {
      _defaultUserId = _generateUUID();
    }
    return _defaultUserId;
  }
  
  String get _envKey => DEV_KEY;
  String _collectSimpleURL = 'http://collect9102tstpp.deltadna.net/collect/api';
  String get _collectURL => "${_collectSimpleURL}/${_envKey}";
  String get _collectBulkURL => "${_collectURL}/bulk";
  
  void setupFromDeepLinking() { _lastVisitedScreen = "DeepLinking"; }
  String _lastVisitedScreen = "-";
  
  Http _http;
  ProfileService get _profileService => ProfileService.instance;
  DateTimeService _dateTimeService;
}