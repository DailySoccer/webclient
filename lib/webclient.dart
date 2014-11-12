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

import 'package:webclient/components/landing_page_comp.dart';

import 'package:webclient/utils/form-autofill-fix.dart';
import 'package:webclient/utils/element-autofocus.dart';
import 'package:webclient/utils/limit_to_dot.dart';

import 'package:webclient/components/navigation/main_menu_slide_comp.dart';
import 'package:webclient/components/navigation/footer_comp.dart';
import 'package:webclient/components/global_connection_comp.dart';
import 'package:webclient/components/flash_messages_comp.dart';
import 'package:webclient/components/modal_comp.dart';

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
import 'package:webclient/components/view_contest/teams_panel_comp.dart';

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
import 'package:webclient/utils/js_utils.dart';

class WebClientApp extends Module {

  WebClientApp() {
    // El cache de templates solo lo primeamos en produccion, pq es donde tenemos garantizado que se habra
    // hecho una build y por lo tanto el fichero lib/template_cache.dart tendra todos los contenidos frescos
    if (HostServer.isProd) {
      TemplateCache cache = new TemplateCache();
      primeTemplateCache(cache);
      bind(TemplateCache, toValue: cache);
    }

    // No usamos animacion -> podemos quitar esto
    bind(CompilerConfig, toValue:new CompilerConfig.withOptions(elementProbeEnabled: false));

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

    bind(FormAutofillDecorator);
    bind(AutoFocusDecorator);
    bind(LimitToDot);

    bind(LandingPageComp);

    bind(MainMenuSlideComp);
    bind(FooterComp);
    bind(FlashMessageComp);
    bind(GlobalConnectionComp);
    bind(ModalComp);

    bind(LoginComp);
    bind(JoinComp);

    bind(LobbyComp);
    bind(ContestsListComp);
    bind(PromosComp);
    bind(PaginatorComp);
    bind(ContestFiltersComp);

    bind(ContestHeaderComp);
    bind(ContestInfoComp);
    bind(ScoringRulesComp);

    bind(MyContestsComp);
    bind(ViewContestComp);
    bind(ViewContestEntryComp);
    bind(FantasyTeamComp);
    bind(UsersListComp);
    bind(TeamsPanelComp);

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
      'landing_page': ngRoute(
          defaultRoute: true,
          path: '/landing_page',
          preEnter: (RoutePreEnterEvent e) => _onLandingPage(e, router),
          viewHtml: '<landing-page></landing-page>'
      )
      ,'beta_info': ngRoute(
          path: '/beta_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<beta-info></beta-info>'
      )
      ,'login': ngRoute(
          path: '/login',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<login></login>'
      )
      ,'join': ngRoute(
          path: '/join',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<join></join>'
      )
      ,'change_password': ngRoute(
          path: '/change_password',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<change-password></change-password>'
      )
      ,'help_info': ngRoute(
          path: '/help-info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<help-info></help-info>'
      )
      ,'legal_info': ngRoute(
          path: '/legal_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<legal-info></legal-info>'
      )
      ,'terminus_info': ngRoute(
          path: '/terminus_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<terminus-info></terminus-info>'
      )
      ,'policy_info': ngRoute(
          path: '/policy_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<policy-info></policy-info>'
      )
      ,'remember_password': ngRoute(
          path: '/remember_password',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router),
          viewHtml: '<remember-password></remember-password>'
      )
      ,'user_profile': ngRoute(
          path: '/user_profile',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<user-profile></user-profile>'
      )
      ,'edit_profile': ngRoute(
          path: '/edit_profile',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<edit-personal-data></edit-personal-data>'
      )
      ,'lobby': ngRoute(
          path: '/lobby',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<lobby></lobby>',
          mount: {
            'contest_info': ngRoute(
                path: '/contest_info/:contestId',
                viewHtml: '<contest-info></contest-info>')
          }
      )
      ,'my_contests': ngRoute(
          path: '/my_contests',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<my-contests></my-contests>'
      )
      ,'live_contest': ngRoute(
          path: '/live_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'history_contest': ngRoute(
          path: '/history_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'enter_contest': ngRoute(
          path: '/enter_contest/:parent/:contestId/:contestEntryId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<enter-contest></enter-contest>',
          mount: {
            'soccer_player_info': ngRoute(
              path: '/soccer_player_info/:instanceSoccerPlayerId',
              viewHtml: '<soccer-player-info></soccer-player-info>')
          }
      )
      ,'view_contest_entry': ngRoute(
          path: '/view_contest_entry/:parent/:viewContestEntryMode/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, verifyAllowEnter: true),
          viewHtml: '<view-contest-entry></view-contest-entry>'
      )
    });
  }

  // Ponemos el wrapper de todo nuestro contenido selectivamente en blanco
  void _bleach(Route route) {
    if (["landing_page", "join", "login"].contains(route.name)) {
      querySelector("#mainWrapper").classes.remove("bleach");
    }
    else {
      querySelector("#mainWrapper").classes.add("bleach");
    }
  }

  // En la landing queremos reroutar al lobby en caso de estar logeados, pero queremos hacerlo
  // antes de que se llegue a ver o parsear por una cuestion de rendimiento.
  void _onLandingPage(RoutePreEnterEvent event, Router router) {

    _bleach(event.route);

    var completer = new Completer<bool>();
    event.allowEnter(completer.future);

    JsUtils.runJavascript(null, "onjQueryReady", [() {
      if (ProfileService.instance.isLoggedIn) {
        router.go("lobby", {}, replace:true);

        // Denegar la entrada evita un flashazo. Si no la deniegas, llega a ir a la landing antes de ir al lobby
        completer.complete(false);
      }
      else {
        completer.complete(true);
      }
    }]);
  }

  void _preEnterPage(RoutePreEnterEvent event, Router router, {bool verifyAllowEnter : false}) {

    _bleach(event.route);

    LoadingService.disable();
    DailySoccerServer.startContext(event.path);

    if (verifyAllowEnter) {
      // Si no estamos logeados, redirigimos a la landing
      if (!ProfileService.instance.isLoggedIn) {
        router.go("landing_page", {}, replace:true);
      }
      event.allowEnter(new Future.value(ProfileService.instance.isLoggedIn));
    }
  }
}