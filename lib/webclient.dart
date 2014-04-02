library webclient;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'models/user.dart';

import 'controllers/login_ctrl.dart';
import 'controllers/register_ctrl.dart';

String HostServer = window.location.origin;
String LocalHostServer = "http://localhost:3000";

// REVIEW:...
User user = new User();


String encodeMap(Map data) {
  return data.keys.map((k) {
    return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
  }).join('&');
}

bool isLocalHost() {
  return ( window.location.hostname.contains("127.") || window.location.hostname.contains("localhost") );
}


class WebClientApp extends Module {
  WebClientApp() {
    type(LoginCtrl);
    type(RegisterCtrl);
    
    value(RouteInitializerFn, webClientRouteInitializer);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
  }
}

startWebClientApp(){
  
  if ( isLocalHost() ) {
    HostServer = LocalHostServer;
  }
  /*
  if ( !identical(1, 1.0) ) { // XXX: horrible hack to detect if we're in JS -- Src: Seth Ladd / Google
    DomainApp = "http://localhost:3000";
  }
  */
  print( "Host: $HostServer" );
  
  ngBootstrap(module: new WebClientApp());
}