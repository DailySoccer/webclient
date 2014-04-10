library webclient;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'services/user_manager.dart';
import 'services/match_manager.dart';
import 'services/group_manager.dart';
import 'services/contest_manager.dart';
import 'services/contest_entry_manager.dart';

import 'controllers/user_ctrl.dart';
import 'controllers/login_ctrl.dart';
import 'controllers/register_ctrl.dart';
import 'controllers/lobby_ctrl.dart';
import 'controllers/team_ctrl.dart';

String HostServer = window.location.origin;
String LocalHostServer = "http://localhost:9000";

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
    type(UserManager);
    type(MatchManager);
    type(GroupManager);
    type(ContestManager);
    type(ContestEntryManager);
    
    type(UserCtrl);
    type(LoginCtrl);
    type(RegisterCtrl);
    type(LobbyCtrl);
    type(TeamCtrl);
    
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