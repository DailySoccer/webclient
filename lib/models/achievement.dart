library achievement;
import 'package:webclient/models/user.dart';

class Achievement {
  static const String PLAYED_VIRTUAL_CONTESTS_LEVEL_1 = "PLAYED_5_VIRTUAL_CONTESTS";
  static const String PLAYED_VIRTUAL_CONTESTS_LEVEL_2 = "PLAYED_10_VIRTUAL_CONTESTS";

  static const String WON_VIRTUAL_CONTESTS_LEVEL_1 = "WON_1_VIRTUAL_CONTEST";
  static const String WON_VIRTUAL_CONTESTS_LEVEL_2 = "WON_5_VIRTUAL_CONTESTS";
  static const String WON_VIRTUAL_CONTESTS_LEVEL_3 = "WON_10_VIRTUAL_CONTESTS";

  static const String FP_VIRTUAL_CONTEST_LEVEL_1 = "FP_500_VIRTUAL_CONTEST";
  static const String FP_VIRTUAL_CONTEST_LEVEL_2 = "FP_700_VIRTUAL_CONTEST";
  static const String FP_VIRTUAL_CONTEST_LEVEL_3 = "FP_1000_VIRTUAL_CONTEST";

  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_1 = "DIFF_FP_100_VIRTUAL_CONTEST";
  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_2 = "DIFF_FP_200_VIRTUAL_CONTEST";
  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_3 = "DIFF_FP_300_VIRTUAL_CONTEST";


  static const String PLAYED_OFFICIAL_CONTESTS_LEVEL_1 = "PLAYED_5_OFFICIAL_CONTESTS";
  static const String PLAYED_OFFICIAL_CONTESTS_LEVEL_2 = "PLAYED_10_OFFICIAL_CONTESTS";

  static const String WON_OFFICIAL_CONTESTS_LEVEL_1 = "WON_1_OFFICIAL_CONTEST";
  static const String WON_OFFICIAL_CONTESTS_LEVEL_2 = "WON_5_OFFICIAL_CONTESTS";
  static const String WON_OFFICIAL_CONTESTS_LEVEL_3 = "WON_10_OFFICIAL_CONTESTS";

  static const String FP_OFFICIAL_CONTEST_LEVEL_1 = "FP_500_OFFICIAL_CONTEST";
  static const String FP_OFFICIAL_CONTEST_LEVEL_2 = "FP_700_OFFICIAL_CONTEST";
  static const String FP_OFFICIAL_CONTEST_LEVEL_3 = "FP_1000_OFFICIAL_CONTEST";

  static const String DIFF_FP_OFFICIAL_CONTEST_LEVEL_1 = "DIFF_FP_100_OFFICIAL_CONTEST";
  static const String DIFF_FP_OFFICIAL_CONTEST_LEVEL_2 = "DIFF_FP_200_OFFICIAL_CONTEST";
  static const String DIFF_FP_OFFICIAL_CONTEST_LEVEL_3 = "DIFF_FP_300_OFFICIAL_CONTEST";

  static const String MANAGER_LEVEL_3 = "MANAGER_LEVEL_3";
  static const String MANAGER_LEVEL_4 = "MANAGER_LEVEL_4";
  static const String MANAGER_LEVEL_5 = "MANAGER_LEVEL_5";

  static const String TRUE_SKILL_LEVEL_1 = "TRUE_SKILL_500";
  static const String TRUE_SKILL_LEVEL_2 = "TRUE_SKILL_600";
  static const String TRUE_SKILL_LEVEL_3 = "TRUE_SKILL_700";
  static const String TRUE_SKILL_LEVEL_4 = "TRUE_SKILL_800";
  static const String TRUE_SKILL_LEVEL_5 = "TRUE_SKILL_900";

  static const String ALL_SOCCER_PLAYERS_WITH_FP = "ALL_SOCCER_PLAYERS_WITH_FP";

  static const String SOCCER_PLAYER_WON_FP_LEVEL_1 = "SOCCER_PLAYER_WON_FP_100";
  static const String SOCCER_PLAYER_WON_FP_LEVEL_2 = "SOCCER_PLAYER_WON_FP_200";

  static const String GOALKEEPER_SAVES_SHOTS_LEVEL_1 = "GOALKEEPER_SAVES_10_SHOTS";
  static const String GOALKEEPER_SAVES_SHOTS_LEVEL_2 = "GOALKEEPER_SAVES_20_SHOTS";
  static const String GOALKEEPER_0_GOAL_RECEIVED = "GOALKEEPER_0_GOAL_RECEIVED";
  static const String GOALKEEPER_RED_CARD = "GOALKEEPER_RED_CARD";
  static const String GOALKEEPER_GOAL_SCORED = "GOALKEEPER_GOAL_SCORED";

  static const String DEFENDER_INTERCEPTIONS_LEVEL_1 = "DEFENDER_10_INTERCEPTIONS";
  static const String DEFENDER_INTERCEPTIONS_LEVEL_2 = "DEFENDER_20_INTERCEPTIONS";

  static const String MIDDLE_PASS_SUCCESSFUL_LEVEL_1 = "MIDDLE_10_PASS_SUCCESSFUL";
  static const String MIDDLE_PASS_SUCCESSFUL_LEVEL_2 = "MIDDLE_20_PASS_SUCCESSFUL";

