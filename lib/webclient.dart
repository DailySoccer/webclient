library webclient;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'package:webclient/mock/mock_server.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/flash_messages_service.dart';

import 'package:webclient/controllers/menu_ctrl.dart';
import 'package:webclient/controllers/login_ctrl.dart';
import 'package:webclient/controllers/signup_ctrl.dart';
import 'package:webclient/controllers/lobby_ctrl.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/controllers/flash_messages_ctrl.dart';

import 'package:webclient/components/main_menu_comp.dart';

// Global variable to hold the url of the app's server
String HostServerUrl;

bool isLocalHost() {
  return (window.location.hostname.contains("127.") || window.location.hostname.contains("localhost"));
}

void setUpHostServerUrl() {
  if (isLocalHost()) {
    HostServerUrl = "http://localhost:9000";
  }
  else {
    HostServerUrl = window.location.origin;
  }
  print("Host: $HostServerUrl");
}

class WebClientApp extends Module {
  WebClientApp() {
    // real: DailySoccerServer / simulation: MockDailySoccerServer
    bind(ServerService, toImplementation: DailySoccerServer);

    bind(ProfileService);
    bind(ContestService);
    bind(FlashMessagesService);

    bind(FlashMessagesCtrl);
    bind(MenuCtrl);
    bind(LoginCtrl);
    bind(SignupCtrl);
    bind(LobbyCtrl);
    bind(EnterContestCtrl);

    bind(MainMenuComp);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toFactory:  (_) => new NgRoutingUsePushState.value(false));
  }
}