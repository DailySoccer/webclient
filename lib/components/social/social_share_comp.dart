library social_share_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';

@Component(
  selector: 'social-share',
  templateUrl: 'packages/webclient/components/social/social_share_comp.html',
  useShadowDom: false
)
class SocialShareComp {

  /********* BINDINGS */
  @NgOneWay("description")
  void set description(String desc) { sharingInfo['description'] = desc; }
  
  @NgOneWay("caption")
  void set caption(String text) { sharingInfo['caption'] = text; }
  
  @NgOneWay("hash-tag")
  void set hashtag(String text) { sharingInfo['hashtag'] = text; }
  
  @NgOneWay("url")
  void set url(String uri) { sharingInfo['url'] = uri; }
  
  @NgOneWay("title")
  void set title(String text) { sharingInfo['title'] = text; }
  
  @NgCallback("on-share")
  void set onShare(func) { sharingInfo['dartCallback'] = func; }

  @NgOneWay("image")
  void set image(String img) { sharingInfo['image'] = img; }

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
  @NgOneWay("parameters-by-map")
  void set info(Map allInfo) { sharingInfo = allInfo; }
  
  SocialShareComp();
  
  Map sharingInfo = {};
}
