library noshim;

import 'dart:html';
import 'package:angular/core_dom/module_internal.dart';
import 'package:angular/angular.dart';


/// Class to effectively disable CSS shim
@Injectable()
class DefaultPlatformNoShim implements DefaultPlatformShim {
  bool get shimRequired => true;
  String shimCss(String css, {String selector, String cssUrl}) => css;
  void shimShadowDom(Element root, String selector) {}
}

/// Class to effectively disable CSS shim
@Injectable()
class PlatformJsBasedNoShim implements PlatformJsBasedShim {
  bool get shimRequired => true;
  String shimCss(String css, {String selector, String cssUrl}) => css;
  void shimShadowDom(Element root, String selector) {}
}