library webclient;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';

import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/services/my_contests_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/scoring_rules_service.dart';

import 'package:webclient/components/root_comp.dart';
import 'package:webclient/components/landing_page_comp.dart';

import 'package:webclient/utils/limit_to_dot.dart';
import 'package:webclient/utils/form-autofill-fix.dart';
import 'package:webclient/utils/element-autofocus.dart';

import 'package:webclient/components/navigation/main_menu_slide_comp.dart';
import 'package:webclient/components/navigation/footer_comp.dart';
import 'package:webclient/components/global_connection_comp.dart';
import 'package:webclient/components/flash_messages_comp.dart';

import 'package:webclient/components/paginator_comp.dart';
import 'package:webclient/components/contest_filters_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
import 'package:webclient/components/promos_comp.dart';
import 'package:webclient/components/contests_list_comp.dart';

import 'package:webclient/components/contest_info_comp.dart';
import 'package:webclient/components/scoring_rules_comp.dart';
import 'package:webclient/components/contest_header_comp.dart';

import 'package:webclient/components/account/login_comp.dart';
import 'package:webclient/components/account/join_comp.dart';
import 'package:webclient/components/account/user_profile_comp.dart';
import 'package:webclient/components/account/edit_personal_data_comp.dart';
import 'package:webclient/components/account/remember_password_comp.dart';
import 'package:webclient/components/account/change_password_comp.dart';

import 'package:webclient/components/my_contests_comp.dart';
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart';
import 'package:webclient/components/view_contest/view_contest_comp.dart';
import 'package:webclient/components/view_contest/fantasy_team_comp.dart';
import 'package:webclient/components/view_contest/users_list_comp.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart';
import 'package:webclient/components/enter_contest/matches_filter_comp.dart';
import 'package:webclient/components/enter_contest/soccer_player_info_comp.dart';

import 'package:webclient/components/legalese_and_help/help_info_comp.dart';
import 'package:webclient/components/legalese_and_help/legal_info_comp.dart';
import 'package:webclient/components/legalese_and_help/terminus_info_comp.dart';
import 'package:webclient/components/legalese_and_help/policy_info_comp.dart';
import 'package:webclient/components/legalese_and_help/beta_info_comp.dart';

import 'package:webclient/utils/host_server.dart';
import 'package:webclient/template_cache.dart';
import 'dart:async';

class WebClientApp extends Module {

  WebClientApp() {
    // El cache de templates solo lo primeamos en produccion, pq es donde tenemos garantizado que se habra
    // hecho una build y por lo tanto el fichero lib/template_cache.dart tendra todos los contenidos frescos
    if (HostServer.isProd) {
      TemplateCache cache = new TemplateCache();
      primeTemplateCache(cache);
      bind(TemplateCache, toValue: cache);
    }

    bind(ExceptionHandler, toImplementation: LoggerExceptionHandler);
    bind(ServerService, toImplementation: DailySoccerServer);

    bind(ScreenDetectorService);

    bind(LoadingService);
    bind(RefreshTimersService);
    bind(DateTimeService);
    bind(ProfileService);
    bind(FlashMessagesService);

    bind(ActiveContestsService);

    bind(MyContestsService);
    bind(SoccerPlayerService);
    bind(ScoringRulesService);

    bind(LimitToDot);
    bind(FormAutofillDecorator);
    bind(AutoFocusDecorator);

    bind(RootComp);
    bind(LandingPageComp);

    bind(MainMenuSlideComp);
    bind(FooterComp);
    bind(FlashMessageComp);
    bind(GlobalConnectionComp);

    bind(LoginComp);
    bind(JoinComp);

    bind(LobbyComp);
    bind(ContestsListComp);
    bind(PromosComp);
    bind(PaginatorComp);
    bind(ContestFiltersComp);

    bind(MyContestsComp);
    bind(ViewContestComp);
    bind(ViewContestEntryComp);
    bind(ContestHeaderComp);
    bind(ContestInfoComp);
    bind(ScoringRulesComp);
    bind(FantasyTeamComp);
    bind(UsersListComp);

    bind(HelpInfoComp);
    bind(LegalInfoComp);
    bind(TerminusInfoComp);
    bind(PolicyInfoComp);
    bind(BetaInfoComp);

    bind(EnterContestComp);
    bind(SoccerPlayersListComp);
    bind(SoccerPlayersFilterComp);
    bind(MatchesFilterComp);
    bind(LineupSelectorComp);
    bind(SoccerPlayerInfoComp);

    bind(ChangePasswordComp);
    bind(RememberPasswordComp);
    bind(UserProfileComp);
    bind(EditPersonalDataComp);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }

