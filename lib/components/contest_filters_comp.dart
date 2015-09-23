library contest_filters_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:math';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/js_utils.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'contest-filters-comp',
    templateUrl: 'packages/webclient/components/contest_filters_comp.html',
    useShadowDom: false
)
class ContestFiltersComp implements ShadowRootAware {

  /********* CONSTANTS */
  static const String FILTER_COMPETITION  = "FILTER_COMPETITION";
  static const String FILTER_CONTEST_NAME = "FILTER_CONTEST_NAME";
  static const String FILTER_ENTRY_FEE    = "FILTER_ENTRY_FEE";
  static const String FILTER_TIER         = "FILTER_TIER";
  static const String FILTER_TOURNAMENT   = "FILTER_TOURNAMENT";

  static const int ENTRY_FEE_MIN_RANGE = 0;
  static const int ENTRY_FEE_MAX_RANGE = 1;

  /********* DECLARATIONS */
  // Mapa para traducir los filtros a lenguaje Human readable
  Map filtersFriendlyName = {
    "FILTER_TOURNAMENT":{
      "FREE"          :"Free Contests",
      "HEAD_TO_HEAD"  :"Head to Head Contests",
      "LEAGUE"        :"League Contests",
      "FIFTY_FIFTY"   :"50 / 50 Contests"
    },
    "FILTER_TIER":{
      "BEGINNER" :"Beginner level",
      "STANDARD" :"Standard level",
      "SKILLEDS" :"Expert level"
    },
    "FILTER_ENTRY_FEE":"Entry fee ",
    "FILTER_CONTEST_NAME":"Name "
  };

  // Filtro por nombre
  String filterContestName = "";
  //Lista de tipos de competición
  List<Map> competitionFilterList = [];

  // Lista de tipos de concurso.
  List<Map> contestTypeFilterList = [];

  // Lista de tipos de Limites de salarios.
  List<Map> salaryCapFilterList = [];

  // Valores para el rango de Entry Fee
  List<int> entryFeeSliderRange = [0,1];

  // Valores para los botones de orden
  List<Map> sortingButtons = [];

  //Lista de filtros
  Map<String, dynamic> filterList = {};
  Map sorting = {};

  ScreenDetectorService scrDet;


  /********* BINDINGS */
  @NgOneWay("contest-count")
  void set contestsCount(int value) {
    _contestCount = value;
  }

  @NgOneWay("contests-list")
   void set contestsList(List<Contest> value) {
    if (value == null) {
      return;
    }
    _contestList = value;
    setFilterValues();
    //La primera vez, el orden por defecto es por fecha de mas asc
    if (isFirstTime) {
      _sortField = 'contest-start-time';
      sortListByField('contest-start-time');
      isFirstTime = false;
    }
  }

  @NgCallback("on-sort-order-change")
  Function onSortOrderChange;

  @NgCallback('on-filter-change')
  Function onFilterChange;


  /********* PROPERTIES */
  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => getEntryFeeFilterRange()[ENTRY_FEE_MIN_RANGE].toString();

  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => getEntryFeeFilterRange()[ENTRY_FEE_MAX_RANGE].toString();

  // Bloque HTML con el resumen de los filtros aplicados
  String get filterResume =>/* xsFilterList.join("<br>") + */"<div>Available contests <span class='contest-count'>" + _contestCount.toString() + "</span></div>";

  String GetLocalizedText(key) {
    return StringUtils.Translate(key, "contestfilters");
  }

  String FormatCurrency(String amount) {
    return StringUtils.FormatCurrency(amount);
  }

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
    competitionFilterList = [
       {'name': "LEAGUE_ES",  'flag':"ESP", 'text': GetLocalizedText('competitionlaliga'),    'checked':false, 'disabled':true, 'id':'filterLeagueEsp'}
      ,{'name': "LEAGUE_UK",  'flag':"UK",  'text': GetLocalizedText('competitionpremier'),   'checked':false, 'disabled':true, 'id':'filterLeagueUK'}
      ,{'name': "CHAMPIONS",  'flag':"EU",  'text': GetLocalizedText('competitionchampions'), 'checked':false, 'disabled':true, 'id':'filterUCL'}
    ];

    // Lista de tipos de concurso.
    contestTypeFilterList = [
       {'name':"FREE",        'text':GetLocalizedText('contestfree'),       'checked':false, 'disabled':true, 'id':'filterTournamentTypeFree'}
      ,{'name':"HEAD_TO_HEAD",'text':GetLocalizedText('contestheadtohead'), 'checked':false, 'disabled':true, 'id':'filterTournamentTypeHeadToHead'}
      ,{'name':"LEAGUE",      'text':GetLocalizedText('contestleague'),     'checked':false, 'disabled':true, 'id':'filterTournamentTypeLeague'}
      ,{'name':"FIFTY_FIFTY", 'text':GetLocalizedText('contestfifty'),      'checked':false, 'disabled':true, 'id':'filterTournamentTypeFiftyFifty'}
    ];

    // Lista de tipos de Limites de salarios.
    salaryCapFilterList = [
       {'name':"BEGINNER", 'text':GetLocalizedText('salarycapbegginer'), 'checked':false, 'disabled':true, 'id':'filterTournamentTierBeginner'}
      ,{'name':"STANDARD", 'text':GetLocalizedText('salarycapstandard'), 'checked':false, 'disabled':true, 'id':'filterTournamentTierStandard'}
      ,{'name':"SKILLEDS", 'text':GetLocalizedText('salarycapskilled'),  'checked':false, 'disabled':true, 'id':'filterTournamentTierSkilled'}
    ];

