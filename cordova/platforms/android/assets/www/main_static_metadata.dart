library webclient.web.main.generated_metadata;

import 'package:angular/core/registry.dart' show MetadataExtractor;
import 'package:di/di.dart' show Module;

import 'package:angular/core_dom/module_internal.dart' as import_0;
import 'package:di/annotations.dart' as import_1;
import 'package:angular/core/annotation_src.dart' as import_2;
import 'package:angular/directive/module.dart' as import_3;
import 'package:angular/core/parser/parser.dart' as import_4;
import 'package:angular/core/formatter.dart' as import_5;
import 'package:angular/core/module_internal.dart' as import_6;
import 'package:angular/core/pending_async.dart' as import_7;
import 'package:angular/core/parser/lexer.dart' as import_8;
import 'package:angular/change_detection/ast_parser.dart' as import_9;
import 'package:angular/cache/module.dart' as import_10;
import 'package:angular/core_dom/resource_url_resolver.dart' as import_11;
import 'package:angular/formatter/module_internal.dart' as import_12;
import 'package:angular/animate/module.dart' as import_13;
import 'package:angular/routing/module.dart' as import_14;
import 'package:angular/cache/js_cache_register.dart' as import_15;
import 'package:webclient/logger_exception_handler.dart' as import_16;
import 'package:webclient/services/profile_service.dart' as import_17;
import 'package:webclient/services/prizes_service.dart' as import_18;
import 'package:webclient/services/datetime_service.dart' as import_19;
import 'package:webclient/services/refresh_timers_service.dart' as import_20;
import 'package:webclient/services/tutorial_service.dart' as import_21;
import 'package:webclient/services/tooltip_service.dart' as import_22;
import 'package:webclient/services/screen_detector_service.dart' as import_23;
import 'package:webclient/components/view_contest/view_contest_comp.dart' as import_24;
import 'package:webclient/services/loading_service.dart' as import_25;
import 'package:webclient/services/flash_messages_service.dart' as import_26;
import 'package:webclient/services/contests_service.dart' as import_27;
import 'package:webclient/services/server_service.dart' as import_28;
import 'package:webclient/components/modal_comp.dart' as import_29;
import 'package:webclient/components/enter_contest/enter_contest_comp.dart' as import_30;
import 'package:webclient/services/catalog_service.dart' as import_31;
import 'package:webclient/services/payment_service.dart' as import_32;
import 'package:webclient/components/achievement_comp.dart' as import_33;
import 'package:webclient/components/navigation/xs_not_available_screen_comp.dart' as import_34;
import 'package:webclient/components/enter_contest/soccer_player_stats_comp.dart' as import_35;
import 'package:webclient/services/soccer_player_service.dart' as import_36;
import 'package:webclient/components/legalese_and_help/how_to_create_contest_comp.dart' as import_37;
import 'package:webclient/components/account/change_password_comp.dart' as import_38;
import 'package:webclient/components/week_calendar_comp.dart' as import_39;
import 'package:webclient/components/promos_comp.dart' as import_40;
import 'package:webclient/services/promos_service.dart' as import_41;
import 'package:webclient/utils/translate_formatter.dart' as import_42;
import 'package:webclient/components/legalese_and_help/terminus_info_comp.dart' as import_43;
import 'package:webclient/services/leaderboard_service.dart' as import_44;
import 'package:webclient/components/account/shop_comp.dart' as import_45;
import 'package:webclient/components/home_comp.dart' as import_46;
import 'package:webclient/components/account/notifications_comp.dart' as import_47;
import 'package:webclient/services/facebook_service.dart' as import_48;
import 'package:webclient/components/social/friend_info_comp.dart' as import_49;
import 'package:webclient/components/contest_header_f2p_comp.dart' as import_50;
import 'package:webclient/components/scouting/teams_filter_comp.dart' as import_51;
import 'package:webclient/components/paginator_comp.dart' as import_52;
import 'package:webclient/components/account/edit_personal_data_comp.dart' as import_53;
import 'package:webclient/components/social/facebook_share_comp.dart' as import_54;
import 'package:webclient/components/navigation/main_menu_f2p_comp.dart' as import_55;
import 'package:webclient/components/account/join_comp.dart' as import_56;
import 'package:webclient/utils/element-autofocus.dart' as import_57;
import 'package:webclient/components/legalese_and_help/legal_info_comp.dart' as import_58;
import 'package:webclient/components/lobby_f2p_comp.dart' as import_59;
import 'package:webclient/components/contests_list_f2p_comp.dart' as import_60;
import 'package:webclient/utils/max_text_width.dart' as import_61;
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart' as import_62;
import 'package:webclient/components/social/social_share_comp.dart' as import_63;
import 'package:webclient/components/scouting/scouting_comp.dart' as import_64;
import 'package:webclient/components/scoring_rules_comp.dart' as import_65;
import 'package:webclient/services/scoring_rules_service.dart' as import_66;
import 'package:webclient/components/achievement_list_comp.dart' as import_67;
import 'package:webclient/components/legalese_and_help/rules_comp.dart' as import_68;
import 'package:webclient/components/legalese_and_help/how_it_works_comp.dart' as import_69;
import 'package:webclient/components/leaderboard_comp.dart' as import_70;
import 'package:webclient/utils/limit_to_dot.dart' as import_71;
import 'package:webclient/components/flash_messages_comp.dart' as import_72;
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart' as import_73;
import 'package:webclient/components/leaderboard_table_comp.dart' as import_74;
import 'package:webclient/utils/ng_bind_html_unsafe.dart' as import_75;
import 'package:webclient/components/account/user_profile_comp.dart' as import_76;
import 'package:webclient/components/account/login_comp.dart' as import_77;
import 'package:webclient/components/create_contest_comp.dart' as import_78;
import 'package:webclient/components/contest_info_comp.dart' as import_79;
import 'package:webclient/components/scouting/scouting_league_comp.dart' as import_80;
import 'package:webclient/components/view_contest/teams_panel_comp.dart' as import_81;
import 'package:webclient/components/welcome_comp.dart' as import_82;
import 'package:webclient/components/legalese_and_help/policy_info_comp.dart' as import_83;
import 'package:webclient/components/my_contests_comp.dart' as import_84;
import 'package:webclient/components/legalese_and_help/tutorials_comp.dart' as import_85;
import 'package:webclient/components/enter_contest/matches_filter_comp.dart' as import_86;
import 'package:webclient/utils/form-autofill-fix.dart' as import_87;
import 'package:webclient/components/social/friends_bar_comp.dart' as import_88;
import 'package:webclient/components/legalese_and_help/help_info_comp.dart' as import_89;
import 'package:webclient/utils/noshim.dart' as import_90;
import 'package:webclient/components/account/remember_password_comp.dart' as import_91;
import 'package:webclient/components/navigation/footer_comp.dart' as import_92;
import 'package:webclient/components/simple_promo_f2p_comp.dart' as import_93;
import 'package:webclient/components/social/twitter_share_comp.dart' as import_94;
import 'package:webclient/components/view_contest/fantasy_team_comp.dart' as import_95;
import 'package:webclient/components/view_contest/users_list_comp.dart' as import_96;
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart' as import_97;
import 'package:webclient/components/account/payment_response_comp.dart' as import_98;
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart' as import_99;
import 'package:webclient/utils/translate_decorator.dart' as import_100;
import 'package:webclient/components/tutorial_list_comp.dart' as import_101;
Module get metadataModule => new Module()
    ..bind(MetadataExtractor, toValue: new _StaticMetadataExtractor());

