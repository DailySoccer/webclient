library user;

import 'package:json_object/json_object.dart';
import 'package:webclient/services/contest_references.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String nickName;
  String email;

  String get fullName => "$firstName $lastName";
  String toString() => "$userId - $fullName - $email - $nickName";
  Map toJson() => {"_id": userId, "firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName};

  User.referenceInit(this.userId);
  
  // TODO: El User para el jugador principal es cargado sin necesidad de ContestReferences
  factory User.fromJsonObject(JsonObject jsonObject, [ContestReferences references]) {
    if (references == null)
      references = new ContestReferences();
    
    // TODO: storedSessionToken almacena un user sin "_id" (por lo que, sin esta comprobacion, lanza una excepcion)
    String userId = (jsonObject.containsKey("_id"))      ? jsonObject._id 
                  : ((jsonObject.containsKey("userId"))  ? jsonObject.userId 
                  : "<userId: null>");
    User user = references.getUserById(userId);
    return user._initFromJsonObject(jsonObject, references);
  }
  
  User _initFromJsonObject(JsonObject jsonObject, ContestReferences references) {
    assert(userId.isNotEmpty);
    firstName = jsonObject.firstName;
    lastName = jsonObject.lastName;
    nickName = jsonObject.nickName;
    
    email = (jsonObject.containsKey("email")) ? jsonObject.email : "<email: null>";
    return this;
  }
}