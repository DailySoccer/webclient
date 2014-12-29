library webclient;

import 'package:barback/barback.dart';
import 'dart:async';
import 'dart:io';

import 'package:utf/utf.dart';


class TransformerLess extends Transformer {

  TransformerLess.asPlugin();

  String get allowedExtensions => ".less";

  static String executable = "./node_modules/less/bin/lessc";

  static Future<String> transformee(String path, String outputPath) {
    var flags = [path, outputPath, "--compress", "--clean-css"];

    return Process.start(executable, flags).then((Process process) {
      StringBuffer errors = new StringBuffer();
      StringBuffer output = new StringBuffer();

      process.stdout.transform(new Utf8DecoderTransformer()).listen((str) => output.write(str));
      process.stderr.transform(new Utf8DecoderTransformer()).listen((str) => errors.write(str));

      return process.exitCode.then((exitCode) {
        if (exitCode == 0) {
          throw new Exception(errors.length != 0 ? errors.toString() : output.toString());
        }
      });
    }).catchError((ProcessException e) {
      throw new Exception(e.toString());
    }, test: (e) => e is ProcessException);
  }




  Future apply(Transform transform) {

    AssetId primaryAssetId = transform.primaryInput.id;

    var id = transform.primaryInput.id.changeExtension(".css");
    //id.path = primaryAssetId.path.replaceFirst("less", "css");

    String newPath = id.path.replaceFirst("/less/", "/css/");

    print(newPath);

    return TransformerLess.transformee(primaryAssetId.path, newPath);
    /*.then( (result) {
            transform.addOutput(new Asset.fromString(id, result));
           });
    */
  }

}
