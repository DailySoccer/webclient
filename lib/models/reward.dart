library reward;
import 'package:webclient/models/money.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:logging/logging.dart';

class Reward {
  static const TYPE_GOLD = "GOLD";
  
  String rewardId;
  String type;
  
  Money money = new Money.zero();
  bool pickedUp = false;
  
  String toString() => "$type($rewardId) ${money.toStringWithCurrency()} - pickedUp: $pickedUp";
  
  Reward.fromJsonObject(Map jsonMap) {
    rewardId = jsonMap["_id"];
    type = jsonMap["type"];
    pickedUp = jsonMap["pickedUp"];
   
    if (type == TYPE_GOLD) {
      money = new Money.fromJsonObject(jsonMap["value"]);
    }
  }
}