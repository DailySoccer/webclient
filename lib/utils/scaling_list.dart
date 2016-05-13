library scaling_list;

import 'package:angular/core/annotation.dart';
import 'dart:html';
import 'dart:math';

class ScalingList<T> {
  List<T> _fullList;
  List<T> _currentList;
  
  int initialAmount = 0;
  
  ScalingList(this.initialAmount);
  
  void set elements(List<T> list) {
    _fullList = list;
    _currentList = list.getRange(0, min(initialAmount, list.length)).toList();
    _startScalingList();
  }
  List<T> get elements {
    return _currentList;
  }
  
  void _startScalingList() {
    Function scaleList;
    scaleList = ([_]) {
      if (_currentList.length < _fullList.length) {
        _currentList.add(_fullList[_currentList.length]);
        window.animationFrame.then(scaleList);
      }
    };
    scaleList();
  }
}