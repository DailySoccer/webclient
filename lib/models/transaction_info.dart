library transaction_info;

import 'package:webclient/services/datetime_service.dart';

class TransactionInfo {
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
    transactionID = jsonMap["accountingTranId"];
    createdAt = DateTimeService.fromMillisecondsSinceEpoch(int.parse(jsonMap["createdAt"]));
  }
}