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



document.addEventListener('deviceready', function () {
  console.log(" # DEVICE READY EVENT - FB");
  fbIsInit = true;
  
  console.log(" # DEVICE READY EVENT - Comscore");
  ComScorePlugin.setCustomerData("13184057", "15f020eaf9d74aaec3b72f6be73feff4");
  
  
  console.log(" # DEVICE READY EVENT - SHOP");
  if (!window.store) {
    window.serverLoggerServere('Store not available');
    return;
  }

  /* use when configure CSS
  var platform = device.platform.toLowerCase();
  document.getElementsByTagName('body')[0].className = platform;
  */

  store.verbosity = store.INFO;

  // Enable remote receipt validation
  // store.validator = "https://api.fovea.cc:1982/check-purchase";

  // Log all errors
  store.error(function(error) {
    window.serverLoggerServere('Store Error => ' + error.code + ': ' + error.message);
  });

  store.ready(function() {
    store.refresh();
    paymentServiceReady();
    console.log("# STORE READY");
  });

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
