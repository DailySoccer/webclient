library achievement;
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';

class Achievement {
  static const String PLAYED_VIRTUAL_CONTESTS_LEVEL_1 = "PLAYED_10_VIRTUAL_CONTESTS";

  static const String WON_VIRTUAL_CONTESTS_LEVEL_1 = "WON_1_VIRTUAL_CONTEST";
  static const String WON_VIRTUAL_CONTESTS_LEVEL_2 = "WON_10_VIRTUAL_CONTESTS";

  static const String FP_VIRTUAL_CONTEST_LEVEL_1 = "FP_1000_VIRTUAL_CONTEST";

  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_1 = "DIFF_FP_200_VIRTUAL_CONTEST";


  static const String PLAYED_OFFICIAL_CONTESTS_LEVEL_1 = "PLAYED_10_OFFICIAL_CONTESTS";

  static const String WON_OFFICIAL_CONTESTS_LEVEL_1 = "WON_1_OFFICIAL_CONTEST";
  static const String WON_OFFICIAL_CONTESTS_LEVEL_2 = "WON_10_OFFICIAL_CONTESTS";

  static const String FP_OFFICIAL_CONTEST_LEVEL_1 = "FP_1000_OFFICIAL_CONTEST";

  static const String DIFF_FP_OFFICIAL_CONTEST_LEVEL_1 = "DIFF_FP_200_OFFICIAL_CONTEST";

  static const String MANAGER_LEVEL_3 = "MANAGER_LEVEL_3";
  static const String MANAGER_LEVEL_4 = "MANAGER_LEVEL_4";
  static const String MANAGER_LEVEL_5 = "MANAGER_LEVEL_5";

  static const String TRUE_SKILL_LEVEL_1 = "TRUE_SKILL_500";
  static const String TRUE_SKILL_LEVEL_2 = "TRUE_SKILL_1000";
  static const String TRUE_SKILL_LEVEL_3 = "TRUE_SKILL_2000";
  static const String TRUE_SKILL_LEVEL_4 = "TRUE_SKILL_3000";
  static const String TRUE_SKILL_LEVEL_5 = "TRUE_SKILL_4000";

  static const String ALL_SOCCER_PLAYERS_WITH_FP = "ALL_SOCCER_PLAYERS_WITH_FP";

  static const String SOCCER_PLAYER_WON_FP_LEVEL_1 = "SOCCER_PLAYER_WON_FP_200";

  static const String GOALKEEPER_SAVES_SHOTS_LEVEL_1 = "GOALKEEPER_SAVES_20_SHOTS";
  static const String GOALKEEPER_0_GOAL_RECEIVED = "GOALKEEPER_0_GOAL_RECEIVED";
  static const String GOALKEEPER_RED_CARD = "GOALKEEPER_RED_CARD";
  static const String GOALKEEPER_GOAL_SCORED = "GOALKEEPER_GOAL_SCORED";

  static const String DEFENDER_INTERCEPTIONS_LEVEL_1 = "DEFENDER_30_INTERCEPTIONS";

  static const String MIDDLE_PASS_SUCCESSFUL_LEVEL_1 = "MIDDLE_70_PASS_SUCCESSFUL";

  static const String FORWARD_GOAL_LEVEL_1 = "FORWARD_4_GOALS";

  String id;
  String name;
  String description;
  String image;
  String style;
  int level;

  static const BASIC_STYLE = "basic";
  static const ORANGE_STYLE = "orange";

  bool earnedByUser(User user) => user.achievements.contains(id);

