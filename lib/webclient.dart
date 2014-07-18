library webclient;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/routing/webclient_router.dart';

import 'package:webclient/mock/mock_server.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

import 'package:webclient/controllers/login_ctrl.dart';
import 'package:webclient/controllers/signup_ctrl.dart';
import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/controllers/live_contest_ctrl.dart';
import 'package:webclient/controllers/flash_messages_ctrl.dart';

import 'package:webclient/components/landing_page_comp.dart';
import 'package:webclient/components/main_menu_comp.dart';
import 'package:webclient/components/contest_info_comp.dart';
import 'package:webclient/components/contest_header_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
import 'package:webclient/components/fantasy_team_comp.dart';
import 'package:webclient/components/live_contest_comp.dart';
import 'package:webclient/components/users_list_comp.dart';
import 'package:webclient/components/soccer_players_list_comp.dart';
import 'package:webclient/components/lineup_selector_comp.dart';
import 'package:webclient/components/my_contests_comp.dart';
import 'package:webclient/components/contests_list_comp.dart';

import 'package:webclient/directives/form-autofill-fix.dart';

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
    bind(ActiveContestsService);
    bind(MyContestsService);
    bind(FlashMessagesService);
    bind(ScreenDetectorService);

    bind(FlashMessagesCtrl);
    bind(LoginCtrl);
    bind(SignupCtrl);
    bind(EnterContestCtrl);
    bind(LiveContestCtrl);

    bind(LandingPageComp);
    bind(MainMenuComp);
    bind(ContestInfoComp);
    bind(ContestHeaderComp);
    bind(FantasyTeamComp);
    bind(LiveContestComp);
    bind(UsersListComp);
    bind(SoccerPlayersListComp);
    bind(LineupSelectorComp);

    bind(MyContestsComp);
    bind(ContestsListComp);
    bind(LobbyComp);

    bind(FormAutofillDecorator);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toFactory:  (_) => new NgRoutingUsePushState.value(false));
  }
}