library webclient.web.main.generated_type_factory_maps;

import 'package:di/di.dart';
import 'package:di/src/reflector_static.dart';
import 'package:di/type_literal.dart';

import 'package:angular/core_dom/module_internal.dart' as import_0;
import 'package:angular/core/module_internal.dart' as import_1;
import 'package:perf_api/perf_api.dart' as import_2;
import 'package:di/src/injector.dart' as import_4;
import 'package:angular/core/formatter.dart' as import_5;
import 'package:angular/core/registry.dart' as import_6;
import 'package:angular/core/parser/parser.dart' as import_7;
import 'package:angular/change_detection/ast_parser.dart' as import_8;
import 'dart:html' as import_9;
import 'package:angular/core/pending_async.dart' as import_10;
import 'package:angular/change_detection/watch_group.dart' as import_11;
import 'package:angular/core_dom/type_to_uri_mapper.dart' as import_12;
import 'package:angular/core_dom/resource_url_resolver.dart' as import_13;
import 'package:angular/cache/module.dart' as import_14;
import 'package:angular/directive/module.dart' as import_15;
import 'package:angular/core_dom/directive_injector.dart' as import_16;
import 'package:angular/core/parser/lexer.dart' as import_17;
import 'package:angular/change_detection/change_detection.dart' as import_18;
import 'package:angular/formatter/module_internal.dart' as import_19;
import 'package:angular/animate/module.dart' as import_20;
import 'package:angular/routing/module.dart' as import_21;
import 'package:route_hierarchical/client.dart' as import_22;
import 'package:angular/application.dart' as import_23;
import 'package:angular/cache/js_cache_register.dart' as import_24;
import 'package:webclient/logger_exception_handler.dart' as import_25;
import 'package:webclient/services/profile_service.dart' as import_26;
import 'package:webclient/services/server_service.dart' as import_27;
import 'package:webclient/services/prizes_service.dart' as import_28;
import 'package:webclient/services/datetime_service.dart' as import_29;
import 'package:webclient/services/refresh_timers_service.dart' as import_30;
import 'package:webclient/services/tutorial_service.dart' as import_31;
import 'package:webclient/services/tooltip_service.dart' as import_32;
import 'package:webclient/services/screen_detector_service.dart' as import_33;
import 'package:webclient/components/view_contest/view_contest_comp.dart' as import_34;
import 'package:webclient/services/contests_service.dart' as import_35;
import 'package:webclient/services/flash_messages_service.dart' as import_36;
import 'package:webclient/services/loading_service.dart' as import_37;
import 'package:webclient/components/modal_comp.dart' as import_38;
import 'package:webclient/components/enter_contest/enter_contest_comp.dart' as import_39;
import 'package:webclient/services/catalog_service.dart' as import_40;
import 'package:webclient/services/payment_service.dart' as import_41;
import 'package:webclient/components/achievement_comp.dart' as import_42;
import 'package:webclient/components/navigation/xs_not_available_screen_comp.dart' as import_43;
import 'package:webclient/components/enter_contest/soccer_player_stats_comp.dart' as import_44;
import 'package:webclient/services/soccer_player_service.dart' as import_45;
import 'package:webclient/components/legalese_and_help/how_to_create_contest_comp.dart' as import_46;
import 'package:webclient/components/account/change_password_comp.dart' as import_47;
import 'package:webclient/components/week_calendar_comp.dart' as import_48;
import 'package:webclient/components/promos_comp.dart' as import_49;
import 'package:webclient/services/promos_service.dart' as import_50;
import 'package:webclient/utils/translate_formatter.dart' as import_51;
import 'package:webclient/components/legalese_and_help/terminus_info_comp.dart' as import_52;
import 'package:webclient/services/leaderboard_service.dart' as import_53;
import 'package:webclient/components/account/shop_comp.dart' as import_54;
import 'package:webclient/components/home_comp.dart' as import_55;
import 'package:webclient/components/account/notifications_comp.dart' as import_56;
import 'package:webclient/services/facebook_service.dart' as import_57;
import 'package:webclient/components/social/friend_info_comp.dart' as import_58;
import 'package:webclient/components/contest_header_f2p_comp.dart' as import_59;
import 'package:webclient/components/scouting/teams_filter_comp.dart' as import_60;
import 'package:webclient/components/paginator_comp.dart' as import_61;
import 'package:webclient/components/account/edit_personal_data_comp.dart' as import_62;
import 'package:webclient/components/social/facebook_share_comp.dart' as import_63;
import 'package:webclient/components/navigation/main_menu_f2p_comp.dart' as import_64;
import 'package:webclient/components/account/join_comp.dart' as import_65;
import 'package:webclient/utils/element-autofocus.dart' as import_66;
import 'package:webclient/components/legalese_and_help/legal_info_comp.dart' as import_67;
import 'package:webclient/components/lobby_f2p_comp.dart' as import_68;
import 'package:webclient/components/contests_list_f2p_comp.dart' as import_69;
import 'package:webclient/utils/max_text_width.dart' as import_70;
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart' as import_71;
import 'package:webclient/components/social/social_share_comp.dart' as import_72;
import 'package:webclient/components/scouting/scouting_comp.dart' as import_73;
import 'package:webclient/components/scoring_rules_comp.dart' as import_74;
import 'package:webclient/services/scoring_rules_service.dart' as import_75;
import 'package:webclient/components/achievement_list_comp.dart' as import_76;
import 'package:webclient/components/legalese_and_help/rules_comp.dart' as import_77;
import 'package:webclient/components/legalese_and_help/how_it_works_comp.dart' as import_78;
import 'package:webclient/components/leaderboard_comp.dart' as import_79;
import 'package:webclient/utils/limit_to_dot.dart' as import_80;
import 'package:webclient/components/flash_messages_comp.dart' as import_81;
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart' as import_82;
import 'package:webclient/components/leaderboard_table_comp.dart' as import_83;
import 'package:webclient/utils/ng_bind_html_unsafe.dart' as import_84;
import 'package:webclient/components/account/user_profile_comp.dart' as import_85;
import 'package:webclient/components/account/login_comp.dart' as import_86;
import 'package:webclient/components/create_contest_comp.dart' as import_87;
import 'package:webclient/components/contest_info_comp.dart' as import_88;
import 'package:webclient/components/scouting/scouting_league_comp.dart' as import_89;
import 'package:webclient/components/view_contest/teams_panel_comp.dart' as import_90;
import 'package:webclient/components/welcome_comp.dart' as import_91;
import 'package:webclient/components/legalese_and_help/policy_info_comp.dart' as import_92;
import 'package:webclient/components/my_contests_comp.dart' as import_93;
import 'package:webclient/resource_url_resolver_wrapper.dart' as import_94;
import 'package:webclient/components/legalese_and_help/tutorials_comp.dart' as import_95;
import 'package:webclient/components/enter_contest/matches_filter_comp.dart' as import_96;
import 'package:webclient/utils/form-autofill-fix.dart' as import_97;
import 'package:webclient/components/social/friends_bar_comp.dart' as import_98;
import 'package:webclient/components/legalese_and_help/help_info_comp.dart' as import_99;
import 'package:webclient/utils/noshim.dart' as import_100;
import 'package:webclient/components/account/remember_password_comp.dart' as import_101;
import 'package:webclient/components/navigation/footer_comp.dart' as import_102;
import 'package:webclient/components/simple_promo_f2p_comp.dart' as import_103;
import 'package:webclient/components/social/twitter_share_comp.dart' as import_104;
import 'package:webclient/components/view_contest/fantasy_team_comp.dart' as import_105;
import 'package:webclient/components/view_contest/users_list_comp.dart' as import_106;
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart' as import_107;
import 'package:webclient/components/account/payment_response_comp.dart' as import_108;
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart' as import_109;
import 'package:webclient/utils/translate_decorator.dart' as import_110;
import 'package:webclient/components/tutorial_list_comp.dart' as import_111;

