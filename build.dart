//import 'package:web_ui/component_build.dart';
import 'dart:io';
import 'cache_gen.dart';

void main(List<String> args) {
  for (String arg in args) {
      if (arg.startsWith('--changed=')) {
        String file = arg.substring('--changed='.length);

        if (!file.contains('generated.dart')) {
          print('Building...');
          generate("");
          print('Built');
        }
      }
    }

}
