library webclient;

import 'package:barback/barback.dart';
import 'dart:async';
import 'dart:io';

import 'package:utf/utf.dart';


class TransformerLess extends Transformer {

  TransformerLess.asPlugin();

  String get allowedExtensions => ".less";

  final String executable = "./node_modules/less/bin/lessc";

  Future compile(String inputPath, String outputPath) {
    var flags = [inputPath, outputPath, "--compress", "--clean-css"];

    return Process.start(executable, flags).then((Process process) {
      StringBuffer errors = new StringBuffer();
      StringBuffer output = new StringBuffer();

      process.stdout.transform(new Utf8DecoderTransformer()).listen((str) => output.write(str));
      process.stderr.transform(new Utf8DecoderTransformer()).listen((str) => errors.write(str));

      return process.exitCode.then((exitCode) {
        if (exitCode != 0) {
          throw new Exception(errors.length != 0 ? errors.toString() : output.toString());
        }
      });
    }).catchError((ProcessException e) {
      throw new Exception(e.toString());
    }, test: (e) => e is ProcessException);
  }

  Future apply(Transform transform) {
    return compile(transform.primaryInput.id.path,
                   transform.primaryInput.id.changeExtension(".css").path
                    .replaceFirst("/less/", "/css/")
                    .replaceFirst("web/", "build/web/"));
  }
}
