library webclient;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'controllers/login_ctrl.dart';
import 'controllers/register_ctrl.dart';

const String DomainApp = "http://dailysoccer.herokuapp.com";

String encodeMap(Map data) {
  return data.keys.map((k) {
    return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
  }).join('&');
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
  ngBootstrap(module: new WebClientApp());
}