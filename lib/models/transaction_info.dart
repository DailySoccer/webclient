library transaction_info;

import 'package:webclient/services/datetime_service.dart';

class TransactionInfo {

  Map transactionTypes = {
    "PRIZE"               : "Premio",
    "ORDER"               : "Transacción",
    "ENTER_CONTEST"       : "Participación en torneo",
    "CANCEL_CONTEST_ENTRY": "Cancelar participación en torneo",
    "CANCEL_CONTEST"      : "Torneo cancelado",
    "REFUND"              : "Reembolso",
    "FREE_MONEY"          : "Esta ronda la paga la casa"
  };

  String transactionDescription;
  String type;
  double value;
  DateTime createdAt;
  String transactionID;


  // Estado del balance después de aplicar la transaction
  double balance;

  String get formattedDate => DateTimeService.formatDateTimeDayHour(createdAt);

  TransactionInfo.fromJsonObject(Map jsonMap) {
    type = jsonMap["type"];
    value = double.parse(jsonMap["value"]);
    transactionDescription = transactionTypes[type];
    transactionID = jsonMap["accountingTranId"];
    createdAt = DateTimeService.fromMillisecondsSinceEpoch(int.parse(jsonMap["createdAt"]));
  }


}