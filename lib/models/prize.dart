library prize;
import 'package:webclient/models/money.dart';
import 'package:webclient/utils/string_utils.dart';

class Prize {
  // Tipos de Premios (obtenidos del backend)
  static const FREE         = "FREE";
  static const WINNER       = "WINNER_TAKES_ALL";
  static const TOP_3        = "TOP_3_GET_PRIZES";
  static const TOP_THIRD    = "TOP_THIRD_GET_PRIZES";
  static const FIFTY_FIFTY  = "FIFTY_FIFTY";

  static Map<String, String> typeNames = {
    FREE: StringUtils.translate("free", "prizes"), //"Free",
    WINNER: StringUtils.translate("winnertakesall", "prizes"), //"Winner takes all",
    TOP_3: StringUtils.translate("first3", "prizes"), //"Top 3 get prizes",
    TOP_THIRD: StringUtils.translate("firstthird", "prizes"),// "El tercio superior de concursantes reciben premio", //Top third get prizes",
    FIFTY_FIFTY: StringUtils.translate("fifty", "prizes")// "La mitad superior de concursantes reciben premio", //"50/50"
  };

  String prizeType;
  int maxEntries;
  Money prizePool;
  List<Money> values = [];
  // List<num> multipliers = new List<num>();

  Prize() {
    prizeType = FREE;
  }

  Prize.fromJsonObject(Map jsonMap) {
    prizeType = jsonMap["prizeType"];
    maxEntries = jsonMap["maxEntries"];
    prizePool = jsonMap.containsKey("prizePool") ? new Money.fromJsonObject(jsonMap["prizePool"]) : new Money.zero();
    // multipliers = jsonMap.containsKey("multipliers") ? jsonMap["multipliers"] : [];
    values = jsonMap.containsKey("values") ? jsonMap["values"].map((jsonMap) => new Money.fromJsonObject(jsonMap)).toList() : [];
  }

  String get key => getKey(prizeType, maxEntries, prizePool);

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

  static String getKey(String prizeType, int maxEntries, Money prizePool) {
    if (prizeType == FREE) {
      return "${prizeType}";
    }
    else if (prizeType == WINNER || prizeType == FIFTY_FIFTY) {
      return "${prizeType}_${prizePool}";
    }
    return "${prizeType}_${maxEntries}_${prizePool}";
  }
}