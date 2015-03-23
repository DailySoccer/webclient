library social_bar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/components/contest_header_comp.dart';

@Component(
    selector: 'social-bar',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"]
)
class SocialBarComp implements ShadowRootAware {

  String get url => window.location.toString().replaceAll("#","%23");
  SocialBarComp(this._rootElement, this._contestHeader);

  void _createHtml() {

    // print("Estoy en el concurso: ${_contestHeader.contest.name}");

    List <Map> social = [
                          {'name':'facebook', 'link_tag':'''data-href="shareOnFacebook"'''}
                         ,{'name':'twitter',  'link_tag':'''href="http://twitter.com/share?via=EpicEleven&url=${url}&text=${getTextToShare()}" target="_blank"'''}
                         ,{'name':'whatsapp', 'link_tag':'''href="whatsapp://send?text=${getTextToShare()} ${url}"'''}
                         ,{'name':'email',    'link_tag':'''href="mailto:?subject=${getSubject()}&body=${getTextToShare()} ${url}"'''}
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
    _fbShare(url,'caption', getSubject(), getTextToShare(), 'http://epiceleven.com/images/apple-touch-icon-512x512-precomposed.png');
  }

  @override void onShadowRoot(emulatedRoot) {
    _createHtml();
  }

  String getTextToShare() {
    return "Mira como molo";
  }
  String getSubject() {
    return "Name";
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

  Element _rootElement;
  String _imgPath = 'images/social/';
  ContestHeaderComp _contestHeader;

  final NodeValidatorBuilder _htmlValidator=new NodeValidatorBuilder.common()
    ..allowElement('a', attributes: ['data-href', 'href', 'target']);
}