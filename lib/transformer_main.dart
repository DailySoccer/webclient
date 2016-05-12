library webclient;

import 'package:barback/barback.dart';
import 'dart:async';

class TransformerMain extends Transformer {

  TransformerMain.asPlugin();

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((content) {
      transform.addOutput(new Asset.fromString(transform.primaryInput.id,
                                               content.toString()
                                               .replaceFirst('<script src="main.dart" id="mainDart" type="application/dart"></script>',
                                                             '<!--script src="main.dart.js" id="mainDart"></script-->')));
    });
  }
}