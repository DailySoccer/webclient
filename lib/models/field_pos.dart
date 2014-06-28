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

  // Nuestra alineacion por defecto
  static List<String> LINEUP = [ "GOALKEEPER", "DEFENSE", "DEFENSE", "DEFENSE", "DEFENSE", "MIDDLE", "MIDDLE", "MIDDLE", "MIDDLE", "FORWARD", "FORWARD" ];

  FieldPos(this.fieldPos);

  String     fieldPos;
  String get fullName  => FIELD_POSITION_FULL_NAMES[fieldPos];
  String get abrevName => FIELD_POSITION_ABREV[fieldPos];

  bool operator == (other) {
    if (other is! FieldPos) return false;
    return (other as FieldPos).fieldPos == fieldPos;
  }

  int get hashCode => fieldPos.hashCode;
}