library webclient_router;

import 'package:angular/angular.dart';

void webClientRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'login': ngRoute(
        path: '/login',
        view: 'view/login.tpl.html'
    ),
    'join': ngRoute(
        path: '/join',
        view: 'view/join.tpl.html'
    ),
    'lobby': ngRoute(
        defaultRoute: true,
        path: '/lobby',
        view: 'view/lobby.tpl.html'
    ),
    'entered_contests': ngRoute(
        path: '/entered_contests',
        view: 'view/entered_contests.tpl.html'
    ),
    'live_contests': ngRoute(
         path: '/live_contests',
         view: 'view/live_contests.tpl.html'
     ),
    'contest_entry': ngRoute(
        path: '/contest_entry/:contestId',
        mount: {
          'create': ngRoute(
              path: '/create',
              view: 'view/contest_entry.tpl.html')
        })
  });
}