library prize;
import 'package:webclient/models/money.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest.dart';
import 'package:logging/logging.dart';

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
  int entries;
  Money prizePool;
  List<Money> values = [];
  // List<num> multipliers = new List<num>();

  Prize() {
    prizeType = FREE;
  }

  Prize.fromContest(Contest contest) {
    prizeType = contest.prizeType;
    entries = (contest.numEntries < contest.minEntries) ? contest.minEntries : contest.numEntries;
    prizePool = contest.prizePool; //getPool(contest.entryFee, entries, contest.prizeMultiplier);
    values = _calculateValues();

    // TODO: Premios como "enteros"
    // values.forEach((money) => money.amount = money.amount.toInt());
  }

  Prize.fromJsonObject(Map jsonMap) {
    prizeType = jsonMap["prizeType"];
    entries = jsonMap["maxEntries"];
    prizePool = jsonMap.containsKey("prizePool") ? new Money.fromJsonObject(jsonMap["prizePool"]) : new Money.zero();
    // multipliers = jsonMap.containsKey("multipliers") ? jsonMap["multipliers"] : [];
    values = jsonMap.containsKey("values") ? jsonMap["values"].map((jsonMap) => new Money.fromJsonObject(jsonMap)).toList() : [];
  }

  String get key => getKey(prizeType, entries, prizePool);

  int get numPrizes {
    int ret = 0;
    if (prizeType == FREE) {
    }
    else if (prizeType == WINNER) {
      ret = 1;
    }
    else if (prizeType == FIFTY_FIFTY) {
      ret = (entries ~/ 2);
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
      return (index < (entries / 2)) ? values[0] : new Money.zero();
    }
    return (index < values.length) ? values[index] : new Money.zero();
  }

  List<Money> getValues() {
    List<Money> ret = [];

    if (prizeType == FIFTY_FIFTY) {
      for (int i=0; i<entries~/2; i++) {
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

  List<Money> _calculateValues() {
    List<Money> result = [];

    if (prizeType == WINNER) {
      // El ganador se lo lleva todo
      result.add(prizePool);
    }
    else if (prizeType == TOP_3) {
      // Reparto directamente proporcional entre los 3 primeros (proporción: 5, 3 y 2)
      result.add(prizePool.multipliedBy(5 / 10));
      result.add(prizePool.multipliedBy(3 / 10));
      result.add(prizePool.multipliedBy(2 / 10));
    }
    else if (prizeType == TOP_THIRD) {
      // Reparto directamente proporcional entre los n primeros
      int third = entries ~/ 3;
      int total = 0;
      for (int i=0; i<third; i++)
        total += (i+1);

      for (int i=0; i<third; i++) {
        result.add(prizePool.multipliedBy( (third - i) / total));
      }
    }
    else if (prizeType == FIFTY_FIFTY) {
      // Se reparte a partes iguales entre la mitad de los participantes
      int mitad = entries ~/ 2;
      Money money = new Money.from(prizePool.currencyUnit, prizePool.amount ~/ mitad);
      for (int i=0; i<mitad; i++) {
        result.add(money);
      }
    }

    // Logger.root.info("Prize: $prizeType: [${result.map((premio) => premio.toString()).join(" : ")}]");
    return result;
  }

  static Money getPool(Money entryFee, int entries, num prizeMultiplier) {
      Money money = new Money.zeroFrom(entryFee.currencyUnit == Money.CURRENCY_ENERGY ? Money.CURRENCY_MANAGER : Money.CURRENCY_GOLD);
      return money.plus(entryFee).multipliedBy(entries * prizeMultiplier);
  }

}