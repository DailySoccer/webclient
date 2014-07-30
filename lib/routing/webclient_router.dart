library webclient_router;

import 'package:angular/angular.dart';

void webClientRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'landing_page': ngRoute(
        defaultRoute: true,
        path: '/landing_page',
        viewHtml: '<landing-page></landing-page>'
    )
    ,'login': ngRoute(
        path: '/login',
        view: 'view/login.tpl.html'
    )
    ,'join': ngRoute(
        path: '/join',
        view: 'view/join.tpl.html'
    )
    ,'lobby': ngRoute(
        path: '/lobby',
        viewHtml: '<lobby></lobby>'
    )
    ,'my_contests': ngRoute(
        path: '/my_contests',
        viewHtml: '<my-contests></my-contests>'
    )
    // Acceso directo a un live (sin indicar un contestId)
    ,'my_live_contests': ngRoute(
        path: '/my_live_contests',
        view: 'view/live_contest.tpl.html'
    )
    ,'live_contest': ngRoute(
        path: '/live_contest/:contestId',
        view: 'view/live_contest.tpl.html'
    )
    ,'history_contest': ngRoute(
        path: '/history_contest/:contestId',
        view: 'view/live_contest.tpl.html'
    )
    ,'enter_contest': ngRoute(
        path: '/enter_contest/:contestId',
        view: 'view/enter_contest.tpl.html'
    )
  });
}