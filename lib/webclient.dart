library webclient;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'services/profile_service.dart';
import 'services/match_service.dart';
import 'services/match_group_service.dart';
import 'services/contest_service.dart';
import 'services/contest_entry_service.dart';
import 'services/server_service.dart';
import 'services/flash_messages_service.dart';

import 'controllers/flash_messages_ctrl.dart';

import 'controllers/menu_ctrl.dart';
import 'controllers/login_ctrl.dart';
import 'controllers/signup_ctrl.dart';
import 'controllers/lobby_ctrl.dart';
import 'controllers/enter_contest_ctrl.dart';

String HostServer = window.location.origin;


String encodeMap(Map data) {
  return data.keys.map((k) {
    return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
  }).join('&');
}

bool isLocalHost() {
  return (window.location.hostname.contains("127.") || window.location.hostname.contains("localhost"));
}


class WebClientApp extends Module {
  WebClientApp() {
    // real: DailySoccerServer / simulation: MockDailySoccerServer
    bind(ServerService, toImplementation: DailySoccerServer);

    bind(ProfileService);
    bind(MatchService);
    bind(MatchGroupService);
    bind(ContestService);
    bind(ContestEntryService);
    bind(FlashMessagesService);

    bind(MenuCtrl);
    bind(LoginCtrl);
    bind(SignupCtrl);
    bind(LobbyCtrl);
    bind(EnterContestCtrl);
    bind(FlashMessagesCtrl);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toFactory:  (_) => new NgRoutingUsePushState.value(false));
  }
}

startWebClientApp() {

  if (isLocalHost()) {
    HostServer = _LocalHostServer;
  }
  print("Host: $HostServer");

  applicationFactory().addModule(new WebClientApp()).run();
}

String _LocalHostServer = "http://localhost:9000";
