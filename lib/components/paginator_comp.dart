library paginator_comp;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:math';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'paginator',
    templateUrl: 'packages/webclient/components/paginator_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class PaginatorComp implements DetachAware, ShadowRootAware {

  @NgCallback('on-page-change')
  Function onPageChange;

  @NgOneWay('list-length')
  void set listLength(int value) {
    if (value == null) {
      return;
    }
    _currentPage = 0;
    _listLength = value;

    // Calculamos la páginas que habrá en total y determinamos si el paginador estará disponible o no.
    _totalPages = (_listLength / _options["itemsPerPage"]).ceil();

    goToPage(_currentPage);
  }

  PaginatorComp(this._scrDet) {
    _originalPageLinksCount = _options["numPageLinksToDisplay"];

    // Si empezamos desde la versión XS el numero de botones es menor.
    if (_scrDet.isXsScreen) {
      _options["numPageLinksToDisplay"] = 1;
    }
    _streamListener = _scrDet.mediaScreenWidth.listen((String msg) => onScreenWidthChange(msg));
  }

  void detach() {
    _streamListener.cancel();
  }

  void onShadowRoot(root) {
    var rootElement = root as HtmlElement;

    _paginatorContainer = rootElement.querySelector(".paginator-box");

    goToPage(_currentPage);
  }

  void onScreenWidthChange(msg) {

    if (msg == "xs") {
      _options["numPageLinksToDisplay"] = 1;
    }
    else {
      _options["numPageLinksToDisplay"] = _originalPageLinksCount;
    }

    createPaginator();
  }

  void createPaginator() {
    if (_paginatorContainer == null) {
      return;
    }

    if (_totalPages > 0) {
      generatePaginatorButtons();
    }
    else {
      _paginatorContainer.innerHtml = "";
    }
  }

  void generatePaginatorButtons() {
    // Limpiamos el paginador
    _paginatorContainer.innerHtml = "";

    // El botón de ir a la "Primera"
    LIElement first = createLinkElement(_options["navLabelFirst"], 0, []);

    // El botón de ir a la "Anterior"
    LIElement prev = createLinkElement(_options["navLabelPrev"], _currentPage - 1, []);

    // El botón de ir a la "Siguiente"
    LIElement next =  createLinkElement(_options["navLabelNext"], _currentPage + 1, []);

    // El botón de ir a la "Última"
    LIElement last = createLinkElement(_options["navLabelLast"], _totalPages -1, []);

    // Además creamos el botón de "..." que indica que hay mas botones antes
    LIElement less = createLinkElement("...", null, ["ellipsis", "less"] );

    // Además creamos el botón de "..." que indica que hay mas botones después
    LIElement more = createLinkElement("...", null, ["ellipsis", "more"] );

    List<LIElement> numbers = [];
    int currentLink = 0;
    while (_totalPages > currentLink) {
      // El primer elemento se linka con la página 0 aunque su label sea 1;
      numbers.add(createLinkElement("${currentLink + 1}", currentLink, [_options["pageLinksCss"]]));
      currentLink++;
    }

    // Activamos la página actual
    numbers[_currentPage].classes.add(_options["stateActive"]);


    // Mostramos X elementos según el parametro 'numPageLinkdToDisplay' definido en las opciones
    if (numbers.length > _options["numPageLinksToDisplay"]) {
      // Ocultamos TODOS los botones numericos
      numbers.forEach((Element elem) => elem.style.display = 'none');

      Map range = calculateLinksRange(_currentPage, _options["numPageLinksToDisplay"]);

      numbers.getRange(range["start"], range["end"]).forEach((LIElement element) => element.style.display = '');

      less.style.display = range["start"] == 0 ? 'none' : '';
      more.style.display = range["end"] >= _totalPages ? 'none' : '';
    }
    else {
      // Si estamos dentro del rango los botones de puntos suspensivos los ocultamos
      [less, more].forEach((LIElement liElem) => liElem.style.display = 'none');
    }

    _createUListElement(first, prev, less, numbers, more, next, last);
  }

  void _createUListElement(first, prev, less, numbers, more, next, last) {
    UListElement ul = new UListElement();
    ul.classes.add("pagination");

    // Generamos la lista de elementos que tendrá el paginador
    for (int i=0; i < _options["navOrder"].length; i++) {
      switch(_options["navOrder"][i]) {
        case "first":
          if (_options["showFirstLast"]) {
            ul.children.add(first);
          }
        break;

        case "prev":
          ul.children.add(prev);
        break;

        case "num":
          ul.children.add(less);
          ul.children.addAll(numbers);
          ul.children.add(more);
        break;

        case "next":
          ul.children.add(next);
        break;
        case "last":
          if (_options["showFirstLast"]) {
            ul.children.add(last);
          }
        break;
      }
    };

    // Añadimos los elementos al contenedor padre
    _paginatorContainer.children.add(ul);
  }

  // Crea un element <li> con un <a> en su interior que linkará con la página correspondiente de la lista, y que añadiremos al paginador;
  LIElement createLinkElement(String label, int pageNum, List<String> cssClasses) {
    AnchorElement a = new AnchorElement()
      ..innerHtml = label;

    if (pageNum != null) {
      a.on['click'].listen((event) => goToPage(pageNum));
    }

    if (pageNum == 0) {
      cssClasses.add('first-page');
    }

    if (pageNum == _totalPages - 1) {
      cssClasses.add('last-page');
    }

    LIElement li = new LIElement()
      ..children.add(a)
      ..classes.addAll(cssClasses);

    return li;
  }

  // Calcula el valor inicial de un rango
  Map calculateLinksRange(int currentPosition, int numPageLinksToDisplay) {

    int start = 0;
    int end = 0;

    int average = (numPageLinksToDisplay / 2).ceil();
    start = max(currentPosition + 1 - average, 0);

    if (start > _totalPages -1 - numPageLinksToDisplay) {
      start = _totalPages - numPageLinksToDisplay;
    }

    if (_totalPages < numPageLinksToDisplay) {
      end = numPageLinksToDisplay;
    }
    else {
      end = start + numPageLinksToDisplay;
    }

    return {"start":start, "end":end};
 }

  void goToPage(int pageNum) {
    if (_totalPages == 0) {
      onPageChange({"currentPage":0, "itemsPerPage":_options["itemsPerPage"]});
      if (_paginatorContainer != null) {
        _paginatorContainer.innerHtml = "";
      }
      return;
    }

    _currentPage = pageNum;

    if (_currentPage < 0) {
      _currentPage = 0;
    }

    if (_currentPage > _totalPages -1) {
      _currentPage = _totalPages -1;
    }

    createPaginator();

    if (onPageChange != null) {
      onPageChange({"currentPage":_currentPage, "itemsPerPage":_options["itemsPerPage"]});
    }
  }

  Map _options = {
     "itemsPerPage"          : 10,
     "pageLinksCss"          : "page-link",
     "numPageLinksToDisplay" :  5,
     "navLabelFirst"         : "&laquo;",
     "navLabelPrev"          : "&lt;",
     "navLabelNext"          : "&gt",
     "navLabelLast"          : "&raquo;",
     "navOrder"              : ["first", "prev", "num", "next", "last"],
     "showFirstLast"         : true,
     "stateActive"           : "active"
   };

   int _currentPage = 0;
   int _totalPages = 0;
   int _originalPageLinksCount;
   int _listLength;

   Element _paginatorContainer;

   ScreenDetectorService _scrDet;

   var _streamListener;
}