import 'package:angular/application_factory.dart';
//import 'package:angular/routing/static_keys.dart';
import 'package:angular/core_dom/static_keys.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';
import 'package:webclient/generated.dart';
import 'package:angular/angular.dart';

void main() {

  try {
    LoggerExceptionHandler.setUpLogger();

    var injector = applicationFactory().addModule(new WebClientApp()).run();
    setUpCache(injector);
  }
  catch (exc, stackTrace) {
    LoggerExceptionHandler.logExceptionToServer(exc, stackTrace);
  }
}

void setUpCache(injector) {
  TemplateCache cache = injector.getByKey(TEMPLATE_CACHE_KEY);
  primeTemplateCache(cache);

  //
  // Precacheamos lost html de las vistas para que no los cargue luego al entrar en las pantallas
  //
  /*
  TemplateCache cache = injector.getByKey(TEMPLATE_CACHE_KEY);

  cache.fromUrl("packages/webclient/components/fantasy_team_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/users_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contest_header_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/my_contests_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("packages/webclient/components/contest_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contests_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/edit_personal_data_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/flash_messages_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/footer_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/join_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/landing_page_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("packages/webclient/components/lobby_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/login_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/main_menu_slide_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/paginator_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("packages/webclient/components/promos_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/remember_password_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/scoring_rules_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("packages/webclient/components/user_profile_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/view_contest_entry_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/view_contest_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("packages/webclient/components/enter_contest/enter_contest_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/enter_contest/lineup_selector_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/enter_contest/soccer_players_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/enter_contest/soccer_players_filter_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/enter_contest/matches_filter_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/enter_contest/soccer_player_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  */

  /*
   * Estos quiza mejor no gastar al principio
   *
  cache.fromUrl("packages/webclient/components/legalese_and_help/beta_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/legalese_and_help/legal_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/legalese_and_help/help_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/legalese_and_help/policy_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/legalese_and_help/terminus_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  */
}

