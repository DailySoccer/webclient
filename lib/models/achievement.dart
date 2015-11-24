library achievement;
import 'package:webclient/models/user.dart';

class Achievement {
  static const String PLAYED_VIRTUAL_CONTESTS_LEVEL_1 = "PLAYED_5_VIRTUAL_CONTESTS";
  static const String PLAYED_VIRTUAL_CONTESTS_LEVEL_2 = "PLAYED_10_VIRTUAL_CONTESTS";

  static const String WON_VIRTUAL_CONTESTS_LEVEL_1 = "WON_1_VIRTUAL_CONTEST";
  static const String WON_VIRTUAL_CONTESTS_LEVEL_5 = "WON_5_VIRTUAL_CONTESTS";
  static const String WON_VIRTUAL_CONTESTS_LEVEL_10 = "WON_10_VIRTUAL_CONTESTS";

  static const String FP_VIRTUAL_CONTEST_LEVEL_1 = "FP_500_VIRTUAL_CONTEST";
  static const String FP_VIRTUAL_CONTEST_LEVEL_2 = "FP_700_VIRTUAL_CONTEST";
  static const String FP_VIRTUAL_CONTEST_LEVEL_3 = "FP_1000_VIRTUAL_CONTEST";

  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_1 = "DIFF_FP_100_VIRTUAL_CONTEST";
  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_2 = "DIFF_FP_200_VIRTUAL_CONTEST";
  static const String DIFF_FP_VIRTUAL_CONTEST_LEVEL_3 = "DIFF_FP_300_VIRTUAL_CONTEST";


  static const String PLAYED_OFFICIAL_CONTESTS_LEVEL_1 = "PLAYED_5_OFFICIAL_CONTESTS";
  static const String PLAYED_OFFICIAL_CONTESTS_LEVEL_2 = "PLAYED_10_OFFICIAL_CONTESTS";

  static const String WON_OFFICIAL_CONTESTS_LEVEL_1 = "WON_1_OFFICIAL_CONTEST";
  static const String WON_OFFICIAL_CONTESTS_LEVEL_5 = "WON_5_OFFICIAL_CONTESTS";
  static const String WON_OFFICIAL_CONTESTS_LEVEL_10 = "WON_10_OFFICIAL_CONTESTS";

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
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "xcv",
      "description": "qweqweqweqwe",
      "image": '',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "ser",
      "description": "eeeeeeee",
      "image": '',
      "style": 'Oficial'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "sds",
      "description": "ddddddd",
      "image": '',
      "style": 'Oficial'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "cccccccc",
      "image": '',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerMister.png',
      "style": 'Training'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerMister.png',
      "style": 'Oficial'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerPrincipiante.png',
      "style": 'Player'
    },
    {
      "id": PLAYED_VIRTUAL_CONTESTS_LEVEL_1,
      "name": "asd",
      "description": "qweqweqweqwe",
      "image": 'IconManagerPrincipiante.png',
      "style": 'SkillLevel'
    }
  ];

}