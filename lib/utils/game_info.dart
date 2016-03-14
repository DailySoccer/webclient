library gameInfo;

import 'dart:html';
import 'package:logging/logging.dart';

class GameInfo {
  static void clear() {
    if (isLocalStorageNameSupported)  {
      window.localStorage.clear();
    }
    else {
      _pool.clear();
    }
  }
  
  
  static bool contains(String key) {
    return isLocalStorageNameSupported ? window.localStorage.containsKey(key) : _pool.containsKey(key);
  }

  static void assign(String key, dynamic value) {
    if (isLocalStorageNameSupported)  {
      window.localStorage[key] = value;
    }
    else {
      _pool[key] = value;
    }
  }

  static void remove(String key) {
    if (isLocalStorageNameSupported)  {
      window.localStorage.remove(key);
    }
    else {
      _pool.remove(key);
    }
  }

  static dynamic get(String key) {
    return isLocalStorageNameSupported ? window.localStorage[key] : _pool[key];
  }

  static bool get isLocalStorageNameSupported {
    if (!_initialized) {
      var testKey = 'test', storage = window.localStorage;
      try {
        storage[testKey] = '1';
        storage.remove(testKey);
        _localStorageNameSupported = true;
      } catch (error) {
        _localStorageNameSupported = false;
      }
      
      Logger.root.info("GameInfo: isLocalStorageNameSupported: $_localStorageNameSupported");
      _initialized = true;
    }
    return _localStorageNameSupported;
  }
  
  static Map<String, dynamic> _pool = new Map<String, dynamic>();
  static bool _localStorageNameSupported;
  static bool _initialized = false;
}