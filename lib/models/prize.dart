library prize;
import 'package:webclient/models/money.dart';

class Prize {
  // Tipos de Premios (obtenidos del backend)
  static const FREE         = "FREE";
  static const WINNER       = "WINNER_TAKES_ALL";
  static const TOP_3        = "TOP_3_GET_PRIZES";
  static const TOP_THIRD    = "TOP_THIRD_GET_PRIZES";
  static const FIFTY_FIFTY  = "FIFTY_FIFTY";

  static Map<String, String> typeNames = {
    FREE: "Free contest. No prizes", //"Free",
    WINNER: "Winner takes all", //"Winner takes all",
    TOP_3: "First 3 get prizes", //"Top 3 get prizes",
    TOP_THIRD: "First # get prizes",// "El tercio superior de concursantes reciben premio", //Top third get prizes",
    FIFTY_FIFTY: "First # get prizes",// "La mitad superior de concursantes reciben premio", //"50/50"
  };

  String prizeType;
  int maxEntries;
  Money entryFee;
  List<Money> values = [];
  // List<num> multipliers = new List<num>();

  Prize() {
    prizeType = FREE;
  }

  Prize.fromJsonObject(Map jsonMap) {
    prizeType = jsonMap["prizeType"];
    maxEntries = jsonMap["maxEntries"];
    entryFee = new Money.fromJsonObject(jsonMap["entryFee"]);
    // multipliers = jsonMap.containsKey("multipliers") ? jsonMap["multipliers"] : [];
    values = jsonMap.containsKey("values") ? jsonMap["values"].map((jsonMap) => new Money.fromJsonObject(jsonMap)).toList() : [];
  }

  String get key => getKey(prizeType, maxEntries, entryFee);

  int get numPrizes {
    int ret = 0;
    if (prizeType == FREE) {
    }
    else if (prizeType == WINNER) {
      ret = 1;
    }
    else if (prizeType == FIFTY_FIFTY) {
      ret = (maxEntries ~/ 2);
    }
    else {
      ret = values.length;
    }
    return ret;
  }

  Money getValue(int index) {
    if (prizeType == FREE) {
      return new Money.zero();
    }
    else if (prizeType == WINNER) {
      return (index == 0) ? values[0] : new Money.zero();
    }
    else if (prizeType == FIFTY_FIFTY) {
      return (index < (maxEntries / 2)) ? values[0] : new Money.zero();
    }
    return (index < values.length) ? values[index] : new Money.zero();
  }

  List<Money> getValues() {
    List<Money> ret = [];

    if (prizeType == FIFTY_FIFTY) {
      for (int i=0; i<maxEntries~/2; i++) {
        ret.add(values[0]);
      }
    }
    else {
      ret = values;
    }

    return ret;
  }

  static String getKey(String prizeType, int maxEntries, Money entryFee) {
    if (prizeType == FREE) {
      return "${prizeType}";
    }
    else if (prizeType == WINNER || prizeType == FIFTY_FIFTY) {
      return "${prizeType}_${entryFee}";
    }
    return "${prizeType}_${maxEntries}_${entryFee}";
  }
}