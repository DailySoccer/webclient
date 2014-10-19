import 'package:angular/tools/template_cache_generator.dart' as generator;

void main() {
	var flush = generator.main(['--out=generated.dart',
	                            "--sdk-path=/Users/vmendi/Documents/Dart/dart-sdk",
                              'lib/components/lobby_comp.dart',
                              'generated']);
	flush.then((_) {
	  print("generated.dart done");
	});
}