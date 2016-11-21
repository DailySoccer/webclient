library limit_to_dot;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Pipe(name:'limitToDot')
class LimitToDot implements Function {

  String call(String items, int limit) {

    if (items.length > limit) {
      return items.substring(0, limit) + '…';
    }
    else {
      return items;
    }
  }
}