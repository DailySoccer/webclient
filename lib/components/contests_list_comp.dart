library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'contests-list',
    templateUrl: 'packages/webclient/components/contests_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class ContestsListComp implements DetachAware, ShadowRootAware {

  static const int    SALARY_LIMIT_FOR_BEGGINERS    = 90000;
  static const int    SALARY_LIMIT_FOR_STANDARDS    = 80000;
  static const int    SALARY_LIMIT_FOR_SKILLEDS     = 70000;

  static const String TOURNAMENT_TYPE_FREE          = "FREE";
  static const String TOURNAMENT_TYPE_LIGA          = "LIGA";
  static const String TOURNAMENT_TYPE_FIFTY_FIFTY   = "FIFTY_FIFTY";
  static const String TOURNAMENT_TYPE_HEAD_TO_HEAD  = "HEAD_TO_HEAD";

  // Lista copia de la original que guardará los contest tras aplicar los filtros
  List<Contest> contestsListFiltered;

  // Lista de filtros a aplicar
  Map<String,dynamic> filterList;

  bool isToday(DateTime date) => (date.year == _dateTimeService.now.year && date.month == _dateTimeService.now.month && date.day == _dateTimeService.now.day);

  String listName="";

  List<Contest> currentPageList = [];

  @NgOneWay("list-name")
  void set name(value){
    listName = value;
  }

  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    _contestsListOriginal = value;
    contestsListFiltered = _contestsListOriginal;
    refreshList();
  }

  //Setter de los filtros, Recibe la lista de los filtros aplicados.
  @NgOneWay("filter-by")
  void set filterBy(Map<String,dynamic> value) {
    if (value == null)
      return;
    filterList = value;
    _currentPage = 0;
    refreshList();
  }

  @NgOneWay("sorted-by")
  void set sortedBy(String value) {
    if(value == null || value.isEmpty)
      return;
    _sortType = value;
    refreshList();
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "Ver";

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  String dateInfo(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (isToday(date)) {
      Duration duration = date.difference(_dateTimeService.now);
      // Avisamos unos minutos antes (30 min)
      if (duration.inMinutes >= 0 && duration.inMinutes < 30) {
        int secondsTotal = duration.inSeconds;
        int minutes = secondsTotal ~/ 60;
        int seconds = secondsTotal - (minutes * 60);
        if (minutes >= 0 && seconds >= 0) {
          return (seconds >= 10) ? "$minutes:$seconds" : "$minutes:0$seconds";
        }
      }
      return "Hoy";
    }
    return new DateFormat("dd/MM").format(date);
  }

  String timeInfo(DateTime date) {
    // Avisamos 2 horas antes...
    if (isToday(date) && date.isAfter(_dateTimeService.now)) {
      Duration duration = date.difference(_dateTimeService.now);
      int minutesLeft = duration.inMinutes;
      if (minutesLeft >= 0 && minutesLeft < 120) {
        return (minutesLeft >= 30) ? "${minutesLeft} min." : "Faltan";
      }
    }
    return new DateFormat("HH:mm").format(date) + "h.";
  }


  int getMyPosition(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.position + 1;
  }

  int getMyFantasyPoints(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.fantasyPoints;
  }

  int getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
  }

  ContestsListComp(this._profileService, this._dateTimeService, this._scrDet){
    _originalPageLinksCount = _options["numPageLinksToDisplay"];
    _streamListener = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void detach() {
    _streamListener.cancel();
  }

  // Esto es necesario porque cuando quiero buscar al padre, lo tengo que buscar dentro del ShadowRoot.
  // No se puede generar un ID en el div padre de forma dinámica con angular (id="prefijo_{{comp.nombrepropio}}") porque deja el id en el root vacío.
  // parece ser que solo rellena ese id cuando realmente lo inserta en el DOM.
  // Para poder tener el ID de forma dinámica, lo que hago es dejar el prefijo de forma fija en el HTML y una vez que lo encuentro, lo modifico.
  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;
    // Capturamos el elementos qe será el padre del paginador del sharowRoot.
    String parentName= _options["navPanelIdPrefix"] + listName;
    _paginatorContainer = rootElement.querySelector("#paginatorBox_")
        ..id = parentName;

    createPaginator();
  }


  void onScreenWidthChange(msg) {
    if(msg == "xs")
      _options["numPageLinksToDisplay"] = 2;
    else
      _options["numPageLinksToDisplay"] = _originalPageLinksCount;

    createPaginator();
  }

  void onRow(Contest contest) {
    if (onRowClick != null)
      onRowClick({"contest":contest});
  }

  void onAction(Contest contest) {
    if (onActionClick != null)
      onActionClick({"contest":contest});
  }

  void refreshList()
  {
    refreshFilters();
    refreshSort();
    createPaginator();
  }

  void refreshSort()
  {
    if(_sortType == null)
      return;

    List<String> sortParams = _sortType.split('_');

    if (sortParams.length != 2) {
      print("-CONTEST_LIST-: El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
    }

    switch(sortParams[0])
    {
      case "contest-name":
        contestsListFiltered.sort(( contest1, contest2) => ( sortParams[1] == "asc" ? contest1.compareNameTo(contest2) : contest2.compareNameTo(contest1)) );
      break;

      case "contest-entry-fee":
        contestsListFiltered.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.compareEntryFeeTo(contest2) : contest2.compareEntryFeeTo(contest1)) );
      break;

      case "contest-start-time":
        contestsListFiltered.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.compareStartDateTo(contest2) : contest2.compareStartDateTo(contest1)) );
      break;

      default:
        print('-CONTEST_LIST-: No se ha encontrado el campo para ordenar');
      break;
    }
  }

  void refreshFilters() {
    if( filterList == null)
      return;

    contestsListFiltered = _contestsListOriginal;
    //Recorremos la lista de filtros
    filterList.forEach( (String key, dynamic value )  {
      switch(key)
      {
        case "FILTER_CONTEST_NAME":
          contestsListFiltered = contestsListFiltered.where( (contest) => contest.name.toUpperCase().contains(value.toUpperCase()) ).toList();
        break;
        case "FILTER_ENTRY_FEE_MIN":
          contestsListFiltered = contestsListFiltered.where( (contest) => contest.templateContest.entryFee >= int.parse(value.split('.')[0]) ).toList();
        break;
        case "FILTER_ENTRY_FEE_MAX":
          contestsListFiltered = contestsListFiltered.where( (contest) => contest.templateContest.entryFee <= int.parse(value.split('.')[0]) ).toList();
        break;
        case "FILTER_TOURNAMENT":
          contestsListFiltered = contestsListFiltered.where( (contest) => value.contains(contest.templateContest.tournamentType)).toList();
        break;
        case "FILTER_TIER":
          contestsListFiltered = contestsListFiltered.where( (contest) {
            for (String val in value) {
              switch(val)
              {
                case "BEGGINER":
                  if(contest.templateContest.salaryCap >= SALARY_LIMIT_FOR_BEGGINERS){
                    return true;
                  }else
                    return false;
                break;
                case "STANDARD":
                  if(contest.templateContest.salaryCap < SALARY_LIMIT_FOR_BEGGINERS &&
                     contest.templateContest.salaryCap > SALARY_LIMIT_FOR_SKILLEDS){
                    return true;
                  }else
                    return false;
                break;
                case "SKILLED":
                  if(contest.templateContest.salaryCap <= SALARY_LIMIT_FOR_SKILLEDS) {
                    return true;
                  }else
                    return false;
                break;
              }
            }
          }).toList();
        break;
      }
    });
  }

  /*************************************/
  /*****  Paginador functionality  *****/
  /*************************************/
  void createPaginator() {

    if(_scrDet.isXsScreen)
      _options["numPageLinksToDisplay"] = 2;

    if(listName == null) {
      print('-CONTEST_LIST-: El nombre de esta lista de concursos es null');
    }

    if(contestsListFiltered != null){

      //Calculamos la páginas que habrá en total y determinamos si el paginador estará disponible o no.
      _totalPages = (contestsListFiltered.length /_options["itemsPerPage"]).ceil();

      _paginatorAvailable = _totalPages > 1 ? true : false;

      if(_paginatorAvailable){
        generatePaginatorButtons();
        // Determinamos que elementos se mostrarán en la pagina actual
        int rangeStart = _currentPage * _options["itemsPerPage"];
        int rangeEnd =  (rangeStart + _options["itemsPerPage"] < contestsListFiltered.length) ? rangeStart + _options["itemsPerPage"] : contestsListFiltered.length;
        currentPageList = contestsListFiltered.getRange(rangeStart, rangeEnd).toList();
      }
      else//Si solo elementos para rellenar una página mostramos la lista talcual
      {
        if(_paginatorContainer != null)
          _paginatorContainer.innerHtml="";

        currentPageList = contestsListFiltered;
      }
    }
  }

  void generatePaginatorButtons() {
    if(_paginatorContainer == null) {
      return;
    }

    // Limpiamos el paginador
    _paginatorContainer.innerHtml="";

    // Elementos fijos de la lista
    UListElement ul = new UListElement();
    ul.classes.add("pagination");

    // El botón de ir a la "Primera"
    LIElement first = createPageOption(_options["navLabelFirst"], null, ["to-first-page"] );

   // El botón de ir a la "Anterior"
    LIElement prev = createPageOption(_options["navLabelPrev"], null, ["to-prev-page"] );

    // El botón de ir a la "Siguiente"
    LIElement next =  createPageOption(_options["navLabelNext"], null, ["to-next-page"] );

    // El botón de ir a la "Última"
    LIElement last = createPageOption(_options["navLabelLast"], null, ["to-last-page"] );

    //Además creamos el botón de "..." que indica que hay mas botones antes
    LIElement less = createPageOption("...", null, ["ellipsis", "less"] );
    //Además creamos el botón de "..." que indica que hay mas botones después
    LIElement more = createPageOption("...", null, ["ellipsis", "more"] );

    // Generamos la lista de elementos que tendrá el paginador
    for (int i=0; i < _options["navOrder"].length; i++) {
      switch(_options["navOrder"][i]) {
        case "first":
          if(_options["showFirstLast"])
            ul.children.add(first);
        break;
        case "prev":
          ul.children.add(prev);
        break;
        case "num":
         ul.children.add(less);
         int currentLink = 0;
         while (_totalPages > currentLink) {
           // El primer elemento se linka con la página 0 aunque su label sea 1;
           ul.children.add(createPageOption("${currentLink + 1}", currentLink, [_options["pageLinksIdentifier"]]));
          currentLink++;
         }
         ul.children.add(more);
        break;
        case "next":
          ul.children.add(next);
        break;
        case "last":
          if(_options["showFirstLast"])
            ul.children.add(last);
        break;
      }
    };

    // Los botones de puntos suspensivos los ocultamos
   var ellipsisButtons  = ul.children.where( (Element element) => element.classes.contains('ellipsis')).toList();
   ellipsisButtons.forEach( (LIElement element) => element.style.display = 'none');

   // Llista inks de enlaces a páginas
   var links = ul.children.where( (element) => element.classes.contains(_options["pageLinksIdentifier"])).toList();
    //Activamos la página actual
   links[_currentPage].classes.add(_options["stateActive"]);

   // Ocultamos todos los links de páginas...
   links.forEach((LIElement element) => element.style.display = 'none');
   // ... Y mostramos X elementos según el parametro 'numPageLinkdToDisplay' definido en las opciones
   List<dynamic> visibles;
   if(links.length > _options["numPageLinksToDisplay"]) {
      int rangeStarts = calculateRangeStart(_currentPage, _options["numPageLinksToDisplay"], 0, links.length);
      int rangeEnds = rangeStarts + _options["numPageLinksToDisplay"];
      visibles = links.getRange(rangeStarts, rangeEnds).toList();
   } else {
     visibles = links;
   }
   visibles.forEach((LIElement element) => element.style.display = '');

   //TODO: Toggle less y more buttons e ya!;
   toggleEllipsis(visibles, ul.children);

   //Añadimos los elementos al contenedor padre
   _paginatorContainer.children.add(ul);
  }

  // Crea un element <li> con un <a> en su interior que linkará con la página correspondiente
  // de la lista, y que añadiremos al paginador;
  LIElement createPageOption(String label, int pageNum, List<String> cssClasses) {
    AnchorElement a = new AnchorElement()
      ..innerHtml =label;

    //if(pageNum != null) // Los botones que llevan "..." no llevan, por eso se especifica pageNum = -1
    a.on['click'].listen((event) => goToPage( a, pageNum));

    if(pageNum == 0)
      cssClasses.add('first-page');
    if(pageNum == _totalPages - 1)
      cssClasses.add('last-page');

    String myName = "${_options["linkButtonId"]}_${listName}_";
    myName += pageNum == null? cssClasses.join("-") : (pageNum + 1).toString();
    LIElement li = new LIElement()
      ..children.add(a)
      ..classes.addAll(cssClasses)
      ..id = myName;
    return li;
  }

  // Calcula el valor inicial de un rango
  int calculateRangeStart(int current, int size, int minLmit, int maxLimit) {

    int retorno;
    int average = (size / 2).ceil()-1;
    // El limite inferior es posible es minLmit
    retorno  = current - average < minLmit ? minLmit : current - average;

    if(retorno > maxLimit - size)
        retorno = maxLimit- size;
    return retorno;
  }

  void toggleEllipsis(List<dynamic> currentButtonsShowed, List<dynamic> buttonList) {
    List<Element> first = currentButtonsShowed.where((Element element) => element.classes.contains("first-page")).toList();
    List<Element> last = currentButtonsShowed.where((Element element) => element.classes.contains("last-page")).toList();

    var lessButton = buttonList.where((Element element) => element.classes.contains("less")).toList().first;
    lessButton.style.display = first.isEmpty ? '' : 'none';

    var moreButton = buttonList.where((Element element) => element.classes.contains("more")).toList().first;
    moreButton.style.display = last.isEmpty ? '' : 'none';
  }

  void goToPage(Element target, int pageNum) {
    if(pageNum == null)
    {
      switch(target.parent.classes.first)
      {
        case "to-first-page":
          _currentPage = 0;
        break;
        case "to-prev-page":
          _currentPage--;
        break;
        case "to-next-page":
          _currentPage++;
        break;
        case "to-last-page":
          _currentPage = _totalPages - 1;
        break;
      }
    }
    else
      _currentPage = pageNum;

    if(_currentPage < 0)
      _currentPage = 0;
    if(_currentPage > _totalPages -1)
      _currentPage = _totalPages -1;

    print("-CONTEST_LIST-: Cambio a la página ${_currentPage}");

    createPaginator();
  }


  // Lista original de los contest
  List<Contest> _contestsListOriginal;

  Map _options = {
    "itemsPerPage"          : 10,
    "navPanelIdPrefix"      : "paginatorBox_",
    "linkButtonId"          : "linkButton",
    "pageLinksIdentifier"   : "page-link",
    "numPageLinksToDisplay" :  5,
    "navLabelFirst"         : "&laquo;",
    "navLabelPrev"          : "&lt;",
    "navLabelNext"          : "&gt",
    "navLabelLast"          : "&raquo;",
    "navOrder"              : ["first", "prev", "num", "next", "last"],
    "showFirstLast"         : true,
    "stateActive"           : "active",
    "stateDisabled"         : "disabled"
  };

  int _currentPage = 0;
  int _totalPages = 0;
  int _originalPageLinksCount;

  Element _paginatorContainer;

  bool _paginatorAvailable = false;
  String _sortType;

  DateTimeService _dateTimeService;
  ProfileService _profileService;
  ScreenDetectorService _scrDet;

  var _streamListener;
}
