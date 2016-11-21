library facebook_share_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/game_metrics.dart';

@Component(
  selector: 'facebook-share',
  templateUrl: 'facebook_share_comp.html'
)
class FacebookShareComp {
  
  /********* BINDINGS */
  @Input("description")
  void set description(String desc) { _info['description'] = desc; }
  
  @Input("image")
  void set image(String img) { _info['image'] = img; }
  
  @Input("caption")
  void set caption(String text) { _info['caption'] = text; }
  
  @Input("url")
  void set url(String uri) { _info['url'] = uri; }
  
  @Input("title")
  void set title(String text) { _info['title'] = text; }

  @Input("on-share")
  void set onShare(func) { _info['dartCallback'] = func; }
  
  @Input("show-like")
  bool showLike = true;
  
  // Este es por comodidad
  @Input("parameters-by-map")
  void set info(Map allInfo) { _info = allInfo; }
  
  FacebookShareComp() {
    FBLogin.parseXFBML('.facebook-like-xfbml');
  }
  
  void shareOnFB() {
    FBLogin.share(_info);
    //GameMetrics.logEvent(GameMetrics.SHARE_REQUEST_FB);
  }
  
  Map _info = {};
}
