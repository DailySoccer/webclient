library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';

@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

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

  //NumberFormat numFormat = new NumberFormat("#");

  bool isToday(DateTime date) => (date.year == _dateTimeService.now.year && date.month == _dateTimeService.now.month && date.day == _dateTimeService.now.day);

  String listName="";

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


  ContestsListComp(this._profileService, this._dateTimeService);

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
      print("El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
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
        print('No se ha encontrado el campo para ordenar');
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

  // Lista original de los contest
  List<Contest> _contestsListOriginal;
  String _sortType;

  DateTimeService _dateTimeService;
  ProfileService _profileService;

  /*************************************/
  /*****  Paginador functionality  *****/
  /*************************************/



  var _meta;

  Map _defaults = {
    "itemContainerId"       : ".content",
    "itemPerPage"           : 10,
    "navPanelId0"           : ".page-navigation",
    "navInfoId"             : ".info-text",
    "numPageLinksToDisplay" : 20,
    "startPage"             : 0,
    "wrapAround"            : false,
    "navLabelFirst"         : "&laquo;",
    "navLabelPrev"          : "&lt;",
    "navLabelNext"          : "&gt",
    "navLabelLast"          : "&raquo;",
    "navOrder"              : ["first", "prev", "num", "next", "last"],
    "navLabelInfo"          : "Showing [0]-[1] of {2} results",
    "showFirstLast"         : true,
    "abortOnSmallLists"     : true,
    "stateActive"           : "active",
    "stateDisabled"         : "disabled"
  };
  int _currentPage = 0;
  int _itemsPerPage = 5;
  int _totalPages = 0;

  List<Contest> currentPageList = [];

  Element _paginatorContainer;

  bool paginatorAvailable = false;

  void createPaginator() {
    if(listName == null) {
      print('-CONTEST_LIST-: El nombre de esta lista de concursos es null');
    }
    // Capturamos el elementos qe será el padre del paginador.
    String paginatorContainerId = "paginatorBox" + listName;
    _paginatorContainer = querySelector('#'+paginatorContainerId);

    if(contestsListFiltered != null){
    //  Determinamos que elementos se mostrarán en la first page
    //Calculamos la páginas que habrá en total y determinamos si el paginador estará disponible o no.
    _totalPages = (contestsListFiltered.length /_itemsPerPage).ceil();
    if(_totalPages > 1)
      paginatorAvailable = true;

    ///////
    if(_paginatorContainer != null) {
      _paginatorContainer.text = "El paginador tendrá ${_totalPages} páginas";
      _paginatorContainer.style.width = "150px";
    }
    /////

    if(paginatorAvailable){
      currentPageList = contestsListFiltered.getRange(_currentPage * _itemsPerPage , _itemsPerPage).toList();
    }
    else //Si solo elementos para rellenar una página mostramos la lista talcual
      currentPageList = contestsListFiltered;
    }



  }







}