final Key _KEY_ExceptionHandler = new Key(import_1.ExceptionHandler);
final Key _KEY_BrowserCookies = new Key(import_0.BrowserCookies);
final Key _KEY_Profiler = new Key(import_2.Profiler);
final Key _KEY_Expando = new Key(Expando);
final Key _KEY_Injector = new Key(import_4.Injector);
final Key _KEY_FormatterMap = new Key(import_5.FormatterMap);
final Key _KEY_MetadataExtractor = new Key(import_6.MetadataExtractor);
final Key _KEY_DirectiveSelectorFactory = new Key(import_0.DirectiveSelectorFactory);
final Key _KEY_Parser = new Key(import_7.Parser);
final Key _KEY_CompilerConfig = new Key(import_0.CompilerConfig);
final Key _KEY_ASTParser = new Key(import_8.ASTParser);
final Key _KEY_ComponentFactory = new Key(import_0.ComponentFactory);
final Key _KEY_ShadowDomComponentFactory = new Key(import_0.ShadowDomComponentFactory);
final Key _KEY_TranscludingComponentFactory = new Key(import_0.TranscludingComponentFactory);
final Key _KEY_Node = new Key(import_9.Node);
final Key _KEY_ShadowRoot = new Key(import_9.ShadowRoot);
final Key _KEY_HttpDefaultHeaders = new Key(import_0.HttpDefaultHeaders);
final Key _KEY_LocationWrapper = new Key(import_0.LocationWrapper);
final Key _KEY_UrlRewriter = new Key(import_0.UrlRewriter);
final Key _KEY_HttpBackend = new Key(import_0.HttpBackend);
final Key _KEY_HttpDefaults = new Key(import_0.HttpDefaults);
final Key _KEY_HttpInterceptors = new Key(import_0.HttpInterceptors);
final Key _KEY_RootScope = new Key(import_1.RootScope);
final Key _KEY_HttpConfig = new Key(import_0.HttpConfig);
final Key _KEY_VmTurnZone = new Key(import_1.VmTurnZone);
final Key _KEY_PendingAsync = new Key(import_10.PendingAsync);
final Key _KEY_AST = new Key(import_11.AST);
final Key _KEY_Scope = new Key(import_1.Scope);
final Key _KEY_NodeAttrs = new Key(import_0.NodeAttrs);
final Key _KEY_String = new Key(String);
final Key _KEY_Element = new Key(import_9.Element);
final Key _KEY_Animate = new Key(import_0.Animate);
final Key _KEY_DestinationLightDom = new Key(import_0.DestinationLightDom);
final Key _KEY_ElementBinderFactory = new Key(import_0.ElementBinderFactory);
final Key _KEY_Interpolate = new Key(import_1.Interpolate);
final Key _KEY_ViewFactoryCache = new Key(import_0.ViewFactoryCache);
final Key _KEY_PlatformJsBasedShim = new Key(import_0.PlatformJsBasedShim);
final Key _KEY_TypeToUriMapper = new Key(import_12.TypeToUriMapper);
final Key _KEY_ResourceUrlResolver = new Key(import_13.ResourceUrlResolver);
final Key _KEY_Http = new Key(import_0.Http);
final Key _KEY_TemplateCache = new Key(import_0.TemplateCache);
final Key _KEY_ComponentCssRewriter = new Key(import_0.ComponentCssRewriter);
final Key _KEY_NodeTreeSanitizer = new Key(import_9.NodeTreeSanitizer);
final Key _KEY_CacheRegister = new Key(import_14.CacheRegister);
final Key _KEY_DefaultPlatformShim = new Key(import_0.DefaultPlatformShim);
final Key _KEY_SourceLightDom = new Key(import_0.SourceLightDom);
final Key _KEY_View = new Key(import_0.View);
final Key _KEY_Compiler = new Key(import_0.Compiler);
final Key _KEY_ElementProbe = new Key(import_0.ElementProbe);
final Key _KEY_NodeValidator = new Key(import_9.NodeValidator);
final Key _KEY_NgElement = new Key(import_0.NgElement);
final Key _KEY_ViewFactory = new Key(import_0.ViewFactory);
final Key _KEY_ViewPort = new Key(import_0.ViewPort);
final Key _KEY_DirectiveInjector = new Key(import_16.DirectiveInjector);
final Key _KEY_DirectiveMap = new Key(import_0.DirectiveMap);
final Key _KEY_NgModel = new Key(import_15.NgModel);
final Key _KEY_NgTrueValue = new Key(import_15.NgTrueValue);
final Key _KEY_NgFalseValue = new Key(import_15.NgFalseValue);
final Key _KEY_NgModelOptions = new Key(import_15.NgModelOptions);
final Key _KEY_NgBindTypeForDateLike = new Key(import_15.NgBindTypeForDateLike);
final Key _KEY_NgValue = new Key(import_15.NgValue);
final Key _KEY_BoundViewFactory = new Key(import_0.BoundViewFactory);
final Key _KEY_NgSwitch = new Key(import_15.NgSwitch);
final Key _KEY_InputSelect = new Key(import_15.InputSelect);
final Key _KEY_Lexer = new Key(import_17.Lexer);
final Key _KEY_ParserBackend = new Key(import_7.ParserBackend);
final Key _KEY_ClosureMap = new Key(import_7.ClosureMap);
final Key _KEY_ScopeStatsEmitter = new Key(import_1.ScopeStatsEmitter);
final Key _KEY_ScopeStatsConfig = new Key(import_1.ScopeStatsConfig);
final Key _KEY_Object = new Key(Object);
final Key _KEY_FieldGetterFactory = new Key(import_18.FieldGetterFactory);
final Key _KEY_ScopeDigestTTL = new Key(import_1.ScopeDigestTTL);
final Key _KEY_ScopeStats = new Key(import_1.ScopeStats);
final Key _KEY_ResourceResolverConfig = new Key(import_13.ResourceResolverConfig);
final Key _KEY_AnimationFrame = new Key(import_20.AnimationFrame);
final Key _KEY_Window = new Key(import_9.Window);
final Key _KEY_AnimationLoop = new Key(import_20.AnimationLoop);
final Key _KEY_CssAnimationMap = new Key(import_20.CssAnimationMap);
final Key _KEY_AnimationOptimizer = new Key(import_20.AnimationOptimizer);
final Key _KEY_RouteInitializer = new Key(import_21.RouteInitializer);
final Key _KEY_Router = new Key(import_22.Router);
final Key _KEY_Application = new Key(import_23.Application);
final Key _KEY_NgRoutingHelper = new Key(import_21.NgRoutingHelper);
final Key _KEY_ServerService = new Key(import_27.ServerService);
final Key _KEY_RefreshTimersService = new Key(import_30.RefreshTimersService);
final Key _KEY_ProfileService = new Key(import_26.ProfileService);
final Key _KEY_ToolTipService = new Key(import_32.ToolTipService);
final Key _KEY_ScreenDetectorService = new Key(import_33.ScreenDetectorService);
final Key _KEY_RouteProvider = new Key(import_21.RouteProvider);
final Key _KEY_ContestsService = new Key(import_35.ContestsService);
final Key _KEY_FlashMessagesService = new Key(import_36.FlashMessagesService);
final Key _KEY_LoadingService = new Key(import_37.LoadingService);
final Key _KEY_TutorialService = new Key(import_31.TutorialService);
final Key _KEY_PrizesService = new Key(import_28.PrizesService);
final Key _KEY_CatalogService = new Key(import_40.CatalogService);
final Key _KEY_PaymentService = new Key(import_41.PaymentService);
final Key _KEY_SoccerPlayerService = new Key(import_45.SoccerPlayerService);
final Key _KEY_PromosService = new Key(import_50.PromosService);
final Key _KEY_ScoringRulesService = new Key(import_75.ScoringRulesService);
final Key _KEY_LeaderboardService = new Key(import_53.LeaderboardService);
final Key _KEY_DateTimeService = new Key(import_29.DateTimeService);
final Map<Type, Function> typeFactories = <Type, Function>{
  import_0.Animate: () => new import_0.Animate(),
  import_0.BrowserCookies: (a1) => new import_0.BrowserCookies(a1),
  import_0.Cookies: (a1) => new import_0.Cookies(a1),
  import_0.Compiler: (a1, a2) => new import_0.Compiler(a1, a2),
  import_0.CompilerConfig: () => new import_0.CompilerConfig(),
  import_0.DirectiveMap: (a1, a2, a3, a4) => new import_0.DirectiveMap(a1, a2, a3, a4),
  import_0.ElementBinderFactory: (a1, a2, a3, a4, a5, a6, a7, a8) => new import_0.ElementBinderFactory(a1, a2, a3, a4, a5, a6, a7, a8),
  import_0.EventHandler: (a1, a2, a3) => new import_0.EventHandler(a1, a2, a3),
  import_0.ShadowRootEventHandler: (a1, a2, a3) => new import_0.ShadowRootEventHandler(a1, a2, a3),
  import_0.DefaultShadowBoundary: () => new import_0.DefaultShadowBoundary(),
  import_0.ShadowRootBoundary: (a1) => new import_0.ShadowRootBoundary(a1),
  import_0.UrlRewriter: () => new import_0.UrlRewriter(),
  import_0.HttpBackend: () => new import_0.HttpBackend(),
  import_0.LocationWrapper: () => new import_0.LocationWrapper(),
  import_0.HttpInterceptors: () => new import_0.HttpInterceptors(),
  import_0.HttpDefaultHeaders: () => new import_0.HttpDefaultHeaders(),
  import_0.HttpDefaults: (a1) => new import_0.HttpDefaults(a1),
  import_0.Http: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) => new import_0.Http(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10),
  import_0.HttpConfig: () => new import_0.HttpConfig(),
  import_0.TextMustache: (a1, a2, a3) => new import_0.TextMustache(a1, a2, a3),
  import_0.AttrMustache: (a1, a2, a3, a4) => new import_0.AttrMustache(a1, a2, a3, a4),
  import_0.NgElement: (a1, a2, a3, a4) => new import_0.NgElement(a1, a2, a3, a4),
  import_0.DirectiveSelectorFactory: (a1, a2, a3, a4, a5) => new import_0.DirectiveSelectorFactory(a1, a2, a3, a4, a5),
  import_0.ShadowDomComponentFactory: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) => new import_0.ShadowDomComponentFactory(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11),
  import_0.ComponentCssRewriter: () => new import_0.ComponentCssRewriter(),
  import_0.TranscludingComponentFactory: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) => new import_0.TranscludingComponentFactory(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11),
  import_0.Content: (a1, a2, a3, a4) => new import_0.Content(a1, a2, a3, a4),
  import_0.NullTreeSanitizer: () => new import_0.NullTreeSanitizer(),
  import_0.ViewFactoryCache: (a1, a2, a3, a4, a5, a6) => new import_0.ViewFactoryCache(a1, a2, a3, a4, a5, a6),
  import_0.PlatformJsBasedShim: () => new import_0.PlatformJsBasedShim(),
  import_0.DefaultPlatformShim: () => new import_0.DefaultPlatformShim(),
  import_15.AHref: (a1, a2) => new import_15.AHref(a1, a2),
  import_15.NgBaseCss: () => new import_15.NgBaseCss(),
  import_15.NgBind: (a1, a2) => new import_15.NgBind(a1, a2),
  import_15.NgBindHtml: (a1, a2) => new import_15.NgBindHtml(a1, a2),
  import_15.NgBindTemplate: (a1) => new import_15.NgBindTemplate(a1),
  import_15.NgClass: (a1, a2, a3) => new import_15.NgClass(a1, a2, a3),
  import_15.NgClassOdd: (a1, a2, a3) => new import_15.NgClassOdd(a1, a2, a3),
  import_15.NgClassEven: (a1, a2, a3) => new import_15.NgClassEven(a1, a2, a3),
  import_15.NgEvent: (a1, a2) => new import_15.NgEvent(a1, a2),
  import_15.NgCloak: (a1, a2) => new import_15.NgCloak(a1, a2),
  import_15.NgIf: (a1, a2, a3) => new import_15.NgIf(a1, a2, a3),
  import_15.NgUnless: (a1, a2, a3) => new import_15.NgUnless(a1, a2, a3),
  import_15.NgInclude: (a1, a2, a3, a4, a5) => new import_15.NgInclude(a1, a2, a3, a4, a5),
  import_15.NgModel: (a1, a2, a3, a4, a5, a6) => new import_15.NgModel(a1, a2, a3, a4, a5, a6),
  import_15.InputCheckbox: (a1, a2, a3, a4, a5, a6) => new import_15.InputCheckbox(a1, a2, a3, a4, a5, a6),
  import_15.InputTextLike: (a1, a2, a3, a4) => new import_15.InputTextLike(a1, a2, a3, a4),
  import_15.InputNumberLike: (a1, a2, a3, a4) => new import_15.InputNumberLike(a1, a2, a3, a4),
  import_15.NgBindTypeForDateLike: (a1) => new import_15.NgBindTypeForDateLike(a1),
  import_15.InputDateLike: (a1, a2, a3, a4, a5) => new import_15.InputDateLike(a1, a2, a3, a4, a5),
  import_15.NgValue: (a1) => new import_15.NgValue(a1),
  import_15.NgTrueValue: (a1) => new import_15.NgTrueValue(a1),
  import_15.NgFalseValue: (a1) => new import_15.NgFalseValue(a1),
  import_15.InputRadio: (a1, a2, a3, a4, a5) => new import_15.InputRadio(a1, a2, a3, a4, a5),
  import_15.ContentEditable: (a1, a2, a3, a4) => new import_15.ContentEditable(a1, a2, a3, a4),
  import_15.NgPluralize: (a1, a2, a3, a4) => new import_15.NgPluralize(a1, a2, a3, a4),
  import_15.NgRepeat: (a1, a2, a3, a4, a5) => new import_15.NgRepeat(a1, a2, a3, a4, a5),
  import_15.NgTemplate: (a1, a2) => new import_15.NgTemplate(a1, a2),
  import_15.NgHide: (a1, a2) => new import_15.NgHide(a1, a2),
  import_15.NgShow: (a1, a2) => new import_15.NgShow(a1, a2),
  import_15.NgBooleanAttribute: (a1) => new import_15.NgBooleanAttribute(a1),
  import_15.NgSource: (a1) => new import_15.NgSource(a1),
  import_15.NgAttribute: (a1) => new import_15.NgAttribute(a1),
  import_15.NgStyle: (a1, a2) => new import_15.NgStyle(a1, a2),
  import_15.NgSwitch: (a1) => new import_15.NgSwitch(a1),
  import_15.NgSwitchWhen: (a1, a2, a3) => new import_15.NgSwitchWhen(a1, a2, a3),
  import_15.NgSwitchDefault: (a1, a2, a3) => new import_15.NgSwitchDefault(a1, a2, a3),
  import_15.NgNonBindable: () => new import_15.NgNonBindable(),
  import_15.InputSelect: (a1, a2, a3, a4) => new import_15.InputSelect(a1, a2, a3, a4),
  import_15.OptionValue: (a1, a2, a3) => new import_15.OptionValue(a1, a2, a3),
  import_15.NgForm: (a1, a2, a3, a4) => new import_15.NgForm(a1, a2, a3, a4),
  import_15.NgModelRequiredValidator: (a1) => new import_15.NgModelRequiredValidator(a1),
  import_15.NgModelUrlValidator: (a1) => new import_15.NgModelUrlValidator(a1),
  import_15.NgModelColorValidator: (a1) => new import_15.NgModelColorValidator(a1),
  import_15.NgModelEmailValidator: (a1) => new import_15.NgModelEmailValidator(a1),
  import_15.NgModelNumberValidator: (a1) => new import_15.NgModelNumberValidator(a1),
  import_15.NgModelMaxNumberValidator: (a1) => new import_15.NgModelMaxNumberValidator(a1),
  import_15.NgModelMinNumberValidator: (a1) => new import_15.NgModelMinNumberValidator(a1),
  import_15.NgModelPatternValidator: (a1) => new import_15.NgModelPatternValidator(a1),
  import_15.NgModelMinLengthValidator: (a1) => new import_15.NgModelMinLengthValidator(a1),
  import_15.NgModelMaxLengthValidator: (a1) => new import_15.NgModelMaxLengthValidator(a1),
  import_15.NgModelOptions: () => new import_15.NgModelOptions(),
  import_7.Parser: (a1, a2, a3) => new import_7.Parser(a1, a2, a3),
  import_7.RuntimeParserBackend: (a1) => new import_7.RuntimeParserBackend(a1),
  import_5.FormatterMap: (a1, a2) => new import_5.FormatterMap(a1, a2),
  import_1.ExceptionHandler: () => new import_1.ExceptionHandler(),
  import_1.Interpolate: (a1) => new import_1.Interpolate(a1),
  import_1.ScopeDigestTTL: () => new import_1.ScopeDigestTTL(),
  import_1.ScopeStats: (a1, a2) => new import_1.ScopeStats(a1, a2),
  import_1.ScopeStatsEmitter: () => new import_1.ScopeStatsEmitter(),
  import_1.ScopeStatsConfig: () => new import_1.ScopeStatsConfig(),
  import_1.RootScope: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) => new import_1.RootScope(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11),
  import_10.PendingAsync: () => new import_10.PendingAsync(),
  import_17.Lexer: () => new import_17.Lexer(),
  import_8.ASTParser: (a1, a2) => new import_8.ASTParser(a1, a2),
  import_14.CacheRegister: () => new import_14.CacheRegister(),
  import_13.ResourceUrlResolver: (a1, a2) => new import_13.ResourceUrlResolver(a1, a2),
  import_13.ResourceResolverConfig: () => new import_13.ResourceResolverConfig(),
  import_19.Currency: () => new import_19.Currency(),
  import_19.Date: () => new import_19.Date(),
  import_19.Filter: (a1) => new import_19.Filter(a1),
  import_19.Json: () => new import_19.Json(),
  import_19.LimitTo: (a1) => new import_19.LimitTo(a1),
  import_19.Lowercase: () => new import_19.Lowercase(),
  import_19.Arrayify: () => new import_19.Arrayify(),
  import_19.Number: () => new import_19.Number(),
  import_19.OrderBy: (a1) => new import_19.OrderBy(a1),
  import_19.Uppercase: () => new import_19.Uppercase(),
  import_19.Stringify: () => new import_19.Stringify(),
  import_20.AnimationLoop: (a1, a2, a3) => new import_20.AnimationLoop(a1, a2, a3),
  import_20.AnimationFrame: (a1) => new import_20.AnimationFrame(a1),
  import_20.AnimationOptimizer: (a1) => new import_20.AnimationOptimizer(a1),
  import_20.CssAnimate: (a1, a2, a3) => new import_20.CssAnimate(a1, a2, a3),
  import_20.CssAnimationMap: () => new import_20.CssAnimationMap(),
  import_20.NgAnimate: (a1, a2) => new import_20.NgAnimate(a1, a2),
  import_20.NgAnimateChildren: (a1, a2) => new import_20.NgAnimateChildren(a1, a2),
  import_21.NgRoutingUsePushState: () => new import_21.NgRoutingUsePushState(),
  import_21.NgRoutingHelper: (a1, a2, a3, a4) => new import_21.NgRoutingHelper(a1, a2, a3, a4),
  import_21.NgView: (a1, a2, a3, a4, a5, a6) => new import_21.NgView(a1, a2, a3, a4, a5, a6),
  import_21.NgBindRoute: (a1, a2, a3) => new import_21.NgBindRoute(a1, a2, a3),
  import_24.JsCacheRegister: (a1) => new import_24.JsCacheRegister(a1),
  import_25.LoggerExceptionHandler: () => new import_25.LoggerExceptionHandler(),
  import_26.ProfileService: (a1) => new import_26.ProfileService(a1),
  import_28.PrizesService: (a1) => new import_28.PrizesService(a1),
  import_29.DateTimeService: (a1, a2) => new import_29.DateTimeService(a1, a2),
  import_30.RefreshTimersService: () => new import_30.RefreshTimersService(),
  import_31.TutorialService: (a1, a2, a3, a4) => new import_31.TutorialService(a1, a2, a3, a4),
  import_32.ToolTipService: (a1) => new import_32.ToolTipService(a1),
  import_33.ScreenDetectorService: (a1) => new import_33.ScreenDetectorService(a1),
  import_34.ViewContestComp: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) => new import_34.ViewContestComp(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10),
  import_37.LoadingService: () => new import_37.LoadingService(),
  import_36.FlashMessagesService: () => new import_36.FlashMessagesService(),
  import_35.ContestsService: (a1, a2, a3) => new import_35.ContestsService(a1, a2, a3),
  import_27.DailySoccerServer: (a1) => new import_27.DailySoccerServer(a1),
  import_38.ModalComp: (a1, a2, a3, a4) => new import_38.ModalComp(a1, a2, a3, a4),
  import_39.EnterContestComp: (a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) => new import_39.EnterContestComp(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10),
  import_40.CatalogService: (a1, a2, a3) => new import_40.CatalogService(a1, a2, a3),
  import_41.PaymentService: (a1, a2) => new import_41.PaymentService(a1, a2),
  import_42.AchievementComp: () => new import_42.AchievementComp(),
  import_43.XsNotAvailableScreenComp: () => new import_43.XsNotAvailableScreenComp(),
  import_44.SoccerPlayerStatsComp: (a1, a2, a3, a4, a5, a6) => new import_44.SoccerPlayerStatsComp(a1, a2, a3, a4, a5, a6),
  import_45.SoccerPlayerService: (a1, a2, a3) => new import_45.SoccerPlayerService(a1, a2, a3),
  import_46.HowToCreateContestComp: (a1, a2) => new import_46.HowToCreateContestComp(a1, a2),
  import_47.ChangePasswordComp: (a1, a2, a3, a4, a5) => new import_47.ChangePasswordComp(a1, a2, a3, a4, a5),
  import_48.WeekCalendar: () => new import_48.WeekCalendar(),
  import_49.PromosComp: (a1, a2, a3, a4) => new import_49.PromosComp(a1, a2, a3, a4),
  import_50.PromosService: (a1, a2, a3) => new import_50.PromosService(a1, a2, a3),
  import_51.TranslateFormatter: () => new import_51.TranslateFormatter(),
  import_52.TerminusInfoComp: () => new import_52.TerminusInfoComp(),
  import_53.LeaderboardService: (a1, a2) => new import_53.LeaderboardService(a1, a2),
  import_54.ShopComp: (a1, a2, a3, a4) => new import_54.ShopComp(a1, a2, a3, a4),
  import_55.HomeComp: (a1, a2, a3, a4, a5, a6, a7, a8) => new import_55.HomeComp(a1, a2, a3, a4, a5, a6, a7, a8),
  import_56.NotificationsComp: (a1) => new import_56.NotificationsComp(a1),
  import_57.FacebookService: () => new import_57.FacebookService(),
  import_58.FriendInfoComp: () => new import_58.FriendInfoComp(),
  import_59.ContestHeaderF2PComp: (a1, a2, a3, a4, a5, a6) => new import_59.ContestHeaderF2PComp(a1, a2, a3, a4, a5, a6),
  import_60.TeamsFilterComp: (a1) => new import_60.TeamsFilterComp(a1),
  import_61.PaginatorComp: (a1, a2) => new import_61.PaginatorComp(a1, a2),
  import_62.EditPersonalDataComp: (a1, a2, a3) => new import_62.EditPersonalDataComp(a1, a2, a3),
  import_63.FacebookShareComp: () => new import_63.FacebookShareComp(),
  import_64.MainMenuF2PComp: (a1, a2, a3, a4) => new import_64.MainMenuF2PComp(a1, a2, a3, a4),
  import_65.JoinComp: (a1, a2, a3, a4, a5, a6) => new import_65.JoinComp(a1, a2, a3, a4, a5, a6),
  import_66.AutoFocusDecorator: (a1) => new import_66.AutoFocusDecorator(a1),
  import_67.LegalInfoComp: () => new import_67.LegalInfoComp(),
  import_68.LobbyF2PComp: (a1, a2, a3, a4, a5, a6, a7, a8) => new import_68.LobbyF2PComp(a1, a2, a3, a4, a5, a6, a7, a8),
  import_69.ContestsListF2PComp: (a1, a2) => new import_69.ContestsListF2PComp(a1, a2),
  import_70.MaxTextWidthDirective: (a1) => new import_70.MaxTextWidthDirective(a1),
  import_71.LineupSelectorComp: () => new import_71.LineupSelectorComp(),
  import_72.SocialShareComp: () => new import_72.SocialShareComp(),
  import_73.ScoutingComp: (a1, a2, a3, a4, a5) => new import_73.ScoutingComp(a1, a2, a3, a4, a5),
  import_74.ScoringRulesComp: (a1, a2) => new import_74.ScoringRulesComp(a1, a2),
  import_75.ScoringRulesService: (a1) => new import_75.ScoringRulesService(a1),
  import_76.AchievementListComp: (a1) => new import_76.AchievementListComp(a1),
  import_77.RulesComp: () => new import_77.RulesComp(),
  import_78.HowItWoksComp: (a1) => new import_78.HowItWoksComp(a1),
  import_79.LeaderboardComp: (a1, a2, a3, a4, a5, a6) => new import_79.LeaderboardComp(a1, a2, a3, a4, a5, a6),
  import_80.LimitToDot: () => new import_80.LimitToDot(),
  import_81.FlashMessageComp: (a1, a2, a3) => new import_81.FlashMessageComp(a1, a2, a3),
  import_82.SoccerPlayersFilterComp: (a1) => new import_82.SoccerPlayersFilterComp(a1),
  import_83.LeaderboardTableComp: () => new import_83.LeaderboardTableComp(),
  import_84.NgBindHtmlUnsafeDirective: (a1) => new import_84.NgBindHtmlUnsafeDirective(a1),
  import_85.UserProfileComp: (a1, a2, a3, a4) => new import_85.UserProfileComp(a1, a2, a3, a4),
  import_86.LoginComp: (a1, a2, a3, a4, a5) => new import_86.LoginComp(a1, a2, a3, a4, a5),
  import_87.CreateContestComp: (a1, a2) => new import_87.CreateContestComp(a1, a2),
  import_88.ContestInfoComp: (a1, a2, a3, a4, a5, a6, a7) => new import_88.ContestInfoComp(a1, a2, a3, a4, a5, a6, a7),
  import_89.ScoutingLeagueComp: (a1, a2) => new import_89.ScoutingLeagueComp(a1, a2),
  import_90.TeamsPanelComp: (a1, a2, a3) => new import_90.TeamsPanelComp(a1, a2, a3),
  import_91.WelcomeComp: (a1, a2, a3, a4, a5) => new import_91.WelcomeComp(a1, a2, a3, a4, a5),
  import_92.PolicyInfoComp: () => new import_92.PolicyInfoComp(),
  import_93.MyContestsComp: (a1, a2, a3, a4, a5, a6, a7, a8, a9) => new import_93.MyContestsComp(a1, a2, a3, a4, a5, a6, a7, a8, a9),
  import_94.ResourceUrlResolverWrapper: (a1, a2) => new import_94.ResourceUrlResolverWrapper(a1, a2),
  import_95.TutorialsComp: (a1, a2) => new import_95.TutorialsComp(a1, a2),
  import_96.MatchesFilterComp: (a1, a2) => new import_96.MatchesFilterComp(a1, a2),
  import_97.FormAutofillDecorator: (a1) => new import_97.FormAutofillDecorator(a1),
  import_98.FriendsBarComp: () => new import_98.FriendsBarComp(),
  import_99.HelpInfoComp: (a1, a2) => new import_99.HelpInfoComp(a1, a2),
  import_100.DefaultPlatformNoShim: () => new import_100.DefaultPlatformNoShim(),
  import_100.PlatformJsBasedNoShim: () => new import_100.PlatformJsBasedNoShim(),
  import_101.RememberPasswordComp: (a1, a2, a3, a4, a5) => new import_101.RememberPasswordComp(a1, a2, a3, a4, a5),
  import_102.FooterComp: (a1, a2, a3, a4, a5, a6, a7) => new import_102.FooterComp(a1, a2, a3, a4, a5, a6, a7),
  import_103.SimplePromoF2PComp: (a1, a2) => new import_103.SimplePromoF2PComp(a1, a2),
  import_104.TwitterShareComp: () => new import_104.TwitterShareComp(),
  import_105.FantasyTeamComp: (a1, a2, a3) => new import_105.FantasyTeamComp(a1, a2, a3),
  import_106.UsersListComp: (a1, a2) => new import_106.UsersListComp(a1, a2),
  import_107.SoccerPlayersListComp: (a1, a2, a3, a4) => new import_107.SoccerPlayersListComp(a1, a2, a3, a4),
  import_108.PaymentResponseComp: (a1, a2, a3) => new import_108.PaymentResponseComp(a1, a2, a3),
  import_109.ViewContestEntryComp: (a1, a2, a3, a4, a5, a6, a7) => new import_109.ViewContestEntryComp(a1, a2, a3, a4, a5, a6, a7),
  import_110.TranslateDecorator: (a1) => new import_110.TranslateDecorator(a1),
  import_111.TutorialListComp: (a1) => new import_111.TutorialListComp(a1),
  import_2.Profiler: () => new import_2.Profiler(),
};
final Map<Type, List<Key>> parameterKeys = {
  import_0.Animate: const[],
  import_0.BrowserCookies: [_KEY_ExceptionHandler],
  import_0.Cookies: [_KEY_BrowserCookies],
  import_0.Compiler: [_KEY_Profiler, _KEY_Expando],
  import_0.CompilerConfig: const[],
  import_0.DirectiveMap: [_KEY_Injector, _KEY_FormatterMap, _KEY_MetadataExtractor, _KEY_DirectiveSelectorFactory],
  import_0.ElementBinderFactory: [_KEY_Parser, _KEY_Profiler, _KEY_CompilerConfig, _KEY_Expando, _KEY_ASTParser, _KEY_ComponentFactory, _KEY_ShadowDomComponentFactory, _KEY_TranscludingComponentFactory],
  import_0.EventHandler: [_KEY_Node, _KEY_Expando, _KEY_ExceptionHandler],
  import_0.ShadowRootEventHandler: [_KEY_ShadowRoot, _KEY_Expando, _KEY_ExceptionHandler],
  import_0.DefaultShadowBoundary: const[],
  import_0.ShadowRootBoundary: [_KEY_ShadowRoot],
  import_0.UrlRewriter: const[],
  import_0.HttpBackend: const[],
  import_0.LocationWrapper: const[],
  import_0.HttpInterceptors: const[],
  import_0.HttpDefaultHeaders: const[],
  import_0.HttpDefaults: [_KEY_HttpDefaultHeaders],
  import_0.Http: [_KEY_BrowserCookies, _KEY_LocationWrapper, _KEY_UrlRewriter, _KEY_HttpBackend, _KEY_HttpDefaults, _KEY_HttpInterceptors, _KEY_RootScope, _KEY_HttpConfig, _KEY_VmTurnZone, _KEY_PendingAsync],
  import_0.HttpConfig: const[],
  import_0.TextMustache: [_KEY_Node, _KEY_AST, _KEY_Scope],
  import_0.AttrMustache: [_KEY_NodeAttrs, _KEY_String, _KEY_AST, _KEY_Scope],
  import_0.NgElement: [_KEY_Element, _KEY_RootScope, _KEY_Animate, _KEY_DestinationLightDom],
  import_0.DirectiveSelectorFactory: [_KEY_ElementBinderFactory, _KEY_Interpolate, _KEY_ASTParser, _KEY_FormatterMap, _KEY_Injector],
  import_0.ShadowDomComponentFactory: [_KEY_ViewFactoryCache, _KEY_PlatformJsBasedShim, _KEY_Expando, _KEY_CompilerConfig, _KEY_TypeToUriMapper, _KEY_ResourceUrlResolver, _KEY_Http, _KEY_TemplateCache, _KEY_ComponentCssRewriter, _KEY_NodeTreeSanitizer, _KEY_CacheRegister],
  import_0.ComponentCssRewriter: const[],
  import_0.TranscludingComponentFactory: [_KEY_Expando, _KEY_ViewFactoryCache, _KEY_CompilerConfig, _KEY_DefaultPlatformShim, _KEY_TypeToUriMapper, _KEY_ResourceUrlResolver, _KEY_Http, _KEY_TemplateCache, _KEY_ComponentCssRewriter, _KEY_NodeTreeSanitizer, _KEY_CacheRegister],
  import_0.Content: [_KEY_Element, _KEY_SourceLightDom, _KEY_DestinationLightDom, _KEY_View],
  import_0.NullTreeSanitizer: const[],
  import_0.ViewFactoryCache: [_KEY_Http, _KEY_TemplateCache, _KEY_Compiler, _KEY_NodeTreeSanitizer, _KEY_ResourceUrlResolver, _KEY_CacheRegister],
  import_0.PlatformJsBasedShim: const[],
  import_0.DefaultPlatformShim: const[],
  import_15.AHref: [_KEY_Element, _KEY_VmTurnZone],
  import_15.NgBaseCss: const[],
  import_15.NgBind: [_KEY_Element, _KEY_ElementProbe],
  import_15.NgBindHtml: [_KEY_Element, _KEY_NodeValidator],
  import_15.NgBindTemplate: [_KEY_Element],
  import_15.NgClass: [_KEY_NgElement, _KEY_Scope, _KEY_NodeAttrs],
  import_15.NgClassOdd: [_KEY_NgElement, _KEY_Scope, _KEY_NodeAttrs],
  import_15.NgClassEven: [_KEY_NgElement, _KEY_Scope, _KEY_NodeAttrs],
  import_15.NgEvent: [_KEY_Element, _KEY_Scope],
  import_15.NgCloak: [_KEY_Element, _KEY_Animate],
  import_15.NgIf: [_KEY_ViewFactory, _KEY_ViewPort, _KEY_Scope],
  import_15.NgUnless: [_KEY_ViewFactory, _KEY_ViewPort, _KEY_Scope],
  import_15.NgInclude: [_KEY_Element, _KEY_Scope, _KEY_ViewFactoryCache, _KEY_DirectiveInjector, _KEY_DirectiveMap],
  import_15.NgModel: [_KEY_Scope, _KEY_NgElement, _KEY_DirectiveInjector, _KEY_NodeAttrs, _KEY_Animate, _KEY_ElementProbe],
  import_15.InputCheckbox: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgTrueValue, _KEY_NgFalseValue, _KEY_NgModelOptions],
  import_15.InputTextLike: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgModelOptions],
  import_15.InputNumberLike: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgModelOptions],
  import_15.NgBindTypeForDateLike: [_KEY_Element],
  import_15.InputDateLike: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgBindTypeForDateLike, _KEY_NgModelOptions],
  import_15.NgValue: [_KEY_Element],
  import_15.NgTrueValue: [_KEY_Element],
  import_15.NgFalseValue: [_KEY_Element],
  import_15.InputRadio: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgValue, _KEY_NodeAttrs],
  import_15.ContentEditable: [_KEY_Element, _KEY_NgModel, _KEY_Scope, _KEY_NgModelOptions],
  import_15.NgPluralize: [_KEY_Scope, _KEY_Element, _KEY_Interpolate, _KEY_FormatterMap],
  import_15.NgRepeat: [_KEY_ViewPort, _KEY_BoundViewFactory, _KEY_Scope, _KEY_Parser, _KEY_FormatterMap],
  import_15.NgTemplate: [_KEY_Element, _KEY_TemplateCache],
  import_15.NgHide: [_KEY_Element, _KEY_Animate],
  import_15.NgShow: [_KEY_Element, _KEY_Animate],
  import_15.NgBooleanAttribute: [_KEY_NgElement],
  import_15.NgSource: [_KEY_NgElement],
  import_15.NgAttribute: [_KEY_NodeAttrs],
  import_15.NgStyle: [_KEY_Element, _KEY_Scope],
  import_15.NgSwitch: [_KEY_Scope],
  import_15.NgSwitchWhen: [_KEY_NgSwitch, _KEY_ViewPort, _KEY_BoundViewFactory],
  import_15.NgSwitchDefault: [_KEY_NgSwitch, _KEY_ViewPort, _KEY_BoundViewFactory],
  import_15.NgNonBindable: const[],
  import_15.InputSelect: [_KEY_Element, _KEY_NodeAttrs, _KEY_NgModel, _KEY_Scope],
  import_15.OptionValue: [_KEY_Element, _KEY_InputSelect, _KEY_NgValue],
  import_15.NgForm: [_KEY_Scope, _KEY_NgElement, _KEY_DirectiveInjector, _KEY_Animate],
  import_15.NgModelRequiredValidator: [_KEY_NgModel],
  import_15.NgModelUrlValidator: [_KEY_NgModel],
  import_15.NgModelColorValidator: [_KEY_NgModel],
  import_15.NgModelEmailValidator: [_KEY_NgModel],
  import_15.NgModelNumberValidator: [_KEY_NgModel],
  import_15.NgModelMaxNumberValidator: [_KEY_NgModel],
  import_15.NgModelMinNumberValidator: [_KEY_NgModel],
  import_15.NgModelPatternValidator: [_KEY_NgModel],
  import_15.NgModelMinLengthValidator: [_KEY_NgModel],
  import_15.NgModelMaxLengthValidator: [_KEY_NgModel],
  import_15.NgModelOptions: const[],
  import_7.Parser: [_KEY_Lexer, _KEY_ParserBackend, _KEY_CacheRegister],
  import_7.RuntimeParserBackend: [_KEY_ClosureMap],
  import_5.FormatterMap: [_KEY_Injector, _KEY_MetadataExtractor],
  import_1.ExceptionHandler: const[],
  import_1.Interpolate: [_KEY_CacheRegister],
  import_1.ScopeDigestTTL: const[],
  import_1.ScopeStats: [_KEY_ScopeStatsEmitter, _KEY_ScopeStatsConfig],
  import_1.ScopeStatsEmitter: const[],
  import_1.ScopeStatsConfig: const[],
  import_1.RootScope: [_KEY_Object, _KEY_Parser, _KEY_ASTParser, _KEY_FieldGetterFactory, _KEY_FormatterMap, _KEY_ExceptionHandler, _KEY_ScopeDigestTTL, _KEY_VmTurnZone, _KEY_ScopeStats, _KEY_CacheRegister, _KEY_PendingAsync],
  import_10.PendingAsync: const[],
  import_17.Lexer: const[],
  import_8.ASTParser: [_KEY_Parser, _KEY_ClosureMap],
  import_14.CacheRegister: const[],
  import_13.ResourceUrlResolver: [_KEY_TypeToUriMapper, _KEY_ResourceResolverConfig],
  import_13.ResourceResolverConfig: const[],
  import_19.Currency: const[],
  import_19.Date: const[],
  import_19.Filter: [_KEY_Parser],
  import_19.Json: const[],
  import_19.LimitTo: [_KEY_Injector],
  import_19.Lowercase: const[],
  import_19.Arrayify: const[],
  import_19.Number: const[],
  import_19.OrderBy: [_KEY_Parser],
  import_19.Uppercase: const[],
  import_19.Stringify: const[],
  import_20.AnimationLoop: [_KEY_AnimationFrame, _KEY_Profiler, _KEY_VmTurnZone],
  import_20.AnimationFrame: [_KEY_Window],
  import_20.AnimationOptimizer: [_KEY_Expando],
  import_20.CssAnimate: [_KEY_AnimationLoop, _KEY_CssAnimationMap, _KEY_AnimationOptimizer],
  import_20.CssAnimationMap: const[],
  import_20.NgAnimate: [_KEY_Element, _KEY_AnimationOptimizer],
  import_20.NgAnimateChildren: [_KEY_Element, _KEY_AnimationOptimizer],
  import_21.NgRoutingUsePushState: const[],
  import_21.NgRoutingHelper: [_KEY_RouteInitializer, _KEY_Injector, _KEY_Router, _KEY_Application],
  import_21.NgView: [_KEY_Element, _KEY_ViewFactoryCache, _KEY_DirectiveInjector, _KEY_Injector, _KEY_Router, _KEY_Scope],
  import_21.NgBindRoute: [_KEY_Router, _KEY_DirectiveInjector, _KEY_NgRoutingHelper],
  import_24.JsCacheRegister: [_KEY_CacheRegister],
  import_25.LoggerExceptionHandler: const[],
  import_26.ProfileService: [_KEY_ServerService],
  import_28.PrizesService: [_KEY_ServerService],
  import_29.DateTimeService: [_KEY_ServerService, _KEY_RefreshTimersService],
  import_30.RefreshTimersService: const[],
  import_31.TutorialService: [_KEY_Router, _KEY_ProfileService, _KEY_ToolTipService, _KEY_ScreenDetectorService],
  import_32.ToolTipService: [_KEY_ScreenDetectorService],
  import_33.ScreenDetectorService: [_KEY_VmTurnZone],
  import_34.ViewContestComp: [_KEY_VmTurnZone, _KEY_RouteProvider, _KEY_Router, _KEY_ScreenDetectorService, _KEY_RefreshTimersService, _KEY_ContestsService, _KEY_ProfileService, _KEY_FlashMessagesService, _KEY_LoadingService, _KEY_TutorialService],
  import_37.LoadingService: const[],
  import_36.FlashMessagesService: const[],
  import_35.ContestsService: [_KEY_ServerService, _KEY_ProfileService, _KEY_PrizesService],
  import_27.DailySoccerServer: [_KEY_Http],
  import_38.ModalComp: [_KEY_Router, _KEY_Element, _KEY_ScreenDetectorService, _KEY_View],
  import_39.EnterContestComp: [_KEY_RouteProvider, _KEY_Router, _KEY_ScreenDetectorService, _KEY_ContestsService, _KEY_LoadingService, _KEY_ProfileService, _KEY_CatalogService, _KEY_FlashMessagesService, _KEY_Element, _KEY_TutorialService],
  import_40.CatalogService: [_KEY_ServerService, _KEY_ProfileService, _KEY_PaymentService],
  import_41.PaymentService: [_KEY_ProfileService, _KEY_ServerService],
  import_42.AchievementComp: const[],
  import_43.XsNotAvailableScreenComp: const[],
  import_44.SoccerPlayerStatsComp: [_KEY_FlashMessagesService, _KEY_ScreenDetectorService, _KEY_SoccerPlayerService, _KEY_RouteProvider, _KEY_Router, _KEY_Element],
  import_45.SoccerPlayerService: [_KEY_ServerService, _KEY_ContestsService, _KEY_ProfileService],
  import_46.HowToCreateContestComp: [_KEY_ScreenDetectorService, _KEY_Router],
  import_47.ChangePasswordComp: [_KEY_Router, _KEY_RouteProvider, _KEY_ProfileService, _KEY_Element, _KEY_LoadingService],
  import_48.WeekCalendar: const[],
  import_49.PromosComp: [_KEY_ScreenDetectorService, _KEY_PromosService, _KEY_Router, _KEY_RefreshTimersService],
  import_50.PromosService: [_KEY_Router, _KEY_ServerService, _KEY_RefreshTimersService],
  import_51.TranslateFormatter: const[],
  import_52.TerminusInfoComp: const[],
  import_53.LeaderboardService: [_KEY_ServerService, _KEY_ProfileService],
  import_54.ShopComp: [_KEY_FlashMessagesService, _KEY_ProfileService, _KEY_CatalogService, _KEY_TutorialService],
  import_55.HomeComp: [_KEY_Router, _KEY_ProfileService, _KEY_ContestsService, _KEY_FlashMessagesService, _KEY_LoadingService, _KEY_RefreshTimersService, _KEY_PromosService, _KEY_TutorialService],
  import_56.NotificationsComp: [_KEY_ProfileService],
  import_57.FacebookService: const[],
  import_58.FriendInfoComp: const[],
  import_59.ContestHeaderF2PComp: [_KEY_Router, _KEY_RouteProvider, _KEY_ProfileService, _KEY_ScreenDetectorService, _KEY_ContestsService, _KEY_Element],
  import_60.TeamsFilterComp: [_KEY_View],
  import_61.PaginatorComp: [_KEY_ScreenDetectorService, _KEY_Element],
  import_62.EditPersonalDataComp: [_KEY_ProfileService, _KEY_LoadingService, _KEY_Router],
  import_63.FacebookShareComp: const[],
  import_64.MainMenuF2PComp: [_KEY_Router, _KEY_ProfileService, _KEY_ScreenDetectorService, _KEY_Element],
  import_65.JoinComp: [_KEY_Router, _KEY_RouteProvider, _KEY_ProfileService, _KEY_LoadingService, _KEY_Element, _KEY_ScreenDetectorService],
  import_66.AutoFocusDecorator: [_KEY_Element],
  import_67.LegalInfoComp: const[],
  import_68.LobbyF2PComp: [_KEY_RouteProvider, _KEY_Router, _KEY_RefreshTimersService, _KEY_ContestsService, _KEY_ScreenDetectorService, _KEY_LoadingService, _KEY_ProfileService, _KEY_TutorialService],
  import_69.ContestsListF2PComp: [_KEY_ScreenDetectorService, _KEY_ProfileService],
  import_70.MaxTextWidthDirective: [_KEY_Element],
  import_71.LineupSelectorComp: const[],
  import_72.SocialShareComp: const[],
  import_73.ScoutingComp: [_KEY_RouteProvider, _KEY_Router, _KEY_LoadingService, _KEY_ProfileService, _KEY_SoccerPlayerService],
  import_74.ScoringRulesComp: [_KEY_ScoringRulesService, _KEY_FlashMessagesService],
  import_75.ScoringRulesService: [_KEY_ServerService],
  import_76.AchievementListComp: [_KEY_ProfileService],
  import_77.RulesComp: const[],
  import_78.HowItWoksComp: [_KEY_ScreenDetectorService],
  import_79.LeaderboardComp: [_KEY_LeaderboardService, _KEY_LoadingService, _KEY_ProfileService, _KEY_Router, _KEY_RouteProvider, _KEY_Element],
  import_80.LimitToDot: const[],
  import_81.FlashMessageComp: [_KEY_FlashMessagesService, _KEY_ServerService, _KEY_Element],
  import_82.SoccerPlayersFilterComp: [_KEY_ScreenDetectorService],
  import_83.LeaderboardTableComp: const[],
  import_84.NgBindHtmlUnsafeDirective: [_KEY_Element],
  import_85.UserProfileComp: [_KEY_Router, _KEY_ProfileService, _KEY_LoadingService, _KEY_LeaderboardService],
  import_86.LoginComp: [_KEY_Router, _KEY_ProfileService, _KEY_LoadingService, _KEY_Element, _KEY_ScreenDetectorService],
  import_87.CreateContestComp: [_KEY_Router, _KEY_ContestsService],
  import_88.ContestInfoComp: [_KEY_ScreenDetectorService, _KEY_RouteProvider, _KEY_LoadingService, _KEY_Router, _KEY_ContestsService, _KEY_ProfileService, _KEY_FlashMessagesService],
  import_89.ScoutingLeagueComp: [_KEY_RouteProvider, _KEY_Router],
  import_90.TeamsPanelComp: [_KEY_ScreenDetectorService, _KEY_ContestsService, _KEY_RouteProvider],
  import_91.WelcomeComp: [_KEY_Element, _KEY_Router, _KEY_RouteProvider, _KEY_ScreenDetectorService, _KEY_ProfileService],
  import_92.PolicyInfoComp: const[],
  import_93.MyContestsComp: [_KEY_LoadingService, _KEY_ProfileService, _KEY_RefreshTimersService, _KEY_ContestsService, _KEY_Router, _KEY_RouteProvider, _KEY_FlashMessagesService, _KEY_Element, _KEY_TutorialService],
  import_94.ResourceUrlResolverWrapper: [_KEY_TypeToUriMapper, _KEY_ResourceResolverConfig],
  import_95.TutorialsComp: [_KEY_TutorialService, _KEY_Router],
  import_96.MatchesFilterComp: [_KEY_ScreenDetectorService, _KEY_View],
  import_97.FormAutofillDecorator: [_KEY_Element],
  import_98.FriendsBarComp: const[],
  import_99.HelpInfoComp: [_KEY_ScreenDetectorService, _KEY_Router],
  import_100.DefaultPlatformNoShim: const[],
  import_100.PlatformJsBasedNoShim: const[],
  import_101.RememberPasswordComp: [_KEY_Router, _KEY_ProfileService, _KEY_LoadingService, _KEY_ServerService, _KEY_Element],
  import_102.FooterComp: [_KEY_Router, _KEY_LoadingService, _KEY_View, _KEY_Element, _KEY_DateTimeService, _KEY_ScreenDetectorService, _KEY_ProfileService],
  import_103.SimplePromoF2PComp: [_KEY_Router, _KEY_Element],
  import_104.TwitterShareComp: const[],
  import_105.FantasyTeamComp: [_KEY_RouteProvider, _KEY_Router, _KEY_Element],
  import_106.UsersListComp: [_KEY_RouteProvider, _KEY_ProfileService],
  import_107.SoccerPlayersListComp: [_KEY_ScreenDetectorService, _KEY_Element, _KEY_VmTurnZone, _KEY_ProfileService],
  import_108.PaymentResponseComp: [_KEY_RouteProvider, _KEY_Router, _KEY_PaymentService],
  import_109.ViewContestEntryComp: [_KEY_RouteProvider, _KEY_ScreenDetectorService, _KEY_ContestsService, _KEY_ProfileService, _KEY_Router, _KEY_LoadingService, _KEY_TutorialService],
  import_110.TranslateDecorator: [_KEY_Element],
  import_111.TutorialListComp: [_KEY_Router],
  import_2.Profiler: const[],
};
setStaticReflectorAsDefault() => Module.DEFAULT_REFLECTOR = new GeneratedTypeFactories(typeFactories, parameterKeys);
