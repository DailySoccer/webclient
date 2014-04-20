library user;
import 'package:json_object/json_object.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String nickName;

  String get fullName => "$firstName $lastName";
  String toString() => "$fullName - $email - $nickName";
  Map toJson() => {"firstName": firstName, "lastName": lastName, "email": email, "nickName": nickName};

  User.initFromJSONObject(JsonObject jsonObject) {
    firstName = jsonObject.firstName;
    lastName = jsonObject.lastName;
    email = jsonObject.email;
    nickName = jsonObject.nickName;
  }

  User.initFromJSONString(String jsonString) : this(new JsonObject.fromJsonString(jsonString));
}