  static const String FORWARD_GOAL_LEVEL_1 = "FORWARD_1_GOAL";
  static const String FORWARD_GOAL_LEVEL_2 = "FORWARD_2_GOAL";
  static const String FORWARD_GOAL_LEVEL_3 = "FORWARD_3_GOAL";

  String id;
  String name;
  String description;
  String image;
  String style;

  static const BASIC_STYLE = "basic";
  static const ORANGE_STYLE = "orange";

  bool earnedByUser(User user) => user.achievements.contains(id);

  Achievement({String id: "", String name: "", String description: "", String image: "", String style: BASIC_STYLE}) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.style = style;
  }

  Achievement.fromJsonObject(Map jsonMap) {
    id = jsonMap["id"];
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    description = jsonMap.containsKey("description") ? jsonMap["description"] : "";
    image = jsonMap.containsKey("image") ? jsonMap["image"] : "";
    style = jsonMap.containsKey("style") ? jsonMap["style"] : "";
  }

  static List<Map> AVAILABLES = [
    {
      "id": WON_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "El Principiante",
      "description": "Ganar el primer torneo virtual",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "Superentreno",
      "description": "Jugar 10 torneos virtuales",
      "image": '',
      "style": 'Training'
    },
    {
      "id": WON_VIRTUAL_CONTESTS_LEVEL_2,
      "name": "El Hacha",
      "description": "Ganar 10 torneos virtuales",
      "image": '',
      "style": 'Oficial'
    },
    {
      "id": FP_VIRTUAL_CONTEST_LEVEL_1,
      "name": "El Resultón",
      "description": "Puntuar más de 1000 FP con un equipo en un torneo virtual",
      "image": '',
      "style": 'Oficial'
    },
    {
      "id": DIFF_FP_VIRTUAL_CONTEST_LEVEL_1,
      "name": "El Míster",
      "description": "Ganar un torneo virtual por más de 200 FP de diferencia",
      "image": '',
      "style": 'Training'
    },
    {
      "id": WON_OFFICIAL_CONTESTS_LEVEL_1,
      "name": "El Debutante",
      "description": "Ganar el primer torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_OFFICIAL_CONTESTS_LEVEL_1,
      "name": "La Reválida",
      "description": "Jugar 10 torneos oficiales",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": WON_OFFICIAL_CONTESTS_LEVEL_2,
      "name": "La Consolidación",
      "description": "Ganar N torneos oficiales",
      "image": 'IconManagerMister.png',
      "style": 'Oficial'
    },
    {
      "id": FP_OFFICIAL_CONTEST_LEVEL_1,
      "name": "La Gloria",
      "description": "Puntuar más de 1000 FP con un equipo en un torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": DIFF_FP_OFFICIAL_CONTEST_LEVEL_1,
      "name": "Máster",
      "description": "Ganar un torneo oficial por más de 200 FP de diferencia",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": SOCCER_PLAYER_WON_FP_LEVEL_1,
      "name": "El Crack",
      "description": "Un jugador consigue más de 200 FP en un torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": GOALKEEPER_SAVES_SHOTS_LEVEL_1,
      "name": "El Santo",
      "description": "Portero hace más de 20 paradas",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Training'
    },
    {
      "id": GOALKEEPER_0_GOAL_RECEIVED,
      "name": "El Autobús",
      "description": "Portero recibe 0 goles",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": GOALKEEPER_RED_CARD,
      "name": "El Leñero",
      "description": "Portero expulsado",
      "image": 'IconManagerMister.png',
      "style": 'Oficial'
    },
    {
      "id": GOALKEEPER_GOAL_SCORED,
      "name": "Al Ataque",
      "description": "Portero hace gol",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": DEFENDER_INTERCEPTIONS_LEVEL_1,
      "name": "El Muro",
      "description": "Defensa hace más de 30 intercepciones",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": MIDDLE_PASS_SUCCESSFUL_LEVEL_1,
      "name": "El Jugón",
      "description": "Centrocampista hace más de 70 pases",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": FORWARD_GOAL_LEVEL_1,
      "name": "El Pistolero",
      "description": "Delantero hace más de 4 goles",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": ALL_SOCCER_PLAYERS_WITH_FP,
      "name": "El Equipo",
      "description": "Todos los jugadores puntúan",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": TRUE_SKILL_LEVEL_1,
      "name": "Nivel de Skill 1",
      "description": "Nivel de Skill 1",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": TRUE_SKILL_LEVEL_2,
      "name": "Nivel de Skill 2",
      "description": "Nivel de Skill 2",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": TRUE_SKILL_LEVEL_3,
      "name": "Nivel de Skill 3",
      "description": "Nivel de Skill 3",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": TRUE_SKILL_LEVEL_4,
      "name": "Nivel de Skill 4",
      "description": "Nivel de Skill 4",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": TRUE_SKILL_LEVEL_5,
      "name": "Nivel de Skill 5",
      "description": "Nivel de Skill 5",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": MANAGER_LEVEL_3,
      "name": "Nivel de Manager 3",
      "description": "Nivel de Manager 3",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": MANAGER_LEVEL_4,
      "name": "Nivel de Manager 4",
      "description": "Nivel de Manager 4",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    },
    {
      "id": MANAGER_LEVEL_5,
      "name": "Nivel de Manager 5",
      "description": "Nivel de Manager 5",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    }
  ];

}