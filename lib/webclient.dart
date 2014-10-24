library webclient;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/webclient_router.dart';

import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/scoring_rules_service.dart';

import 'package:webclient/logger_exception_handler.dart';

import 'package:webclient/utils/limit_to_dot.dart';
import 'package:webclient/utils/form-autofill-fix.dart';

import 'package:webclient/components/flash_messages_comp.dart';
import 'package:webclient/components/landing_page_comp.dart';
import 'package:webclient/components/navigation/main_menu_slide_comp.dart';
import 'package:webclient/components/navigation/footer_comp.dart';

import 'package:webclient/components/contest_info_comp.dart';
import 'package:webclient/components/scoring_rules_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
import 'package:webclient/components/my_contests_comp.dart';
import 'package:webclient/components/contests_list_comp.dart';
import 'package:webclient/components/promos_comp.dart';
import 'package:webclient/components/paginator_comp.dart';
import 'package:webclient/components/global_connection_comp.dart';
import 'package:webclient/components/loading_comp.dart';

import 'package:webclient/components/account/login_comp.dart';
import 'package:webclient/components/account/join_comp.dart';


class WebClientApp extends Module {
  WebClientApp() {

    bind(ExceptionHandler, toImplementation: LoggerExceptionHandler);
    bind(ServerService, toImplementation: DailySoccerServer);

    bind(ScreenDetectorService);
    bind(LoadingService);
    bind(RefreshTimersService);
    bind(DateTimeService);
    bind(ProfileService);
    bind(ActiveContestsService);
    bind(MyContestsService);
    bind(SoccerPlayerService);
    bind(FlashMessagesService);
    bind(ScoringRulesService);

    bind(LimitToDot);
    bind(FormAutofillDecorator);

    bind(LandingPageComp);
    bind(MainMenuSlideComp);
    bind(FooterComp);
    bind(FlashMessageComp);

    bind(ContestInfoComp);
    bind(ScoringRulesComp);

    bind(ContestsListComp);
    bind(LobbyComp);
    bind(PromosComp);
    bind(PaginatorComp);

    bind(MyContestsComp);

    bind(LoginComp);
    bind(JoinComp);

    bind(GlobalConnectionComp);
    bind(LoadingComp);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }
}