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
    ,'remember_password': ngRoute(
        path: '/remember_password',
        viewHtml: '<remember-password></remember-password>'
    )
    ,'user_profile': ngRoute(
        path: '/user_profile',
        viewHtml: '<user-profile></user-profile>'
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
        path: '/:parent/live_contest/:contestId',
        view: 'view/view_contest.tpl.html'
    )
    ,'history_contest': ngRoute(
        path: '/:parent/history_contest/:contestId',
        view: 'view/view_contest.tpl.html'
    )
    ,'enter_contest': ngRoute(
        path: '/:parent/enter_contest/:contestId',
        view: 'view/enter_contest.tpl.html'
    )
    ,'edit_contest': ngRoute(
        path: '/:parent/edit_contest/:contestId/:contestEntryId',
        view: 'view/enter_contest.tpl.html'
    )
    ,'view_contest_entry': ngRoute(
        path: '/:parent/view_contest_entry/:contestId',
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
    ,'edit_contest_entry': ngRoute(
        path: '/:parent/edit_contest_entry/:contestId',
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
    ,'new_contest_entry': ngRoute(
        path: '/:parent/new_contest_entry/:contestId',
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
  });
}