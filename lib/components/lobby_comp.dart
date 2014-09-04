library active_contest_list_comp;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;
import 'package:angular/angular.dart';
import 'package:webclient/services/active_contests_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/models/template_contest.dart';

@Component(
  selector: 'lobby',
  templateUrl: 'packages/webclient/components/lobby_comp.html',
  publishAs: 'comp',
  useShadowDom: false
)

class LobbyComp implements ShadowRootAware, DetachAware {
  static const String FILTER_CONTEST_NAME = "FILTER_CONTEST_NAME";
  static const String FILTER_ENTRY_FEE    = "FILTER_ENTRY_FEE";
  static const String FILTER_TOURNAMENT   = "FILTER_TOURNAMENT";
  static const String FILTER_TIER         = "FILTER_TIER";

  static const int XS_LOBBY_ACTION_GOTO_ALL_TOURNAMENTS       = 0;
  static const int XS_LOBBY_ACTION_GOTO_MY_TOURNAMENTS        = 1;
  static const int XS_LOBBY_ACTION_GOTO_NOT_FREE_TOURNAMENTS  = 2;
  static const int XS_LOBBY_ACTION_GOTO_FREE_TOURNAMENTS      = 3;

  // Mapa para traducir los filtros a lenguaje Human readable
  Map filtersFriendlyName = {
    "FILTER_TOURNAMENT":{
      "FREE"          :"Torneos Gratuitos",
      "HEAD_TO_HEAD"  :"Torneos 1 Contra 1",
      "LEAGUE"        :"Torneos de Liga",
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


  // Variables expuestas por ng-model en los checks del filtro de dificultad
  bool isBeginnerTierChecked          = false;
  bool isStandardTierChecked          = false;
  bool isSkilledTierChecked           = false;

  // Filtros que están bindeados a la contestList
  Map<String, dynamic> lobbyFilters = {};

  // Tipo de ordenación de la lista de partidos
  String sortType = "";

  // Valor para el filtro por nombre
  String filterContestName;

  //filtro aplicados en el lobby XS
  List<String> xsFilterList = [];

  // estado actual del lobby en XS
  int currentXsLobbyState = 0;

  // numero de torneos listados actualmente
  int contestsCount = 0;

  ActiveContestsService activeContestsService;
  Contest selectedContest;
  ScreenDetectorService scrDet;

  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => getEntryFeeFilterRange()[0];

  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => getEntryFeeFilterRange()[1];

  // propiedad que dice si existen concursos del tipo "PRINCIPIANTE" en la lista actual de concursos.
  bool get hasBegginerTier => activeContestsService.activeContests.where((contest) => contest.templateContest.tier == TemplateContest.TIER_BEGGINER).toList().length > 0;

  // propiedad que dice si existen concursos del tipo "STANDARS" en la lista actual de concursos.
  bool get hasStandardTier => activeContestsService.activeContests.where((contest) => contest.templateContest.tier == TemplateContest.TIER_STANDARD).toList().length > 0;

  // propiedad que dice si existen concursos del tipo "EXPERTS" en la lista actual de concursos.
  bool get hasSkilledTier  => activeContestsService.activeContests.where((contest) => contest.templateContest.tier == TemplateContest.TIER_SKILLED).toList().length > 0;


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
    return false;
  }

  // Variables expuestas por ng-model en los checks del filtro de Tipo de Torneo
  void set isFreeTournamentChecked(value) {
    _isFreeTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isFreeTournamentChecked => _isFreeTournamentChecked;
  // Devuelve true si existen torneos del tipo GRATIS
  bool get hasTournamentsFree => activeContestsService.activeContests.where((contest)       => contest.templateContest.tournamentType == TemplateContest.TOURNAMENT_FREE).toList().length > 0;

  void set isLigaTournamentChecked(value) {
    _isLigaTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isLigaTournamentChecked => _isLigaTournamentChecked;
  // Devuelve true si existen torneos del tipo LIGA
  bool get hasTournamentsLeague => activeContestsService.activeContests.where((contest)     => contest.templateContest.tournamentType == TemplateContest.TOURNAMENT_LEAGUE).toList().length > 0;

  void set isFiftyFiftyTournamentChecked(value) {
    _isFiftyFiftyTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isFiftyFiftyTournamentChecked => _isFiftyFiftyTournamentChecked;
  // Devuelve true si existen torneos del tipo 50 / 50
  bool get hasTournamentsFiftyFifty => activeContestsService.activeContests.where((contest) => contest.templateContest.tournamentType == TemplateContest.TOURNAMENT_FIFTY_FIFTY).toList().length > 0;

  void set isHeadToHeadTournamentChecked(value) {
    _isHeadToHeadTournamentChecked = value;
    refreshTorunamentFilter();
  }
  bool get isHeadToHeadTournamentChecked => _isHeadToHeadTournamentChecked;
  // Devuelve true si existen torneos del tipo LIGA
  bool get hasTournamentsHeadToHead => activeContestsService.activeContests.where((contest) => contest.templateContest.tournamentType == TemplateContest.TOURNAMENT_HEAD_TO_HEAD).toList().length > 0;


  // Esto devuelve un bloque HTML con el resumen de los filtros aplicados
  String get xsFilterResume => xsFilterList.join("<br>") + "<div>Torneos disponibles <span class='contest-count'>" + contestsCount.toString() + "</span></div>";

  int get freeTournamentsCount    => _freeContestCount;
  int get prizedTournamentsCount  => activeContestsService.activeContests.length - _freeContestCount;

  //CONTRUCTOR
  LobbyComp(this._router, this.activeContestsService, this.scrDet) {
    refreshActiveContest();
    const refreshSeconds = const Duration(seconds: 10);
    _timer = new Timer.periodic(refreshSeconds, (Timer t) =>  refreshActiveContest());
    _streamListener = scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    activeContestsService.refreshActiveContests();
    _freeContestCount   = activeContestsService.activeContests.where((contest) => contest.templateContest.tournamentType == TemplateContest.TOURNAMENT_FREE).toList().length;
  }

  void onShadowRoot(root) {
    // Metemos en la lista de botones de ordenación los elementos que ordenan la lista
    _sortingButtons = document.querySelectorAll('.sorting-button');
    // Nos guardamos la lista de clases por defecto que traen los botones de filtros.
    _sortingButtonClassesByDefault = _sortingButtons.first.classes.toList();
    //capturamos el botón que abre el panel de filtros
    _filtersButtons = document.querySelectorAll('.filters-button');
    _filtersButtonClassesByDefault = _filtersButtons.first.classes.toList();
    //Al iniciar, tiene está cerrado por lo tanto le añadimos la clase que pone la flecha hacia abajo
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
    var range = runJavascript("#slider-range", 'val', null);
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
      runJavascript('#infoContestModal', 'modal', "hide");
    }
    if (msg == "xs") {
      ResetXsLobby();
      if (_isFiltersPanelOpen) {
        runJavascript('#filtersPanel', 'collapse', "hide");
        _isFiltersPanelOpen = false;
      }
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
      runJavascript('#infoContestModal', 'modal', null);
    }
    else {
      onActionClick(contest);
    }
  }

  void onListChange(int itemsCount) {
     contestsCount = itemsCount;
   }

  // Cambia el orden de la lista de concursos
  void sortListByField(String id, String sortName) {
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

    updateSorButtonsStyle(id);
  }

  // Aplica los estilos necesarios para mostrar las flechitas de orden en los botones
  void updateSorButtonsStyle(String buttonId) {
    _sortingButtons.forEach( (Element btn) {
      btn..classes.clear()
        ..classes.addAll(_sortingButtonClassesByDefault);
      if (btn.id == buttonId) {
        btn..classes.add(_butonState[_currentButtonState]);
      }
    });
  }

  // Muestra/Oculta el panel de filtros avanzados
  void toggleFilterMenu() {
    //Controlamos el estado de la flecha de los dos botones que abren los filtros (en XS y Desktop son diferentes)
    _filtersButtons.forEach((value) => value.classes.clear());
    _filtersButtons.forEach((value) => value.classes.addAll(_filtersButtonClassesByDefault));

    if (_isFilterButtonOpen) {
      _filtersButtons.forEach((value) => value.classes.add('toggleOff'));
      _isFilterButtonOpen = false;
    } else {
      _filtersButtons.forEach((value) => value.classes.add('toggleOn'));
      _isFilterButtonOpen = true;
    }

    // Abrimos el menú si está cerrado
    if (_isFiltersPanelOpen) {
      runJavascript('#filtersPanel', 'collapse', "hide");
      _isFiltersPanelOpen = false;
    }
    else {
      runJavascript('#filtersPanel', 'collapse', "show");
      _isFiltersPanelOpen = true;
    }
  }

  void initSliderRange()
  {
    //iniciamos slider-range
    runJavascript('#slider-range', 'noUiSlider', { 'start':      [0, 100],
                                                  'step' :      1,
                                                  'behaviour':  'drag',
                                                  'connect':    true,
                                                  'range':      {'min':0,'max':100}});
    // Nos subscribimos al evento change
    runJavascript('#slider-range', 'on', {'set': onEntryFeeRangeChange});
  }

  /*
  * Funciones para los filtros
  */
  void filterByContestName() {
    addFilter(FILTER_CONTEST_NAME, filterContestName);
  }

  void filterByEntryFee(){
    addFilter(FILTER_ENTRY_FEE, [_filterEntryFeeMin, _filterEntryFeeMax]);
    print('-LOBBY_COMP-: Filtrando por tipo precio entrada. Valores entre [${_filterEntryFeeMin} - ${_filterEntryFeeMax}]');
  }

  void refreshTierFilter() {
    List<String> tierValues = [];
    _tierFilterList = [];

    if (isBeginnerTierChecked) {
      tierValues.add(TemplateContest.TIER_BEGGINER);
    }

    if (isStandardTierChecked) {
      tierValues.add(TemplateContest.TIER_STANDARD);
    }

    if (isSkilledTierChecked) {
      tierValues.add(TemplateContest.TIER_SKILLED);
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

  void refreshTorunamentFilter() {
    List<String> tournamentValues = [];
    _tournamentFilterList = [];

    if (isFreeTournamentChecked) {
      tournamentValues.add(TemplateContest.TOURNAMENT_FREE);
    }

    if (isLigaTournamentChecked) {
      tournamentValues.add(TemplateContest.TOURNAMENT_LEAGUE);
    }

    if (isFiftyFiftyTournamentChecked) {
      tournamentValues.add(TemplateContest.TOURNAMENT_FIFTY_FIFTY);
    }

    if (isHeadToHeadTournamentChecked) {
      tournamentValues.add(TemplateContest.TOURNAMENT_HEAD_TO_HEAD);
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

  void addFilter(String key, dynamic val) {
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
      Map<String, dynamic> tmpMap = {key: val};
      // ... y lo añadimos a la lista temporal que tendrá los valores anteriores + este nuevo
      lobbyFilterClone.addAll(tmpMap);
    }
    //4-Por ultimo igualamos el lobbyFilter con el temporal que hemos construidos.
    lobbyFilters = lobbyFilterClone;
    updateXsFiltersResumeList();
  }

  void resetAllFilters(){
    // reseteo del filtro por precio de entrada
    _filterEntryFeeMin = "0";
    _filterEntryFeeMax = "100";
    runJavascript('#slider-range','val', [_filterEntryFeeMin, _filterEntryFeeMax]);

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
    InputElement txtSearch = document.querySelector('.searcher');
    txtSearch.value = "";

    //provocamos la actialización
    lobbyFilters = {};
    addFilter("", []);
    print('-LOBBY_COMP-: Filtros reseteados');
  }

  void filterXsLobbyClick(int action)
  {
    switch(action) {
      case XS_LOBBY_ACTION_GOTO_ALL_TOURNAMENTS:
        // Informamos que estamos en el estado elige tipo de juegos [con / sin premios]
        currentXsLobbyState = 1;
      break;
      case XS_LOBBY_ACTION_GOTO_MY_TOURNAMENTS:
        _router.go("my_contests", {});
      break;
      case XS_LOBBY_ACTION_GOTO_FREE_TOURNAMENTS:
        addFilter(FILTER_TOURNAMENT, [TemplateContest.TOURNAMENT_FREE]);
        _isFreeTournamentChecked = true;
        // Pasamos al estado en el muestra la lista de torneos disponibles.
        currentXsLobbyState = 2;
      break;
      case XS_LOBBY_ACTION_GOTO_NOT_FREE_TOURNAMENTS:
        addFilter(FILTER_TOURNAMENT, [TemplateContest.TOURNAMENT_LEAGUE, TemplateContest.TOURNAMENT_FIFTY_FIFTY, TemplateContest.TOURNAMENT_HEAD_TO_HEAD]);
        _isLigaTournamentChecked = true;
        _isFiftyFiftyTournamentChecked = true;
        _isHeadToHeadTournamentChecked = true;
        // Pasamos al estado en el muestra la lista de torneos disponibles.
        currentXsLobbyState = 2;
      break;
    }
    refreshActiveContest();
  }

  void ResetXsLobby() {
    currentXsLobbyState = 0;
    refreshActiveContest();
    resetAllFilters();
    xsFilterList = [];
  }

  bool sortsAndFiltersVisibles() {
    if (!scrDet.isXsScreen) {
      return true;
    }
    else {
      if (currentXsLobbyState == 2)
        return true;
    }
    return false;
  }

  // Actualizamos el resumen de siltros aplicados. Sólo se vé en XS y son  Human Friendly
  void updateXsFiltersResumeList() {
    xsFilterList = [];
    lobbyFilters.forEach((key, value) {
      switch (key) {
        case FILTER_TOURNAMENT:
        case FILTER_TIER:
          for (int i = 0; i< value.length; i++) {
            xsFilterList.add(filtersFriendlyName[key][value[i]]); // añadimos cada uno de los filros del tipo torneo que haya
          }
        break;
        case FILTER_ENTRY_FEE:
          String EntryRange = "";
          for (int i = 0; i< value.length; i++) {
            //formamos el rango con el currency
            EntryRange += (i == 0)? value[i].split(".")[0] + "€" : " - " + value[i].split(".")[0] + "€";
          }
          xsFilterList.add(filtersFriendlyName[key] + EntryRange);
          break;
          case FILTER_CONTEST_NAME:
            xsFilterList.add(filtersFriendlyName[key]);
          break;
      }
    });
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

  //Conteos de los torneos gratuitos
  int _freeContestCount = 0;
  bool _isFiltersPanelOpen = false;

  var _streamListener;


  /****************************************************
   *      Pasar esta Funcion a una de utiles          *
   ***************************************************/

  // Funcion para ejecutar los JavaScripts que necesitamos en esta página
  dynamic runJavascript(String selector, String method, dynamic params) {
    if (params == null) { //javascript / jquery sin parametros
      return js.context.callMethod(r'$', [selector]).callMethod(method);
    }
    else { //javascript / jquery con parametro de valor iterable
      if (params.toString().contains('[') || params.toString().contains('{')  ) // Si tienen un objeto iterable
        return js.context.callMethod(r'$', [selector]).callMethod(method, [new js.JsObject.jsify(params)]);
    } //javascript / jquery con parametro de valor simple
    return js.context.callMethod(r'$', [selector]).callMethod(method, [params]);
  }

}
