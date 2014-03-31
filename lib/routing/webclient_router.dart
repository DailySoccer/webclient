library webclient_routing;

import 'package:angular/angular.dart';

void webClientRouteInitializer(Router router, ViewFactory views) {
  views.configure({
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