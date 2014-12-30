library webclient;

import 'package:barback/barback.dart';
import 'dart:async';
import 'dart:io';

import 'package:utf/utf.dart';


class TransformerLess extends Transformer {

  TransformerLess.asPlugin();

  String get allowedExtensions => ".less";

  final String executable = "./node_modules/less/bin/lessc";

  Future<String> compile(String inputPath) {
    var flags = [inputPath, "--compress", "--clean-css"];

    return Process.start(executable, flags).then((Process process) {
      StringBuffer errors = new StringBuffer();
      StringBuffer output = new StringBuffer();

      process.stdout.transform(new Utf8DecoderTransformer()).listen((str) => output.write(str));
      process.stderr.transform(new Utf8DecoderTransformer()).listen((str) => errors.write(str));

      return process.exitCode.then((exitCode) {
        if (exitCode != 0) {
          throw new Exception(errors.length != 0 ? errors.toString() : output.toString());
        }
        else {
          return output.toString();
        }
      });
    }).catchError((ProcessException e) {
      throw new Exception(e.toString());
    }, test: (e) => e is ProcessException);
  }

  Future apply(Transform transform) {
    return compile(transform.primaryInput.id.path).then((output) {
      transform.addOutput(new Asset.fromString(
          new AssetId(transform.primaryInput.id.package,
              transform.primaryInput.id.changeExtension(".css").path
              .replaceFirst("/less/", "/css/")
              ),
              output));
    });
  }
}
