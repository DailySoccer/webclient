library active_contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';


@Component(
    selector: 'lobby',
    templateUrl: 'packages/webclient/components/lobby_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class LobbyComp implements ShadowRootAware, DetachAware {

  ActiveContestsService activeContestsService;
  Contest selectedContest;
  ScreenDetectorService scrDet;

  String sortType = "";

  /******************************************/
  final String FILTER_CONTEST_NAME = "FILTER_CONTEST_NAME";

  //Filtros que están bindeados a la contestList
  Map<String, Map> lobbyFilters = {};
  //Variable que guarda lo escrito en el input de buscar contest por nombre
  String filterContestName;
  /******************************************/
  LobbyComp(this._router, this.activeContestsService, this.scrDet) {
    activeContestsService.refreshActiveContests();
    const refreshSeconds = const Duration(seconds: 10);
    _timer = new Timer.periodic(refreshSeconds, (Timer t) => activeContestsService.refreshActiveContests());
    scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void onShadowRoot(root) {
    // Metemos en la lista de botones de ordenación los elementos que ordenan la lista
    _sortingButtons = document.querySelectorAll('.sorting-button');
    // Nos guardamos la lista de clases por defecto que traen los botones de filtros.
    _sortingButtonClassesByDefault = _sortingButtons.first.classes.toList();

    //capturamos el botón que abre el panel de filtros
    _filtersButtons = document.querySelectorAll('.filters-button');
    _filtersButtonClassesByDefault = _filtersButtons.first.classes.toList();
    //Al iniciar, tiene que está cerrado por lo tanto le añadimos la clase que pone la flecha hacia abajo
    _filtersButtons.forEach((value) => value.classes.add('toggleOff'));

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
    _router.go('enter_contest', {
      "contestId": contest.contestId
    });
  }

  // Handle que recibe cual es la nueva mediaquery que se aplica.
  void onScreenWidthChange(String msg) {
    if (msg != "desktop") {
      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal']).callMethod('modal', ['hide']);
    }
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
    if (scrDet.isDesktop) {
      selectedContest = contest;

      // Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
      var modal = querySelector('#infoContestModal');
      modal.style.display = "block";

      // Con esto llamamos a funciones de jQuery
      js.context.callMethod(r'$', ['#infoContestModal']).callMethod('modal');
    } else {
      onActionClick(contest);
    }
  }

  // Cambia el orden de la lista de concursos
  void sortListByField(String sortName) {
    if (sortName != _currentSelectedButton) {
      _currentButtonState = 0;
      _currentSelectedButton = sortName;
    } else {
      _currentButtonState++;
      if (_currentButtonState >= _butonState.length) _currentButtonState = 0;
    }

    //sortType = campo_dirección;
    sortType = sortName + "_" + _butonState[_currentButtonState];

    applySortingStyles("sort-" + sortName);
  }

  // Aplica los estilos necesarios para mostrar las flechitas de orden en los botones
  void applySortingStyles(String sortName) {
    Element btn = getButtonElementById(sortName);
    CleanAllSortButtonClasses();

    if (btn != null) {
      btn.classes.add(_butonState[_currentButtonState]);
      //print("El boton [$sortName] tiene ahora las clases: " + btn.classes.toList().toString() );
    }
  }

  // devuelve un elemento de la lista de botones de orden por su id
  Element getButtonElementById(String id) {
    for (Element button in _sortingButtons) {
      if (button.id == id) return button;
    }
    return null;
  }

  void CleanAllSortButtonClasses() {
    for (Element button in _sortingButtons) {
      button.classes.clear();
      button.classes.addAll(_sortingButtonClassesByDefault);
    }
  }

  // Muestra/Oculta el panel de filtros avanzados
  void toggleFilterMenu() {
    _filtersButtons.forEach((value) => value.classes.clear());
    _filtersButtons.forEach((value) => value.classes.addAll(_filtersButtonClassesByDefault));

    if (_isFilterButtonOpen) {
      _filtersButtons.forEach((value) => value.classes.add('toggleOff'));
      _isFilterButtonOpen = false;
    } else {
      _filtersButtons.forEach((value) => value.classes.add('toggleOn'));
      _isFilterButtonOpen = true;
    }
  }

  /*
   * Funciones para los filtros
   */
  void filterByContestName() {
    //comprobamos que si existe ya este filtro... Si existe lo eliminamos
    if (lobbyFilters.containsKey(FILTER_CONTEST_NAME)) {
      lobbyFilters.remove(FILTER_CONTEST_NAME);
    }
    //Como no se actualiza en el componente lista al modificar los valores... hay que crear siempre la lista 'lobbyFilters 'de cero:
    //1-Creamos un mapa nuevo
    Map<String, Map> lobbyFilterClone = {};
    //2- El mapa nuevo lo iniciamos con los valores de lobbyFilters para que no sea una referencia
    lobbyFilterClone.addAll(lobbyFilters);
    //3-Creamos el nuevo filtro...
    Map<String, Map> tmpMap = { FILTER_CONTEST_NAME: {'FILTER_FIELD': 'name', 'FILTER_CONDITION': 'CONTAINS', 'FILTER_VALUE': filterContestName } };
    //... y lo añadimos a la lista temporal que tendrá los valores anteriores + este nuevo
    lobbyFilterClone.addAll(tmpMap);
    //4-Por ultimo igualamos el lobbyFilter con el temporal que hemos construidos.
    lobbyFilters = lobbyFilterClone;
  }


  Timer _timer;
  Router _router;

  List<Element> _sortingButtons = [];
  List<String> _butonState = ['asc', 'desc'];
  int _currentButtonState = 0;
  String _currentSelectedButton = "";
  List<String> _sortingButtonClassesByDefault;

  List<Element> _filtersButtons;
  List<String> _filtersButtonClassesByDefault;
  bool _isFilterButtonOpen = false;
}
