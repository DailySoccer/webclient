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

@Injectable()
class DeltaDNAService {
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
  
  String get _sessionId {
    if (!window.sessionStorage.containsKey('sessionID')) {
      window.sessionStorage['sessionID'] = _generateUUID();
      sendEvent('gameStarted',{ 'clientVersion': 'v0.1'});
      sendEvent('clientDevice',{ 'operatingSystemVersion': HostServer.platform});
    }
    return window.sessionStorage['sessionID'];
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
  
  String _envKey = "72891174095194552870731883714660";
  String _collectSimpleURL = 'http://collect9102tstpp.deltadna.net/collect/api';
  String get _collectURL => "${_collectSimpleURL}/${_envKey}";
  String get _collectBulkURL => "${_collectURL}/bulk";
  
  Http _http;
  ProfileService get _profileService => ProfileService.instance;
  DateTimeService _dateTimeService;
}