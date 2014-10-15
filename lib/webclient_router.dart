library webclient_router;

import 'package:angular/angular.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';

void webClientRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'landing_page': ngRoute(
        defaultRoute: true,
        path: '/landing_page',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<landing-page></landing-page>'
    )
    ,'beta_info': ngRoute(
        path: '/beta_info',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<beta-info></beta-info>'
    )
    ,'login': ngRoute(
        path: '/login',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<login></login>'
    )
    ,'join': ngRoute(
        path: '/join',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<join></join>'
    )
    ,'help_info': ngRoute(
        path: '/help-info',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<help-info></help-info>'
    )
    ,'legal_info': ngRoute(
        path: '/legal_info',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<legal-info></legal-info>'
    )
    ,'terminus_info': ngRoute(
        path: '/terminus_info',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<terminus-info></terminus-info>'
    )
    ,'policy_info': ngRoute(
        path: '/policy_info',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<policy-info></policy-info>'
    )
    ,'remember_password': ngRoute(
        path: '/remember_password',
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<remember-password></remember-password>'
    )
    ,'user_profile': ngRoute(
        path: '/user_profile',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<user-profile></user-profile>'
    )
    ,'lobby': ngRoute(
        path: '/lobby',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<lobby></lobby>'
    )
    ,'my_contests': ngRoute(
        path: '/my_contests',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<my-contests></my-contests>'
    )
    ,'live_contest': ngRoute(
        path: '/:parent/live_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<view-contest></view-contest>'
    )
    ,'history_contest': ngRoute(
        path: '/:parent/history_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<view-contest></view-contest>'
    )
    ,'enter_contest': ngRoute(
        path: '/:parent/enter_contest/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        view: 'view/enter_contest.tpl.html'
    )
    ,'edit_contest': ngRoute(
        path: '/:parent/edit_contest/:contestId/:contestEntryId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        view: 'view/enter_contest.tpl.html'
    )
    ,'view_contest_entry': ngRoute(
        path: '/:parent/view_contest_entry/:viewContestEntryMode/:contestId',
        preEnter: (RoutePreEnterEvent e) => e.allowEnter(ProfileService.allowEnter()),
        enter: (RouteEnterEvent e) => enterPage(e),
        leave: (RouteLeaveEvent e) => leavePage(e),
        viewHtml: '<view-contest-entry></view-contest-entry>'
    )
  });
}

// Funcion que ejecutamos nada más entrar en la página
void enterPage(RouteEnterEvent event) {
}

// Funcion que ejecutamos nada más salir de la página
void leavePage(RouteLeaveEvent event) {
  // Reseteamos las modales en el caso de que hubiera (bug de modal abierta y vuelta atrás)
  _closeModal();
}

void _closeModal() {
  bool isModalOpen = (document.querySelector('body').classes.contains('modal-open'));
  if(isModalOpen) {
    document.querySelector('body').classes.remove('modal-open');
    document.querySelector('.modal-backdrop').remove();
  }
}