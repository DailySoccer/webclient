library webclient_router;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';

void webClientRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'landing_page': ngRoute(
        defaultRoute: true,
        path: '/landing_page',
        enter: (_) => enterPage(),
        viewHtml: '<landing-page></landing-page>'
    )
    ,'beta_info': ngRoute(
        path: '/beta_info',
        enter: (_) => enterPage(),
        viewHtml: '<beta-info></beta-info>'
    )
    ,'login': ngRoute(
        path: '/login',
        enter: (_) => enterPage(),
        viewHtml: '<login></login>'
    )
    ,'join': ngRoute(
        path: '/join',
        enter: (_) => enterPage(),
        viewHtml: '<join></join>'
    )
    ,'help_info': ngRoute(
        path: '/help-info',
        enter: (_) => enterPage(),
        viewHtml: '<help-info></help-info>'
    )
    ,'legal_info': ngRoute(
        path: '/legal_info',
        enter: (_) => enterPage(),
        viewHtml: '<legal-info></legal-info>'
    )
    ,'terminus_info': ngRoute(
        path: '/terminus_info',
        enter: (_) => enterPage(),
        viewHtml: '<terminus-info></terminus-info>'
    )
    ,'policy_info': ngRoute(
        path: '/policy_info',
        enter: (_) => enterPage(),
        viewHtml: '<policy-info></policy-info>'
    )
    ,'remember_password': ngRoute(
        path: '/remember_password',
        enter: (_) => enterPage(),
        viewHtml: '<remember-password></remember-password>'
    )
    ,'user_profile': ngRoute(
        path: '/user_profile',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<user-profile></user-profile>'
    )
    ,'lobby': ngRoute(
        path: '/lobby',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<lobby></lobby>'
    )
    ,'my_contests': ngRoute(
        path: '/my_contests',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<my-contests></my-contests>'
    )
    ,'live_contest': ngRoute(
        path: '/:parent/live_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        view: 'view/view_contest.tpl.html'
    )
    ,'history_contest': ngRoute(
        path: '/:parent/history_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        view: 'view/view_contest.tpl.html'
    )
    ,'enter_contest': ngRoute(
        path: '/:parent/enter_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        view: 'view/enter_contest.tpl.html'
    )
    ,'edit_contest': ngRoute(
        path: '/:parent/edit_contest/:contestId/:contestEntryId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        view: 'view/enter_contest.tpl.html'
    )
    ,'view_contest_entry': ngRoute(
        path: '/:parent/view_contest_entry/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
    ,'edit_contest_entry': ngRoute(
        path: '/:parent/edit_contest_entry/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
    ,'new_contest_entry': ngRoute(
        path: '/:parent/new_contest_entry/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (_) => enterPage(),
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
  });
}

// Funcion que ejecutamos nada más entrar en la página
void enterPage() {
  // Reseteamos las modales en el caso de que hubiera (bug de modal abierta y vuelta atrás)
  _resetModal();
}

void _resetModal() {
  bool isModalOpen = (document.querySelector('body').classes.contains('modal-open'));
  if(isModalOpen) {
    document.querySelector('body').classes.remove('modal-open');
    document.querySelector('.modal-backdrop').remove();
  }
}