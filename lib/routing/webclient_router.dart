library webclient_routing;

import 'package:angular/angular.dart';

void webClientRouteInitializer(Router router, ViewFactory views) {
  views.configure({
    'home': ngRoute(
        defaultRoute: true,
        path: '/',
        view: 'view/home.tpl.html'
    ),
    'login': ngRoute(
        path: '/login',
        view: 'view/login.tpl.html'
    ),
    'join': ngRoute(
        path: '/join',
        view: 'view/join.tpl.html'
    ),
    'lobby': ngRoute(
        path: '/lobby',
        view: 'view/lobby.tpl.html'
    ),
    'team': ngRoute(
        path: '/team/:contestId',
        mount: {
          'create': ngRoute(
              path: '/create',
              view: 'view/team.tpl.html')
        })
  });
}