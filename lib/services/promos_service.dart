library promos_service;

import 'package:angular/angular.dart';
import 'dart:math';
import 'package:webclient/services/server_service.dart';

@Injectable()
class PromosService {
  Map<String, Map> promos = {
    'promo1': {
                 'thumbXs': 'images/promos/promo02_2015_Bulls_Xs.jpg'
                ,'thumbLg': 'images/promos/promo02_2015_Bulls_Desktop.png'
                ,'directUrl': 'restricted'
                ,'imageXs'  : 'images/promos/promo02_2015_Bulls_Landing_Xs.png'
                ,'imageLg'  : 'images/promos/promo02_2015_Bulls_Landing.png'
                ,'text'     : 'Lorem fistrum condemor minim commodo quietooor eiusmod ese hombree de la pradera ese que llega quietooor. Adipisicing qui por la gloria de mi madre llevame al sircoo ese hombree la caidita sexuarl tiene musho peligro sit amet occaecat. Llevame al sircoo no puedor tempor a gramenawer a wan.'
                ,'promoEnterUrl' : 'restricted'
                ,'buttonCaption' :'Reserve your Spot'
                ,'name': 'Bull'
              }
    ,'promo2': {
                 'thumbXs': 'images/promos/promo02_2015_Premier_Xs.jpg'
                ,'thumbLg': 'images/promos/promo02_2015_Premier_Desktop.png'
                ,'directUrl' : 'restricted'
                ,'imageXs' :'images/promos/promo02_2015_Premier_Landing_Xs.png'
                ,'imageLg':'images/promos/promo02_2015_Premier_Landing.jpg'
                ,'text'   : 'Sit amet velit sed condemor tiene musho peligro diodenoo occaecat te va a hasé pupitaa minim adipisicing se calle ustée. Minim aliquip magna ese hombree diodenoo sed reprehenderit. Te va a hasé pupitaa enim consectetur amatomaa nostrud. Esse jarl exercitation dolor al ataquerl incididunt por la gloria de mi madre labore. '
               ,'promoEnterUrl' : 'restricted'
               ,'buttonCaption' :'Reserve your Spot'
               ,'name': 'Premier'
              }
  };

  Map promoNotFound = {
    'imageXs' :''
    ,'imageLg':''
    ,'text'   : ''
    ,'promoEnterUrl' : 'lobby'
    ,'buttonCaption':'Return to Lobby'
  };


  PromosService(this._server) {
    print("Activando promo service");
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