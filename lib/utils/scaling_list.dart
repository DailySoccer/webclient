library scaling_list;

import 'package:angular/core/annotation.dart';
import 'dart:html';
import 'dart:math';
import 'dart:collection';

class ScalingList<T> {
  List<T> _fullList;
  Queue<_Pair<T>> _insertList;
  List<T> _currentList;
  
  int initialAmount = 0;
  Function _compare = (T t1,T t2) => t1 == t2;
  
  ScalingList(this.initialAmount, [bool f(T a, T b)]) {
    _insertList = new Queue<_Pair<T>>();
    _currentList = [];
    if(f != null) _compare = f;
  }
  
  void set elements(List<T> list) {
    _fullList = list;
    _processList();
    _startScalingList();
  }
  List<T> get elements => _currentList;
  bool get isFullList => _insertList.length == 0;

  void _processList() {
    int i = 0;
    int j = 0;
    _insertList.clear();
    
    if(_currentList.isEmpty) {
      // Si _currentList esta vacía _insertList tiene lo mismo que full list.
      _fullList.forEach( (t) => _insertList.addLast(new _Pair(t, i++)));
      // Despues sacamos initialAmount y los metemos en _currentList.
      for (j = 0; j < initialAmount; j++) {
        _currentList.add(_insertList.removeFirst().value);
      }
    } else {
      // Si _currentList no está vacía eliminamos todos los que no esten en full list.
      _currentList.removeWhere((t1) => _fullList.firstWhere((t2) => _compare(t1, t2), orElse: () => null) == null);
      // y añadimos a la insert list los elementos que no están y la posicion en la que hay que insertarlos.
      _fullList.forEach( (t) {
        if(!_compare(_fullList[i], _currentList[j])) {
          _insertList.add(new _Pair(t, i));
        } else {
          j++;
        }
        i++;
      });
    }
  }
  
  void _startScalingList() {
    Function scaleList;
    scaleList = ([_]) {
      if (_insertList.length > 0) {
        _Pair<T> element = _insertList.removeFirst();
        _currentList.insert(element.position, element.value);
        window.animationFrame.then(scaleList);
      }
    };
    scaleList();
  }
}

class _Pair<T> {
    T value;
    int position;
    _Pair(this.value, this.position);
}
