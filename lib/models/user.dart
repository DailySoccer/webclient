library user;

import 'package:webclient/services/contest_references.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String nickName;
  String email;
  double balance;

  // Numero de veces que el usuario ha ganado un contest
  int wins;

  //String get fullName => "$firstName $lastName";
  String toString() => "$userId - $email - $nickName";
  Map toJson() => {"_id": userId, "firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName};

  User.referenceInit(this.userId);

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
    firstName = jsonMap["firstName"];
    lastName = jsonMap["lastName"];
    nickName = jsonMap["nickName"];

    email = (jsonMap.containsKey("email")) ? jsonMap["email"] : "<email: null>";
    wins = (jsonMap.containsKey("wins")) ? jsonMap["wins"] : 0;
    balance = (jsonMap.containsKey("cachedBalance")) ? double.parse(jsonMap["cachedBalance"]) : 0.0;
    return this;
  }
}