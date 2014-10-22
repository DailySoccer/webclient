library contest_filters_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:math';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'contest-filters-comp',
    templateUrl: '/packages/webclient/components/contest_filters_comp.html',
    useShadowDom: false
)
class ContestFiltersComp implements ShadowRootAware {

  /********* CONSTANTS */
  static const String FILTER_CONTEST_NAME = "FILTER_CONTEST_NAME";
  static const String FILTER_ENTRY_FEE    = "FILTER_ENTRY_FEE";
  static const String FILTER_TOURNAMENT   = "FILTER_TOURNAMENT";
  static const String FILTER_TIER         = "FILTER_TIER";

  static const int ENTRY_FEE_MIN_RANGE = 0;
  static const int ENTRY_FEE_MAX_RANGE = 1;

  /********* DECLARATIONS */
  // Mapa para traducir los filtros a lenguaje Human readable
  Map filtersFriendlyName = {
    "FILTER_TOURNAMENT":{
      "FREE"          :"Torneos Gratuitos",
      "HEAD_TO_HEAD"  :"Torneos 1 Contra 1",
      "LEAGUE"        :"Torneos de league",
      "FIFTY_FIFTY"   :"Torneos 50 / 50"
    },
    "FILTER_TIER":{
      "BEGGINER" :"Dificultad principiante",
      "STANDARD" :"Dificultad Estandar",
      "SKILLEDS" :"Dificultad Experto"
    },
    "FILTER_ENTRY_FEE":"Entrada ",
    "FILTER_CONTEST_NAME":"Nombre "
  };

  // Filtro por nombre
  String filterContestName = "";

  // Lista de tipos de concurso.
  List<Map> contestTypeFilterList = [];

  // Lista de tipos de Limites de salarios.
  List<Map> salaryCapFilterList = [];

  // Valores para el rango de Entry Fee
  List<int> entryFeeSliderRange = [];

  // Valores para los botones de orden
  List<Map> sortingButtons = [];

  //Lista de filtros
  Map<String, dynamic> filterList = {};


  ScreenDetectorService scrDet;


  /********* BINDINGS */
  @NgOneWay("contests-list")
   void set contestsList(List<Contest> value) {
    if (value == null) {
      return;
    }
    _contestList = value;
    setFilterValues();
  }

  @NgTwoWay("on-sort-order-change")
  Function onSortOrderChange;

  @NgCallback('on-filter-change')
  Function onFilterChange;


  /********* PROPERTIES */
  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => "0";

  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => "1";

  ContestFiltersComp(this.scrDet) {
    initializeFilterValues();
    initializeSortValues();
  }

  /********* HANDLERS */
  void onOpenFiltersPanel(dynamic sender) {
    _filtersPanelButtons.forEach((value) => value.classes.remove('toggleOff'));
    _filtersPanelButtons.forEach((value) => value.classes.add('toggleOn'));
    _isFiltersPanelOpen = true;
  }

  void onCloseFiltersPanel(dynamic sender) {
    _filtersPanelButtons.forEach((value) => value.classes.remove('toggleOn'));
    _filtersPanelButtons.forEach((value) => value.classes.add('toggleOff'));
    _isFiltersPanelOpen = false;
  }

  void onEntryFeeRangeChange(dynamic sender, dynamic data) {
    _filterEntryFeeMin = data[ENTRY_FEE_MIN_RANGE];
    _filterEntryFeeMax = data[ENTRY_FEE_MAX_RANGE];
    filterByEntryFee();
  }

  /********* METHODS */
  // Muestra/Oculta el panel de filtros avanzados
  void toggleFilterMenu() {

    // Abrimos el menú si está cerrado
    if (_isFiltersPanelOpen) {
      JsUtils.runJavascript('#filtersPanel', 'collapse', "hide");
    }
    else {
      JsUtils.runJavascript('#filtersPanel', 'collapse', "show");
    }
  }

  // Inicia los valores por defecto de los filtros
  void initializeFilterValues() {
    // Filtro por nombre
    filterContestName = "";

    // Lista de tipos de concurso.
    contestTypeFilterList = [
       {'name':"FREE",        'checked':false, 'disabled':true, 'id':'filterTournamentTypeFree'}
      ,{'name':"HEAD_TO_HEAD",'checked':false, 'disabled':true, 'id':'filterTournamentTypeHeadToHead'}
      ,{'name':"LEAGUE",      'checked':false, 'disabled':true, 'id':'filterTournamentTypeLeague'}
      ,{'name':"FIFTY_FIFTY", 'checked':false, 'disabled':true, 'id':'filterTournamentTypeFiftyFifty'}
    ];

    // Lista de tipos de Limites de salarios.
    salaryCapFilterList = [
       {'name':"BEGGINER", 'checked':false, 'disabled':true}
      ,{'name':"STANDARD", 'checked':false, 'disabled':true}
      ,{'name':"SKILLEDS", 'checked':false, 'disabled':true}
    ];

    // Rango de Entry Fee
    entryFeeSliderRange = [0, 1];
  }

