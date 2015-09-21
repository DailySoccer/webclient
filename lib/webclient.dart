library webclient;

import 'dart:html';
import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
// import 'package:intl/intl.dart';

import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/scoring_rules_service.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/services/prizes_service.dart';
import 'package:webclient/services/promos_service.dart';

import 'package:webclient/components/landing_page_1_slide_comp.dart';

import 'package:webclient/utils/form-autofill-fix.dart';
import 'package:webclient/utils/element-autofocus.dart';
import 'package:webclient/utils/translate_decorator.dart';
import 'package:webclient/utils/translate_formatter.dart';
import 'package:webclient/utils/translate_config.dart';

import 'package:webclient/utils/limit_to_dot.dart';

import 'package:webclient/components/navigation/main_menu_slide_comp.dart';
import 'package:webclient/components/navigation/footer_comp.dart';
import 'package:webclient/components/flash_messages_comp.dart';
import 'package:webclient/components/modal_comp.dart';

import 'package:webclient/components/paginator_comp.dart';
import 'package:webclient/components/contest_filters_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
import 'package:webclient/components/promos_comp.dart';
import 'package:webclient/components/simple_promo_viewer_comp.dart';

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
import 'package:webclient/components/account/payment_comp.dart';
import 'package:webclient/components/account/payment_response_comp.dart';
import 'package:webclient/components/account/add_funds_comp.dart';
import 'package:webclient/components/account/withdraw_funds_comp.dart';
import 'package:webclient/components/account/transaction_history_comp.dart';

import 'package:webclient/components/my_contests_comp.dart';
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart';
import 'package:webclient/components/view_contest/view_contest_comp.dart';
import 'package:webclient/components/view_contest/fantasy_team_comp.dart';
import 'package:webclient/components/view_contest/users_list_comp.dart';
import 'package:webclient/components/view_contest/teams_panel_comp.dart';

import 'package:webclient/components/welcome_comp.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart';
import 'package:webclient/components/enter_contest/matches_filter_comp.dart';

import 'package:webclient/components/enter_contest/soccer_player_stats_comp.dart';

import 'package:webclient/components/legalese_and_help/help_info_comp.dart';
import 'package:webclient/components/legalese_and_help/legal_info_comp.dart';
import 'package:webclient/components/legalese_and_help/terminus_info_comp.dart';
import 'package:webclient/components/legalese_and_help/policy_info_comp.dart';
import 'package:webclient/components/legalese_and_help/beta_info_comp.dart';
import 'package:webclient/components/legalese_and_help/restricted_comp.dart';

import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/js_utils.dart';

import 'package:webclient/utils/noshim.dart';
import 'package:angular/core_dom/module_internal.dart';

