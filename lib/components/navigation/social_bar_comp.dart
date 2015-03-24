library social_bar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/components/contest_header_comp.dart';
import 'package:webclient/services/server_service.dart';

@Component(
    selector: 'social-bar',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"]
)
class SocialBarComp implements ShadowRootAware {

  SocialBarComp(this._rootElement, this._contestHeader, this._serverService);

  void _createHtml() {

    // print("Estoy en el concurso: ${_contestHeader.contest.name}");

    List <Map> social = [
                          {'name':'facebook', 'link_tag':'''data-href="shareOnFacebook"'''}
                         ,{'name':'twitter',  'link_tag':'''href="http://twitter.com/share?via=EpicEleven&url=${_url}&text=${getSubject()}" target="_blank"'''}
                         ,{'name':'whatsapp', 'link_tag':'''href="whatsapp://send?text=${getSubject()} ${_url}"'''}
                         ,{'name':'email',    'link_tag':'''href="mailto:?subject=${getSubject()}&body=${getTextToShare()} ${_url}"'''}
                        ];
    String icons = "";


    social.forEach((item) {
        icons += '''<a ${item['link_tag']} class="social_link ${item['name']}"><img src="${_imgPath + item['name'] + '.png'}"></a>''';
    });

    String html = '''
      <div id="socialBarRoot">
        <div class="socialBarWrapper">
          ${icons}
        </div>        
      </div>
     ''';


     _rootElement.setInnerHtml(html, validator: _htmlValidator);
     _rootElement.querySelectorAll("[data-href]").onClick.listen(_onAction);
  }

  void _onAction(MouseEvent event) {
    print("Llamada a la funcion para ${(event.target as Element).parent.attributes["data-href"]}");
    _fbShare(_url,'Play everywhere, anytime', getSubject(), getTextToShare(), 'http://epiceleven.com/images/apple-touch-icon-512x512-precomposed.png');
  }

  @override void onShadowRoot(emulatedRoot) {
    _serverService.shortUrl(window.location.toString()).then((shortenUrl) {
      _url = shortenUrl["meta"]["rdd_url"];
      _createHtml();
    });
  }


  String getTextToShare() {
    String textToShare;
    //Antes de que empiece:
    if (_contestHeader.contest.isActive) {
      textToShare="I've chosen my players for ${_contestHeader.contest.name}";
    }
    //Live
    else
    if (_contestHeader.contest.isLive) {
      textToShare="Check out how am I doing at ${_contestHeader.contest.name}";
    }
    //History
    else
    if (_contestHeader.contest.isHistory) {
      textToShare="These are my results";
    }
    return textToShare;
  }

  String getSubject() {
    String subject;
    //Antes de que empiece:
    if (_contestHeader.contest.isActive) {
      subject="I've picked my lineup at Epic Eleven!";
    }
    //Live
    else
    if (_contestHeader.contest.isLive) {
      subject="Watch my team live!";
    }
    //History
    else
    if (_contestHeader.contest.isHistory) {
      subject="The contest is over at Epic Eleven";
    }
    return subject;
  }

  static void _fbShare(String url, String caption, String name, String description, String picture) {
    JsUtils.runJavascript(null, "ui", {
      "method": 'feed',
      "caption": caption,
      "name": name,
      "description": description,
      "picture": picture,
      "link": url
      }, "FB");

  }

  String _url;
  Element _rootElement;
  String _imgPath = 'images/social/';
  ContestHeaderComp _contestHeader;
  ServerService _serverService;

  final NodeValidatorBuilder _htmlValidator=new NodeValidatorBuilder.common()
    ..allowElement('a', attributes: ['data-href', 'href', 'target']);
}