library promos_service;

import 'package:angular/angular.dart';
import 'dart:math';
import 'package:webclient/services/server_service.dart';

@Injectable()
class PromosService {
  Map<String, Map> promos = {
    'promo1': {
                 'thumbXs': 'images/promos/promoGen02Xs.jpg'
                ,'thumbLg': 'images/promos/promoGen02Desktop.png'
                ,'directUrl': '#/enter_contest/lobby/54eca721e4b09263f9e8ec6e/none'
                ,'imageXs'  : 'images/promos/promo02_2015_Bulls_Landing_Xs.png'
                ,'imageLg'  : 'images/promos/promo02_2015_Bulls_Landing.png'
                ,'text'     : ''
                ,'promoEnterUrl' : 'restricted'
                ,'buttonCaption' :'Reserve your Spot'
                ,'name': 'BullsOnParadeW25'
              }
    ,'promo2': {
                 'thumbXs': 'images/promos/promoGen01Xs.jpg'
                ,'thumbLg': 'images/promos/promoGen01Desktop.png'
                ,'directUrl' : '#/enter_contest/lobby/54eca9b6e4b09263f9e8ec6f/none'
                ,'imageXs' :'images/promos/promo02_2015_Premier_Landing_Xs.png'
                ,'imageLg':'images/promos/promo02_2015_Premier_Landing.jpg'
                ,'text'   : ''
               ,'promoEnterUrl' : 'restricted'
               ,'buttonCaption' :'Reserve your Spot'
               ,'name': 'QueensMenW27'
              }
  };

  Map promoNotFound = {
    'thumbXs': ''
    ,'thumbLg': ''
    ,'directUrl': ''
    ,'imageXs'  : ''
    ,'imageLg'  : ''
    ,'text'     : 'The promo you are trying to access is not available'
    ,'promoEnterUrl' : 'lobby'
    ,'buttonCaption' :'Return to Lobby'
    ,'name': '404'
  };


  PromosService(this._server) {
    _rng = new Random();
  }

  Map getPromo(String promoId) {
    if (promos.containsKey(promoId)) {
      return promos[promoId];
    }
    return promoNotFound;
  }

  Map<String,Map> getRandomPromo(int quantity) {
    List promosIds = promos.keys.toList();

    Map<String, Map> myPromoList = new Map();
    List myIdList = new List();

    for (int i = 0; i < quantity; i++) {
      int id = _rng.nextInt(promosIds.length);
      String promoId = promosIds.elementAt(id);
      myIdList.add(promoId);
      promosIds.remove(promoId);
      myPromoList.addAll({promoId: promos[promoId]});
    }

    return myPromoList;
  }

  String getDirectUrl(String promoId) {
    Map promo = getPromo(promoId);
    if (promo['directUrl']=='') {
      return 'lobby';
    }
    else return promo['directUrl'];
  }


  ServerService _server;
  var _rng;
}