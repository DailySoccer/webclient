library field_pos;
import 'package:webclient/utils/localization.dart';

class FieldPos {
  static Localization get T => Localization.instance;

  // Las unicas instancias de FieldPos en todo el programa
  static Map<String, FieldPos> FIELD_POSITIONS = {
    'GOALKEEPER': new FieldPos._internal('GOALKEEPER'),
    'DEFENSE': new FieldPos._internal('DEFENSE'),
    'MIDDLE': new FieldPos._internal('MIDDLE'),
    'FORWARD': new FieldPos._internal('FORWARD'),
  };

  // Mapeamos los fieldPos que nos llegan de la DB a nombres que podemos exponer al usuario
  static Map<String, String> FIELD_POSITION_FULL_NAMES = {
    'GOALKEEPER': T.fieldPosGoalkeeper,
    'DEFENSE': T.fieldPosDefense,
    'MIDDLE': T.fieldPosMiddle,
    'FORWARD': T.fieldPosForward
  };

  static Map<String, String> FIELD_POSITION_ABREV = {
      'GOALKEEPER': T.fieldPosGoalkeeperShort,
      'DEFENSE':    T.fieldPosDefenseShort,
      'MIDDLE':     T.fieldPosMiddleShort,
      'FORWARD':    T.fieldPosForwardShort
   };

  static List<String> SORT_ORDER = [T.fieldPosGoalkeeperShort, T.fieldPosDefenseShort, T.fieldPosMiddleShort, T.fieldPosForwardShort];

  // Nuestra alineacion por defecto
  static List<String> LINEUP = [ "GOALKEEPER", "DEFENSE", "DEFENSE", "DEFENSE", "DEFENSE", "MIDDLE", "MIDDLE", "MIDDLE", "MIDDLE", "FORWARD", "FORWARD" ];

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