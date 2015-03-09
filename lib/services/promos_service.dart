library promos_service;

import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'dart:async';
import 'package:webclient/services/refresh_timers_service.dart';
import 'dart:math';

@Injectable()
class PromosService {

  PromosService(this._server, this._refreshTimersService) {
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_UPDATE_PROMOS, refreshPromos);
  }


  Future<Map> refreshPromos() {
    void assignPromoList(Map jsonMap) {
      _promos = jsonMap['promos'];
    }

    return _permanentCodeName!=null? _server.getPromo(_permanentCodeName).then(assignPromoList) :
                                     _server.getPromos().then(assignPromoList);
  }

  static void configurePromosService(String codeName) {
    _permanentCodeName = codeName;
  }

  Map getPromo(String codeName) {
    return _promos.firstWhere((promo)=>(promo['codeName']==codeName), orElse:()=>_promoNotFound);
  }

  Future <Map<String,Map>> getRandomPromo(int quantity) {
    Completer<Map<String,Map>> completer = new Completer();
    Map<String,Map> randPromo;
    if(_promos!=null) {
      completer.complete(_getRandomPromo(quantity));
    }
    else {
      refreshPromos().then((_) {
        completer.complete(_getRandomPromo(quantity));
            });
    }

    return completer.future;
  }

  Map<String,Map> _getRandomPromo(int quantity) {
    Map<String, Map> myPromoList = new Map();

    if (_promos!=null && _promos.isNotEmpty) {
      int currentPriority = _promos.first['priority'];
      List tempPromos = new List();
      while (tempPromos.length < min(quantity, _promos.length)) {
        List morePromos = _promos.skip(tempPromos.length).takeWhile((promo) => promo['priority']==currentPriority).toList();
        currentPriority = currentPriority-1;
        morePromos.shuffle();
        tempPromos.addAll(morePromos);
      }

      List promosIds = tempPromos.take(quantity).toList();
      promosIds.forEach((promo) => myPromoList.addAll({promo['codeName']: promo}));
    }

    return myPromoList;
  }


  String getDirectUrl(String promoId) {
    Map promo = getPromo(promoId);
    if (promo['url']=='') {
      return 'lobby';
    }
    else return promo['url'];
  }


  static String _permanentCodeName;

  ServerService _server;
  RefreshTimersService _refreshTimersService;

  List<Map> _promos;

  Map _promoNotFound = {
     'url': ''
    ,'imageXs'  : ''
    ,'imageDesktop'  : ''
    ,'html' : ''
    ,'text'     : 'The promo you are trying to access is not available'
    ,'promoEnterUrl' : 'lobby'
    ,'buttonCaption' :'Return to Lobby'
    ,'codeName': '404'
  };

}