library footer_comp;

import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/utils/html_utils.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';


@Component(
   selector: 'footer',
   useShadowDom: false
)
class FooterComp implements ShadowRootAware {

  FooterComp(this._router, this._loadingService, this._view, this._rootElement, this._dateTimeService, this._profileService, this._templateService, this._catalogService) {
    //_streamListener = _scrDet.mediaScreenWidth.listen((String scrWidth) => onScreenWidthChange(scrWidth));
  }

  @override void onShadowRoot(emulatedRoot) {
    _createHtml();
  }

  void detach() {
    //_streamListener.cancel();
  }

  void onScreenWidthChange(String scrWidth) {
    _createHtml();
  }

  void _createHtml() {
    /*
    String html =
    '''
    <div id="rootFooter">
      <div class="sub-footer-wrapper">
        <div class="sub-footer">
  
          <div class="logo-wrapper">
            <footer-a class="clickable" destination="home">
              <img src="images/logoLobbyFooter.png" alt="FÚTBOL CUATRO">
            </footer-a> 
            <span class="footer-count">&nbsp;</span>
          </div>
  
          <div class="data-wrapper">
            <footer-a class="clickable goto-link" id="footerHelp" destination="help_info">           <span class="sub-footer-help-link">${StringUtils.translate("help", "footer")}</span></footer-a>
            <!--a class="goto-link" id="footerLegal" destination="legal_info">         <span class="sub-footer-legal-link">${StringUtils.translate("legal", "footer")}</span></a-->
            <footer-a class="goto-link" id="footerTermsOfUse" externaldest="http://www.futbolcuatro.com/terminos-de-uso/"> <span class="sub-footer-terms-link">${StringUtils.translate("terms", "footer")}</span></footer-a>
            <footer-a class="goto-link" id="footerPrivacyPolicy" externaldest="http://www.futbolcuatro.com/politica-de-privacidad/"><span class="sub-footer-policy-link">${StringUtils.translate("privacy", "footer")}</span></footer-a>
            <!--a class="goto-link" id="footerBlog" target="_system" href="http://halftime.epiceleven.com"><span class="sub-footer-blog-link">BLOG</span></a-->
          </div>
  
          <!--
          <div class="credit-cards">
            <img src="images/creditCards.png" />
          </div>
          -->
          ${_scrDet.isXsScreen ? '' : '''
          <div class="opta">
            <div>${StringUtils.translate("data-provided-by", "footer")}: <span>OPTA</span></div>
            <div>A <strong>PERFORM</strong> GROUP COMPANY</div>
          </div>
          '''}
  
          <div class="copyright">© Copyright 2016 Fútbol Cuatro</div>
          ${_scrDet.isXsScreen ? '' : '''
          <div class="social">
            <footer-a externaldest="https://www.facebook.com/Futbolcuatro/"><img src="images/facebook.png"/></footer-a>
            <footer-a externaldest="https://www.twitter.com/Futbol_cuatro"><img src="images/twitter.png"/></footer-a>
          </div>
          '''}
        </div>
      </div>
    </div>
    ''';
    */
    String html = '''
        <div id="FooterBar" class="on-scroll">
          <div class="footer-wrapper">
            <div class="branding-column">
              <img title="Logo Futbol Cuatro el juego" alt="Logo de Futbol Cuatro" src="images/Logo-Futbol-Cuatro-el-juego-Footer.png">
              <ul class="footer-column-link-list">
                <li><a target="_blank" href="http://www.futbolcuatro.com/terminos-de-uso/">${StringUtils.translate("terms", "footer")}</a></li>
                <li><a target="_blank" href="http://www.futbolcuatro.com/politica-de-privacidad/">${StringUtils.translate("privacy", "footer")}</a></li>
              </ul>
              <p>${StringUtils.translate("data-provided-by", "footer")} <img title="Logo Opta" alt="Logo Opta" class="opta-brand-img" src="images/opta-logo.png"></p>
              <img title="Logo Opta Perform Group" alt="Logo Opta Perform Group" src="images/opta-perform-group.png">
              <span class="footer-count">&nbsp;</span>
            </div>
            <div class="links-column">
              <h5 class="links-column-title footer-column-title">${StringUtils.translate("links", "footer")}</h5>
              <ul class="footer-column-link-list">
                <li><a target="_blank" href="http://www.futbolcuatro.com/foros">${StringUtils.translate("futbolcuatroforum", "footer")}</a></li>
                <li><a target="_blank" href="http://www.futbolcuatro.com/blog/">${StringUtils.translate("futbolcuatroblog", "footer")}</a></li>
              </ul>
            </div>
            <div class="contact-column">
              <h5 class="contact-column-title footer-column-title">${StringUtils.translate("contact", "footer")}</h5>
              <ul class="footer-column-link-list">
                <li><a target="_blank" href="mailto:support@futbolcuatro.com">${StringUtils.translate("supportmail", "footer")}</a></li>
                <li>
                  <a target="_blank" class="footer-facebook-social" href="https://www.facebook.com/Futbolcuatro/">
                    <img title="Futbol Cuatro en Facebook" alt="Futbol Cuatro en Facebook" src="images/iconoFacebook.png">
                  </a>
                  <a target="_blank" class="footer-twitter-social" href="https://twitter.com/Futbol_cuatro">
                    <img title="Futbol Cuatro en Twitter" alt="Futbol Cuatro en Twitter" src="images/iconoTwitter.png">
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div class="copyright-bar">&copy; Copyright 2016 Fútbol Cuatro</div>
        </div>
    ''';
    
    _rootElement.setInnerHtml(html, treeSanitizer: NULL_TREE_SANITIZER);
    //_rootElement.querySelectorAll("[destination]").onClick.listen(_onMouseClick);
    //_rootElement.querySelectorAll("[externaldest]").onClick.listen(_onMouseClickExternal);
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
  
  void _onMouseClickExternal(event) {
    String destination = event.currentTarget.attributes["externaldest"];
    window.open(destination, "_system");
  }

  Element _rootElement;
  View _view;
  Router _router;

  DateTimeService _dateTimeService;
  LoadingService _loadingService;

  TemplateService _templateService;
  CatalogService _catalogService;
  ProfileService _profileService;
  //ScreenDetectorService _scrDet;

  //var _streamListener;
}