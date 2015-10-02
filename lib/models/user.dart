library user;

import 'package:webclient/services/contest_references.dart';
import 'package:webclient/models/money.dart';
import 'package:logging/logging.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String nickName;
  String email;
  Money balance;
  Money bonus;
  Money goldBalance;
  Money managerBalance;
  Money energyBalance;

  // Numero de veces que el usuario ha ganado un contest
  int wins;
  int trueSkill;
  Money earnedMoney;

  //String get fullName => "$firstName $lastName";
  String toString() => "$userId - $email - $nickName";
  Map toJson() => {"_id": userId, "firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName};

  User.referenceInit(this.userId);

  bool hasMoney(Money money) {
    if (money.isGold) {
      return goldBalance >= money;
    }
    else if (money.isManagerPoints) {
      return managerBalance >= money;
    }
    else if (money.isEnergy) {
      return energyBalance >= money;
    }

    Logger.root.severe("User ${userId} not has Money ${money}");
    return false;
  }

  // TODO: El User para el jugador principal es cargado sin necesidad de ContestReferences
  factory User.fromJsonObject(Map jsonMap, [ContestReferences references]) {
    if (references == null)
      references = new ContestReferences();

    // En nuestro localStorage se almacena un user serializado directamente de esta clase, asi que tendra
    // un campo userId. Sin embargo, del servidor los ids siempre nos llegan en el campo _id. Asi que tenemos
    // que hacer esta comprobacion, pq a veces el user nos llega desde el servidor y otras desde el localStorage
    String userId = (jsonMap.containsKey("_id"))      ? jsonMap["_id"]
                  : ((jsonMap.containsKey("userId"))  ? jsonMap["userId"]
                  : "<userId: null>");

    User user = references.getUserById(userId);
    return user._initFromJsonObject(jsonMap, references);
  }

  User _initFromJsonObject(Map jsonMap, ContestReferences references) {
    assert(userId.isNotEmpty);
    firstName = (jsonMap.containsKey("firstName")) ? jsonMap["firstName"] : "";
    lastName = (jsonMap.containsKey("lastName")) ? jsonMap["lastName"] : "";
    nickName = jsonMap["nickName"];

    email = (jsonMap.containsKey("email")) ? jsonMap["email"] : "<email: null>";
    wins = (jsonMap.containsKey("wins")) ? jsonMap["wins"] : 0;
    balance = jsonMap.containsKey("cachedBalance") ? new Money.fromJsonObject(jsonMap["cachedBalance"]) : new Money.zero();
    bonus = jsonMap.containsKey("cachedBonus") ? new Money.fromJsonObject(jsonMap["cachedBonus"]) : new Money.zero();

    trueSkill = (jsonMap.containsKey("trueSkill")) ? jsonMap["trueSkill"] : 0;
    earnedMoney = jsonMap.containsKey("earnedMoney") ? new Money.fromJsonObject(jsonMap["earnedMoney"]) : new Money.zero();
    
    goldBalance = jsonMap.containsKey("goldBalance") ? new Money.fromJsonObject(jsonMap["goldBalance"]) : new Money.zeroFrom(Money.CURRENCY_GOLD);
    managerBalance = jsonMap.containsKey("managerBalance") ? new Money.fromJsonObject(jsonMap["managerBalance"]) : new Money.zeroFrom(Money.CURRENCY_MANAGER);
    energyBalance = jsonMap.containsKey("energyBalance") ? new Money.fromJsonObject(jsonMap["energyBalance"]) : new Money.zeroFrom(Money.CURRENCY_ENERGY);
    return this;
  }
}