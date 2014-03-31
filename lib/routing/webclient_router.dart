library webclient_routing;

import 'package:angular/angular.dart';

void webClientRouteInitializer(Router router, ViewFactory views) {
  views.configure({
    'home': ngRoute(
        path: '',
        view: 'view/home.html'
    ),
    'login': ngRoute(
        path: '/login',
        view: 'view/login.html'
    ),
    'join': ngRoute(
        path: '/join',
        view: 'view/join.html'
    )
  });
}