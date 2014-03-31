library User;

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
  
  registerEnd(HttpRequest request) {
    if (request.status != 200) {
      print('Register: Uh oh, there was an error of ${request.status}');
    } else {
      print('Register OK: Data has been posted');
      isRegistered = true;
    }
  }
  
  Future register() {
    print("Register: $this");
    
    var dataUrl = "$DomainApp/register";
    var data = {'fullName': fullName, 'email': email, 'nickName': nickName, 'password': password};
    
    /*
    var encodedData = encodeMap(data);

    var httpRequest = new HttpRequest();
    httpRequest.open('POST', dataUrl);
    httpRequest.setRequestHeader('Content-type',
                                 'application/x-www-form-urlencoded');
    httpRequest.onLoadEnd.listen((e) => registerEnd(httpRequest));
    httpRequest.send(encodedData);
    */
    
    return HttpRequest.postFormData(dataUrl, data)
        .then( (HttpRequest request) {
          registerEnd( request );
        }).catchError((error) {
            print("Error: " + error.target.responseText); // Current target should be you HttpRequest
        });
   }

  loginEnd(HttpRequest request) {
    if (request.status != 200) {
      print('Login: Uh oh, there was an error of ${request.status}');
    } else {
      print('Login OK: Data has been posted');
      isLogin = true;
    }
  }
  
  Future login() {
    print("Login: $email - $password");
    
    var dataUrl = "$DomainApp/login";
    var data = {'email': email, 'password': password};
    
    return HttpRequest.postFormData(dataUrl, data)
        .then( (HttpRequest request) {
          loginEnd( request );
        }).catchError((error) {
            print("Login Error: " + error.target.responseText); // Current target should be you HttpRequest
        });
   }
}