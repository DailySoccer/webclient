library field_pos;

class FieldPos {
  // Mapeamos los fieldPos que nos llegan de la DB a nombres que podemos exponer al usuario
  static Map<String, String> FIELD_POSITION_NAMES = {
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
}