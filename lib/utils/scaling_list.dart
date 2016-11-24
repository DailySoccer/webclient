library scaling_list;

import 'package:angular/core/annotation.dart';
import 'dart:html';
import 'dart:math';
import 'dart:collection';
import 'package:logging/logging.dart';
// import 'package:logging/logging.dart';

class ScalingList<T> {
  
  int initialAmount = 0;
  Function get sortComparer =>  _sortComparer;
  void set sortComparer(bool comparer(T a, T b)) {
    _sortComparer = comparer;
    _processList();
  }
  
  void set elements(List<T> list) {
    if (list == null) return;
    _fullList = list;
    _processList();
  }
  List<T> get elements => _currentList;
  bool get isFullList => _insertList.isEmpty;
  
  // TODO Cambiar los parámetros opcionales por "named"
  ScalingList(this.initialAmount, [bool eqComparer(T a, T b), bool sorting]) {
    _insertList = new Queue<T>();
    _referenceList = new Queue<T>();
    _fullList = [];
    _currentList = [];
    if(eqComparer != null) _equalsComparer = eqComparer;
    if(sorting != null) _sorting = sorting;
  }

  void _processList() {
    _insertList.clear();
    
    if (_sorting) {
      _fullList.sort(sortComparer);
    }
    
    if(_currentList.isEmpty) {
      // Si _currentList esta vacía _insertList tiene lo mismo que full list.
      _fullList.forEach( (t) => _insertList.addLast(t));
    } else {
      // Si _currentList no está vacía eliminamos todos los que no esten en full list.
      _currentList.removeWhere((t1) => !_fullList.any((t2) => _equalsComparer(t1, t2)));

      // Actualizar las referencias (dado que la información de los mismos puede haber cambiado)
      // Añadimos todas las que no estén actualmente
      _referenceList.addAll(_fullList.where((t1) => !_referenceList.any((t2) => _equalsComparer(t1, t2))));
      window.animationFrame.then(_runUpdateReferences);
      
      // y añadimos a la insert list los elementos que no están y la posicion en la que hay que insertarlos.
      _insertList.addAll(_fullList.where((t1) => !_currentList.any((t2) => _equalsComparer(t1, t2))));
    }

    window.animationFrame.then(_startScalingList);
    // Logger.root.info("_processList: ${_fullList.length} - ${new DateTime.now()}");
  }
  
  void _setInitialAmount([_]) {
    int count = min(initialAmount, _insertList.length);
    for (int i = _currentList.length; i < count; i++) {
      _currentList.add(_insertList.removeFirst());
    }
    
    for (int j = 0; j < count; j++) {
      if (!_equalsComparer(_currentList[j], _fullList[j]) && _insertList.isNotEmpty) {
        _currentList.add(_insertList.removeFirst());
      }
    }
    
    if (_sorting) {
      _currentList.sort(sortComparer);
    }
  }
  
  void _startScalingList([_]) {
    /*int count = min(initialAmount, _insertList.length);
    for (int j = _currentList.length; j < count; j++) {
      _currentList.add(_insertList.removeFirst());
    }*/
    _setInitialAmount();
    _continueScaling = true;
    
    window.animationFrame.then(_runScaleList);
  }

  int _numScaleList = 0;
  void _runScaleList([_]) { if (_numScaleList <= 0) { ++_numScaleList; _scaleList(); } }
  void _endScaleList() { --_numScaleList; }

  int _numUpdateReferences = 0;
  void _runUpdateReferences([_]) { if (_numUpdateReferences <= 0) { ++_numUpdateReferences; _updateReferences(); } }
  void _endUpdateReferences() { --_numUpdateReferences; }
 
  void _updateReferences([_]) {
    if (_referenceList.isNotEmpty) {
      var el = _referenceList.removeFirst();
      
      for (int i=0; i<_currentList.length && i<10; i++) {
        if (_equalsComparer(el, _currentList[i])) {
          _currentList[i] = el;
          break;
        }
      }
      
      window.animationFrame.then(_updateReferences);
    }
    else {
      _endUpdateReferences();
    }
  }
  
  void _scaleList([_]) {
    if (_insertList.isNotEmpty && _continueScaling) {
      _currentList.add(_insertList.removeFirst());
      
      if (_sorting) {
        _currentList.sort(sortComparer);
      }
      
      window.animationFrame.then(_scaleList);
      // Logger.root.info("_scaleList: ${_currentList.length} - ${new DateTime.now()}");
    }
    else {
      _endScaleList();
    }
  }
    
  void stopScaling() {
    _continueScaling = false;
  }
  
  void resumeScaling() {
    if (!_continueScaling) {
      _continueScaling = true;
      _runScaleList();
    }
  }
  
  void redraw() {
    if (_currentList != null) {
      // TODO Habrá que buscar un método alternativo de "redraw" cuando la lista no se quiera ordenar
      if (_sorting) {
        _currentList.sort(sortComparer);
      }
    }
  }
  
  List<T> _fullList;
  Queue<T> _insertList;
  Queue<T> _referenceList;
  List<T> _currentList;
  bool _continueScaling;
  
  Function _equalsComparer = (T t1,T t2) => t1 == t2;
  Function _sortComparer =  (T t1,T t2) => 0;
  bool _sorting = true;
}

