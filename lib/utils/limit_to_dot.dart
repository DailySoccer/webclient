library limit_to_dot;

import 'package:angular/core/annotation.dart';

@Formatter(name:'limitToDot')
class LimitToDot implements Function {

  String call(String items, int limit) {

    int j = items.length;

    if (j > limit) {
      return items.substring(0, limit) + '…';
    }
    else {
      return items.substring(0, j);
    }
  }
}