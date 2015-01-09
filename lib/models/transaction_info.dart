library transaction_info;

import 'package:webclient/services/datetime_service.dart';

class TransactionInfo {
  String type;
  String value;
  DateTime createdAt;

  TransactionInfo.fromJsonObject(Map jsonMap) {
    type = jsonMap["type"];
    value = jsonMap["value"];
    createdAt = DateTimeService.fromMillisecondsSinceEpoch(int.parse(jsonMap["createdAt"]));
  }
}