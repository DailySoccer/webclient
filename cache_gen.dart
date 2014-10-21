import 'package:angular/tools/template_cache_generator.dart' as generator;

import 'package:path/path.dart' as path;
import 'dart:io';

void generate(String sdk_path) {
  List opts_array = ['--out=lib/generated.dart',
                    '--package-root=packages',
                    '--skip-classes=FooterComp,LandingPageComp,MainMenuSlideComp,FlashMessageComp',
                    'web/main.dart',
                    'template_cache'];

  if (sdk_path == null) {
    opts_array.insert(1,"--sdk-path="+path.dirname(path.dirname(Platform.environment["_"])));
  }

  var flush = generator.main(opts_array);

    flush.then((_) {
      print("generated.dart done");
    });
}

void main() {
		generate(null);
}