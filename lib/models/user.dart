library user;

import 'package:json_object/json_object.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  String nickName;

  String get fullName => "$firstName $lastName";
  String toString() => "$fullName - $email - $nickName";
  Map toJson() => {"_id": userId, "firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName};

  User.fromJsonObject(JsonObject jsonObject) {
    // TODO: storedSessionToken almacena un user sin "_id" (por lo que, sin esta comprobacion, lanza una excepcion)
    if (jsonObject.containsKey("_id"))
      userId = jsonObject._id;
    firstName = jsonObject.firstName;
    lastName = jsonObject.lastName;
    email = jsonObject.email;
    nickName = jsonObject.nickName;
  }

  User.fromJsonString(String jsonString) : this.fromJsonObject(new JsonObject.fromJsonString(jsonString));
}