import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'package:webclient/logger_exception_handler.dart';

import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/resource_url_resolver_wrapper.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/soccer_player_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/flash_messages_service.dart';
import 'package:webclient/services/scoring_rules_service.dart';
import 'package:webclient/services/leaderboard_service.dart';
import 'package:webclient/services/payment_service.dart';
import 'package:webclient/services/prizes_service.dart';
import 'package:webclient/services/promos_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/services/tooltip_service.dart';
import 'package:webclient/services/guild_service.dart';
import 'package:webclient/services/deltaDNA_service.dart';

import 'package:webclient/components/navigation/footer_comp.dart';
import 'package:webclient/components/navigation/top_bar_comp.dart';
import 'package:webclient/components/navigation/tab_bar_comp.dart';
import 'package:webclient/components/navigation/secondary_tab_bar_comp.dart';
import 'package:webclient/components/navigation/deprecated_version_screen_comp.dart';
//import 'package:webclient/components/navigation/xs_not_available_screen_comp.dart';

/*
import 'package:webclient/components/flash_messages_comp.dart';
import 'package:webclient/components/modal_comp.dart';
import 'package:webclient/components/paginator_comp.dart';
import 'package:webclient/components/lobby_comp.dart';
*/
import 'package:webclient/components/home_comp.dart';
/*
import 'package:webclient/components/promos_comp.dart';
import 'package:webclient/components/simple_promo_f2p_comp.dart';
import 'package:webclient/components/contests_list_comp.dart';
import 'package:webclient/components/contest_info_comp.dart';
import 'package:webclient/components/scoring_rules_comp.dart';
import 'package:webclient/components/contest_header_comp.dart';
import 'package:webclient/components/daily_rewards_comp.dart';

import 'package:webclient/components/leaderboards/leaderboard_comp.dart';
import 'package:webclient/components/leaderboards/leaderboard_table_comp.dart';
import 'package:webclient/components/leaderboards/ranking_comp.dart';
import 'package:webclient/components/leaderboards/achievement_list_comp.dart';
import 'package:webclient/components/leaderboards/achievement_comp.dart';

import 'package:webclient/components/my_contests_comp.dart';
//import 'package:webclient/components/welcome_comp.dart';
import 'package:webclient/components/week_calendar_comp.dart';
import 'package:webclient/components/tutorial_list_comp.dart';
import 'package:webclient/components/create_contest_comp.dart';

import 'package:webclient/components/social/facebook_share_comp.dart';
import 'package:webclient/components/social/twitter_share_comp.dart';
import 'package:webclient/components/social/social_share_comp.dart';
import 'package:webclient/components/social/friends_bar_comp.dart';
import 'package:webclient/components/social/friend_info_comp.dart';
*/
import 'package:webclient/components/account/login_comp.dart';
import 'package:webclient/components/account/join_comp.dart';
import 'package:webclient/components/account/user_profile_comp.dart';
import 'package:webclient/components/account/edit_personal_data_comp.dart';
import 'package:webclient/components/account/remember_password_comp.dart';
import 'package:webclient/components/account/change_password_comp.dart';
import 'package:webclient/components/account/shop_comp.dart';
import 'package:webclient/components/account/payment_response_comp.dart';
import 'package:webclient/components/account/notifications_comp.dart';
/*
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart';
import 'package:webclient/components/view_contest/view_contest_comp.dart';
import 'package:webclient/components/view_contest/fantasy_team_comp.dart';
import 'package:webclient/components/view_contest/users_list_comp.dart';
import 'package:webclient/components/view_contest/user_shortinfo_bar_comp.dart';
import 'package:webclient/components/view_contest/teams_panel_comp.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart';
import 'package:webclient/components/enter_contest/lineup_field_selector_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_scalinglist_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart';
import 'package:webclient/components/enter_contest/matches_filter_comp.dart';
import 'package:webclient/components/enter_contest/soccer_player_stats_comp.dart';

import 'package:webclient/components/scouting/scouting_comp.dart';
import 'package:webclient/components/scouting/scouting_league_comp.dart';
import 'package:webclient/components/scouting/teams_filter_comp.dart';
*/

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [
            DeprecatedVersionScreenComp,
            TopBarComp,
            SecondaryTabBarComp,
            ROUTER_DIRECTIVES
    ],
    providers: const [
        ROUTER_PROVIDERS,
        const Provider(APP_BASE_HREF, useValue: '/'),
        // const Provider(ExceptionHandler, useClass: LoggerExceptionHandler),
        const Provider(ServerService, useClass: DailySoccerServer),
        ScreenDetectorService,
        LoadingService,
        RefreshTimersService,
        DateTimeService,
        ProfileService,
        FlashMessagesService,
        PromosService,
        ContestsService,
        SoccerPlayerService,
        TemplateService,
        ScoringRulesService,
        LeaderboardService,
        PaymentService,
        PrizesService,
        CatalogService,
        AppStateService,
        TutorialService,
        ToolTipService,
        GuildService,
        DeltaDNAService,
    ])
@RouteConfig(const [
        const Route(path: '/home', useAsDefault: true, component: HomeComp),
        const Route(path: '/login', component: LoginComp)
])
class AppComponent {
}
