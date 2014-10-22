library contest_filters_comp;

import 'package:angular/angular.dart';
import 'dart:html';
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

  ScreenDetectorService scrDet;

  // Filtro por nombre
  String filterContestName = "";

  // Lista de tipos de concurso.
  List<Map> contestTypeList = [
     {'name':"FREE",        'checked':false, 'disabled':true}
    ,{'name':"HEAD_TO_HEAD",'checked':false, 'disabled':true}
    ,{'name':"LEAGUE",      'checked':false, 'disabled':true}
    ,{'name':"FIFTY_FIFTY", 'checked':false, 'disabled':true}
  ];

  // Lista de tipos de Limites de salarios.
  List<Map> salaryCap = [
     {'name':"BEGGINER", 'checked':false, 'disabled':true}
    ,{'name':"STANDARD", 'checked':false, 'disabled':true}
    ,{'name':"SKILLEDS", 'checked':false, 'disabled':true}
  ];

  // TODO: actualizar los filtros que se usan en una lista filtersList; y "updateFilterByName()"

  /********* BINDINGS */
  @NgOneWay("contests-list")
   void set contestsList(List<Contest> value) {
    if (value == null) {
      return;
    }
    _contestsListOriginal = value;
    refreshFilters();
  }

  @NgTwoWay("filters")
  Map<String, dynamic> filtersList;

  @NgTwoWay("sorting")
  String sort;

  /********* PROPERTIES */
  // Resumen de filtros seleccionados
  String get filterResume => "";

  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => "0";

  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => "1";


  ContestFiltersComp(this.scrDet);

  /********* HANDLERS */
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

  void onOpenFiltersPanel(dynamic sender) {
    _filtersButtons.forEach((value) => value.classes.remove('toggleOff'));
    _filtersButtons.forEach((value) => value.classes.add('toggleOn'));
    _isFiltersPanelOpen = true;
  }

  void onCloseFiltersPanel(dynamic sender) {
    _filtersButtons.forEach((value) => value.classes.remove('toggleOn'));
    _filtersButtons.forEach((value) => value.classes.add('toggleOff'));
    _isFiltersPanelOpen = false;
  }

  /********* METHODS */
  void refreshFilters() {
      print("-CONTEST_FILTERS_COMP-: Lista de concusos actualizada");
  }

  /********* IMPLEMENTATIONS */
  void onShadowRoot(emulatedRoot) {

    // Capturamos el botón que abre el panel de filtros
    _filtersButtons = querySelectorAll('.filters-button');

    // Al iniciar, tiene está cerrado por lo tanto le añadimos la clase que pone la flecha hacia abajo
    _filtersButtons.forEach((value) => value.classes.add('toggleOff'));

    // Inicializamos el control que dibuja el slider para el filtro por entrada
   // initSliderRange();

    // Nos subscribimos a los eventos de apertura y cierre de los filtros
    JsUtils.runJavascript('#filtersPanel', 'on', {'hidden.bs.collapse': onCloseFiltersPanel});
    JsUtils.runJavascript('#filtersPanel', 'on', {'shown.bs.collapse': onOpenFiltersPanel});
  }

  /********* PRIVATE VARIABLES */
  bool _isFiltersPanelOpen = false;
  List<Element> _filtersButtons;
  List<Contest> _contestsListOriginal;

}