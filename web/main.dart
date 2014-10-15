import 'package:angular/application_factory.dart';
import 'package:angular/routing/static_keys.dart';
import 'package:angular/core_dom/static_keys.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';

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
  // Precacheamos lost html de las vistas para que no los cargue luego al entrar en las pantallas
  var cache = injector.getByKey(VIEW_CACHE_KEY);

  cache.fromUrl("packages/webclient/components/fantasy_team_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/users_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contest_header_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/my_contests_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/lineup_selector_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/soccer_players_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  /****/
  cache.fromUrl("packages/webclient/components/beta_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contest_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contests_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/edit_personal_data_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/flash_messages_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/footer_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/help_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/join_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/landing_page_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/legal_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/lobby_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/login_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/main_menu_slide_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/paginator_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/policy_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/promos_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/remember_password_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/scoring_rules_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/soccer_player_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/terminus_info_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/user_profile_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/view_contest_entry_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/view_contest_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));

  cache.fromUrl("view/enter_contest.tpl.html", injector.getByKey(DIRECTIVE_MAP_KEY));
}