    // Rango de Entry Fee
    entryFeeSliderRange = [0, 1];
  }

  void initializeSortValues(){
    sortingButtons = [
       {'name':GetLocalizedText('sortbyname'),      'state':'', 'id':'orderByName',      'field-name':'contest-name'}
      ,{'name':GetLocalizedText('sortbyentryfee'),  'state':'', 'id':'orderByEntryFee',  'field-name':'contest-entry-fee'}
      ,{'name':GetLocalizedText('sortbystartdate'), 'state':'', 'id':'orderByStartDate', 'field-name':'contest-start-time'}
    ];
  }

  // Establece los valores que tendrán los filtros
  void setFilterValues() {
      _contestList.forEach( (contest) {
        // Seteo de los "tipos de concursos"
       Map competition = competitionFilterList.firstWhere( (map) => map['name'] == contest.competitionType , orElse: () => null);
       if (competition != null) {
         competition['disabled'] = false;
       }
        // Seteo de los "tipos de concursos"
        Map contestType = contestTypeFilterList.firstWhere( (map) => map['name'] == contest.tournamentType, orElse: () => null);
        if (contestType != null) {
          contestType['disabled'] = false;
        }
        // Seteo de los "salary caps"
        Map salaryCap = salaryCapFilterList.firstWhere( (map) => map['name'] == contest.tier, orElse: () => null);
        if (salaryCap != null) {
          salaryCap["disabled"] = false;
        }
      });

      // Seteo del rango de "entry fee"
      setEntryFeeFilterValues();
  }

  // Actualiza los valores del contro range-slider
  void setEntryFeeFilterValues() {
    _lastRangeMaxLimit = entryFeeSliderRange[ENTRY_FEE_MAX_RANGE];
    _lastMaxRangeValue = double.parse(filterEntryFeeRangeMax).ceil();
    int currentMinValue =  double.parse(filterEntryFeeRangeMin).floor();

    entryFeeSliderRange = getFilterEntryFeeRange();
    if (_lastRangeMaxLimit != entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]) {
      JsUtils.runJavascript('#slider-range','noUiSlider', [{'range': {'min': entryFeeSliderRange[ENTRY_FEE_MIN_RANGE], 'max': entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]}}, true]);
    }

    if ( _lastMaxRangeValue == _lastRangeMaxLimit && _lastMaxRangeValue < entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]) {
      JsUtils.runJavascript('#slider-range','val', [[currentMinValue, entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]]]);
    }
  }

  // Devuelve los valores posibles para el filtro de rango de entrada MIN: 0 y MAX: maximo valor de entrada de un concurso ( ó 1).
  List<int> getFilterEntryFeeRange() {
    int maxLimit = 1;
    if(_contestList != null) {
      _contestList.forEach( (contest) {
        maxLimit = max(contest.entryFee.toInt(), maxLimit);
      });
    }
    return [0, maxLimit];
  }

  dynamic getEntryFeeFilterRange(){
    var range = JsUtils.runJavascript("#slider-range", 'val', null);
    return ( range == null || range == "" ) ? ["0","1"] : range;
  }

  void filterByCompetitionType(Map m) {
    competitionFilterList.forEach((elem) {
      if (elem['name'] == m['name']) {
        elem['checked'] = !elem['checked'];
      }
    });

    addFilter(FILTER_COMPETITION, competitionFilterList.where((element) => element['checked'] == true).map((element) => element['name']).toList());
  }

  void filterByTournamentType(Map m) {
    contestTypeFilterList.forEach((elem) {
      if (elem['name'] == m['name']) {
        elem['checked'] = !elem['checked'];
      }
    });

    addFilter(FILTER_TOURNAMENT, contestTypeFilterList.where((element) => element['checked'] == true).map((element) => element['name']).toList());
  }

  void filterByTier(Map m) {
    salaryCapFilterList.forEach((elem) {
      if (elem['name'] == m['name']) {
        elem['checked'] = !elem['checked'];
      }
    });
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
    filterList = {"FILTER_COMPETITION":[], "FILTER_TOURNAMENT":[], "FILTER_TIER":[], "FILTER_ENTRY_FEE":[], "FILTER_CONTEST_NAME":""};
    initializeFilterValues();
    setFilterValues();
    //Fuerzo el reset del slider
    JsUtils.runJavascript('#slider-range','val', [[0, entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]]]);
    onFilterChange({'filterList':filterList});
  }

  void sortListByField(String fieldName) {
    if (_sortField != fieldName) {
      _order = 1;
      _sortField = fieldName;
    }
    else {
      _order = -1 * _order;
    }
    sortingButtons.forEach((element) {
      element["state"] = _sortField != element['field-name'] ? "" : _order == -1 ? "desc" : "asc";
    });


    onSortOrderChange({'sortParams':{"fieldName": _sortField, "order" : _order}});
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
    // Temporalmente le meto un retraso para pasar los test has que que se resuelva lo del defer y el jQuery ready.
    //new Timer(const Duration(seconds:0), () => initSliderRange());
    initSliderRange();
  }

  void initSliderRange()
  {
    //iniciamos slider-range
    JsUtils.runJavascript('#slider-range', 'noUiSlider', {
      'start'     : [entryFeeSliderRange[ENTRY_FEE_MIN_RANGE], entryFeeSliderRange[ENTRY_FEE_MAX_RANGE]],
      'step'      : 1,
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
  int _lastRangeMaxLimit = 0;
  int _lastMaxRangeValue = 0;

  List<Contest> _contestList;
  int _contestCount = 0;

  String _sortField;
  int _order = -1;

  bool isFirstTime = true;
}