import 'package:webclient/template_cache.dart';
import 'package:webclient/utils/game_metrics.dart';


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

    // Disable CSS shim
    bind(PlatformJsBasedShim, toImplementation: PlatformJsBasedNoShim);
    bind(DefaultPlatformShim, toImplementation: DefaultPlatformNoShim);

    bind(ExceptionHandler, toImplementation: LoggerExceptionHandler);
    bind(ServerService, toImplementation: DailySoccerServer);

    bind(ScreenDetectorService);

    bind(LoadingService);
    bind(RefreshTimersService);
    bind(DateTimeService);
    bind(ProfileService);
    bind(FlashMessagesService);
    bind(PromosService);

    bind(ContestsService);
    bind(SoccerPlayerService);
    bind(ScoringRulesService);
    bind(PaymentService);
    bind(PrizesService);

    bind(FormAutofillDecorator);
    bind(AutoFocusDecorator);
    bind(LimitToDot);

    bind(TranslateConfig);
    bind(TranslateDecorator);
    bind(TranslateFormatter);

    bind(LandingPage1SlideComp);

    bind(MainMenuSlideComp);
    bind(FooterComp);
    bind(FlashMessageComp);
    bind(ModalComp);

    bind(LoginComp);
    bind(JoinComp);

    bind(LobbyComp);
    bind(ContestsListComp);
    bind(PromosComp);
    bind(SimplePromoViewerComp);
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
    bind(WelcomeComp);

    bind(HelpInfoComp);
    bind(LegalInfoComp);
    bind(TerminusInfoComp);
    bind(PolicyInfoComp);
    bind(BetaInfoComp);
    bind(RestrictedComp);

    bind(EnterContestComp);
    bind(SoccerPlayersListComp);
    bind(SoccerPlayersFilterComp);
    bind(MatchesFilterComp);
    bind(LineupSelectorComp);

    bind(SoccerPlayerStatsComp);

    bind(ChangePasswordComp);
    bind(RememberPasswordComp);
    bind(UserProfileComp);
    bind(EditPersonalDataComp);
    bind(PaymentComp);
    bind(PaymentResponseComp);
    bind(AddFundsComp);
    bind(WithdrawFundsComp);
    bind(TransactionHistoryComp);

    bind(RouteInitializerFn, toValue: webClientRouteInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));


  }

  void webClientRouteInitializer(Router router, RouteViewFactory views) {

    views.configure({
      'landing_page': ngRoute(
          defaultRoute: true,
          path: '/landing_page',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
          viewHtml: '<landing-page-1-slide></landing-page-1-slide>'
      )
      ,'beta_info': ngRoute(
          path: '/beta_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<beta-info></beta-info>'
      )
      ,'login': ngRoute(
          path: '/login',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
          viewHtml: '<login></login>'
      )
      ,'join': ngRoute(
          path: '/join',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
          viewHtml: '<join></join>'
      )
      ,'change_password': ngRoute(
          path: '/change_password',
          preEnter: (RoutePreEnterEvent e) {
            if (ProfileService.instance.isLoggedIn) {
              ProfileService.instance.logout();
            }
            _preEnterPage(e, router, visibility: _ALWAYS);
          },
          viewHtml: '<change-password></change-password>'
      )
      ,'help_info': ngRoute(
          path: '/help-info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<help-info></help-info>'
      )
      ,'legal_info': ngRoute(
          path: '/legal_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<legal-info></legal-info>'
      )
      ,'terminus_info': ngRoute(
          path: '/terminus_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<terminus-info></terminus-info>'
      )
      ,'policy_info': ngRoute(
          path: '/policy_info',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<policy-info></policy-info>'
      )
      ,'remember_password': ngRoute(
          path: '/remember_password',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
          viewHtml: '<remember-password></remember-password>'
      )
      ,'user_profile': ngRoute(
          path: '/user_profile',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<user-profile></user-profile>'
      )
      ,'edit_profile': ngRoute(
          path: '/edit_profile',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<edit-personal-data></edit-personal-data>'
      )
      ,'payment': ngRoute(
          path: '/payment',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<payment></payment>',
          mount: {
            'response': ngRoute(
                path: '/response/:result',
                viewHtml: '<payment-response></payment-response>')
          }
      )
      ,'add_funds': ngRoute(
          path: '/add_funds',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<add-funds></add-funds>',
          mount: {
            'response': ngRoute(
                path: '/response/:result',
                preEnter: (RoutePreEnterEvent e) => _preEnterPagePayment(e, router),
                viewHtml: '<payment-response></payment-response>')
          }
      )
      ,'withdraw_funds': ngRoute(
          path: '/withdraw_funds',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<withdraw-funds></withdraw-funds>'
      )
      ,'transaction_history': ngRoute(
          path: '/transaction_history',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<transaction-history></transaction-history>'
      )
      ,'lobby': ngRoute(
          path: '/lobby',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<lobby></lobby>',
          mount: {
            'contest_info': ngRoute(
                path: '/contest_info/:contestId',
                viewHtml: '<contest-info></contest-info>')
            ,'welcome': ngRoute(
                path: '/welcome',
                preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
                viewHtml: '''<modal window-size="'90percent'"><welcome></welcome></modal>'''
            )
            ,'view_promo': ngRoute(
                path: '/view_promo/:promoCodeName',
                preEnter: (RoutePreEnterEvent e) {
                  PromosService.configurePromosService(e.parameters['promoCodeName']);
                  _preEnterPage(e, router, visibility: _ALWAYS);
                  }
            )
          }
      )
      ,'my_contests': ngRoute(
          path: '/my_contests/:section/',
          preEnter: (RoutePreEnterEvent e) => _preEnterMycontest(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<my-contests></my-contests>'
      )
      ,'live_contest': ngRoute(
          path: '/live_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'history_contest': ngRoute(
          path: '/history_contest/:parent/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<view-contest></view-contest>'
      )
      ,'enter_contest': ngRoute(
          path: '/enter_contest/:parent/:contestId/:contestEntryId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
          viewHtml: '<enter-contest></enter-contest>',
          mount: {
            'soccer_player_stats': ngRoute(
              path: '/soccer_player_stats/:instanceSoccerPlayerId/selectable/:selectable',
              viewHtml: '<soccer-player-stats></soccer-player-stats>')
            ,'login': ngRoute(
                path: '/login',
                preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
                viewHtml: '''<modal window-size="'md'"><login is-modal="true"></login></modal>'''
            )
            ,'join': ngRoute(
                path: '/join',
                preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_OUT),
                viewHtml: '''<modal window-size="'md'"><join is-modal="true"></join></modal>'''
            )
            ,'welcome': ngRoute(
                path: '/welcome',
                preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
                viewHtml: '''<modal window-size="'90percent'"><welcome></welcome></modal>'''
            )
          }
      )
      ,'view_contest_entry': ngRoute(
          path: '/view_contest_entry/:parent/:viewContestEntryMode/:contestId',
          preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ONLY_WHEN_LOGGED_IN),
          viewHtml: '<view-contest-entry></view-contest-entry>',
          mount: {
            'welcome': ngRoute(
              path: '/welcome',
              preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
              viewHtml: '''<modal window-size="'90percent'"><welcome></welcome></modal>''')
          }
      )
      ,'restricted': ngRoute(
        path: '/restricted',
        preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
        viewHtml: '''<restricted-comp></restricted-comp>'''
      )
      ,'view_promo': ngRoute(
        path: '/view_promo/:promoId',
        preEnter: (RoutePreEnterEvent e) => _preEnterPage(e, router, visibility: _ALWAYS),
        viewHtml: '''<simple-promo-viewer></simple-promo-viewer>'''
      )
    });
  }

  Future _waitingjQueryReady(Function cb) {
    var completer = new Completer<bool>();
    if (_jQueryReady) {
      completer.complete( cb() );
    }
    else {
      JsUtils.runJavascript(null, "onjQueryReady", [() {
        GameMetrics.logEvent(GameMetrics.PAGE_READY);
        _jQueryReady = true;
        completer.complete( cb() );
      }]);
    }
    return completer.future;
  }

  void _preEnterPagePayment(RoutePreEnterEvent event, Router router) {
    if (event.parameters["result"] == 'success' && window.localStorage.containsKey("add_funds_success")) {
      window.location.assign(window.localStorage["add_funds_success"]);

      event.allowEnter(_waitingjQueryReady(() {
        return false;
      }));
    }
  }

  void _preEnterMycontest(RoutePreEnterEvent event, Router router, {int visibility}) {
    _preEnterPage(event, router,visibility:visibility);
    if (event.parameters["section"] == "null") {
      //event.parameters["section"] = "live";
      router.go(event.route.name, {"section":'live'});
    }
  }

  void _preEnterPage(RoutePreEnterEvent event, Router router, {int visibility}) {

    LoadingService.disable();
    DailySoccerServer.startContext(event.path);

    _addBodyStyles(event.route.name);

    event.allowEnter(_waitingjQueryReady(() {
      bool bEnter = true;

      if ((visibility == _ONLY_WHEN_LOGGED_IN && !ProfileService.instance.isLoggedIn) ||
          (visibility == _ONLY_WHEN_LOGGED_OUT && ProfileService.instance.isLoggedIn)) {
        bEnter = false;
      }

      if (!bEnter) {
        if (ProfileService.instance.isLoggedIn) {
          // Antes de redirigir al lobby, miramos que vengamos desde 0. Esto evita un flashazo en el que si estas
          // por ejemplo en my_contest e intentas ir a la landing, se ve brevemente el lobby
          if (router.activePath.isEmpty) {
            router.go("lobby", {}, replace:true);
          }
        }
        else {
          router.go("landing_page", {}, replace: true);
        }
      }

      window.scroll(0, 0);

      // Denegar la entrada evita un flashazo. Si no la deniegas, llega a ir a la landing antes de ir al lobby
      return bEnter;
    }));
  }

  void _addBodyStyles(String routeName) {
    querySelector("body").classes.removeWhere((String theClass) => theClass.startsWith("global-"));

    // Añadir este estilo nos permite hacer el "bleach" solo cuando estamos logeados
    if (ProfileService.instance.isLoggedIn) {
      querySelector("body").classes.add("global-logged-in");
    }

    querySelector("body").classes.add("global-" + routeName.replaceAll("_", "-"));
  }

  final int _ALWAYS = 0;
  final int _ONLY_WHEN_LOGGED_IN = 1;
  final int _ONLY_WHEN_LOGGED_OUT = 2;

  bool _jQueryReady = false;
}
