  library promos_service;

import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";

@Injectable()
class PromosService {

  Map<String, Map> promos = {
    'promo1': {
                 'thumbXs': ''
                ,'thumbLg': ''
                ,'directUrl' : ''
                ,'imageXs' :''
                ,'imageLg':''
                ,'text'   : ''
                ,'promoEnterUrl' : 'lobby'
                ,'buttonCaption':'Return to Lobby'
              }
    ,'promo2': {
                'thumbXs': ''
               ,'thumbLg': ''
               ,'directUrl' : ''
               ,'imageXs' :''
               ,'imageLg':''
               ,'text'   : ''
               ,'promoEnterUrl' : 'lobby'
               ,'buttonCaption':'Return to Lobby'
    }
    ,'promo3': {
                'thumbXs': ''
               ,'thumbLg': ''
               ,'directUrl' : ''
               ,'imageXs' :''
               ,'imageLg':''
               ,'text'   : ''
               ,'promoEnterUrl' : 'lobby'
               ,'buttonCaption':'Return to Lobby'
      }
  };

  static Map promoNotFound = {
    'imageXs' :''
    ,'imageLg':''
    ,'text'   : ''
    ,'promoEnterUrl' : 'lobby'
    ,'buttonCaption':'Return to Lobby'
  };


  PromosService(this._server) {
    _instance = this;
  }

  static Map getPromo(String promoId) {
    if (_instance == null)
      throw new Exception("WTF 8111");

    if (_instance.promos.containsKey(key)) {
      return _instance.promos[key];
    }
    return promoNotFound;
  }

  ServerService _server;
  static PromosService _instance;
}