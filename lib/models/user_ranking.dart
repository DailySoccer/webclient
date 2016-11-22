library user_ranking;
import 'package:webclient/models/money.dart';

class UserRanking {
  static const String USER_ID = "userId";
  static const String NICKNAME = "nickName";
  static const String TRUESKILL = "trueSkill";
  static const String EARNEDMONEY = "earnedMoney";
  static const String GOLD_RANK = "goldRank";
  static const String SKILL_RANK = "skillRank";
  
  UserRanking();
  
  String get userId => (_userId != null) ? _userId : (_userId = _jsonMap[USER_ID]);
  int get goldRank => (_goldRank >= 0) ? _goldRank : (_goldRank = _jsonMap[GOLD_RANK]);
  int get skillRank => (_skillRank >= 0) ? _skillRank : (_skillRank = _jsonMap[SKILL_RANK]);
  
  String get nickName => (_nickName != null) ? _nickName : (_nickName = _jsonMap[NICKNAME]);
  int get trueSkill => (_trueSkill >= 0) 
      ? _trueSkill 
      : _trueSkill = (_jsonMap.containsKey(TRUESKILL) ? _jsonMap[TRUESKILL] : 0);
  Money get earnedMoney => (_earnedMoney !=null) 
      ? _earnedMoney 
      : _earnedMoney = (_jsonMap.containsKey(EARNEDMONEY) ? new Money.fromJsonObject(_jsonMap[EARNEDMONEY]) : new Money.zero());
  
  factory UserRanking.fromJsonObject(Map jsonMap) {
    UserRanking userRanking = new UserRanking();    
    userRanking._jsonMap = jsonMap;
    return userRanking;
  }

  Map _jsonMap;
  
  String _userId;
  int _goldRank = -1;
  int _skillRank = -1;
  String _nickName;
  int _trueSkill = -1;
  Money _earnedMoney;
}
