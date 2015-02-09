library prizes_service;

import 'package:angular/angular.dart';

import "package:webclient/services/server_service.dart";
import "package:webclient/models/prize.dart";


@Injectable()
class PrizesService {

  Map<String, Prize> prizes = {};

  PrizesService(this._server) {
    _instance = this;
  }

  static Prize getPrize(String key) {
    if (_instance == null)
      throw new Exception("WTF 8111");

    if (_instance.prizes.containsKey(key)) {
      return _instance.prizes[key];
    }
    return new Prize();
  }

  void loadFromJsonObject(Map jsonMapRoot) {
    prizes.clear();

    if (jsonMapRoot.containsKey("prizes_list")) {
      jsonMapRoot["prizes_list"].map((jsonObject) {
        Prize prize = new Prize.fromJsonObject(jsonObject);
        prizes[prize.key] = prize;
      });
    }
    else if (jsonMapRoot.containsKey("prizes")) {
      Prize prize = new Prize.fromJsonObject(jsonMapRoot["prizes"]);
      prizes[prize.key] = prize;
    }
  }

  ServerService _server;
  static PrizesService _instance;
}