library facebook_share_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'facebook-share',
  templateUrl: 'packages/webclient/components/social/facebook_share_comp.html',
  useShadowDom: false
)
class FacebookShareComp {
  
  /********* BINDINGS */
  @NgOneWay("description")
  void set description(String desc) { _info['description'] = desc; }
  
  @NgOneWay("image")
  void set image(String img) { _info['image'] = img; }
  
  @NgOneWay("caption")
  void set caption(String text) { _info['caption'] = text; }
  
  @NgOneWay("url")
  void set url(String uri) { _info['url'] = uri; }
  
  @NgOneWay("title")
  void set title(String text) { _info['title'] = text; }

  @NgCallback("on-share")
  void set onShare(func) { _info['dartCallback'] = func; }
  
  @NgOneWay("show-like")
  bool showLike = true;
  
  // Este es por comodidad
  @NgOneWay("parameters-by-map")
  void set info(Map allInfo) { _info = allInfo; }
  
  FacebookShareComp() {
    FBLogin.parseXFBML('.facebook-like-xfbml');
  }
  
  void shareOnFB() {
    FBLogin.share(_info);
    GameMetrics.logEvent(GameMetrics.SHARE_REQUEST_FB);
  }
  
  Map _info = {};
}
