library transaction_info;

import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/models/money.dart';

class TransactionInfo {

  Map transactionTypes = {
    "PRIZE"               : "Prize",
    "ORDER"               : "Add funds",
    "ENTER_CONTEST"       : "Contest entry fee",
    "CANCEL_CONTEST_ENTRY": "Cancelled contest entry fee",
    "CANCEL_CONTEST"      : "Cancelled contest",
    "REFUND"              : "Refund",
    "FREE_MONEY"          : "This one's on the house",
    "BONUS_TO_CASH"       : "Pending bonus"
  };

  String transactionDescription;
  String type;
  Money value;
  DateTime createdAt;
  String transactionID;


  // Estado del balance después de aplicar la transaction
  Money balance;

  String get formattedDate => DateTimeService.formatDateTimeDayHour(createdAt);

  TransactionInfo.fromJsonObject(Map jsonMap) {
    type = jsonMap["type"];
    value = new Money.fromJsonObject(jsonMap["value"]);
    transactionDescription = transactionTypes[type];
    transactionID = jsonMap["accountingTranId"];
    createdAt = DateTimeService.fromMillisecondsSinceEpoch(int.parse(jsonMap["createdAt"]));
  }


}