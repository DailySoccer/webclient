var fbIsInit = false;
var facebookApiWrapper = {
  /*
  waitToBePrepared: function(callback) {
    var tryCall;
    tryCall = function (callback) {
      if (fbIsInit === false) {
        //console.log(" # RETRY");
        setTimeout(function() { tryCall(callback); }, 100);
      } else {
        //console.log(" # PRE-CALL");
        facebookConnectPlugin.getLoginStatus(
            function (status) {
              //console.log(" # CALLING");
              callback();
            }, function (error) {
              //console.log(error);
            }
        );
      }
    };
    tryCall(callback);
  },
  */
  login: function(callback) {
    //console.log(" - FB REQUEST => Login");
    facebookConnectPlugin.login(["public_profile", "email", "user_friends"],
        function (info) {
          //console.log(" - FB REQUEST => Login r:" + info);
          callback(info);
        },
        function (error) {
          console.warn(error)
        }
      );
  },

  loginStatus: function (callback) {
    //console.log(" - FB REQUEST => LoginStatus");
    facebookConnectPlugin.getLoginStatus(
        function (info ) {
          //console.log(" - FB REQUEST => LoginStatus r:" + info);
          callback(info);
        },
        function (error) {
          console.log(error)
        }
      );
  },
	permissions: function (callback) {
		//console.log(" - FB REQUEST => Permissions");
		facebookConnectPlugin.api('/me/permissions',
				["public_profile", "email", "user_friends"],
				function (response) {
					if (response && !response.error) {
						response['error'] = false;
					}
					//console.log(" - FB REQUEST => Permissions r:" + response);
					callback(response);
				},
				function (error) {
					console.log(error)
				}
			);
	},
	profileInfo: function(callback) {
		facebookConnectPlugin.api('/me?fields=picture,id,name,email', ["public_profile", "email", "user_friends"],
      function(response) {
         if (response && !response.error) {
           response['error'] = false;

           facebookConnectPlugin.getAccessToken(function(token) {
                  response['accessToken'] = token;
                  callback(response);
               }, function(err) {
                  response = err;
                  callback(response);
               });
         } else {
           callback(response);
         }
       },
      function (error) { console.log(error) });
	},
  profilePhoto: function(callback) {
		facebookConnectPlugin.api('/me?fields=picture,id,name,email', ["public_profile", "email", "user_friends"],
      function(response) {
         if (response && !response.error) {
           response['error'] = false;

           facebookConnectPlugin.getAccessToken(function(token) {
                  response['accessToken'] = token;
                  callback(response);
               }, function(err) {
                  response = err;
                  callback(response);
               });
         } else {
           callback(response);
         }
       },
      function (error) { console.log(error) });
  },
  friends: function (facebookId, callback) {
    //console.log(" - FB REQUEST => ProfileFriends");
    facebookConnectPlugin.api('/me/friends?fields=picture,id', ["public_profile", "email", "user_friends"],
        function(response) {
          //console.log(" - FRIENDS RESPONSE:");
          //console.log(response);
          if (response && !response.error) {
            var friendsInfo = [];
            for(var i = 0; i < response.data.length; i++) {
              friendsInfo[i] = { 'id': response.data[i].id,
                                 'image': {
                                     'url' : response.data[i]['picture']['data']['url'],
                                     'isDefault': response.data[i]['picture']['data']['is_silhouette']
                                   }
                                };
            }
            callback({ error: false,
                       friendsInfo: friendsInfo });
          } else {
            callback({ error: response.error });
          }
         },
        function (error) { console.log(error) });
  },
  share: function (params) {
    dartCallback = params.dartCallback || function() {};
    facebookConnectPlugin.showDialog(
        {
            method: 'share',
            name: 'Facebook Dialogs',
            href: params.url || $(location).attr('href'),
            link: params.url || $(location).attr('href'),
            picture: params.imageUrl,
            caption: params.caption || '',
            description: params.description || '',
            title: params.title
        },
        function (response) { dartCallback(); },
        function (response) { serverLoggerInfo(JSON.stringify(response)) });
  }

};
/*
function waitForFacebook(callback) {
  var tryCall;
  tryCall = function (callback) {
    if (fbIsInit === false) {
      //console.log(" # RETRY");
      setTimeout(function() { tryCall(callback); }, 100);
    } else {
      //console.log(" # PRE-CALL");
      facebookConnectPlugin.getLoginStatus(
          function (status) {
            //console.log(" # CALLING");
            callback();
          }, function (error) {
            //console.log(error);
          }
      );
    }
  };
  tryCall(callback);
}

// facebook sdk
// https://developers.facebook.com/docs/javascript/examples
function facebookLogin(callback) {
  //console.log(" - FB REQUEST => Login");
  facebookConnectPlugin.login(["public_profile", "email", "user_friends"],
      function (info ) {
        //console.log(" - FB REQUEST => Login r:" + info);
        callback(info);
      },
      function (error) {
        console.warn(error)
      }
    );
}

function facebookLoginStatus(callback) {
  //console.log(" - FB REQUEST => LoginStatus");
  facebookConnectPlugin.getLoginStatus(
      function (info ) {
        //console.log(" - FB REQUEST => LoginStatus r:" + info);
        callback(info);
      },
      function (error) {
        console.log(error)
      }
    );
}

function facebookPermissions(callback) {
  //console.log(" - FB REQUEST => Permissions");
  facebookConnectPlugin.api('/me/permissions',
      ["public_profile", "email", "user_friends"],
      function (response) {
        if (response && !response.error) {
          response['error'] = false;
        }
        //console.log(" - FB REQUEST => Permissions r:" + response);
        callback(response);
      },
      function (error) {
        console.log(error)
      }
    );
}

function facebookLoginReRequest(callback) {
  //TODO: NO CONTEMPLADO
  //console.log(" - FB REQUEST => LoginReRequest");
  waitForFacebook(function() {
    //console.log("js facebook rerequest");
    FB.login(callback, {
        scope: 'email, public_profile, user_friends',
        auth_type: 'rerequest'
      });
  });
}

function facebookProfileInfo(callback) {
  //console.log(" - FB REQUEST => ProfileInfo");
  facebookConnectPlugin.api('/me?fields=picture,id,name,email', ["public_profile", "email", "user_friends"],
      function(response) {
         if (response && !response.error) {
           response['error'] = false;

           facebookConnectPlugin.getAccessToken(function(token) {
                  response['accessToken'] = token;
                  callback(response);
               }, function(err) {
                  response = err;
                  callback(response);
               });
         } else {
           callback(response);
         }
       },
      function (error) { console.log(error) });
}

function facebookProfilePhoto(facebookId, callback) {
  //console.log(" - FB REQUEST => ProfilePhoto  ::: " + '/' + facebookId + '/picture?redirect=false' );
  waitForFacebook( function() {
    facebookConnectPlugin.api('/' + facebookId + '/picture?redirect=false', [],
        function(response) {
          //console.log(" - PROFILE PHOTO RESPONSE:");
          //console.log(response);
          if (response && !response.error) {
            callback({ error: false,
                       imageUrl: response.data.url,
                       isDefault: response.data.is_silhouette
                      });
          } else {
            callback({error: response.error});
          }
        },
        function (error) { callback({error: response.error}); });
  });
}

function facebookFriends(facebookId, callback) {
  //console.log(" - FB REQUEST => ProfileFriends");
  facebookConnectPlugin.api('/me/friends?fields=picture,id', ["public_profile", "email", "user_friends"],
      function(response) {
        //console.log(" - FRIENDS RESPONSE:");
        //console.log(response);
        if (response && !response.error) {
          var friendsInfo = [];
          for(var i = 0; i < response.data.length; i++) {
            friendsInfo[i] = { 'id': response.data[i].id,
                               'image': {
                                   'url' : response.data[i]['picture']['data']['url'],
                                   'isDefault': response.data[i]['picture']['data']['is_silhouette']
                                 }
                              };
          }
          callback({ error: false,
                     friendsInfo: friendsInfo });
        } else {
          callback({ error: response.error });
        }
       },
      function (error) { console.log(error) });
}

function facebookShare(params) {
  dartCallback = params.dartCallback || function() {};
  facebookConnectPlugin.showDialog(
      {
          method: 'share',
          name: 'Facebook Dialogs',
          href: params.url || $(location).attr('href'),
          link: params.url || $(location).attr('href'),
          picture: params.imageUrl,
          caption: params.caption || '',
          description: params.description || '',
          title: params.title
      },
      function (response) { dartCallback(); },
      function (response) { serverLoggerInfo(JSON.stringify(response)) });
}
*/
var facebookParseXFBMLActiveSelectors = [];

function facebookParseXFBML(cssSelector) {
  if (facebookParseXFBMLActiveSelectors.indexOf(cssSelector) != -1) {
    return;
  }
  facebookParseXFBMLActiveSelectors.push(cssSelector);

  var parse;
  var trys = 0;
  var fbCheck = false;
  var msWaiting = 20;
  parse = function () {
    var xfbmlElements = document.querySelectorAll(cssSelector);
    if (!fbCheck || xfbmlElements.length == 0) {
      trys++;
      if (trys < 500) {
        setTimeout(parse, msWaiting);
      } else {
        serverLoggerServere("WTF - 8798 - JS - Parse XFBML made " + trys +
                            " trys in " + (trys*msWaiting /1000) + " seconds and fail");
      }
    } else {
      FB.XFBML.parse();
      facebookParseXFBMLActiveSelectors.splice(facebookParseXFBMLActiveSelectors.indexOf(cssSelector),1);
    }
  }
  facebookApiWrapper.waitForFacebook(function() { fbCheck = true; });
  parse();
}