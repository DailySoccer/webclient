library webclient;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:webclient/webclient_router.dart';

import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/logger_exception_handler.dart';

import 'package:webclient/utils/limit_to_dot.dart';

import 'package:webclient/controllers/enter_contest_ctrl.dart';
import 'package:webclient/controllers/view_contest_ctrl.dart';

import 'package:webclient/components/flash_messages_comp.dart';
import 'package:webclient/components/landing_page_comp.dart';
import 'package:webclient/components/main_menu_comp.dart';
import 'package:webclient/components/main_menu_slide_comp.dart';
import 'package:webclient/components/contest_info_comp.dart';
import 'package:webclient/components/soccer_player_info_comp.dart';
import 'package:webclient/components/contest_header_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
import 'package:webclient/components/fantasy_team_comp.dart';
import 'package:webclient/components/users_list_comp.dart';
import 'package:webclient/components/soccer_players_list_comp.dart';
import 'package:webclient/components/lineup_selector_comp.dart';
import 'package:webclient/components/my_contests_comp.dart';
import 'package:webclient/components/contests_list_comp.dart';
import 'package:webclient/components/promos_comp.dart';
import 'package:webclient/components/footer_comp.dart';
import 'package:webclient/components/paginator_comp.dart';
import 'package:webclient/components/login_comp.dart';
import 'package:webclient/components/join_comp.dart';
import 'package:webclient/components/user_profile_comp.dart';
import 'package:webclient/components/edit_personal_data_comp.dart';
import 'package:webclient/components/remember_password_comp.dart';
import 'package:webclient/components/view_contest_entry_comp.dart';
import 'package:webclient/utils/form-autofill-fix.dart';

class WebClientApp extends Module {
  WebClientApp() {

    bind(ExceptionHandler, toImplementation: LoggerExceptionHandler);

    bind(ServerService, toImplementation: DailySoccerServer);

    bind(DateTimeService);
    bind(ProfileService);
    bind(ActiveContestsService);
    bind(MyContestsService);
    bind(SoccerPlayerService);
    bind(FlashMessagesService);
    bind(ScreenDetectorService);

    bind(LimitToDot);

    bind(EnterContestCtrl);
    bind(ViewContestCtrl);

    bind(FlashMessageComp);
    bind(LandingPageComp);
    bind(MainMenuComp);
    bind(MainMenuSlideComp);

    bind(ContestInfoComp);
    bind(SoccerPlayerInfoComp);
    bind(ContestHeaderComp);
    bind(FantasyTeamComp);
    bind(UsersListComp);
    bind(SoccerPlayersListComp);
    bind(LineupSelectorComp);

    bind(MyContestsComp);
    bind(ContestsListComp);
    bind(LobbyComp);
    bind(PromosComp);
    bind(FooterComp);
    bind(PaginatorComp);
    bind(LoginComp);
    bind(JoinComp);
    bind(RememberPasswordComp);
    bind(UserProfileComp);
    bind(EditPersonalDataComp);
    bind(ViewContestEntryComp);

    bind(FormAutofillDecorator);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }
}