library social_share_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/fblogin.dart';

@Component(
  selector: 'social-share',
  templateUrl: 'social_share_comp.html'
)
class SocialShareComp {

  /********* BINDINGS */
  @Input("description")
  void set description(String desc) { sharingInfo['description'] = desc; }
  
  @Input("caption")
  void set caption(String text) { sharingInfo['caption'] = text; }
  
  @Input("hash-tag")
  void set hashtag(String text) { sharingInfo['hashtag'] = text; }
  
  @Input("url")
  void set url(String uri) { sharingInfo['url'] = uri; }
  
  @Input("title")
  void set title(String text) { sharingInfo['title'] = text; }
  
  @Input("on-share")
  void set onShare(func) { sharingInfo['dartCallback'] = func; }

  @Input("image")
  void set image(String img) { sharingInfo['image'] = img; }
  
  @Input("show-like")
  bool showLike = true;

  /*
   *   <a href="https%3A%2F%2Fepiceleven.com%2Fshare"
   *      class="twitter-share-button"{count}
   *      data-url="{{sharingInfo['url']}}" 
   *      data-text="{{sharingInfo['description']}}"
   *      data-via="EpicEleven"
   *      data-related="epiceleven"
   *      data-hashtags="epiceleven"
   *      data-dnt="true">Tweet</a>
   */
  
  // Este es por comodidad
  @Input("parameters-by-map")
  void set info(Map allInfo) { sharingInfo = allInfo; }
  
  String get wraperId => sharingInfo['selector-prefix'].toString().replaceAll('#', '');
  
  SocialShareComp();
  
  Map sharingInfo = {};
}
