import 'package:barback/barback.dart';

class TransformerTest extends Transformer {
  final BarbackSettings _settings;

  TransformerTest.asPlugin(this._settings);

  Future apply(Transform transform) {
    // Skip the transform in debug mode.
    if (_settings.mode.name == 'debug') return;

  }
}
