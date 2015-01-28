library prize;

class Prize {
  // Tipos de Premios (obtenidos del backend)
  static const FREE         = "FREE";
  static const WINNER       = "WINNER_TAKES_ALL";
  static const TOP_3        = "TOP_3_GET_PRIZES";
  static const TOP_THIRD    = "TOP_THIRD_GET_PRIZES";
  static const FIFTY_FIFTY  = "FIFTY_FIFTY";

  static Map<String, String> typeNames = {
    FREE: "Concurso Gratuito. No hay premios a repartir", //"Free",
    WINNER: "Todo para el ganador", //"Winner takes all",
    TOP_3: "Los 3 primeros concursantes reciben premio", //"Top 3 get prizes",
    TOP_THIRD: "Los # primeros reciben premio",// "El tercio superior de concursantes reciben premio", //Top third get prizes",
    FIFTY_FIFTY: "Los # primeros reciben premio",// "La mitad superior de concursantes reciben premio", //"50/50"
  };

  String prizeType;
  int maxEntries;
  int prizePool;
  List<num> values = new List<num>();

  Prize() {
    prizeType = FREE;
  }

  Prize.fromJsonObject(Map jsonMap) {
    prizeType = jsonMap["prizeType"];
    maxEntries = jsonMap["maxEntries"];
    prizePool = jsonMap["prizePool"];
    values = jsonMap["values"];
  }

  String get key => getKey(prizeType, maxEntries, prizePool);

  num getValue(int index) {
    if (prizeType == FREE) {
      return 0;
    }
    else if (prizeType == WINNER) {
      return (index == 0) ? values[0] : 0;
    }
    else if (prizeType == FIFTY_FIFTY) {
      return (index < (maxEntries / 2)) ? values[0] : 0;
    }
    return (index < values.length) ? values[index] : 0;
  }

  List<num> getValues() {
    List<num> ret = [];

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

  static String getKey(String prizeType, int maxEntries, int prizePool) {
    if (prizeType == FREE) {
      return "${prizeType}";
    }
    else if (prizeType == WINNER || prizeType == FIFTY_FIFTY) {
      return "${prizeType}_${prizePool}";
    }
    return "${prizeType}_${maxEntries}_${prizePool}";
  }
}