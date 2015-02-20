library promos_service;

import 'package:angular/angular.dart';
import 'dart:math';
import "package:webclient/services/server_service.dart";

@Injectable()
class PromosService {

  Map<String, Map> promos = {
    'promo1': {
                 'thumbXs': 'images/promos/promo02_2015_Bulls_Xs.png'
                ,'thumbLg': 'images/promos/promo02_2015_Bulls_Desktop.png'
                ,'directUrl': ''
                ,'imageXs'  : 'images/promos/promo1_slide_lg.jpg'
                ,'imageLg'  : 'images/promos/promo1_slide_lg.jpg'
                ,'text'     : 'Lorem fistrum a gramenawer está la cosa muy malar no te digo trigo por no llamarte Rodrigor caballo blanco caballo negroorl diodeno. Qué dise usteer ese pedazo de torpedo a peich hasta luego Lucas condemor de la pradera de la pradera benemeritaar ese hombree diodeno. Hasta luego Lucas ese pedazo de tiene musho peligro pupita de la pradera por la gloria de mi madre se calle ustée mamaar te va a hasé pupitaa por la gloria de mi madre no te digo trigo por no llamarte Rodrigor. Diodeno fistro pupita ese hombree se calle ustée te voy a borrar el cerito ese que llega amatomaa a wan. Diodeno apetecan torpedo pecador torpedo hasta luego Lucas tiene musho peligro te voy a borrar el cerito. Fistro sexuarl tiene musho peligro no te digo trigo por no llamarte Rodrigor quietooor está la cosa muy malar hasta luego Lucas llevame al sircoo condemor fistro te va a hasé pupitaa. De la pradera se calle ustée ese hombree ahorarr ese que llega la caidita la caidita fistro ahorarr apetecan pupita. Ese que llega por la gloria de mi madre a gramenawer sexuarl al ataquerl tiene musho peligro ese que llega pupita pupita pecador.'
                ,'promoEnterUrl' : 'prohibited'
                ,'buttonCaption' :'Reserve your Spot'
              }
    ,'promo2': {
                 'thumbXs': 'images/promos/promo02_2015_Premier_Xs.png'
                ,'thumbLg': 'images/promos/promo02_2015_Premier_Desktop.png'
                ,'directUrl' : ''
                ,'imageXs' :''
                ,'imageLg':''
                ,'text'   : ''
               ,'promoEnterUrl' : 'prohibited'
               ,'buttonCaption' :'Apply Promo'
    }
    ,'promo3': {
                'thumbXs': 'images/promos/promo02_2015_Bulls_Xs.png'
               ,'thumbLg': 'images/promos/promo02_2015_Bulls_Desktop.png'
               ,'directUrl' : ''
               ,'imageXs'   :''
               ,'imageLg'   :''
               ,'text'      : ''
               ,'promoEnterUrl' : 'prohibited'
               ,'buttonCaption' :'Apply Promo'
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
    if (promos.containsKey(key)) {
      return promos[key];
    }
    return promoNotFound;
  }

  Map<String,Map> getRandomPromo(int quantity) {
    List promosIds = promos.keys.toList();

    Map<String, Map> myPromoList = new Map();
    List myIdList = new List();

    for (int i = 0; i<quantity; i++) {
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