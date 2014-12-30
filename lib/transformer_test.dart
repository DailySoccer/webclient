library webclient;

import 'package:barback/barback.dart';
import 'dart:async';

class TransformerTest extends Transformer {

  TransformerTest.asPlugin();

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((content) {
      transform.addOutput(new Asset.fromString(transform.primaryInput.id,
                                               content.toString()
                                                 .replaceFirst(
                  "<script src=\"main.dart\" id=\"mainDart\"></script>\n",
                  "<script src=\"main.dart.js\" id=\"mainDart\"></script>\n")));
    });
    }

}
