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
  /******************************************/
  static const String FILTER_CONTEST_NAME                 = "FILTER_CONTEST_NAME";
  static const String FILTER_ENTRY_FEE_MIN                = "FILTER_ENTRY_FEE_MIN";
  static const String FILTER_ENTRY_FEE_MAX                = "FILTER_ENTRY_FEE_MAX";

  static const int    SALARY_LIMIT_FOR_BEGGINERS          = 80000;
  static const String FILTER_SALARY_LIMIT_BEGINNER        = "FILTER_SALARY_LIMIT_BEGINNER";
  static const int    SALARY_LIMIT_FOR_STANDARDS          = 70000;
  static const String FILTER_SALARY_LIMIT_STANDARD        = "FILTER_SALARY_LIMIT_STANDARD";
  static const int    SALARY_LIMIT_FOR_SKILLEDS           = 60000;
  static const String FILTER_SALARY_LIMIT_SKILLED         = "FILTER_SALARY_LIMIT_SKILLED";

  static const String TOURNAMENT_TYPE_FREE                = "FREE";
  static const String FILTER_TOURNAMENT_TYPE_FREE         = "FILTER_TOURNAMENT_TYPE_FREE";
  static const String TOURNAMENT_TYPE_LIGA                = "LIGA";
  static const String FILTER_TOURNAMENT_TYPE_LIGA         = "FILTER_TOURNAMENT_TYPE_LIGA";
  static const String TOURNAMENT_TYPE_FIFTY_FIFTY         = "FIFTY_FIFTY";
  static const String FILTER_TOURNAMENT_TYPE_FIFTY_FIFTY  = "FILTER_TOURNAMENT_TYPE_FIFTY_FIFTY";
  static const String TOURNAMENT_TYPE_HEAD_TO_HEAD        = "HEAD_TO_HEAD";
  static const String FILTER_TOURNAMENT_TYPE_HEAD_TO_HEAD = "FILTER_TOURNAMENT_TYPE_HEAD_TO_HEAD";

  //Filtros que están bindeados a la contestList
  Map<String, String> lobbyFilters = {};
  //Variable que guarda lo escrito en el input de buscar contest por nombre
  String filterContestName;

  //valor para el filtro por entryFee. mínimo
  String filterEntryFeeMin;
  //valor para el filtro por entryFee. máximo
  String filterEntryFeeMax;

  // Variables expuestas por ng-model en los checks del filtro de dificultad
  bool isBeginnerTierChecked;
  bool isStandardTierChecked;
  bool isSkilledTierChecked;

  // Variables expuestas por ng-model en los checks del filtro de Tipo de Torneo
  bool isFreeTournamentChecked;
  bool isLigaTournamentChecked;
  bool isFiftyFiftyTournamentChecked;
  bool isHeadToHeadTournamentChecked;


  /******************************************/
  ActiveContestsService activeContestsService;
  Contest selectedContest;
  ScreenDetectorService scrDet;
  //Tipo de ordenación de la lista de partidos
  String sortType = "";

  // Rango minímo del filtro del EntryFee
  String get filterEntryFeeRangeMin => getEntryFeeFilterRange()[0];
  // Rango máximo del filtro del EntryFee
  String get filterEntryFeeRangeMax => getEntryFeeFilterRange()[1];


  // propiedad que dice si existen concursos del tipo "PRINCIPIANTE" en la lista actual de concursos.
  bool get hasBegginerTier {
    bool result = false;
    if( activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap >= SALARY_LIMIT_FOR_BEGGINERS;
         if(comparison)
           result =  true;
      });
    }
    return result;
  }
  // propiedad que dice si existen concursos del tipo "STANDARS" en la lista actual de concursos.
  bool get hasStandardTier {
    bool result = false;
    if( activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap < SALARY_LIMIT_FOR_BEGGINERS &&
                           contest.templateContest.salaryCap > SALARY_LIMIT_FOR_SKILLEDS;
         if(comparison)
           result =  true;
      });
    }
    return result;
  }
  // propiedad que dice si existen concursos del tipo "EXPERTS" en la lista actual de concursos.
  bool get hasSkilledTier {
    bool result = false;
    if( activeContestsService.activeContests != null) {
      activeContestsService.activeContests.forEach( (Contest contest) {
         bool comparison = contest.templateContest.salaryCap <= SALARY_LIMIT_FOR_SKILLEDS;
         if(comparison)
           result =  true;
      });
    }
    return result;
  }

  //Propiedad que dice si hay partido del torneos FREE
  bool get hasFreeTournaments
  {
    bool result = false;
        if( activeContestsService.activeContests != null) {
          activeContestsService.activeContests.forEach( (Contest contest) {
             bool comparison = contest.templateContest.tournamentType == TOURNAMENT_TYPE_FREE;
             if(comparison)
               result =  true;
          });
        }
        return result;
  }
  //Propiedad que dice si hay partido del torneos LIGA
  bool get hasLigaTournaments
  {
    bool result = false;
        if( activeContestsService.activeContests != null) {
          activeContestsService.activeContests.forEach( (Contest contest) {
             bool comparison = contest.templateContest.tournamentType == TOURNAMENT_TYPE_LIGA;
             if(comparison)
               result =  true;
          });
        }
        return result;
  }

  //Propiedad que dice si hay partido del torneos FIFTY_FIFTY
  bool get hasFiftyFiftyTournaments
  {
    bool result = false;
        if( activeContestsService.activeContests != null) {
          activeContestsService.activeContests.forEach( (Contest contest) {
             bool comparison = contest.templateContest.tournamentType == TOURNAMENT_TYPE_FIFTY_FIFTY;
             if(comparison)
               result =  true;
          });
        }
        return result;
  }
  //Propiedad que dice si hay partido del torneos HEAD_TO_HEAD
  bool get hasHeadToHeadTournaments
  {
    bool result = false;
        if( activeContestsService.activeContests != null) {
          activeContestsService.activeContests.forEach( (Contest contest) {
             bool comparison = contest.templateContest.tournamentType == TOURNAMENT_TYPE_HEAD_TO_HEAD;
             if(comparison)
               result =  true;
          });
        }
        return result;
  }
