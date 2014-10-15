library field_pos;

class FieldPos {

  // Las unicas instancias de FieldPos en todo el programa
  static Map<String, FieldPos> FIELD_POSITIONS = {
    'GOALKEEPER': new FieldPos._internal('GOALKEEPER'),
    'DEFENSE': new FieldPos._internal('DEFENSE'),
    'MIDDLE': new FieldPos._internal('MIDDLE'),
    'FORWARD': new FieldPos._internal('FORWARD'),
  };

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