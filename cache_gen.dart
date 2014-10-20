import 'package:angular/tools/template_cache_generator.dart' as generator;

void main() {
  /*
	var flush = generator.main(['--out=generated.dart',
	                            //"--sdk-path=/Users/vmendi/Documents/Dart/dart-sdk",
                              'lib/components/lobby_comp.dart',
                              'template_cache']);

  */
	var flush = generator.main(['--out=generated.dart',
	                            "--sdk-path=/Users/gnufede/Desktop/dart/dart-sdk",
	                            'lib/components/lobby_comp.dart',
	                            //'web/index.html',
	                            'template_cache']);
	flush.then((_) {
	  print("generated.dart done");
	});
}