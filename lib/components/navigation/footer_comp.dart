library footer_comp;

import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(
   selector: 'footer',
   useShadowDom: false
)
class FooterComp implements ShadowRootAware {

  FooterComp(this._router, this._loadingService, this._view, this._rootElement, this._dateTimeService, this._srcDet);

  @override void onShadowRoot(emulatedRoot) {
    _createHtml();
  }

  void _createHtml() {

    String html =
    '''
    <div id="rootFooter">
      <div class="sub-footer-wrapper">
        <div class="sub-footer">
  
          <div class="logo-wrapper">
            <a href="/"><img src="images/logoLobbyFooter.png" alt="EPIC ELEVEN"></img></a> <span class="footer-count">&nbsp;</span>
          </div>
  
          <div class="data-wrapper">
            <a class="goto-link" id="footerHelp" destination="help_info"><span class="sub-footer-help-link">AYUDA</span></a>
            <a class="goto-link" id="footerLegal" destination="legal_info"><span class="sub-footer-legal-link">LEGAL</span></a>
            <a class="goto-link" id="footerTermsOfUse" destination="terminus_info"><span class="sub-footer-terms-link">TERMINOS<span> DE USO</span></span></a>
            <a class="goto-link" id="footerPrivacyPolicy" destination="policy_info"><span class="sub-footer-policy-link"><span>POLÍTICA DE </span>PRIVACIDAD</span></a>
          </div>
  
          <!--<div class="credit-cards">
            <img src="images/creditCards.png" />
          </div>-->
  
          <div class="opta">
            <div>Datos suministrados por: <span>OPTA</span></div>
            <div>A <strong>PERFORM</strong> GROUP COMPANY</div>
          </div>
  
          <div class="copyright">@ Copyright 2014 Epic Eleven</div>
  
          <div class="social">
            <a href="https://www.facebook.com/pages/Epic-Eleven/582891628483988?fref=ts"><img src="images/social.png"/></a>
          </div>
        </div>
      </div>
    </div>
    ''';

    _rootElement.setInnerHtml(html, treeSanitizer: NULL_TREE_SANITIZER);
    _rootElement.querySelectorAll("[destination]").onClick.listen(_onMouseClick);
    _setupTimer();
  }

  void _setupTimer() {
    if (HostServer.isDev) {
      // No hace falta cancelar, somos un componente global
      new Timer.periodic(new Duration(seconds: 1), (_) {
        _rootElement.querySelector(".footer-count").text = DateTimeService.formatDateTimeLong(DateTimeService.now);
      });
    }
  }

  void _onMouseClick(event) {
    String destination = event.currentTarget.attributes["destination"];
    _router.go(destination, {});
  }


  Element _rootElement;
  View _view;
  Router _router;

  DateTimeService _dateTimeService;
  LoadingService _loadingService;
  ScreenDetectorService _srcDet;
}