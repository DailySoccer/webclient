library field_pos;

class FieldPos {
  // Mapeamos los fieldPos que nos llegan de la DB a nombres que podemos exponer al usuario
  static Map<String, String> FIELD_POSITION_FULL_NAMES = {
    'GOALKEEPER': "PORTERO",
    'DEFENSE': "DEFENSA",
    'MIDDLE': "MEDIOCAMPISTA",
    'FORWARD': "DELANTERO"
  };

  static Map<String, String> FIELD_POSITION_ABREV = {
      'GOALKEEPER': "POR",
      'DEFENSE': "DEF",
      'MIDDLE': "MED",
      'FORWARD': "DEL"
   };

  static List<String> SORT_ORDER = ["POR", "DEF", "MED", "DEL"];

    // Nuestra alineacion por defecto
  static List<String> LINEUP = [ "GOALKEEPER", "DEFENSE", "DEFENSE", "DEFENSE", "DEFENSE", "MIDDLE", "MIDDLE", "MIDDLE", "MIDDLE", "FORWARD", "FORWARD" ];

  factory FieldPos(String val) {
    return FIELD_POSITIONS[val];
  }

  factory FieldPos.fromAbrev(String abrev) {
    if (abrev != null) {
      // Buscamos la key cuyo value es la abreviatura parametro
      return FIELD_POSITIONS[FIELD_POSITION_ABREV.keys.firstWhere((k) => FIELD_POSITION_ABREV[k] == abrev)];
    }
    else {
      return null;
    }
  }

  FieldPos._internal(this.value);

  /*
  FieldPos(this.value);
  FieldPos.fromAbrev(String abrev) {

    value = FIELD_POSITION_ABREV.keys.firstWhere((k) => FIELD_POSITION_ABREV[k] == abrev);
  }
  */

  String     value;
  String get fullName  => FIELD_POSITION_FULL_NAMES[value];
  String get abrevName => FIELD_POSITION_ABREV[value];

  int get sortOrder => SORT_ORDER.indexOf(abrevName);

  bool operator == (other) {
    if (other is! FieldPos) return false;
    return (other as FieldPos).value == value;
  }

  int get hashCode => value.hashCode;

  // Las unicas instancias de FieldPos en todo el programa
  static Map<String, FieldPos> FIELD_POSITIONS = {
    'GOALKEEPER': new FieldPos._internal('GOALKEEPER'),
    'DEFENSE': new FieldPos._internal('DEFENSE'),
    'MIDDLE': new FieldPos._internal('MIDDLE'),
    'FORWARD': new FieldPos._internal('FORWARD'),
 };
}