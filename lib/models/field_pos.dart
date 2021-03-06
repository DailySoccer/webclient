library field_pos;
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/models/contest_entry.dart';

class FieldPos {
  static FieldPos GOALKEEPER = new FieldPos(getLocalizedText("goalkeeper"));
  static FieldPos DEFENSE = new FieldPos(getLocalizedText("defense"));
  static FieldPos MIDDLE = new FieldPos(getLocalizedText("middle"));
  static FieldPos FORWARD = new FieldPos(getLocalizedText("forward"));

  // Las unicas instancias de FieldPos en todo el programa
  static Map<String, FieldPos> FIELD_POSITIONS = {
    getLocalizedText("goalkeeper"): new FieldPos._internal(getLocalizedText("goalkeeper")),
    getLocalizedText("defense"): new FieldPos._internal(getLocalizedText("defense")),
    getLocalizedText("middle"): new FieldPos._internal(getLocalizedText("middle")),
    getLocalizedText("forward"): new FieldPos._internal(getLocalizedText("forward")),
  };

  // Mapeamos los fieldPos que nos llegan de la DB a nombres que podemos exponer al usuario
  static Map<String, String> FIELD_POSITION_FULL_NAMES = {
    getLocalizedText("goalkeeper")  : getLocalizedText("goalkeeper"),
    getLocalizedText("defense")     : getLocalizedText("defense"),
    getLocalizedText("middle")      : getLocalizedText("middle"),
    getLocalizedText("forward")     : getLocalizedText("forward")
  };

  static Map<String, List<String>> FORMATIONS = {
    ContestEntry.FORMATION_442: [ GOALKEEPER.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  FORWARD.value,
                                  FORWARD.value
                                 ],

    ContestEntry.FORMATION_352: [ GOALKEEPER.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  FORWARD.value,
                                  FORWARD.value
                                 ],

    ContestEntry.FORMATION_433: [ GOALKEEPER.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  FORWARD.value,
                                  FORWARD.value,
                                  FORWARD.value
                                 ],

    ContestEntry.FORMATION_343: [ GOALKEEPER.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  FORWARD.value,
                                  FORWARD.value,
                                  FORWARD.value
                                 ],

    ContestEntry.FORMATION_451: [ GOALKEEPER.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  DEFENSE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  MIDDLE.value,
                                  FORWARD.value
                                 ]
                                 
  };

  static String getLocalizedText(String key) {
    return StringUtils.translate(key, "soccerplayerpositions");
  }

  static Map<String, String> get FIELD_POSITION_ABREV => {
    getLocalizedText("goalkeeper")  : getLocalizedText("gk"),
    getLocalizedText("defense")     : getLocalizedText("def"),
    getLocalizedText("middle")      : getLocalizedText("mid"),
    getLocalizedText("forward")     : getLocalizedText("for")
   };

  static List<String> get SORT_ORDER => [
    getLocalizedText("gk"),
    getLocalizedText("def"),
    getLocalizedText("mid"),
    getLocalizedText("for")
  ];

  // Nuestra alineacion por defecto
  static List<String> LINEUP = [
    getLocalizedText("goalkeeper"),
    getLocalizedText("defense"),
    getLocalizedText("defense"),
    getLocalizedText("defense"),
    getLocalizedText("defense"),
    getLocalizedText("middle"),
    getLocalizedText("middle"),
    getLocalizedText("middle"),
    getLocalizedText("middle"),
    getLocalizedText("forward"),
    getLocalizedText("forward")
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