import 'package:angular/application_factory.dart';
import 'package:angular/routing/static_keys.dart';
import 'package:angular/core_dom/static_keys.dart';

import 'package:webclient/webclient.dart';
import 'package:webclient/logger_exception_handler.dart';

void main() {

  LoggerExceptionHandler.setUpLogger();

  var injector = applicationFactory().addModule(new WebClientApp()).run();

  // Precacheamos lost html de las vistas para que no los cargue luego al entrar en las pantallas
  var cache = injector.getByKey(VIEW_CACHE_KEY);

  cache.fromUrl("packages/webclient/components/fantasy_team_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/users_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/contest_header_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/my_contests_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/lineup_selector_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("packages/webclient/components/soccer_players_list_comp.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("view/enter_contest.tpl.html", injector.getByKey(DIRECTIVE_MAP_KEY));
  cache.fromUrl("view/view_contest.tpl.html", injector.getByKey(DIRECTIVE_MAP_KEY));
}

