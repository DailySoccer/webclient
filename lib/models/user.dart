library user;

import 'package:webclient/services/contest_references.dart';
import 'package:webclient/models/money.dart';
import 'package:logging/logging.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:intl/intl.dart';
import 'package:webclient/models/user_notification.dart';

class User {
  static const int MINUTES_TO_RELOAD_ENERGY = 60;
  static const num MAX_ENERGY = 10;

  static List MANAGER_POINTS = [
    0, 65, 125, 250, 500, 1000
  ];

  static num get MAX_MANAGER_LEVEL => MANAGER_POINTS.length - 1;

  String userId;
  String firstName;
  String lastName;
  String nickName;
  String email;
  Money balance;
  Money goldBalance;
  Money managerBalance;
  Money energyBalance;

  num managerLevel;
  int get pointsToNextLevel {
    int level = managerLevel.toInt();
    return (level == 5) ? MANAGER_POINTS[5] : MANAGER_POINTS[level+1];
  }

  DateTime lastUpdatedEnergy;

  // Numero de veces que el usuario ha ganado un contest
  int wins;
  int trueSkill;
  Money earnedMoney;

  Set<String> achievements = new Set<String>();
  List<UserNotification> notifications = new List<UserNotification>();

  bool hasAchievement(String achievement) => achievements.contains(achievement);

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

  NumberFormat nfTime = new NumberFormat("00");
  String get printableEnergyTimeLeft {
    String result = "";
    if (energyBalance.amount < MAX_ENERGY) {
      int seconds = EnergyTimeLeft;
      result = "${nfTime.format(seconds~/60)}:${nfTime.format(seconds%60)}";
    }
    return result;
  }

  int get EnergyTimeLeft {
    int time = (energyBalance.amount < MAX_ENERGY)
        ? (MINUTES_TO_RELOAD_ENERGY * 60) - DateTimeService.now.difference(lastUpdatedEnergy).inSeconds
        : 0;
    if (time < 0) {
      energyRefresh();
      time = EnergyTimeLeft;
    }
    return time;
  }

  Money energyRefresh() {
    // Si la energía no la tenemos completamente recargada, miramos si ha pasado suficiente tiempo desde que se usó
    if (energyBalance.amount < MAX_ENERGY) {
      // Cuánta energía ha recuperado desde que se usó?
      int lastUpdatedMinutes = DateTimeService.now.difference(lastUpdatedEnergy).inMinutes;
      int energyPlus = lastUpdatedMinutes ~/ MINUTES_TO_RELOAD_ENERGY;

      if (energyPlus > 0) {
        energyBalance.amount += energyPlus;
        energyBalance.amount = energyBalance.amount.clamp(0.0, MAX_ENERGY);

        lastUpdatedEnergy = lastUpdatedEnergy.add(new Duration(minutes: energyPlus * MINUTES_TO_RELOAD_ENERGY));
      }
    }
    return energyBalance;
  }

  int get Gold => goldBalance.amount.toInt();
  int get ManagerPoints => managerBalance.amount.toInt();
  int get Energy => energyRefresh().amount.toInt();
  int get EnergyMax => MAX_ENERGY;

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

    trueSkill = (jsonMap.containsKey("trueSkill")) ? jsonMap["trueSkill"] : 0;
    earnedMoney = jsonMap.containsKey("earnedMoney") ? new Money.fromJsonObject(jsonMap["earnedMoney"]) : new Money.zero();

    goldBalance = jsonMap.containsKey("goldBalance") ? new Money.fromJsonObject(jsonMap["goldBalance"]) : new Money.zeroFrom(Money.CURRENCY_GOLD);
    managerBalance = jsonMap.containsKey("managerBalance") ? new Money.fromJsonObject(jsonMap["managerBalance"]) : new Money.zeroFrom(Money.CURRENCY_MANAGER);
    energyBalance = jsonMap.containsKey("energyBalance") ? new Money.fromJsonObject(jsonMap["energyBalance"]) : new Money.zeroFrom(Money.CURRENCY_ENERGY);

    managerLevel = jsonMap.containsKey("managerLevel") ? jsonMap["managerLevel"] : 0;

    /*
    if (jsonMap.containsKey("managerLevel")) {
      Logger.root.info("Manager: $managerLevel Points: ${managerBalance.amount} Next Level: $pointsToNextLevel");
    }
     */

    if (jsonMap.containsKey("lastUpdatedEnergy") && jsonMap["lastUpdatedEnergy"] != null) {
      lastUpdatedEnergy = DateTimeService.fromMillisecondsSinceEpoch(jsonMap["lastUpdatedEnergy"]);
      energyRefresh();
    }
    else {
      // Si no existe la fecha de la última actualización de la energía es que no ha gastado nada...
      lastUpdatedEnergy = new DateTime.now();
      energyBalance = new Money.from(Money.CURRENCY_ENERGY, MAX_ENERGY);
    }

    if (jsonMap.containsKey("achievements")) {
      achievements = new Set<String>();

      List<String> achievementList = jsonMap["achievements"];
      achievementList.forEach( (achievementId) => achievements.add(achievementId) );
    }

    if (jsonMap.containsKey("notifications")) {
      notifications = jsonMap["notifications"].map((jsonMap) => new UserNotification.fromJsonObject(jsonMap) ).toList();

      // Ordenarlos en orden decreciente (reciente -> antiguo)
      notifications.sort((el1, el2) => el2.createdAt.compareTo(el1.createdAt));
    }

    return this;
  }

  // Eliminar temporalmente del usuario la notificación (a la espera de que el servidor mande una versión actualizada)
  void removeNotification(String notificationId) {
    notifications.removeWhere((notification) => notification.id == notificationId);
  }
}