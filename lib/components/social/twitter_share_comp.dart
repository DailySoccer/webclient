library twitter_share_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/fblogin.dart';
import 'package:webclient/utils/js_utils.dart';

@Component(
  selector: 'twitter-share',
  templateUrl: 'packages/webclient/components/social/twitter_share_comp.html',
  useShadowDom: false
)
class TwitterShareComp {
  
  /********* BINDINGS */
  /*@NgOneWay("description")
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
  */

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
  
  @NgOneWay("show-like")
  bool showLike = true;
  
  // Este es por comodidad
  @NgOneWay("parameters-by-map")
  void set info(Map allInfo) {
    sharingInfo = allInfo;
    updateButtons();
  }
  
  TwitterShareComp() {
    JsUtils.setJavascriptFunction('twitterShareCB', onTweet);
    JsUtils.setJavascriptFunction('twitterFollowCB', onFollow);
  }
  
  void updateButtons() {
    if(sharingInfo['url'] != null && sharingInfo['hashtag'] != null && sharingInfo['description'] != null) {
      JsUtils.runJavascript(null, 'loadTwitterWidgets', { 
            'text': sharingInfo['description'],
            'hashtags': sharingInfo['hashtag'],
            'url': sharingInfo['url'],
            'via': "Epiceleven"
          });
    }
  }

  String getParam(String param) => 'https://about.twitter.com/es/resources/buttons#tweet';
  
  void onTweet() {
    if (sharingInfo['dartCallback'] != null) sharingInfo['dartCallback']();
  }
  void onFollow() {
  }
  
  Map sharingInfo = {};
}
