import 'package:angular/tools/template_cache_generator.dart' as generator;

import 'package:path/path.dart' as path;
import 'dart:io';


void main() {
	var flush = generator.main(['--out=lib/generated.dart',
	                            "--sdk-path="+path.dirname(path.dirname(Platform.environment["_"])),
	                            '--package-root=packages',
                              'web/main.dart',
	                            'template_cache']);


	flush.then((_) {
	  print("generated.dart done");
	});
}