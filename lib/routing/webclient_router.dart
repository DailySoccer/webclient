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
    'enter_contest': ngRoute(
        path: '/enter_contest/:contestId',
        view: 'view/enter_contest.tpl.html'
    )
  });
}