  //TODO: Crear los botones de filtrado con un ng-repeat
  void initializeSortValues(){
    sortingButtons = [
       {'name':"Nombre", 'state':'', 'id':'orderByName'}
      ,{'name':"Entrada", 'state':'', 'id':'orderByEntryFee'}
      ,{'name':"Comienzo", 'state':'', 'id':'orderByStartDate'}
    ];
  }

  // Establece los valores que tendrán los filtros
  void setFilterValues() {
      _contestList.forEach( (contest) {
        // Seteo de los "tipos de concursos"
        contestTypeFilterList.where( (map) => map['name'] == contest.tournamentType).first['disabled'] = false;

        // Seteo de los "salary caps"
        salaryCapFilterList.where( (map) => map['name'] == contest.tier).first["disabled"] = false;
      });

      // Seteo del rango de "entry fee"
      setEntryFeeFilterValues();
  }

  // Actualiza los valores del contro range-slider
  void setEntryFeeFilterValues() {
    entryFeeSliderRange = getFilterEntryFeeRange();
    JsUtils.runJavascript('#slider-range','noUiSlider', {'range': {'min': entryFeeSliderRange[ENTRY_FEE_MIN_RANGE], 'max': entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]}}, true);
    JsUtils.runJavascript('#slider-range','val', entryFeeSliderRange);
  }

  // Devuelve los valores posibles para el filtro de rango de entrada MIN: 0 y MAX: maximo valor de entrada de un concurso ( ó 1).
  List<int> getFilterEntryFeeRange() {
    int maxLimit = 1;
    if(_contestList != null) {
      _contestList.forEach( (contest) {
        maxLimit = max(contest.entryFee, maxLimit);
      });
    }
    return [0, maxLimit];
  }

  void filterByType() {
    addFilter(FILTER_TOURNAMENT, contestTypeFilterList.where((element) => element['checked'] == true).map((element) => element['name']).toList());
  }

  void filterByTier() {
    addFilter(FILTER_TIER, salaryCapFilterList.where((element) => element['checked'] == true ).map((element) => element['name']).toList());
  }

  void filterByEntryFee(){
    addFilter(FILTER_ENTRY_FEE, [_filterEntryFeeMin, _filterEntryFeeMax]);
  }

  void filterByName(){
    addFilter(FILTER_CONTEST_NAME, filterContestName);
  }

  void addFilter(String key, dynamic value) {
    Map<String, dynamic> newFilterList = {};

    newFilterList.addAll(filterList);
    filterList.clear();

    newFilterList[key] = value;

    filterList.addAll(newFilterList);

    onFilterChange({'filterList':filterList});
  }

  // Elimina los filtros e inicializa sus valores
  void resetAllFilters() {
    filterList = {"FILTER_TOURNAMENT":[], "FILTER_TIER":[], "FILTER_ENTRY_FEE":[], "FILTER_CONTEST_NAME":""};
    initializeFilterValues();
    setFilterValues();
    onFilterChange({'filterList':filterList});
  }

  /********* IMPLEMENTATIONS */
  void onShadowRoot(emulatedRoot) {

    // Capturamos los botones que abren/cierran el panel de filtros
    _filtersPanelButtons = querySelectorAll('.filters-button');

    // Como el panel inicial cerrado, le añadimos la clase que pone la flecha hacia abajo
    _filtersPanelButtons.forEach((value) => value.classes.add('toggleOff'));

    // Nos subscribimos a los eventos de apertura y cierre de los filtros
    JsUtils.runJavascript('#filtersPanel', 'on', {'hidden.bs.collapse': onCloseFiltersPanel});
    JsUtils.runJavascript('#filtersPanel', 'on', {'shown.bs.collapse': onOpenFiltersPanel});

    // Inicializamos el control que dibuja el slider para el filtro por entrada
    initSliderRange();
  }

  void initSliderRange()
  {
    //iniciamos slider-range
    JsUtils.runJavascript('#slider-range', 'noUiSlider', {
      'start'     : [0, 1],
      'step'      : 1,
      'behaviour' : 'drag',
      'connect'   : true,
      'range'     : {'min':entryFeeSliderRange[ENTRY_FEE_MIN_RANGE],'max':entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]}
    });

    // Nos subscribimos al evento change para recibir los valores que elija en cuatro
    JsUtils.runJavascript('#slider-range', 'on', {'set': onEntryFeeRangeChange});
  }

  /********* PRIVATE DECLARATIONS */
  bool _isFiltersPanelOpen = false;
  List<Element> _filtersPanelButtons;

  String _filterEntryFeeMin;
  String _filterEntryFeeMax;

  List<Contest> _contestList;

  /*********** HELPERS */
  void whatFilterIsClicked(mapa) {
    print("Se ha hecho click en el filtro ${mapa['name']}");
  }

}