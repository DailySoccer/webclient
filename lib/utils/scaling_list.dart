library scaling_list;

import 'package:angular/core/annotation.dart';
import 'dart:html';
import 'dart:math';
import 'dart:collection';

class ScalingList<T> {
  
  int initialAmount = 0;
  Function get sortComparer =>  _sortComparer;
  void set sortComparer(bool comparer(T a, T b)) {
    _sortComparer = comparer;
    _processList();
  }
  
  void set elements(List<T> list) {
    if (list == null || list.isEmpty) return;
    _fullList = list;
    _processList();
    _startScalingList();
  }
  List<T> get elements => _currentList;
  bool get isFullList => _insertList.length == 0;
  
  ScalingList(this.initialAmount, [bool eqComparer(T a, T b)]) {
    _insertList = new Queue<T>();
    _fullList = [];
    _currentList = [];
    if(eqComparer != null) _equalsComparer = eqComparer;
  }

  void _processList() {
    _insertList.clear();
    _fullList.sort(sortComparer);
    
    if(_currentList.isEmpty) {
      // Si _currentList esta vacía _insertList tiene lo mismo que full list.
      _fullList.forEach( (t) => _insertList.addLast(t));
    } else {
      // Si _currentList no está vacía eliminamos todos los que no esten en full list.
      _currentList.removeWhere((t1) => !_fullList.any((t2) => _equalsComparer(t1, t2)));
      // y añadimos a la insert list los elementos que no están y la posicion en la que hay que insertarlos.
      _insertList.addAll(_fullList.where((t1) => !_currentList.any((t2) => _equalsComparer(t1, t2))));
    }
    _setInitialAmount();
  }
  
  void _setInitialAmount() {
    int count = min(initialAmount, _insertList.length);
    for (int i = _currentList.length; i < count; i++) {
      _currentList.add(_insertList.removeFirst());
    }
    
    for (int j = 0; j < count; j++) {
      if (!_equalsComparer(_currentList[j], _fullList[j])) {
        _currentList.add(_insertList.removeFirst());
      }
    }
    _currentList.sort(sortComparer);
  }
  
  void _startScalingList() {
    /*int count = min(initialAmount, _insertList.length);
    for (int j = _currentList.length; j < count; j++) {
      _currentList.add(_insertList.removeFirst());
    }*/
    //_setInitialAmount();
    _continueScaling = true;
    _scaleList();
  }

  void _scaleList([_]) {
    if (_insertList.length > 0 && _continueScaling) {
      _currentList..add(_insertList.removeFirst())
                  ..sort(sortComparer);
      
      window.animationFrame.then(_scaleList);
    }
  }
    
  void stopScaling() {
    _continueScaling = false;
  }
  void resumeScaling() {
    if (!_continueScaling) {
      _continueScaling = true;
      _scaleList();
    }
  }
  
  List<T> _fullList;
  Queue<T> _insertList;
  List<T> _currentList;
  bool _continueScaling;
  
  Function _equalsComparer = (T t1,T t2) => t1 == t2;
  Function _sortComparer =  (T t1,T t2) => 0;
}

