library social_bar_comp;

import 'dart:html';
import 'package:angular/angular.dart';
//import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'social-bar',
    useShadowDom: false,
    exportExpressions: const ["profileService.user"]
)
class SocialBarComp implements ShadowRootAware {

  SocialBarComp(this._rootElement); /*{
    _streamListener = _scrDet.mediaScreenWidth.listen((String scrWidth) => onScreenWidthChange(scrWidth));
  }*/

  void _createHtml() {
    //List<String> social = ['facebook', 'twitter', 'whatsapp', 'linkedIn', 'mail'];
    List <Map> social = [
                          {'name':'facebook', 'link_tag':'''action="shareOnFacebook"'''}
                         ,{'name':'twitter',  'link_tag':'''href="url_twitter"'''}
                         ,{'name':'whatsapp', 'link_tag':'''href="url_whatsapp"'''}
                         ,{'name':'linkedIn', 'link_tag':'''href="url_linkedIn"'''}
                         ,{'name':'email',    'link_tag':'''href="url_email"'''}
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
     _rootElement.querySelectorAll("[action]").onClick.listen(_onAction);
  }

  void _onAction(MouseEvent event) {
    print("Llamada a la funcion para ${(event.target as Element).parent.attributes["action"]}");
  }
/*
  void onScreenWidthChange(String scrWidth) {
    _createHtml();
  }
*/
  @override void onShadowRoot(emulatedRoot) {
    _createHtml();
  }
/*
  void detach() {
    _streamListener.cancel();
  }
*/
  //ScreenDetectorService _scrDet;
  //var _streamListener;
  Element _rootElement;
  String _imgPath = 'images/social/';

  final NodeValidatorBuilder _htmlValidator=new NodeValidatorBuilder.common()
    ..allowElement('a', attributes: ['action']);
}