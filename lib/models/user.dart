library user;

import 'package:json_object/json_object.dart';

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
  
  User.fromJsonObject(JsonObject jsonObject) {
    // TODO: storedSessionToken almacena un user sin "_id" (por lo que, sin esta comprobacion, lanza una excepcion)
    userId = (jsonObject.containsKey("_id"))      ? jsonObject._id 
           : ((jsonObject.containsKey("userId"))  ? jsonObject.userId 
           : "<userId: null>");
    
    firstName = jsonObject.firstName;
    lastName = jsonObject.lastName;
    nickName = jsonObject.nickName;
    
    email = (jsonObject.containsKey("email")) ? jsonObject.email : "<email: null>";
  }
  
  User.fromJsonString(String jsonString) : this.fromJsonObject(new JsonObject.fromJsonString(jsonString));
}