/**************************************/


  LobbyComp(this._router, this.activeContestsService, this.scrDet) {
    activeContestsService.refreshActiveContests();
    const refreshSeconds = const Duration(seconds: 10);
    _timer = new Timer.periodic(refreshSeconds, (Timer t) =>  activeContestsService.refreshActiveContests());
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

    // Inicializamos el control que dibuja el slider para el filtro por entrada
    initSliderRange();
  }

  void onEntryFeeRangeChange(dynamic sender, dynamic data) {
    filterEntryFeeMin = data[0];
    filterEntryFeeMax = data[1];
    filterByEntryFee();

    print("Range change: $sender, $data");
  }

  void detach() {
    _timer.cancel();
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
    addFilter(FILTER_ENTRY_FEE_MIN, filterEntryFeeMin);
    addFilter(FILTER_ENTRY_FEE_MAX, filterEntryFeeMax);
  }

  void addFilter(String key, String valor){
    //comprobamos que si existe ya este filtro... Si existe lo eliminamos
    if (lobbyFilters.containsKey(key)) {
      lobbyFilters.remove(key);
    }
    refreshFilterList(key, valor);
  }

  void refreshFilterList(String key, String valor){

      //Como no se actualiza en el componente lista al modificar los valores... hay que crear siempre la lista 'lobbyFilters 'de cero:
      //1-Creamos un mapa nuevo
      Map<String, String> lobbyFilterClone = {};
      //2- El mapa nuevo lo iniciamos con los valores de lobbyFilters para que no sea una referencia
      lobbyFilterClone.addAll(lobbyFilters);
      //3-Creamos el nuevo filtro...
      if(!key.isEmpty) {
        Map<String, String> tmpMap = { key: valor };
        //... y lo añadimos a la lista temporal que tendrá los valores anteriores + este nuevo
        lobbyFilterClone.addAll(tmpMap);
      }
      //4-Por ultimo igualamos el lobbyFilter con el temporal que hemos construidos.
      lobbyFilters = lobbyFilterClone;
  }

  // Filtra la lista por concursos de dificultad Fácil
  void filterByBegginerTier() {
    if(isBeginnerTierChecked)
      addFilter(FILTER_SALARY_LIMIT_BEGINNER, SALARY_LIMIT_FOR_BEGGINERS.toString());
    else
      if (lobbyFilters.containsKey(FILTER_SALARY_LIMIT_BEGINNER))
        lobbyFilters.remove(FILTER_SALARY_LIMIT_BEGINNER);

    refreshFilterList("", "");
  }

  // Filtra la lista por concursos de dificultad media
  void filterByStandardTier() {
    if(isStandardTierChecked)
      addFilter(FILTER_SALARY_LIMIT_STANDARD, "");
    else
      if (lobbyFilters.containsKey(FILTER_SALARY_LIMIT_STANDARD))
        lobbyFilters.remove(FILTER_SALARY_LIMIT_STANDARD);

    refreshFilterList("", "");
  }

  // Filtra la lista por concursos de dificultad dificil
  void filterBySkilledTier() {
    if(isBeginnerTierChecked)
      addFilter(FILTER_SALARY_LIMIT_SKILLED, "");
    else
      if (lobbyFilters.containsKey(FILTER_SALARY_LIMIT_SKILLED))
        lobbyFilters.remove(FILTER_SALARY_LIMIT_SKILLED);

    refreshFilterList("", "");
  }

  // Filtra la lista por concursos de torneos GRATIS
  void filterByFreeTournamentType() {
    if(isFreeTournamentChecked)
      addFilter(FILTER_TOURNAMENT_TYPE_FREE, "");
    else
      if (lobbyFilters.containsKey(FILTER_TOURNAMENT_TYPE_FREE))
        lobbyFilters.remove(FILTER_TOURNAMENT_TYPE_FREE);

    refreshFilterList("", "");
  }
  // Filtra la lista por concursos de torneos LIGA
  void filterByLigaTournamentType() {
    if(isLigaTournamentChecked)
      addFilter(FILTER_TOURNAMENT_TYPE_LIGA, "");
    else
      if (lobbyFilters.containsKey(FILTER_TOURNAMENT_TYPE_LIGA))
        lobbyFilters.remove(FILTER_TOURNAMENT_TYPE_LIGA);

    refreshFilterList("", "");
  }
  // Filtra la lista por concursos de torneos 50/50
  void filterByFiftyFiftyTournamentType() {
    if(isFiftyFiftyTournamentChecked)
      addFilter(FILTER_TOURNAMENT_TYPE_FIFTY_FIFTY, "");
    else
      if (lobbyFilters.containsKey(FILTER_TOURNAMENT_TYPE_FIFTY_FIFTY))
        lobbyFilters.remove(FILTER_TOURNAMENT_TYPE_FIFTY_FIFTY);
    refreshFilterList("", "");
  }
  // Filtra la lista por concursos de torneos 1 vs 1
  void filterByHeadToHeadTournamentType() {
    if(isHeadToHeadTournamentChecked)
      addFilter(FILTER_TOURNAMENT_TYPE_HEAD_TO_HEAD, "");
    else
      if (lobbyFilters.containsKey(FILTER_TOURNAMENT_TYPE_HEAD_TO_HEAD))
        lobbyFilters.remove(FILTER_TOURNAMENT_TYPE_HEAD_TO_HEAD);

    refreshFilterList("", "");
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