class _StaticMetadataExtractor implements MetadataExtractor {
  Iterable call(Type type) {
    var annotations = typeAnnotations[type];
    if (annotations != null) {
      return annotations;
    }
    return [];
  }
}

final Map<Type, Object> typeAnnotations = {
  import_0.Animate: const [
    const import_1.Injectable(),
  ],
  import_0.BrowserCookies: const [
    const import_1.Injectable(),
  ],
  import_0.Cookies: const [
    const import_1.Injectable(),
  ],
  import_0.Compiler: const [
    const import_1.Injectable(),
  ],
  import_0.CompilerConfig: const [
    const import_1.Injectable(),
  ],
  import_0.DirectiveMap: const [
    const import_1.Injectable(),
  ],
  import_0.ElementBinderFactory: const [
    const import_1.Injectable(),
  ],
  import_0.EventHandler: const [
    const import_1.Injectable(),
  ],
  import_0.ShadowRootEventHandler: const [
    const import_1.Injectable(),
  ],
  import_0.DefaultShadowBoundary: const [
    const import_1.Injectable(),
  ],
  import_0.ShadowRootBoundary: const [
    const import_1.Injectable(),
  ],
  import_0.UrlRewriter: const [
    const import_1.Injectable(),
  ],
  import_0.HttpBackend: const [
    const import_1.Injectable(),
  ],
  import_0.LocationWrapper: const [
    const import_1.Injectable(),
  ],
  import_0.HttpInterceptors: const [
    const import_1.Injectable(),
  ],
  import_0.HttpDefaultHeaders: const [
    const import_1.Injectable(),
  ],
  import_0.HttpDefaults: const [
    const import_1.Injectable(),
  ],
  import_0.Http: const [
    const import_1.Injectable(),
  ],
  import_0.HttpConfig: const [
    const import_1.Injectable(),
  ],
  import_0.TextMustache: const [
    const import_2.Decorator(selector: r':contains(/{{.*}}/)'),
  ],
  import_0.AttrMustache: const [
    const import_2.Decorator(selector: r'[*=/{{.*}}/]'),
  ],
  import_0.NgElement: const [
    const import_1.Injectable(),
  ],
  import_0.DirectiveSelectorFactory: const [
    const import_1.Injectable(),
  ],
  import_0.ShadowDomComponentFactory: const [
    const import_1.Injectable(),
  ],
  import_0.ComponentCssRewriter: const [
    const import_1.Injectable(),
  ],
  import_0.TranscludingComponentFactory: const [
    const import_1.Injectable(),
  ],
  import_0.Content: const [
    const import_2.Decorator(selector: 'content', map: const {'select': '@select'}),
  ],
  import_0.NullTreeSanitizer: const [
    const import_1.Injectable(),
  ],
  import_0.ViewFactoryCache: const [
    const import_1.Injectable(),
  ],
  import_0.PlatformJsBasedShim: const [
    const import_1.Injectable(),
  ],
  import_0.DefaultPlatformShim: const [
    const import_1.Injectable(),
  ],
  import_3.AHref: const [
    const import_2.Decorator(selector: 'a[href]'),
  ],
  import_3.NgBaseCss: const [
    const import_2.Decorator(selector: '[ng-base-css]', visibility: import_2.Visibility.CHILDREN, map: const {'ng-base-css': '@urls'}),
  ],
  import_3.NgBind: const [
    const import_2.Decorator(selector: '[ng-bind]', map: const {'ng-bind': '=>value'}),
  ],
  import_3.NgBindHtml: const [
    const import_2.Decorator(selector: '[ng-bind-html]', map: const {'ng-bind-html': '=>value'}),
  ],
  import_3.NgBindTemplate: const [
    const import_2.Decorator(selector: '[ng-bind-template]', map: const {'ng-bind-template': '@bind'}),
  ],
  import_3.NgClass: const [
    const import_2.Decorator(selector: '[ng-class]', map: const {'ng-class': '@valueExpression'}, exportExpressionAttrs: const ['ng-class',]),
  ],
  import_3.NgClassOdd: const [
    const import_2.Decorator(selector: '[ng-class-odd]', map: const {'ng-class-odd': '@valueExpression'}, exportExpressionAttrs: const ['ng-class-odd',]),
  ],
  import_3.NgClassEven: const [
    const import_2.Decorator(selector: '[ng-class-even]', map: const {'ng-class-even': '@valueExpression'}, exportExpressionAttrs: const ['ng-class-even',]),
  ],
  import_3.NgEvent: const [
    const import_2.Decorator(selector: '[ng-abort]', map: const {'ng-abort': '&onAbort'}),
    const import_2.Decorator(selector: '[ng-beforecopy]', map: const {'ng-beforecopy': '&onBeforeCopy'}),
    const import_2.Decorator(selector: '[ng-beforecut]', map: const {'ng-beforecut': '&onBeforeCut'}),
    const import_2.Decorator(selector: '[ng-beforepaste]', map: const {'ng-beforepaste': '&onBeforePaste'}),
    const import_2.Decorator(selector: '[ng-blur]', map: const {'ng-blur': '&onBlur'}),
    const import_2.Decorator(selector: '[ng-change]', map: const {'ng-change': '&onChange'}),
    const import_2.Decorator(selector: '[ng-click]', map: const {'ng-click': '&onClick'}),
    const import_2.Decorator(selector: '[ng-contextmenu]', map: const {'ng-contextmenu': '&onContextMenu'}),
    const import_2.Decorator(selector: '[ng-copy]', map: const {'ng-copy': '&onCopy'}),
    const import_2.Decorator(selector: '[ng-cut]', map: const {'ng-cut': '&onCut'}),
    const import_2.Decorator(selector: '[ng-doubleclick]', map: const {'ng-doubleclick': '&onDoubleClick'}),
    const import_2.Decorator(selector: '[ng-drag]', map: const {'ng-drag': '&onDrag'}),
    const import_2.Decorator(selector: '[ng-dragend]', map: const {'ng-dragend': '&onDragEnd'}),
    const import_2.Decorator(selector: '[ng-dragenter]', map: const {'ng-dragenter': '&onDragEnter'}),
    const import_2.Decorator(selector: '[ng-dragleave]', map: const {'ng-dragleave': '&onDragLeave'}),
    const import_2.Decorator(selector: '[ng-dragover]', map: const {'ng-dragover': '&onDragOver'}),
    const import_2.Decorator(selector: '[ng-dragstart]', map: const {'ng-dragstart': '&onDragStart'}),
    const import_2.Decorator(selector: '[ng-drop]', map: const {'ng-drop': '&onDrop'}),
    const import_2.Decorator(selector: '[ng-error]', map: const {'ng-error': '&onError'}),
    const import_2.Decorator(selector: '[ng-focus]', map: const {'ng-focus': '&onFocus'}),
    const import_2.Decorator(selector: '[ng-fullscreenchange]', map: const {'ng-fullscreenchange': '&onFullscreenChange'}),
    const import_2.Decorator(selector: '[ng-fullscreenerror]', map: const {'ng-fullscreenerror': '&onFullscreenError'}),
    const import_2.Decorator(selector: '[ng-input]', map: const {'ng-input': '&onInput'}),
    const import_2.Decorator(selector: '[ng-invalid]', map: const {'ng-invalid': '&onInvalid'}),
    const import_2.Decorator(selector: '[ng-keydown]', map: const {'ng-keydown': '&onKeyDown'}),
    const import_2.Decorator(selector: '[ng-keypress]', map: const {'ng-keypress': '&onKeyPress'}),
    const import_2.Decorator(selector: '[ng-keyup]', map: const {'ng-keyup': '&onKeyUp'}),
    const import_2.Decorator(selector: '[ng-load]', map: const {'ng-load': '&onLoad'}),
    const import_2.Decorator(selector: '[ng-mousedown]', map: const {'ng-mousedown': '&onMouseDown'}),
    const import_2.Decorator(selector: '[ng-mouseenter]', map: const {'ng-mouseenter': '&onMouseEnter'}),
    const import_2.Decorator(selector: '[ng-mouseleave]', map: const {'ng-mouseleave': '&onMouseLeave'}),
    const import_2.Decorator(selector: '[ng-mousemove]', map: const {'ng-mousemove': '&onMouseMove'}),
    const import_2.Decorator(selector: '[ng-mouseout]', map: const {'ng-mouseout': '&onMouseOut'}),
    const import_2.Decorator(selector: '[ng-mouseover]', map: const {'ng-mouseover': '&onMouseOver'}),
    const import_2.Decorator(selector: '[ng-mouseup]', map: const {'ng-mouseup': '&onMouseUp'}),
    const import_2.Decorator(selector: '[ng-mousewheel]', map: const {'ng-mousewheel': '&onMouseWheel'}),
    const import_2.Decorator(selector: '[ng-paste]', map: const {'ng-paste': '&onPaste'}),
    const import_2.Decorator(selector: '[ng-reset]', map: const {'ng-reset': '&onReset'}),
    const import_2.Decorator(selector: '[ng-scroll]', map: const {'ng-scroll': '&onScroll'}),
    const import_2.Decorator(selector: '[ng-search]', map: const {'ng-search': '&onSearch'}),
    const import_2.Decorator(selector: '[ng-select]', map: const {'ng-select': '&onSelect'}),
    const import_2.Decorator(selector: '[ng-selectstart]', map: const {'ng-selectstart': '&onSelectStart'}),
    const import_2.Decorator(selector: '[ng-submit]', map: const {'ng-submit': '&onSubmit'}),
    const import_2.Decorator(selector: '[ng-toucheancel]', map: const {'ng-touchcancel': '&onTouchCancel'}),
    const import_2.Decorator(selector: '[ng-touchend]', map: const {'ng-touchend': '&onTouchEnd'}),
    const import_2.Decorator(selector: '[ng-touchenter]', map: const {'ng-touchenter': '&onTouchEnter'}),
    const import_2.Decorator(selector: '[ng-touchleave]', map: const {'ng-touchleave': '&onTouchLeave'}),
    const import_2.Decorator(selector: '[ng-touchmove]', map: const {'ng-touchmove': '&onTouchMove'}),
    const import_2.Decorator(selector: '[ng-touchstart]', map: const {'ng-touchstart': '&onTouchStart'}),
    const import_2.Decorator(selector: '[ng-transitionend]', map: const {'ng-transitionend': '&onTransitionEnd'}),
  ],
  import_3.NgCloak: const [
    const import_2.Decorator(selector: '[ng-cloak]'),
    const import_2.Decorator(selector: '.ng-cloak'),
  ],
  import_3.NgIf: const [
    const import_2.Decorator(children: import_2.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-if]', map: const {'.': '=>condition'}),
  ],
  import_3.NgUnless: const [
    const import_2.Decorator(children: import_2.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-unless]', map: const {'.': '=>condition'}),
  ],
  import_3.NgInclude: const [
    const import_2.Decorator(selector: '[ng-include]', map: const {'ng-include': '@url'}),
  ],
  import_3.NgModel: const [
    const import_2.Decorator(selector: '[ng-model]', map: const {'name': '@name', 'ng-model': '&model'}),
  ],
  import_3.InputCheckbox: const [
    const import_2.Decorator(selector: 'input[type=checkbox][ng-model]'),
  ],
  import_3.InputTextLike: const [
    const import_2.Decorator(selector: 'textarea[ng-model]'),
    const import_2.Decorator(selector: 'input[type=text][ng-model]'),
    const import_2.Decorator(selector: 'input[type=password][ng-model]'),
    const import_2.Decorator(selector: 'input[type=url][ng-model]'),
    const import_2.Decorator(selector: 'input[type=email][ng-model]'),
    const import_2.Decorator(selector: 'input[type=search][ng-model]'),
    const import_2.Decorator(selector: 'input[type=tel][ng-model]'),
    const import_2.Decorator(selector: 'input[type=color][ng-model]'),
  ],
  import_3.InputNumberLike: const [
    const import_2.Decorator(selector: 'input[type=number][ng-model]'),
    const import_2.Decorator(selector: 'input[type=range][ng-model]'),
  ],
  import_3.NgBindTypeForDateLike: const [
    const import_2.Decorator(selector: 'input[type=date][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_2.Decorator(selector: 'input[type=time][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_2.Decorator(selector: 'input[type=datetime][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_2.Decorator(selector: 'input[type=datetime-local][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_2.Decorator(selector: 'input[type=month][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_2.Decorator(selector: 'input[type=week][ng-model][ng-bind-type]', visibility: import_2.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
  ],
  import_3.InputDateLike: const [
    const import_2.Decorator(selector: 'input[type=date][ng-model]', module: import_3.InputDateLike.moduleFactory),
    const import_2.Decorator(selector: 'input[type=time][ng-model]', module: import_3.InputDateLike.moduleFactory),
    const import_2.Decorator(selector: 'input[type=datetime][ng-model]', module: import_3.InputDateLike.moduleFactory),
    const import_2.Decorator(selector: 'input[type=datetime-local][ng-model]', module: import_3.InputDateLike.moduleFactory),
    const import_2.Decorator(selector: 'input[type=month][ng-model]', module: import_3.InputDateLike.moduleFactory),
    const import_2.Decorator(selector: 'input[type=week][ng-model]', module: import_3.InputDateLike.moduleFactory),
  ],
  import_3.NgValue: const [
    const import_2.Decorator(selector: 'input[type=radio][ng-model][ng-value]', visibility: import_2.Visibility.LOCAL, map: const {'ng-value': '=>value'}),
    const import_2.Decorator(selector: 'option[ng-value]', visibility: import_2.Visibility.LOCAL, map: const {'ng-value': '=>value'}),
  ],
  import_3.NgTrueValue: const [
    const import_2.Decorator(selector: 'input[type=checkbox][ng-model][ng-true-value]', map: const {'ng-true-value': '=>value'}),
  ],
  import_3.NgFalseValue: const [
    const import_2.Decorator(selector: 'input[type=checkbox][ng-model][ng-false-value]', map: const {'ng-false-value': '=>value'}),
  ],
  import_3.InputRadio: const [
    const import_2.Decorator(selector: 'input[type=radio][ng-model]', module: import_3.NgValue.module),
  ],
  import_3.ContentEditable: const [
    const import_2.Decorator(selector: '[contenteditable][ng-model]'),
  ],
  import_3.NgPluralize: const [
    const import_2.Decorator(selector: 'ng-pluralize', map: const {'count': '=>count'}),
    const import_2.Decorator(selector: '[ng-pluralize]', map: const {'count': '=>count'}),
  ],
  import_3.NgRepeat: const [
    const import_2.Decorator(children: import_2.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-repeat]', map: const {'.': '@expression'}),
  ],
  import_3.NgTemplate: const [
    const import_2.Decorator(selector: 'template[type=text/ng-template]', map: const {'id': '@templateUrl'}),
    const import_2.Decorator(selector: 'script[type=text/ng-template]', children: import_2.Directive.IGNORE_CHILDREN, map: const {'id': '@templateUrl'}),
  ],
  import_3.NgHide: const [
    const import_2.Decorator(selector: '[ng-hide]', map: const {'ng-hide': '=>hide'}),
  ],
  import_3.NgShow: const [
    const import_2.Decorator(selector: '[ng-show]', map: const {'ng-show': '=>show'}),
  ],
  import_3.NgBooleanAttribute: const [
    const import_2.Decorator(selector: '[ng-checked]', map: const {'ng-checked': '=>checked'}),
    const import_2.Decorator(selector: '[ng-disabled]', map: const {'ng-disabled': '=>disabled'}),
    const import_2.Decorator(selector: '[ng-multiple]', map: const {'ng-multiple': '=>multiple'}),
    const import_2.Decorator(selector: '[ng-open]', map: const {'ng-open': '=>open'}),
    const import_2.Decorator(selector: '[ng-readonly]', map: const {'ng-readonly': '=>readonly'}),
    const import_2.Decorator(selector: '[ng-required]', map: const {'ng-required': '=>required'}),
    const import_2.Decorator(selector: '[ng-selected]', map: const {'ng-selected': '=>selected'}),
  ],
  import_3.NgSource: const [
    const import_2.Decorator(selector: '[ng-href]', map: const {'ng-href': '@href'}),
    const import_2.Decorator(selector: '[ng-src]', map: const {'ng-src': '@src'}),
    const import_2.Decorator(selector: '[ng-srcset]', map: const {'ng-srcset': '@srcset'}),
  ],
  import_3.NgAttribute: const [
    const import_2.Decorator(selector: '[ng-attr-*]'),
  ],
  import_3.NgStyle: const [
    const import_2.Decorator(selector: '[ng-style]', map: const {'ng-style': '@styleExpression'}, exportExpressionAttrs: const ['ng-style',]),
  ],
  import_3.NgSwitch: const [
    const import_2.Decorator(selector: '[ng-switch]', map: const {'ng-switch': '=>value', 'change': '&onChange'}, visibility: import_2.Visibility.DIRECT_CHILD),
  ],
  import_3.NgSwitchWhen: const [
    const import_2.Decorator(selector: '[ng-switch-when]', children: import_2.Directive.TRANSCLUDE_CHILDREN, map: const {'.': '@value'}),
  ],
  import_3.NgSwitchDefault: const [
    const import_2.Decorator(children: import_2.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-switch-default]'),
  ],
  import_3.NgNonBindable: const [
    const import_2.Decorator(selector: '[ng-non-bindable]', children: import_2.Directive.IGNORE_CHILDREN),
  ],
  import_3.InputSelect: const [
    const import_2.Decorator(selector: 'select[ng-model]', visibility: import_2.Visibility.CHILDREN),
  ],
  import_3.OptionValue: const [
    const import_2.Decorator(selector: 'option', module: import_3.NgValue.module),
  ],
  import_3.NgForm: const [
    const import_2.Decorator(selector: 'form', module: import_3.NgForm.module, map: const {'name': '&name'}),
    const import_2.Decorator(selector: 'fieldset', module: import_3.NgForm.module, map: const {'name': '&name'}),
    const import_2.Decorator(selector: '.ng-form', module: import_3.NgForm.module, map: const {'name': '&name'}),
    const import_2.Decorator(selector: '[ng-form]', module: import_3.NgForm.module, map: const {'ng-form': '&name', 'name': '&name'}),
  ],
  import_3.NgModelRequiredValidator: const [
    const import_2.Decorator(selector: '[ng-model][required]'),
    const import_2.Decorator(selector: '[ng-model][ng-required]', map: const {'ng-required': '=>required'}),
  ],
  import_3.NgModelUrlValidator: const [
    const import_2.Decorator(selector: 'input[type=url][ng-model]'),
  ],
  import_3.NgModelColorValidator: const [
    const import_2.Decorator(selector: 'input[type=color][ng-model]'),
  ],
  import_3.NgModelEmailValidator: const [
    const import_2.Decorator(selector: 'input[type=email][ng-model]'),
  ],
  import_3.NgModelNumberValidator: const [
    const import_2.Decorator(selector: 'input[type=number][ng-model]'),
    const import_2.Decorator(selector: 'input[type=range][ng-model]'),
  ],
  import_3.NgModelMaxNumberValidator: const [
    const import_2.Decorator(selector: 'input[type=number][ng-model][max]', map: const {'max': '@max'}),
    const import_2.Decorator(selector: 'input[type=range][ng-model][max]', map: const {'max': '@max'}),
    const import_2.Decorator(selector: 'input[type=number][ng-model][ng-max]', map: const {'ng-max': '=>max', 'max': '@max'}),
    const import_2.Decorator(selector: 'input[type=range][ng-model][ng-max]', map: const {'ng-max': '=>max', 'max': '@max'}),
  ],
  import_3.NgModelMinNumberValidator: const [
    const import_2.Decorator(selector: 'input[type=number][ng-model][min]', map: const {'min': '@min'}),
    const import_2.Decorator(selector: 'input[type=range][ng-model][min]', map: const {'min': '@min'}),
    const import_2.Decorator(selector: 'input[type=number][ng-model][ng-min]', map: const {'ng-min': '=>min', 'min': '@min'}),
    const import_2.Decorator(selector: 'input[type=range][ng-model][ng-min]', map: const {'ng-min': '=>min', 'min': '@min'}),
  ],
  import_3.NgModelPatternValidator: const [
    const import_2.Decorator(selector: '[ng-model][pattern]', map: const {'pattern': '@pattern'}),
    const import_2.Decorator(selector: '[ng-model][ng-pattern]', map: const {'ng-pattern': '=>pattern', 'pattern': '@pattern'}),
  ],
  import_3.NgModelMinLengthValidator: const [
    const import_2.Decorator(selector: '[ng-model][minlength]', map: const {'minlength': '@minlength'}),
    const import_2.Decorator(selector: '[ng-model][ng-minlength]', map: const {'ng-minlength': '=>minlength', 'minlength': '@minlength'}),
  ],
  import_3.NgModelMaxLengthValidator: const [
    const import_2.Decorator(selector: '[ng-model][maxlength]', map: const {'maxlength': '@maxlength'}),
    const import_2.Decorator(selector: '[ng-model][ng-maxlength]', map: const {'ng-maxlength': '=>maxlength', 'maxlength': '@maxlength'}),
  ],
  import_3.NgModelOptions: const [
    const import_2.Decorator(selector: 'input[ng-model-options]', map: const {'ng-model-options': '=>options'}),
  ],
  import_4.Parser: const [
    const import_1.Injectable(),
  ],
  import_4.RuntimeParserBackend: const [
    const import_1.Injectable(),
  ],
  import_5.FormatterMap: const [
    const import_1.Injectable(),
  ],
  import_6.ExceptionHandler: const [
    const import_1.Injectable(),
  ],
  import_6.Interpolate: const [
    const import_1.Injectable(),
  ],
  import_6.ScopeDigestTTL: const [
    const import_1.Injectable(),
  ],
  import_6.ScopeStats: const [
    const import_1.Injectable(),
  ],
  import_6.ScopeStatsEmitter: const [
    const import_1.Injectable(),
  ],
  import_6.ScopeStatsConfig: const [
    const import_1.Injectable(),
  ],
  import_6.RootScope: const [
    const import_1.Injectable(),
  ],
  import_7.PendingAsync: const [
    const import_1.Injectable(),
  ],
  import_8.Lexer: const [
    const import_1.Injectable(),
  ],
  import_9.ASTParser: const [
    const import_1.Injectable(),
  ],
  import_10.CacheRegister: const [
    const import_1.Injectable(),
  ],
  import_11.ResourceUrlResolver: const [
    const import_1.Injectable(),
  ],
  import_11.ResourceResolverConfig: const [
    const import_1.Injectable(),
  ],
  import_12.Currency: const [
    const import_2.Formatter(name: 'currency'),
  ],
  import_12.Date: const [
    const import_2.Formatter(name: 'date'),
  ],
  import_12.Filter: const [
    const import_2.Formatter(name: 'filter'),
  ],
  import_12.Json: const [
    const import_2.Formatter(name: 'json'),
  ],
  import_12.LimitTo: const [
    const import_2.Formatter(name: 'limitTo'),
  ],
  import_12.Lowercase: const [
    const import_2.Formatter(name: 'lowercase'),
  ],
  import_12.Arrayify: const [
    const import_2.Formatter(name: 'arrayify'),
  ],
  import_12.Number: const [
    const import_2.Formatter(name: 'number'),
  ],
  import_12.OrderBy: const [
    const import_2.Formatter(name: 'orderBy'),
  ],
  import_12.Uppercase: const [
    const import_2.Formatter(name: 'uppercase'),
  ],
  import_12.Stringify: const [
    const import_2.Formatter(name: 'stringify'),
  ],
  import_13.AnimationLoop: const [
    const import_1.Injectable(),
  ],
  import_13.AnimationFrame: const [
    const import_1.Injectable(),
  ],
  import_13.AnimationOptimizer: const [
    const import_1.Injectable(),
  ],
  import_13.CssAnimate: const [
    const import_1.Injectable(),
  ],
  import_13.CssAnimationMap: const [
    const import_1.Injectable(),
  ],
  import_13.NgAnimate: const [
    const import_2.Decorator(selector: '[ng-animate]', map: const {'ng-animate': '@option'}),
  ],
  import_13.NgAnimateChildren: const [
    const import_2.Decorator(selector: '[ng-animate-children]', map: const {'ng-animate-children': '@option'}),
  ],
  import_14.NgRoutingUsePushState: const [
    const import_1.Injectable(),
  ],
  import_14.NgRoutingHelper: const [
    const import_1.Injectable(),
  ],
  import_14.NgView: const [
    const import_2.Decorator(selector: 'ng-view', module: import_14.NgView.module, visibility: import_2.Visibility.CHILDREN),
  ],
  import_14.NgBindRoute: const [
    const import_2.Decorator(selector: '[ng-bind-route]', module: import_14.NgBindRoute.module, map: const {'ng-bind-route': '@routeName'}),
  ],
  import_15.JsCacheRegister: const [
    const import_1.Injectable(),
  ],
  import_16.LoggerExceptionHandler: const [
    const import_1.Injectable(),
  ],
  import_17.ProfileService: const [
    const import_1.Injectable(),
  ],
  import_18.PrizesService: const [
    const import_1.Injectable(),
  ],
  import_19.DateTimeService: const [
    const import_1.Injectable(),
  ],
  import_20.RefreshTimersService: const [
    const import_1.Injectable(),
  ],
  import_21.TutorialService: const [
    const import_1.Injectable(),
  ],
  import_22.ToolTipService: const [
    const import_1.Injectable(),
  ],
  import_23.ScreenDetectorService: const [
    const import_1.Injectable(),
  ],
  import_24.ViewContestComp: const [
    const import_2.Component(selector: 'view-contest', templateUrl: 'packages/webclient/components/view_contest/view_contest_comp.html', useShadowDom: false),
  ],
  import_25.LoadingService: const [
    const import_1.Injectable(),
  ],
  import_26.FlashMessagesService: const [
    const import_1.Injectable(),
  ],
  import_27.ContestsService: const [
    const import_1.Injectable(),
  ],
  import_28.DailySoccerServer: const [
    const import_1.Injectable(),
  ],
  import_29.ModalComp: const [
    const import_2.Component(selector: 'modal', templateUrl: 'packages/webclient/components/modal_comp.html', useShadowDom: false, map: const {"window-size": '=>windowSize'}),
  ],
  import_30.EnterContestComp: const [
    const import_2.Component(selector: 'enter-contest', templateUrl: 'packages/webclient/components/enter_contest/enter_contest_comp.html', useShadowDom: false),
  ],
  import_31.CatalogService: const [
    const import_1.Injectable(),
  ],
  import_32.PaymentService: const [
    const import_1.Injectable(),
  ],
  import_33.AchievementComp: const [
    const import_2.Component(selector: 'achievement', templateUrl: 'packages/webclient/components/achievement_comp.html', useShadowDom: false, map: const {"key": '=>Data', "enabled": '=>Earned'}),
  ],
  import_34.XsNotAvailableScreenComp: const [
    const import_2.Component(selector: 'xs-not-available-screen', templateUrl: 'packages/webclient/components/navigation/xs_not_available_screen_comp.html', useShadowDom: false),
  ],
  import_35.SoccerPlayerStatsComp: const [
    const import_2.Component(selector: 'soccer-player-stats', templateUrl: 'packages/webclient/components/enter_contest/soccer_player_stats_comp.html', useShadowDom: false),
  ],
  import_36.SoccerPlayerService: const [
    const import_1.Injectable(),
  ],
  import_37.HowToCreateContestComp: const [
    const import_2.Component(selector: 'how-to-create-contest', templateUrl: 'packages/webclient/components/legalese_and_help/how_to_create_contest_comp.html', useShadowDom: false),
  ],
  import_38.ChangePasswordComp: const [
    const import_2.Component(selector: 'change-password', templateUrl: 'packages/webclient/components/account/change_password_comp.html', useShadowDom: false),
  ],
  import_39.WeekCalendar: const [
    const import_2.Component(selector: 'week-calendar', templateUrl: 'packages/webclient/components/week_calendar_comp.html', useShadowDom: false, map: const {"disabled": '=>disabled', "selected-date": '=>currentSelectedDate', "dates": '=>dates', "on-day-selected": '&onDayClickCallback'}),
  ],
  import_40.PromosComp: const [
    const import_2.Component(selector: 'promos', templateUrl: 'packages/webclient/components/promos_comp.html', useShadowDom: false),
  ],
  import_41.PromosService: const [
    const import_1.Injectable(),
  ],
  import_42.TranslateFormatter: const [
    const import_2.Formatter(name: 'translate'),
  ],
  import_43.TerminusInfoComp: const [
    const import_2.Component(selector: 'terminus-info', templateUrl: 'packages/webclient/components/legalese_and_help/terminus_info_comp.html', useShadowDom: false),
  ],
  import_44.LeaderboardService: const [
    const import_1.Injectable(),
  ],
  import_45.ShopComp: const [
    const import_2.Component(selector: 'shop-comp', templateUrl: 'packages/webclient/components/account/shop_comp.html', useShadowDom: false),
  ],
  import_46.HomeComp: const [
    const import_2.Component(selector: 'home', templateUrl: 'packages/webclient/components/home_comp.html', useShadowDom: false),
  ],
  import_47.NotificationsComp: const [
    const import_2.Component(selector: 'notifications', templateUrl: 'packages/webclient/components/account/notifications_comp.html', useShadowDom: false),
  ],
  import_48.FacebookService: const [
    const import_1.Injectable(),
  ],
  import_49.FriendInfoComp: const [
    const import_2.Component(selector: 'friend-info', templateUrl: 'packages/webclient/components/social/friend_info_comp.html', useShadowDom: false, map: const {'max-width': '=>maxWidth', 'user': '=>fbUser', 'on-challenge': '&onChallenge', 'show-challenge': '=>showChallenge', 'show-manager-level': '=>showManagerLevel', 'id-error': '=>idError'}),
  ],
  import_50.ContestHeaderF2PComp: const [
    const import_2.Component(selector: 'contest-header-f2p', templateUrl: 'packages/webclient/components/contest_header_f2p_comp.html', useShadowDom: false, map: const {"match-filter": '<=>matchFilter', "contest": '=>setContest', 'view-state': '@viewState', 'modal': '@setModal', 'show-matches': '@setShowMatches', "contest-id": '=>!setContestId', "show-filter": '=>setShowFilter'}),
  ],
  import_51.TeamsFilterComp: const [
    const import_2.Component(selector: 'teams-filter', templateUrl: 'packages/webclient/components/scouting/teams_filter_comp.html', useShadowDom: false, map: const {"selected-option": '<=>selectedOption', "team-list": '=>teamList', 'id-sufix': '=>identifier'}),
  ],
  import_52.PaginatorComp: const [
    const import_2.Component(selector: 'paginator', useShadowDom: false, map: const {'on-page-change': '&onPageChange', 'items-per-page': '=>itemsPerPageCount', 'list-length': '=>listLength'}),
  ],
  import_53.EditPersonalDataComp: const [
    const import_2.Component(selector: 'edit-personal-data', templateUrl: 'packages/webclient/components/account/edit_personal_data_comp.html', useShadowDom: false),
  ],
  import_54.FacebookShareComp: const [
    const import_2.Component(selector: 'facebook-share', templateUrl: 'packages/webclient/components/social/facebook_share_comp.html', useShadowDom: false, map: const {"description": '=>description', "image": '=>image', "caption": '=>caption', "url": '=>url', "title": '=>title', "on-share": '&onShare', "show-like": '=>showLike', "parameters-by-map": '=>info'}),
  ],
  import_55.MainMenuF2PComp: const [
    const import_2.Component(selector: 'main-menu-f2p', useShadowDom: false, exportExpressions: const ["profileService.user",]),
  ],
  import_56.JoinComp: const [
    const import_2.Component(selector: 'join', templateUrl: 'packages/webclient/components/account/join_comp.html', useShadowDom: false, map: const {"is-modal": '=>isModal'}),
  ],
  import_57.AutoFocusDecorator: const [
    const import_2.Decorator(selector: '[auto-focus]'),
  ],
  import_58.LegalInfoComp: const [
    const import_2.Component(selector: 'legal-info', templateUrl: 'packages/webclient/components/legalese_and_help/legal_info_comp.html', useShadowDom: false),
  ],
  import_59.LobbyF2PComp: const [
    const import_2.Component(selector: 'lobbyf2p', templateUrl: 'packages/webclient/components/lobby_f2p_comp.html', useShadowDom: false),
  ],
  import_60.ContestsListF2PComp: const [
    const import_2.Component(selector: 'contests-list-f2p', templateUrl: 'packages/webclient/components/contests_list_f2p_comp.html', useShadowDom: false, map: const {"contests-list": '=>contestsList', "action-button-title": '=>actionButtonTitle', "show-date": '=>showDate', "sorting": '=>sortOrder', "date-filter": '=>filterByDate', 'on-list-change': '&onListChange', "on-row-click": '&onRowClick', "on-action-click": '&onActionClick'}),
  ],
  import_61.MaxTextWidthDirective: const [
    const import_2.Decorator(selector: '[max-text-width]', map: const {'max-text-width': '=>value'}),
  ],
  import_62.LineupSelectorComp: const [
    const import_2.Component(selector: 'lineup-selector', templateUrl: 'packages/webclient/components/enter_contest/lineup_selector_comp.html', useShadowDom: false, map: const {"not-enough-resources": '=>alertNotEnoughResources', "resource": '=>resource', "has-negative-balance": '=>alertNegativeBalance', "has-max-players-same-team": '=>alertMaxPlayersSameTeamExceed', "manager-level": '=>managerLevel', "contest": '=>contest', "lineup-slots": '=>lineupSlots', "lineup-formation": '=>lineupFormation', "on-lineup-slot-selected": '&onLineupSlotSelected', "formation-id": '<=>formationId'}),
  ],
  import_63.SocialShareComp: const [
    const import_2.Component(selector: 'social-share', templateUrl: 'packages/webclient/components/social/social_share_comp.html', useShadowDom: false, map: const {"description": '=>description', "caption": '=>caption', "hash-tag": '=>hashtag', "url": '=>url', "title": '=>title', "on-share": '&onShare', "image": '=>image', "show-like": '=>showLike', "parameters-by-map": '=>info'}),
  ],
  import_64.ScoutingComp: const [
    const import_2.Component(selector: 'scouting', templateUrl: 'packages/webclient/components/scouting/scouting_comp.html', useShadowDom: false),
  ],
  import_65.ScoringRulesComp: const [
    const import_2.Component(selector: 'scoring-rules', templateUrl: 'packages/webclient/components/scoring_rules_comp.html', useShadowDom: false),
  ],
  import_66.ScoringRulesService: const [
    const import_1.Injectable(),
  ],
  import_67.AchievementListComp: const [
    const import_2.Component(selector: 'achievement-list', templateUrl: 'packages/webclient/components/achievement_list_comp.html', useShadowDom: false, map: const {"user": '=>user'}),
  ],
  import_68.RulesComp: const [
    const import_2.Component(selector: 'rules-comp', templateUrl: 'packages/webclient/components/legalese_and_help/rules_comp.html', useShadowDom: false),
  ],
  import_69.HowItWoksComp: const [
    const import_2.Component(selector: 'how-it-works', templateUrl: 'packages/webclient/components/legalese_and_help/how_it_works_comp.html', useShadowDom: false),
  ],
  import_70.LeaderboardComp: const [
    const import_2.Component(selector: 'leaderboard', templateUrl: 'packages/webclient/components/leaderboard_comp.html', useShadowDom: false),
  ],
  import_71.LimitToDot: const [
    const import_2.Formatter(name: 'limitToDot'),
  ],
  import_72.FlashMessageComp: const [
    const import_2.Component(selector: 'flash-messages', useShadowDom: false, exportExpressions: const ["flashMessageService.flashMessages","flashMessageService.globalMessages",]),
  ],
  import_73.SoccerPlayersFilterComp: const [
    const import_2.Component(selector: 'soccer-players-filter', templateUrl: 'packages/webclient/components/enter_contest/soccer_players_filter_comp.html', useShadowDom: false, map: const {"name-filter": '<=>nameFilter', 'field-pos-filter': '<=>fieldPosFilter', 'only-favorites': '<=>onlyFavorites', 'show-on-xs': '=>showOnXs', 'show-favorites-button': '=>showFavoritesButton', 'show-title': '=>showTitle', 'position-filters-enabled': '=>positionFiltersEnabled'}),
  ],
  import_74.LeaderboardTableComp: const [
    const import_2.Component(selector: 'leaderboard-table', templateUrl: 'packages/webclient/components/leaderboard_table_comp.html', useShadowDom: false, map: const {"share-info": '=>info', "show-header": '=>showHeader', "table-elements": '=>tableValues', "highlight-element": '=>playerInfo', "points-column-label": '=>pointsColumnLabel', "hint": '=>hint', "rows": '=>rowsToShow'}),
  ],
  import_75.NgBindHtmlUnsafeDirective: const [
    const import_2.Decorator(selector: '[ng-bind-html-unsafe]', map: const {'ng-bind-html-unsafe': '=>value'}),
  ],
  import_76.UserProfileComp: const [
    const import_2.Component(selector: 'user-profile', templateUrl: 'packages/webclient/components/account/user_profile_comp.html', useShadowDom: false),
  ],
  import_77.LoginComp: const [
    const import_2.Component(selector: 'login', templateUrl: 'packages/webclient/components/account/login_comp.html', useShadowDom: false, map: const {"is-modal": '=>isModal'}),
  ],
  import_78.CreateContestComp: const [
    const import_2.Component(selector: 'create-contest', templateUrl: 'packages/webclient/components/create_contest_comp.html', useShadowDom: false),
  ],
  import_79.ContestInfoComp: const [
    const import_2.Component(selector: 'contest-info', templateUrl: 'packages/webclient/components/contest_info_comp.html', useShadowDom: false),
  ],
  import_80.ScoutingLeagueComp: const [
    const import_2.Component(selector: 'scouting-league', templateUrl: 'packages/webclient/components/scouting/scouting_league_comp.html', useShadowDom: false, map: const {'soccer-player-list': '=>allSoccerPlayers', 'favorites-player-list': '<=>favoritesPlayers', 'team-list': '=>teamList', 'on-action-button': '&onSoccerPlayerAction', 'id-sufix': '=>identifier'}),
  ],
  import_81.TeamsPanelComp: const [
    const import_2.Component(selector: 'teams-panel', templateUrl: 'packages/webclient/components/view_contest/teams_panel_comp.html', useShadowDom: false, map: const {"button-text": '=>buttonText', "as-filter": '=>setUseAsFilter', "selected-option": '<=>matchFilter', "panel-open": '=>isPanelOpen', "template-contest": '=>templateContest', "contest": '=>contest', "contest-id": '=>contestId'}),
  ],
  import_82.WelcomeComp: const [
    const import_2.Component(selector: 'welcome', useShadowDom: false),
  ],
  import_83.PolicyInfoComp: const [
    const import_2.Component(selector: 'policy-info', templateUrl: 'packages/webclient/components/legalese_and_help/policy_info_comp.html', useShadowDom: false),
  ],
  import_84.MyContestsComp: const [
    const import_2.Component(selector: 'my-contests', templateUrl: 'packages/webclient/components/my_contests_comp.html', useShadowDom: false),
  ],
  import_85.TutorialsComp: const [
    const import_2.Component(selector: 'tutorials-comp', templateUrl: 'packages/webclient/components/legalese_and_help/tutorials_comp.html', useShadowDom: false),
  ],
  import_86.MatchesFilterComp: const [
    const import_2.Component(selector: 'matches-filter', templateUrl: 'packages/webclient/components/enter_contest/matches_filter_comp.html', useShadowDom: false, map: const {"selected-option": '<=>selectedOption', "contest": '=>contest'}),
  ],
  import_87.FormAutofillDecorator: const [
    const import_2.Decorator(selector: '[formAutofillFix]'),
  ],
  import_88.FriendsBarComp: const [
    const import_2.Component(selector: 'friends-bar', templateUrl: 'packages/webclient/components/social/friends_bar_comp.html', useShadowDom: false, map: const {'user-list': '=>fbUsers', 'on-challenge': '&onChallenge', 'show-challenge': '=>showChallenge'}),
  ],
  import_89.HelpInfoComp: const [
    const import_2.Component(selector: 'help-info', templateUrl: 'packages/webclient/components/legalese_and_help/help_info_comp.html', useShadowDom: false),
  ],
  import_90.DefaultPlatformNoShim: const [
    const import_1.Injectable(),
  ],
  import_90.PlatformJsBasedNoShim: const [
    const import_1.Injectable(),
  ],
  import_91.RememberPasswordComp: const [
    const import_2.Component(selector: 'remember-password', templateUrl: 'packages/webclient/components/account/remember_password_comp.html', useShadowDom: false),
  ],
  import_92.FooterComp: const [
    const import_2.Component(selector: 'footer', useShadowDom: false),
  ],
  import_93.SimplePromoF2PComp: const [
    const import_2.Component(selector: 'simple-promo-f2p', useShadowDom: false),
  ],
  import_94.TwitterShareComp: const [
    const import_2.Component(selector: 'twitter-share', templateUrl: 'packages/webclient/components/social/twitter_share_comp.html', useShadowDom: false, map: const {"show-like": '=>showLike', "parameters-by-map": '=>info'}),
  ],
  import_95.FantasyTeamComp: const [
    const import_2.Component(selector: 'fantasy-team', templateUrl: 'packages/webclient/components/view_contest/fantasy_team_comp.html', useShadowDom: false, map: const {"contest-entry": '=>contestEntry', "watch": '=>watch', "is-opponent": '=>isOpponent', "show-close-button": '=>showCloseButton', "show-changes": '=>showChanges', "num-changes": '=>numChanges', "changing-soccer-id": '=>changingSoccerId', "available-salary": '=>availableSalary', 'on-close': '&onClose', 'on-request-change': '&onRequestChange'}),
  ],
  import_96.UsersListComp: const [
    const import_2.Component(selector: 'users-list', templateUrl: 'packages/webclient/components/view_contest/users_list_comp.html', useShadowDom: false, map: const {"contest-entries": '=>contestEntries', "on-row-click": '&onRowClick', "watch": '=>watch'}),
  ],
  import_97.SoccerPlayersListComp: const [
    const import_2.Component(selector: 'soccer-players-list', useShadowDom: false, exportExpressions: const ["lineupFilter",], map: const {"on-row-click": '&onRowClick', "on-action-click": '&onActionClick', "manager-level": '=>managerLevel', "contest": '=>contest', "field-pos-filter": '=>fieldPosFilter', "only-favorites": '=>onlyFavorites', "favorites-list": '=>favoritesList', "name-filter": '=>nameFilter', "match-filter": '=>matchFilter', "hide-lineup-players": '=>hideLineupPlayers', "additional-gold-price": '=>additionalGoldPrice', "soccer-players": '=>!setSoccerPlayers', "lineup-filter": '=>setLineupFilter'}),
  ],
  import_98.PaymentResponseComp: const [
    const import_2.Component(selector: 'payment-response', templateUrl: 'packages/webclient/components/account/payment_response_comp.html', useShadowDom: false),
  ],
  import_99.ViewContestEntryComp: const [
    const import_2.Component(selector: 'view-contest-entry', templateUrl: 'packages/webclient/components/view_contest/view_contest_entry_comp.html', useShadowDom: false),
  ],
  import_100.TranslateDecorator: const [
    const import_2.Decorator(selector: '[translate]', map: const {'translate': '<=>translate'}),
  ],
  import_101.TutorialListComp: const [
    const import_2.Component(selector: 'tutorial-list', templateUrl: 'packages/webclient/components/tutorial_list_comp.html', useShadowDom: false),
  ],
};