  void webClientRouteInitializer(Router router, RouteViewFactory views) {
    views.configure({
      'root': ngRoute(
          defaultRoute: true,
          path: '/root',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<root></root>'
      )
      ,'landing_page': ngRoute(
          path: '/landing_page',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<landing-page></landing-page>'
      )
      ,'beta_info': ngRoute(
          path: '/beta_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<beta-info></beta-info>'
      )
      ,'login': ngRoute(
          path: '/login',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<login></login>'
      )
      ,'join': ngRoute(
          path: '/join',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<join></join>'
      )
      ,'change_password': ngRoute(
          path: '/change_password',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<change-password></change-password>'
      )
      ,'help_info': ngRoute(
          path: '/help-info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<help-info></help-info>'
      )
      ,'legal_info': ngRoute(
          path: '/legal_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<legal-info></legal-info>'
      )
      ,'terminus_info': ngRoute(
          path: '/terminus_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<terminus-info></terminus-info>'
      )
      ,'policy_info': ngRoute(
          path: '/policy_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<policy-info></policy-info>'
      )
      ,'remember_password': ngRoute(
          path: '/remember_password',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<remember-password></remember-password>'
      )
      ,'user_profile': ngRoute(
          path: '/user_profile',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<user-profile></user-profile>'
      )
      ,'lobby': ngRoute(
          path: '/lobby',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<lobby></lobby>'
      )
      ,'my_contests': ngRoute(
          path: '/my_contests',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<my-contests></my-contests>'
      )
      ,'live_contest': ngRoute(
          path: '/live_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'history_contest': ngRoute(
          path: '/history_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'enter_contest': ngRoute(
          path: '/enter_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<enter-contest></enter-contest>'
      )
      ,'edit_contest': ngRoute(
          path: '/edit_contest/:parent/:contestId/:contestEntryId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<enter-contest></enter-contest>'
      )
      ,'view_contest_entry': ngRoute(
          path: '/view_contest_entry/:parent/:viewContestEntryMode/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, verifyAllowEnter: true),
          enter: (RouteEnterEvent e) => _enterPage(e),
          leave: (RouteLeaveEvent e) => _leavePage(e),
          viewHtml: '<view-contest-entry></view-contest-entry>'
      )
    });
  }

  void _preEnterPage(RoutePreEnterEvent event, {bool verifyAllowEnter : false}) {

    LoadingService.disable();
    DailySoccerServer.startContext(event.path);

    if (verifyAllowEnter) {
      event.allowEnter(new Future<bool>(() => ProfileService.isLoggedInStatic));
    }
  }

  // Funcion que ejecutamos nada más entrar en la página
  void _enterPage(RouteEnterEvent event) {
  }

  // Funcion que ejecutamos nada más salir de la página
  void _leavePage(RouteLeaveEvent event) {

    // Reseteamos las modales en el caso de que hubiera (bug de modal abierta y vuelta atrás)
    _closeModal();
  }

  void _closeModal() {
    bool isModalOpen = (document.querySelector('body').classes.contains('modal-open'));
    if (isModalOpen) {
      document.querySelector('body').classes.remove('modal-open');
      document.querySelector('.modal-backdrop').remove();
    }
  }
}