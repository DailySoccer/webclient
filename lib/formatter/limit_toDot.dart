library limit_toDot;

import 'package:di/di.dart';
import 'package:angular/core/annotation.dart';

@Formatter(name:'limitToDot')
class LimitToDot implements Function {
  Injector _injector;
  bool _dotted;

  LimitToDot(this._injector);

  dynamic call(String items, [int limit]) {
    if (items == null) 
      return null;
    
    if (limit == null) 
      return const[];
    
    if (items is! List && items is! String) 
      return items;
    
    int i = 0, j = items.length;
    if (limit > -1) {
      _dotted = (j > limit) ? true : false;
      j = (limit > j) ? j : limit;  
    } else {
      _dotted = false;
      i = j + limit;
      if (i < 0) i = 0;
    }
    
    if (_dotted) {
      return items.substring(i, j) + '…';
    } else {
      return items.substring(i, j);
    }
  }
}