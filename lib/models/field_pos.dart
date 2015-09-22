library field_pos;
import 'package:webclient/utils/string_utils.dart';

class FieldPos {

  // Las unicas instancias de FieldPos en todo el programa
  static Map<String, FieldPos> FIELD_POSITIONS = {
    GetLocalizedText("goalkeeper"): new FieldPos._internal(GetLocalizedText("goalkeeper")),
    GetLocalizedText("defense"): new FieldPos._internal(GetLocalizedText("defense")),
    GetLocalizedText("middle"): new FieldPos._internal(GetLocalizedText("middle")),
    GetLocalizedText("forward"): new FieldPos._internal(GetLocalizedText("forward")),
  };

  // Mapeamos los fieldPos que nos llegan de la DB a nombres que podemos exponer al usuario
  static Map<String, String> FIELD_POSITION_FULL_NAMES = {
    GetLocalizedText("goalkeeper")  : GetLocalizedText("goalkeeper"),
    GetLocalizedText("defense")     : GetLocalizedText("defense"),
    GetLocalizedText("middle")      : GetLocalizedText("middle"),
    GetLocalizedText("forward")     : GetLocalizedText("forward")
  };

  static String GetLocalizedText(String key) {
    return StringUtils.Translate(key, "soccerplayerpositions");
  }

  static Map<String, String> get FIELD_POSITION_ABREV => {
    GetLocalizedText("goalkeeper")  : GetLocalizedText("gk"),
    GetLocalizedText("defense")     : GetLocalizedText("def"),
    GetLocalizedText("middle")      : GetLocalizedText("mid"),
    GetLocalizedText("forward")     : GetLocalizedText("for")
   };

  static List<String> get SORT_ORDER => [
    GetLocalizedText("gk"),
    GetLocalizedText("def"),
    GetLocalizedText("mid"),
    GetLocalizedText("for")
  ];

  // Nuestra alineacion por defecto
  static List<String> LINEUP = [
    GetLocalizedText("goalkeeper"),
    GetLocalizedText("defense"),
    GetLocalizedText("defense"),
    GetLocalizedText("defense"),
    GetLocalizedText("defense"),
    GetLocalizedText("middle"),
    GetLocalizedText("middle"),
    GetLocalizedText("middle"),
    GetLocalizedText("middle"),
    GetLocalizedText("forward"),
    GetLocalizedText("forward")
   ];

  factory FieldPos(String val) {
    return FIELD_POSITIONS[val];
  }

  FieldPos._internal(this.value);

  String     value;
  String get fullName  => FIELD_POSITION_FULL_NAMES[value];
  String get abrevName => FIELD_POSITION_ABREV[value];

  int get sortOrder => SORT_ORDER.indexOf(abrevName);

  bool operator == (other) {
    if (other is! FieldPos) return false;
    return (other as FieldPos).value == value;
  }

  int get hashCode => value.hashCode;
}