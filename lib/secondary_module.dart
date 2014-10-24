library secondary_module;

import 'package:angular/angular.dart';

import 'package:webclient/components/contest_header_comp.dart';

import 'package:webclient/components/account/user_profile_comp.dart';
import 'package:webclient/components/account/edit_personal_data_comp.dart';
import 'package:webclient/components/account/remember_password_comp.dart';

import 'package:webclient/components/legalese_and_help/help_info_comp.dart';
import 'package:webclient/components/legalese_and_help/legal_info_comp.dart';
import 'package:webclient/components/legalese_and_help/terminus_info_comp.dart';
import 'package:webclient/components/legalese_and_help/policy_info_comp.dart';
import 'package:webclient/components/legalese_and_help/beta_info_comp.dart';

import 'package:webclient/components/view_contest/fantasy_team_comp.dart';
import 'package:webclient/components/view_contest/users_list_comp.dart';
import 'package:webclient/components/view_contest/view_contest_entry_comp.dart';
import 'package:webclient/components/view_contest/view_contest_comp.dart';

import 'package:webclient/components/enter_contest/enter_contest_comp.dart';
import 'package:webclient/components/enter_contest/lineup_selector_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_list_comp.dart';
import 'package:webclient/components/enter_contest/soccer_players_filter_comp.dart';
import 'package:webclient/components/enter_contest/matches_filter_comp.dart';
import 'package:webclient/components/enter_contest/soccer_player_info_comp.dart';

class SecondaryModule extends Module {
  SecondaryModule() {
    bind(HelpInfoComp);
    bind(LegalInfoComp);
    bind(TerminusInfoComp);
    bind(PolicyInfoComp);
    bind(BetaInfoComp);

    bind(RememberPasswordComp);
    bind(UserProfileComp);
    bind(EditPersonalDataComp);

    bind(ContestHeaderComp);
    bind(EnterContestComp);
    bind(SoccerPlayersListComp);
    bind(SoccerPlayersFilterComp);
    bind(MatchesFilterComp);
    bind(LineupSelectorComp);
    bind(SoccerPlayerInfoComp);

    bind(ViewContestComp);
    bind(ViewContestEntryComp);
    bind(FantasyTeamComp);
    bind(UsersListComp);
  }
}