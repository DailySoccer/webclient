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
        viewHtml: '<login></login>'
    )
    ,'join': ngRoute(
        path: '/join',
        viewHtml: '<join></join>'
    )
    ,'lobby': ngRoute(
        path: '/lobby',
        viewHtml: '<lobby></lobby>'
    )
    ,'my_contests': ngRoute(
        path: '/my_contests',
        viewHtml: '<my-contests></my-contests>'
    )
    ,'live_contest': ngRoute(
        path: '/live_contest/:contestId',
        view: 'view/view_contest.tpl.html'
    )
    ,'history_contest': ngRoute(
        path: '/history_contest/:contestId',
        view: 'view/view_contest.tpl.html'
    )
    ,'enter_contest': ngRoute(
        path: '/enter_contest/:contestId',
        view: 'view/enter_contest.tpl.html'
    )
  });
}