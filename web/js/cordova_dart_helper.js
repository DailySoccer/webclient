
window.onApplicationPause = function() {
  ComScorePlugin.onExitForeground();

  if (typeof dartOnApplicationPause !== 'undefined') {
    console.log("Calling dart callback on app PAUSE");
    dartOnApplicationPause();
  }
};
window.onApplicationResume = function() {
  ComScorePlugin.onEnterForeground();
  StatusBar.hide();

  if (typeof dartOnApplicationResume !== 'undefined') {
    console.log("Calling dart callback on app RESUME");
    dartOnApplicationResume();
  }
};

window.onApplicationPause = typeof onApplicationPause !== 'undefined' ? onApplicationPause : function() {};
window.onApplicationResume = typeof onApplicationResume !== 'undefined' ? onApplicationResume : function() {};

function getUUID(cb) {
  if (typeof cordova === 'undefined') {
    cb("UUID-UUID-UUID-UUID");
    return;
  }
  cb(device.uuid);
}

function getPlatform(cb) {
  if (typeof cordova === 'undefined') {
    cb("web");
    return;
  }
  cb(device.platform);
}

function getAppVersion(cb) {
  if (typeof cordova === 'undefined') {
    cb("1.0.0");
    return;
  }
  cordova.getAppVersion.getVersionNumber(cb);
}

document.onreadystatechange = function () {
  if (typeof cordova === 'undefined') {
    return
  }

  if (document.readyState === 'complete') {
      console.log(" # READY - STATE COMPLETED");

      getAppVersion(function (version) {
          console.log("Version App: " + version);
      });

      console.log('Device Name: ' + device.name);
      console.log('Device Cordova: ' + device.cordova);
      console.log('Device Platform: ' + device.platform);
      console.log('Device UUID: ' + device.uuid);
      console.log('Device Version: ' + device.version);
      console.log('Device Serial: ' + device.serial);
      console.log('Device isVirtual: ' + device.isVirtual);
      console.log('Device Manufacturer: ' + device.manufacturer);

      $.getScript("main.dart.js", function(data, textStatus, jqxhr) {
        console.log('main.dart.js: Load was performed.');
      });
  }
}

var universalLinksData = { "isEmpty": true };
function getULData(callback) {
  callback(JSON.stringify(universalLinksData));
}

function socialShare(s, u) {

  // this is the complete list of currently supported params you can pass to the plugin (all optional)
  /*var options = {
    message: 'share this', // not supported on some apps (Facebook, Instagram)
    subject: 'the subject', // fi. for email
    files: ['', ''], // an array of filenames either locally or remotely
    url: 'https://www.website.com/foo/#bar?a=b',
    chooserTitle: 'Pick an app' // Android only, you can override the default share sheet title
  }*/
  // this is the complete list of currently supported params you can pass to the plugin (all optional)
  var options = {
    subject: s,
    url: u
  };
  var onSuccess = function(result) {
    console.log("Share completed? " + result.completed); // On Android apps mostly return false even while it's true
    console.log("Shared to app: " + result.app); // On Android result.app is currently empty. On iOS it's empty when sharing is cancelled (result.completed=false)
  };
  var onError = function(msg) { console.log("Sharing failed with message: " + msg); };
  
  window.plugins.socialsharing.shareWithOptions(options, onSuccess, onError);
}

document.addEventListener('deviceready', function () {
  showSpinner();
  console.log(" # DEVICE READY EVENT - Comscore");
  ComScorePlugin.setAppContext();
  ComScorePlugin.setAppName("futbolcuatro");
  ComScorePlugin.setCustomerData("13184057", "15f020eaf9d74aaec3b72f6be73feff4");
  ComScorePlugin.autoUpdateForeground(1);
  ComScorePlugin.autoUpdateBackground(1);
  ComScorePlugin.start();
  
  StatusBar.hide();
  
  console.log(" # DEVICE READY EVENT - FB");
  fbIsInit = true;
  
  epicStore.ready();

  console.log(" # DEVICE READY EVENT - UniversalLinks");
  universalLinks.subscribe('e11Event', function(ev) {
    universalLinksData = ev;
    universalLinksData.isEmpty = false;
  });

  /* use when configure CSS
  var platform = device.platform.toLowerCase();
  document.getElementsByTagName('body')[0].className = platform;
  */

  document.addEventListener("pause", function() {
    onApplicationPause();
    console.log(" # PAUSE");
  }, false);

  document.addEventListener("resume", function() {
    onApplicationResume();
    console.log(" # RESUME");
  }, false);
  
}, false);


window.serverLoggerInfo = window.serverLoggerInfo || function(text) {
  if (typeof serverLoggerInfoCB !== "undefined" && serverLoggerInfoCB != null) {
    serverLoggerInfoCB(text);
  }
};

window.serverLoggerWarning = window.serverLoggerWarning || function(text) {
  if (typeof serverLoggerWarningCB !== "undefined" && serverLoggerWarningCB != null) {
    serverLoggerWarningCB(text);
  }
};

window.serverLoggerServere = window.serverLoggerServere || function(text) {
  if (typeof serverLoggerServereCB !== "undefined" && serverLoggerServereCB != null) {
    serverLoggerServereCB(text);
  }
};


function onjQueryReady(dartCallback) {
  $().ready(function() {
    dartCallback();
  });
}

function conversion(remarketing_only) {
  /*if (typeof window.google_trackConversion == 'function') {
    window.google_trackConversion(remarketing_only?
                                  { google_conversion_id: 957611754,
                                    google_custom_params: {},
                                    google_remarketing_only: true
                                  } :
                                  { google_conversion_id: 957611754,
                                    google_conversion_language: "en",
                                    google_conversion_format: "2",
                                    google_conversion_color: "ffffff",
                                    google_conversion_label: "ouQSCJrYx1cQ6v3PyAM",
                                    google_remarketing_only: false
                                  }
                                  );
  }*/
}
