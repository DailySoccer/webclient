library user;

import 'dart:async';
import 'dart:html';

import '../webclient.dart';

class User {
  String fullName;
  String email;
  String nickName;
  String password;
  
  bool isRegistered = false;
  bool isLogin = false;
  
  String toString() => "$fullName - $email - $nickName - $password";
  
  Future register() {
    print("Register: $this");
    
    var dataUrl = "$HostServer/signup";
    var data = {'fullName': fullName, 'email': email, 'nickName': nickName, 'password': password};
    
    return HttpRequest.postFormData(dataUrl, data)
        .then( (HttpRequest request) {
          _registerEnd( request );
        }).catchError((error) {
          print("Register Error: " + error.target.responseText);
        });
   }

  Future login() {
    print("Login: $email - $password");
    
    var dataUrl = "$HostServer/login";
    var data = {'email': email, 'password': password};
    
    return HttpRequest.postFormData(dataUrl, data)
        .then( (HttpRequest request) {
          _loginEnd( request );
        }).catchError((error) {
          print("Login Error: " + error.target.responseText);
        });
   }
  
  Future profile() {
    print("Profile");
    
    var dataUrl = "$HostServer/user_profile";
    
    return HttpRequest.getString(dataUrl)
        .then( (String result) {
          print( result );
        }).catchError((error) {
          print("Profile Error: " + error.target.responseText);
        });
  }
  
  _registerEnd(HttpRequest request) {
    if (request.status != 200) {
      print('Register: Error: ${request.status}');
    } else {
      print('Register OK');
      isRegistered = true;
      isLogin = true;
    }
  }
  
  _loginEnd(HttpRequest request) {
    if (request.status != 200) {
      print('Login: Error: ${request.status}');
    } else {
      print('Login OK');
      isLogin = true;
    }
  }
  
}