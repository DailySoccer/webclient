window.twitterShare = window.twitterShare || function(event) {
  if (typeof twitterShareCB !== "undefined" && twitterShareCB != null) {
    twitterShareCB();
  }
};
window.twitterFollow = window.twitterFollow || function(event) {
  if (typeof twitterFollowCB !== "undefined" && twitterFollowCB != null) {
    twitterFollowCB();
  }
};
var twitterLoaderProcess = null;
function loadTwitterWidgets(options) {
  var generalWrapperSelector = options['selector-prefix'] || '';
  var shareWrapper = document.querySelectorAll(generalWrapperSelector + " .twitter-share-button-wrapper"); //document.getElementsById('twitterShareButton');
  var followWrapper = document.querySelectorAll(generalWrapperSelector + " .twitter-follow-button-wrapper"); //document.getElementById('twitterFollowButton');

  if (followWrapper.length != 0 && shareWrapper.length != 0 && typeof twttr !== "undefined" && twttr != null) {

    for (var i = 0; i < shareWrapper.length; i++) {
      var l = 0;
      var wrapper = shareWrapper[i];
      while (wrapper.children.length > 0) {
        wrapper.children[0].remove();
      }
      twttr.widgets.createShareButton(
        options['url'],
        wrapper,
        {
          text: options['text'],
          hashtags: options['hashtags'],
          via: options['via']
        }
      );
    }

    for (var i = 0; i < followWrapper.length; i++) {
      var l = 0;
      var wrapper = followWrapper[i];
      while (wrapper.children.length > 0) {
        wrapper.children[0].remove();
      }
      twttr.widgets.createFollowButton(
        'EpicEleven',
        wrapper,
        { showScreenName: 'false' }
      );
    }
  }

  if (followWrapper.length == 0 && shareWrapper.length == 0 || typeof twttr === "undefined" || twttr == null) {
    setTimeout(function () {
      loadTwitterWidgets(options);
    }, 100);
  }
}
window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s); js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);
  t._e = []; t.ready = function(f) {t._e.push(f);};
  return t;
}(document, "script", "twitter-wjs"));

twttr.ready(function (twttr) {
  // Now bind our custom intent events
  twttr.events.bind('tweet', window.twitterShare);
  twttr.events.bind('follow', window.twitterFollow);
  /*
  twttr.events.bind('click', window.twitterShare);
  twttr.events.bind('retweet', retweetIntentToAnalytics);
  twttr.events.bind('like', likeIntentToAnalytics);
  */
});