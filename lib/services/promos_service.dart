library promos_service;

import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'dart:async';
import 'package:webclient/services/refresh_timers_service.dart';
import 'dart:math';
import 'package:webclient/utils/game_metrics.dart';
import 'dart:html';

@Injectable()
class PromosService {

  List<Map> get promos => _promos;
  
  PromosService(this._router, this._server, this._refreshTimersService) {
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
  
  void gotoPromo(Map promo, {String defaultUrl: 'view_promo', Map defaultUrlParams: null}) {
    //TODO: elegir el link, pero tiene preferencia el directUrl.
    if (defaultUrlParams == null) defaultUrlParams = defaultUrl == 'view_promo' ? {"promoId" : promo['codeName']} : {};
    // GameMetrics.logEvent(GameMetrics.PROMO, {"code": promo['codeName']});
    String url = promo['url'] == '' ? defaultUrl : promo['url'];
    Map params = promo['url'] == '' ? defaultUrlParams : {};

    if (url.contains("#")) {
      window.location.assign(url);
    } else {
      _router.go(url, params);
    }
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
  Router _router;
  
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