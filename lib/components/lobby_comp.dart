library active_contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(selector: 'lobby',
           templateUrl: 'packages/webclient/components/lobby_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class LobbyComp implements ShadowRootAware, DetachAware {

  ActiveContestsService activeContestsService;
  Contest selectedContest;

  String sortType ="";

  LobbyComp(this._router, this.activeContestsService, this._scrDet) {
      activeContestsService.refreshActiveContests();
      const refreshSeconds = const Duration(seconds:10);
      _timer = new Timer.periodic(refreshSeconds, (Timer t) => activeContestsService.refreshActiveContests());
      _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg) );
  }

  void onShadowRoot(root)
  {
    // Metemos en la lista de botones de ordenación los elementos que ordenan la lista
    _sortingButtons = document.querySelectorAll('.sorting-button');
    // Nos guardamos la lista de clases por defecto que traen los botones de filtros.
    _sortingButtonClassesByDefault = _sortingButtons.first.classes.toList();

    //capturamos el botón que abre el panel de filtros
    _filtersButton = document.querySelector('.filters-button');
    _filtersButtonClassesByDefault = _filtersButton.classes.toList();
    //Al iniciar, tiene que está cerrado por lo tanto le añadimos la clase que pone la flecha hacia abajo
    _filtersButton.classes.add('toggleOff');


    /*
      _sortingButtons.first.classes.forEach((value) => _sortingButtonClassesByDefault += (" " + value) );   ///(String value => _sortingButtonClassesByDefault += value);
      _sortingButtonClassesByDefault = _sortingButtons.first.classes.fold("", (prev, value) => prev + value + " " );
     */
  }

  void detach() {
    _timer.cancel();
  }

  void onActionClick(Contest contest) {
    selectedContest = contest;
    _router.go('enter_contest', { "contestId": contest.contestId });
  }

  // Handle que recibe cual es la nueva mediaquery que se aplica.
  void onScreenWidthChange(String msg)
  {
    if(msg == "xs"){
      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal'])
        .callMethod('modal', ['hide']);

      print('-LOBBY COMP- .Ventana Modal cerrada automáticamente');
    }
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if(!_scrDet.isXsScreen)
    {
      selectedContest = contest;

      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";

      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal'])
        .callMethod('modal');
    }
  }

  // Cambia el orden de la lista de concursos
  void sortListByFlied(String sortName)
  {
    if ( sortName !=_currentSelectedButton )
    {
      _currentButtonState = 0;
      _currentSelectedButton = sortName;
    }
    else
    {
      _currentButtonState++;
      if (_currentButtonState >= _butonState.length)
        _currentButtonState = 0;
    }

    //sortType = campo_dirección;
    sortType = sortName + "_" +_butonState[_currentButtonState];

    applySortingStyles("sort-" + sortName);
  }

  // Aplica los estilos necesarios para mostrar las flechitas de orden en los botones
  void applySortingStyles(String sortName)
  {
    Element btn = getButtonElementById(sortName);
    CleanAllSortButtonClasses();

    if(btn != null){
      btn.classes.add(_butonState[_currentButtonState]);
      //print("El boton [$sortName] tiene ahora las clases: " + btn.classes.toList().toString() );
    }
  }

  // devuelve un elemento de la lista de botones de orden por su id
  Element getButtonElementById(String id)
  {
    for (Element button in _sortingButtons)
    {
      if( button.id == id )
        return button;
    }
    return null;
  }

  void CleanAllSortButtonClasses()
  {
    for (Element button in _sortingButtons)
       {
         button.classes.clear();
         button.classes.addAll(_sortingButtonClassesByDefault);
       }
  }

  // Muestra/Oculta el panel de filtros avanzados
  void toggleFilterMenu()
  {
    _filtersButton.classes.clear();
    _filtersButton.classes.addAll(_filtersButtonClassesByDefault);

    if (_isFilterButtonOpen){
      _filtersButton.classes.add('toggleOff');
       _isFilterButtonOpen = false;
    }
    else
    {
      _filtersButton.classes.add('toggleOn');
      _isFilterButtonOpen = true;
    }
  }

  Timer _timer;
  Router _router;
  ScreenDetectorService _scrDet;

  List<Element> _sortingButtons  = [];
  List<String>  _butonState = ['asc', 'desc'];
  int           _currentButtonState = 0;
  String        _currentSelectedButton = "";
  List<String>  _sortingButtonClassesByDefault;

  Element       _filtersButton;
  List<String>  _filtersButtonClassesByDefault;
  bool          _isFilterButtonOpen = false;
}