  Achievement({String id: "", String name: "", String description: "", String image: "", String style: BASIC_STYLE, int level: -1}) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.style = style;
    this.level = level;
  }

  Achievement.fromJsonObject(Map jsonMap) {
    id = jsonMap["id"];
    name = jsonMap.containsKey("name") ? jsonMap["name"] : "";
    description = jsonMap.containsKey("description") ? jsonMap["description"] : "";
    image = jsonMap.containsKey("image") ? jsonMap["image"] : "";
    style = jsonMap.containsKey("style") ? jsonMap["style"] : "";
    level = jsonMap.containsKey("level") ? jsonMap["level"] : -1;
  }

  static String translate(String key) => StringUtils.translate(key, "achievements");
  
  static Achievement getAchievementWithKey(String key){
    return new Achievement.fromJsonObject(AVAILABLES.firstWhere((achievementMap) => achievementMap['id'] == key));
  }

  static List<Map> AVAILABLES = [
    {
      "id": WON_VIRTUAL_CONTESTS_LEVEL_1,
      "name": translate("name_won_virtual_contests_level_1"), // "El Principiante",
      "description": translate("desc_won_virtual_contests_level_1"), // "Ganar el primer torneo virtual",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": translate("name_played_virtual_contests_level_1"), // "Superentreno",
      "description": translate("desc_played_virtual_contests_level_1"), // "Jugar 10 torneos virtuales",
      "image": '',
      "style": 'Training'
    },
    {
      "id": WON_VIRTUAL_CONTESTS_LEVEL_2,
      "name": translate("name_won_virtual_contests_level_2"), // "El Hacha",
      "description": translate("desc_won_virtual_contests_level_2"), //"Ganar 10 torneos virtuales",
      "image": '',
      "style": 'Training'
    },
    {
      "id": FP_VIRTUAL_CONTEST_LEVEL_1,
      "name": translate("name_fp_virtual_contest_level_1"), // "El Resultón",
      "description": translate("desc_fp_virtual_contest_level_1"), // "Puntuar más de 1000 FP con un equipo en un torneo virtual",
      "image": '',
      "style": 'Training'
    },
    {
      "id": DIFF_FP_VIRTUAL_CONTEST_LEVEL_1,
      "name": translate("name_diff_fp_virtual_contest_level_1"), // "El Míster",
      "description": translate("desc_diff_fp_virtual_contest_level_1"), // "Ganar un torneo virtual por más de 200 FP de diferencia",
      "image": '',
      "style": 'Training'
    },
    {
      "id": WON_OFFICIAL_CONTESTS_LEVEL_1,
      "name": translate("name_won_official_contests_level_1"), // "El Debutante",
      "description": translate("desc_won_official_contests_level_1"), // "Ganar el primer torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Oficial'
    },
    {
      "id": PLAYED_OFFICIAL_CONTESTS_LEVEL_1,
      "name": translate("name_played_official_contests_level_1"), // "La Reválida",
      "description": translate("desc_played_official_contests_level_1"), // "Jugar 10 torneos oficiales",
      "image": 'IconManagerMister.png',
      "style": 'Oficial'
    },
    {
      "id": WON_OFFICIAL_CONTESTS_LEVEL_2,
      "name": translate("name_played_official_contests_level_2"), // "La Consolidación",
      "description": translate("desc_played_official_contests_level_2"), // "Ganar N torneos oficiales",
      "image": 'IconManagerMister.png',
      "style": 'Oficial'
    },
    {
      "id": FP_OFFICIAL_CONTEST_LEVEL_1,
      "name": translate("name_fp_official_contest_level_1"), // "La Gloria",
      "description": translate("desc_fp_official_contest_level_1"), // "Puntuar más de 1000 FP con un equipo en un torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Oficial'
    },
    {
      "id": DIFF_FP_OFFICIAL_CONTEST_LEVEL_1,
      "name": translate("name_diff_fp_official_contest_level_1"), // "Máster",
      "description": translate("desc_diff_fp_official_contest_level_1"), // "Ganar un torneo oficial por más de 200 FP de diferencia",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Oficial'
    },
    {
      "id": SOCCER_PLAYER_WON_FP_LEVEL_1,
      "name": translate("name_soccer_player_won_fp_level_1"), // "El Crack",
      "description": translate("desc_soccer_player_won_fp_level_1"), // "Un jugador consigue más de 200 FP en un torneo oficial",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": GOALKEEPER_SAVES_SHOTS_LEVEL_1,
      "name": translate("name_goalkeeper_saves_shots_level_1"), // "El Santo",
      "description": translate("desc_goalkeeper_saves_shots_level_1"), // "Portero hace más de 20 paradas",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": GOALKEEPER_0_GOAL_RECEIVED,
      "name": translate("name_goalkeeper_0_goal_received"), // "El Autobús",
      "description": translate("desc_goalkeeper_0_goal_received"), // "Portero recibe 0 goles",
      "image": 'IconManagerMister.png',
      "style": 'Player'
    },
    {
      "id": GOALKEEPER_RED_CARD,
      "name": translate("name_goalkeeper_red_card"), // "El Leñero",
      "description": translate("desc_goalkeeper_red_card"), // "Portero expulsado",
      "image": 'IconManagerMister.png',
      "style": 'Player'
    },
    {
      "id": GOALKEEPER_GOAL_SCORED,
      "name": translate("name_goalkeeper_goal_scored"), // "Al Ataque",
      "description": translate("desc_goalkeeper_goal_scored"), // "Portero hace gol",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": DEFENDER_INTERCEPTIONS_LEVEL_1,
      "name": translate("name_defender_interceptions_level_1"), // "El Muro",
      "description": translate("desc_defender_interceptions_level_1"), // "Defensa hace más de 30 intercepciones",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": MIDDLE_PASS_SUCCESSFUL_LEVEL_1,
      "name": translate("name_middle_pass_successful_level_1"), // "El Jugón",
      "description": translate("desc_middle_pass_successful_level_1"), // "Centrocampista hace más de 70 pases",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": FORWARD_GOAL_LEVEL_1,
      "name": translate("name_forward_goal_level_1"), // "El Pistolero",
      "description": translate("desc_forward_goal_level_1"), // "Delantero hace más de 4 goles",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": ALL_SOCCER_PLAYERS_WITH_FP,
      "name": translate("name_all_soccer_players_with_fp"), // "El Equipo",
      "description": translate("desc_all_soccer_players_with_fp"), // "Todos los jugadores puntúan",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": TRUE_SKILL_LEVEL_1,
      "name": translate("name_true_skill_level_1"), // "Nivel de Skill 1",
      "description": translate("desc_true_skill_level_1"), // "Nivel de Skill 1",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel',
      "level": 1
    },
    {
      "id": TRUE_SKILL_LEVEL_2,
      "name": translate("name_true_skill_level_2"), // "Nivel de Skill 2",
      "description": translate("desc_true_skill_level_2"), // "Nivel de Skill 2",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel',
      "level": 2
    },
    {
      "id": TRUE_SKILL_LEVEL_3,
      "name": translate("name_true_skill_level_3"), // "Nivel de Skill 3",
      "description": translate("desc_true_skill_level_3"), // "Nivel de Skill 3",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel',
      "level": 3
    },
    {
      "id": TRUE_SKILL_LEVEL_4,
      "name": translate("name_true_skill_level_4"), // "Nivel de Skill 4",
      "description": translate("desc_true_skill_level_4"), // "Nivel de Skill 4",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel',
      "level": 4
    },
    {
      "id": TRUE_SKILL_LEVEL_5,
      "name": translate("name_true_skill_level_5"), // "Nivel de Skill 5",
      "description": translate("desc_true_skill_level_5"), // "Nivel de Skill 5",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel',
      "level": 5
    },
    {
      "id": MANAGER_LEVEL_3,
      "name": translate("name_manager_level_3"), // "Nivel de Manager 3",
      "description": translate("desc_manager_level_3"), // "Nivel de Manager 3",
      "image": 'IconManagerPrincipiante.png',
      "style": 'ManagerLevel',
      "level": 3
    },
    {
      "id": MANAGER_LEVEL_4,
      "name": translate("name_manager_level_4"), // "Nivel de Manager 4",
      "description": translate("desc_manager_level_4"), // "Nivel de Manager 4",
      "image": 'IconManagerPrincipiante.png',
      "style": 'ManagerLevel',
      "level": 4
    },
    {
      "id": MANAGER_LEVEL_5,
      "name": translate("name_manager_level_5"), // "Nivel de Manager 5",
      "description": translate("desc_manager_level_5"), // "Nivel de Manager 5",
      "image": 'IconManagerPrincipiante.png',
      "style": 'ManagerLevel',
      "level": 5
    }
  ];

}