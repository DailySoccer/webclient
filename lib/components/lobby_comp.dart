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
  static const String FILTER_CONTEST_NAME           = "FILTER_CONTEST_NAME";
  static const String FILTER_ENTRY_FEE_MIN          = "FILTER_ENTRY_FEE_MIN";
  static const String FILTER_ENTRY_FEE_MAX          = "FILTER_ENTRY_FEE_MAX";
  static const String FILTER_TOURNAMENT             = "FILTER_TOURNAMENT";
  static const String FILTER_TIER                   = "FILTER_TIER";

  static const String FILTER_TIER_LIMIT_FOR_BEGGINERS    = "BEGGINER";
  static const String FILTER_TIER_LIMIT_FOR_STANDARDS    = "STANDARD";
  static const String FILTER_TIER_LIMIT_FOR_SKILLEDS     = "SKILLED";

  static const int    SALARY_LIMIT_FOR_BEGGINERS    = 90000;
  static const int    SALARY_LIMIT_FOR_STANDARDS    = 80000;
  static const int    SALARY_LIMIT_FOR_SKILLEDS     = 70000;

  static const String TOURNAMENT_TYPE_FREE          = "FREE";
  static const String TOURNAMENT_TYPE_LIGA          = "LIGA";
  static const String TOURNAMENT_TYPE_FIFTY_FIFTY   = "FIFTY_FIFTY";
  static const String TOURNAMENT_TYPE_HEAD_TO_HEAD  = "HEAD_TO_HEAD";

  //Tipo de ordenación de la lista de partidos
  String sortType = "";

  //Filtros que están bindeados a la contestList
  Map<String, dynamic> lobbyFilters = {};

  //valor para el filtro por nombre
  String filterContestName;

   // Variables expuestas por ng-model en los checks del filtro de dificultad
  bool isBeginnerTierChecked          = false;
  bool isStandardTierChecked          = false;
  bool isSkilledTierChecked           = false;

  ActiveContestsService activeContestsService;
  Contest selectedContest;
  ScreenDetectorService scrDet;

  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => getEntryFeeFilterRange()[0];
  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => getEntryFeeFilterRange()[1];

  // propiedad que dice si existen concursos del tipo "PRINCIPIANTE" en la lista actual de concursos.
  bool get hasBegginerTier {
    bool result = false;
    if (activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap >= SALARY_LIMIT_FOR_BEGGINERS;
         if (comparison) {
           result =  true;
         }
      });
    }
    return result;
  }

  // propiedad que dice si existen concursos del tipo "STANDARS" en la lista actual de concursos.
  bool get hasStandardTier {
    bool result = false;
    if (activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap < SALARY_LIMIT_FOR_BEGGINERS && contest.templateContest.salaryCap > SALARY_LIMIT_FOR_SKILLEDS;
         if (comparison) {
           result =  true;
         }
      });
    }
    return result;
  }

  // propiedad que dice si existen concursos del tipo "EXPERTS" en la lista actual de concursos.
  bool get hasSkilledTier {
    bool result = false;
    if (activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap <= SALARY_LIMIT_FOR_BEGGINERS;
         if (comparison) {
           result =  true;
         }
      });
    }
    return result;
  }

  /*
   * TODO: Mientras no tengamos los datos de a que competición pertenece el torneo, esta función
   *       devolverá siempre "false" para que los botones del filtro de competición estén deshabilitados.
   */
  bool hasCompetitionsOf(String value)
  {
    /*if (activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
        //TODO: devuelvo true o false en funcion del tipo de concurso
      });
    }*/
    //print('-LOBBY_COMP-: Botón de filtro por ${value} deshabilitado temporalmente');
    return false;
  }

  // Variables expuestas por ng-model en los checks del filtro de Tipo de Torneo
  void set isFreeTournamentChecked(value) {
    _isFreeTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isFreeTournamentChecked => _isFreeTournamentChecked;

  void set isLigaTournamentChecked(value) {
    _isLigaTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isLigaTournamentChecked => _isLigaTournamentChecked;

  void set isFiftyFiftyTournamentChecked(value) {
    _isFiftyFiftyTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isFiftyFiftyTournamentChecked => _isFiftyFiftyTournamentChecked;

  void set isHeadToHeadTournamentChecked(value) {
    _isHeadToHeadTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isHeadToHeadTournamentChecked => _isHeadToHeadTournamentChecked;

  LobbyComp(this._router, this.activeContestsService, this.scrDet) {
    activeContestsService.refreshActiveContests();
    const refreshSeconds = const Duration(seconds: 10);
    _timer = new Timer.periodic(refreshSeconds, (Timer t) =>  activeContestsService.refreshActiveContests());
    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
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

    // Inicializamos el control que dibuja el slider para el filtro por entrada
    initSliderRange();
  }

  void onEntryFeeRangeChange(dynamic sender, dynamic data) {
    _filterEntryFeeMin = data[0];
    _filterEntryFeeMax = data[1];
    filterByEntryFee();
  }

  void detach() {
    _timer.cancel();
    _streamListener.cancel();
  }

  dynamic getEntryFeeFilterRange(){
    var range = js.context.callMethod(r'$', ['#slider-range']).callMethod('val');
    return range != null? range : ["",""];
  }

  void onActionClick(Contest contest) {
    selectedContest = contest;
    _router.go('enter_contest', { "contestId": contest.contestId });
  }

  // Handle que recibe cual es la nueva mediaquery que se aplica.
  void onScreenWidthChange(String msg) {
    if (msg != "desktop") {
      // hacemos una llamada de jQuery para ocultar la ventana modal
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
    }
    else {
      onActionClick(contest);
    }
  }

  // Cambia el orden de la lista de concursos
  void sortListByField(String sortName) {
    if (sortName != _currentSelectedButton) {
      _currentButtonState = 0;
      _currentSelectedButton = sortName;
    }
    else {
      _currentButtonState++;
      if (_currentButtonState >= _butonState.length) _currentButtonState = 0;
    }

    sortType = sortName + "_" + _butonState[_currentButtonState];

    print('-LOBBY_COMP-: Ordenando la lista de torneos: ${sortType.split('_')}');

    applySortingStyles("sort-" + sortName);
  }

  // Aplica los estilos necesarios para mostrar las flechitas de orden en los botones
  void applySortingStyles(String sortName) {
    Element btn = getButtonElementById(sortName);
    CleanAllSortButtonClasses();

    if (btn != null) {
      btn.classes.add(_butonState[_currentButtonState]);
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

  void initSliderRange()
  {
    //iniciamos slider-range
        js.context.callMethod(r'$', ['#slider-range'])
            .callMethod('noUiSlider', [new js.JsObject.jsify({'start':      [0, 100],
                                                              'step' :      1,
                                                              'behaviour':  'drag',
                                                              'connect':    true,
                                                              'range':      {'min':0,'max':100}})]);

    // Nos subscribimos al evento change
     js.context.callMethod(r'$', ['#slider-range'])
       .callMethod('on', new js.JsObject.jsify([{'set': onEntryFeeRangeChange}]));
  }

   /*
   * Funciones para los filtros
   */
  void filterByContestName() {
    addFilter(FILTER_CONTEST_NAME, filterContestName);
  }

  void filterByEntryFee(){
    addFilter(FILTER_ENTRY_FEE_MIN, _filterEntryFeeMin);
    addFilter(FILTER_ENTRY_FEE_MAX, _filterEntryFeeMax);
    print('-LOBBY_COMP-: Filtrando por tipo precio entrada. Valores entre [${_filterEntryFeeMin} - ${_filterEntryFeeMax}]');
  }

  void refreshTierFilter() {
    List<String> tierValues = [];
    _tierFilterList = [];

    if (isBeginnerTierChecked) {
      tierValues.add(FILTER_TIER_LIMIT_FOR_BEGGINERS);
    }

    if (isStandardTierChecked) {
      tierValues.add(FILTER_TIER_LIMIT_FOR_STANDARDS);
    }

    if (isSkilledTierChecked) {
      tierValues.add(FILTER_TIER_LIMIT_FOR_SKILLEDS);
    }

    _tierFilterList.addAll(tierValues);

    //Añadimos el filtro solo si se ha seleccionado algún valor...
    if (_tierFilterList.length > 0) {
      addFilter(FILTER_TIER, _tierFilterList);
    }
    else { //...si no, nos aseguramos que no vaya este filtro para que no interfiera
      if (lobbyFilters.containsKey(FILTER_TIER)) {
        lobbyFilters.remove(FILTER_TIER);
      }
    }

    //provocamos la actialización
    addFilter("", []);
    print('-LOBBY_COMP-: Filtrando por tipo de torneo: torneos: [${_tierFilterList}]');
  }

  // Devuelve true si existe un torneo del tipo que le pasamos por parametro.
   bool hasTournamentsType(String value)
   {
     bool result = false;
     if (activeContestsService.activeContests != null) {
        activeContestsService.activeContests.forEach((Contest contest) {
           bool comparison = contest.templateContest.tournamentType == value;
           if (comparison) {
             result =  true;
           }
        });
      }
      return result;
   }

  void refreshTorunamentFilter() {
    List<String> tournamentValues = [];
    _tournamentFilterList = [];

    if (isFreeTournamentChecked) {
      tournamentValues.add(TOURNAMENT_TYPE_FREE);
    }

    if (isLigaTournamentChecked) {
      tournamentValues.add(TOURNAMENT_TYPE_LIGA);
    }

    if (isFiftyFiftyTournamentChecked) {
      tournamentValues.add(TOURNAMENT_TYPE_FIFTY_FIFTY);
    }

    if (isHeadToHeadTournamentChecked) {
      tournamentValues.add(TOURNAMENT_TYPE_HEAD_TO_HEAD);
    }

    _tournamentFilterList.addAll(tournamentValues);

    //Añadimos el filtro solo si se ha seleccionado algún valor...
    if (_tournamentFilterList.length > 0) {
      addFilter(FILTER_TOURNAMENT, _tournamentFilterList);
    }
    else {//...si no, nos aseguramos que no vaya este filtro para que no interfiera
      if (lobbyFilters.containsKey(FILTER_TOURNAMENT)) {
        lobbyFilters.remove(FILTER_TOURNAMENT);
      }
    }
    //provocamos la actialización
    addFilter("", []);

    print('-LOBBY_COMP-: Filtrando por tipo de torneo: torneos: [${_tournamentFilterList}]');
  }

  void addFilter(String key, dynamic valor) {
      //comprobamos que si existe ya este filtro... Si existe lo eliminamos
      if (lobbyFilters.containsKey(key)) {
        lobbyFilters.remove(key);
      }
      //Como no se actualiza en el componente lista al modificar los valores... hay que crear siempre la lista 'lobbyFilters 'de cero:
      //1-Creamos un mapa nuevo
      Map<String, dynamic> lobbyFilterClone = {};
      //2- El mapa nuevo lo iniciamos con los valores de lobbyFilters para que no sea una referencia
      lobbyFilterClone.addAll(lobbyFilters);
      // no metemos keys vacías
      if (key != "") {
        //3-Creamos el nuevo filtro siempre que no no llegue una Key vacía...
        Map<String, dynamic> tmpMap = { key: valor };
        // ... y lo añadimos a la lista temporal que tendrá los valores anteriores + este nuevo
        lobbyFilterClone.addAll(tmpMap);
      }
      //4-Por ultimo igualamos el lobbyFilter con el temporal que hemos construidos.
      lobbyFilters = lobbyFilterClone;
    }

  void resetAllFilters(){
    // reseteo del filtro por precio de entrada
    _filterEntryFeeMin = "0";
    _filterEntryFeeMax = "100";
    js.context.callMethod(r'$', ['#slider-range'])
      .callMethod('val', [new js.JsObject.jsify([0,100])]);

    // reseteo del filtro por dificultad
    isBeginnerTierChecked          = false;
    isStandardTierChecked          = false;
    isSkilledTierChecked           = false;
    _tierFilterList = [];

    // Reseteo del filtro por tipo de torneo
    isFreeTournamentChecked        = false;
    isLigaTournamentChecked        = false;
    isFiftyFiftyTournamentChecked  = false;
    isHeadToHeadTournamentChecked  = false;
    _tournamentFilterList = [];

    //limpio la caja de filtro por nombre
   InputElement el = document.querySelector('.searcher');
   el.value = "";

    //provocamos la actialización
    lobbyFilters = {};
    addFilter("", []);
    print('-LOBBY_COMP-: Filtros reseteados');
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
  String _filterEntryFeeMin;
  String _filterEntryFeeMax;
  List<String> _tierFilterList;
  List<String> _tournamentFilterList;

  bool _isFreeTournamentChecked        = false;
  bool _isLigaTournamentChecked        = false;
  bool _isFiftyFiftyTournamentChecked  = false;
  bool _isHeadToHeadTournamentChecked  = false;

  var _streamListener;
}
