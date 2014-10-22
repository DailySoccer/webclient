import 'dart:io';
import 'package:path/path.dart' as path;
import 'cache_gen_core.dart' as generator;


void main() {
  //generate('/Users/vmendi/Documents/Dart/dart-sdk');
  generate(null);
}

//
// Esto es un envoltorio que le ponemos al template_cache_generator de tools/angular para que sea mas comodo llamarle.
// De momento hemos "retocado" el template_cache_generator que venia con angular para hacer que funcione con nuestros
// paths. En la proxima version cuando el transformer de angular soporte templateUrls con solo el nombre, podremos
// volver a usar el template_cache_generator tal y como viene.
// Tb lo hemos renombrado: template_cache_generator => cache_gen_core.
//
void generate(String sdk_path) {
  List opts_array = ['--out=lib/template_cache.dart',
                     '--package-root=packages',
                     'web/main.dart',
                     'template_cache'];

  if (sdk_path == null)
    sdk_path = Platform.environment["DART_SDK"];

  if (sdk_path == null)
    sdk_path = path.dirname(path.dirname(Platform.environment["_"]));

  print("The Dart SDK path is ${sdk_path}");
  opts_array.insert(1,"--sdk-path=" + sdk_path);

  generator.main(opts_array).then((_) {
    print("lib/template_cache.dart done");
  });
}
