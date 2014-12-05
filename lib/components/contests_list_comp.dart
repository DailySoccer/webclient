library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';
import 'package:webclient/utils/string_utils.dart';

@Component(
    selector: 'contests-list',
    templateUrl: 'packages/webclient/components/contests_list_comp.html',
    useShadowDom: false
)
class ContestsListComp {

  /********* DECLARATIONS */
  // Lista de concursos visible en el componente
  List<Contest> currentPageList = [];

  // Lista de concursos filtrada
  List<Contest> contestsListFiltered = [];

  /********* BINDINGS */
  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    if (value == null || value.isEmpty) {
      return;
    }
    _contestsListOriginal = value;
    refreshListWithFilters();
  }

  @NgOneWay("competition-type-filter")
  void set filterByCompetition(value) {
    if(value != null) {
      _filterList["FILTER_COMPETITION"] = value;
      refreshListWithFilters();
    }
  }

  @NgOneWay("tournament-type-filter")
  void set filterByType(value) {
    if(value != null) {
      _filterList["FILTER_TOURNAMENT"] = value;
      refreshListWithFilters();
    }
  }

  @NgOneWay("salary-cap-filter")
  void set filterBySalaryCap(value) {
    if(value != null) {
      _filterList["FILTER_TIER"] = value;
      refreshListWithFilters();
    }
  }

  @NgOneWay("entry-fee-filter")
  void set filterByEntryFee(value) {
    if(value != null) {
      _filterList["FILTER_ENTRY_FEE"] = value;
      refreshListWithFilters();
    }
  }

  @NgOneWay("name-filter")
  void set filterByName(value) {
    if(value != null) {
      _filterList["FILTER_CONTEST_NAME"] = value;
      refreshListWithFilters();
    }
  }

  @NgOneWay("sorting")
  void set sorting(Map value) {
    _sortOrder = value;
    refreshList();
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "VER";

  @NgTwoWay("contest-count")
  void set contestCount(int value) {
    _contestCount = value;
  }
  int get contestCount => _contestCount;

  @NgCallback('on-list-change')
  Function onListChange;

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  ContestsListComp(this._profileService, this._scrDet);

  /********* METHODS */
  String dateInfo(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (DateTimeService.isToday(date)) {
      Duration duration = DateTimeService.getTimeLeft(date);

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
    return DateTimeService.formatDateShort(date);
  }

  String timeInfo(DateTime date) {
    // Avisamos 2 horas antes...
    if (DateTimeService.isToday(date) && date.isAfter(DateTimeService.now)) {
      Duration duration = DateTimeService.getTimeLeft(date);
      int minutesLeft = duration.inMinutes;
      if (minutesLeft >= 0 && minutesLeft < 120) {
        return (minutesLeft >= 30) ? "${minutesLeft} min." : "Faltan";
      }
    }
    return DateTimeService.formatTimeShort(date);
  }

  int getMyPosition(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los contest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.isHistory) {
      return mainContestEntry.position + 1;
    }

    return contest.getUserPosition(mainContestEntry);
  }

  String getMyFantasyPoints(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los contest Históricos tendremos los fantasyPoints registrados en el propio ContestEntry
    if (contest.isHistory) {
      return StringUtils.parseFantasyPoints(mainContestEntry.fantasyPoints);
    }

    return StringUtils.parseFantasyPoints(mainContestEntry.currentLivePoints);
  }

  int getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
  }

  void updatePage(int pageNum, int itemsPerPage) {
    if (contestsListFiltered == null || itemsPerPage == 0) {
      return;
    }
    // Determinamos que elementos se mostrarán en la pagina actual
    int lastPosiblePage = (contestsListFiltered.length / itemsPerPage).floor();
    //int tmpLastViewedPage = pageNum;
    pageNum = pageNum > lastPosiblePage? lastPosiblePage : pageNum;
    int rangeStart =  (contestsListFiltered == null || contestsListFiltered.length == 0) ? 0 : pageNum * itemsPerPage;
    int rangeEnd   =  (contestsListFiltered == null) ? 0 : (rangeStart + itemsPerPage < contestsListFiltered.length) ? rangeStart + itemsPerPage : contestsListFiltered.length;
    //print("-CONTEST_LIST-: Actualizando la página ${pageNum +1}.\n Hay un máximo de ${lastPosiblePage +1}, y estamos en la página ${tmpLastViewedPage+1}. El rango de concursos es [${rangeStart}-${rangeEnd}] que corresponde con la página ${pageNum+1}");

    currentPageList.clear();
    currentPageList = contestsListFiltered.getRange(rangeStart, rangeEnd).toList();
  }


  void refreshList() {
    refreshListOrder();
    updatePage(_currentPage, _itemsPerPage);
  }

  void refreshListOrder() {
    if (_sortOrder == null || _sortOrder.isEmpty) {
      return;
    }

    List<Contest> tmp = [];
    tmp.addAll(contestsListFiltered);
    contestsListFiltered = [];


    switch(_sortOrder['fieldName']) {
      case "contest-name":
        tmp.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareNameTo(contest2)) );
      break;

      case "contest-entry-fee":
        tmp.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareEntryFeeTo(contest2)) );
      break;

      case "contest-start-time":
        tmp.sort((contest1, contest2) => ( _sortOrder['order'] * contest1.compareStartDateTo(contest2)) );
      break;

      default:
        print('-CONTEST_LIST-: No se ha encontrado el campo para ordenar');
      break;
    }
    contestsListFiltered.addAll(tmp);
  }

  void refreshListWithFilters() {
    if (_filterList == null || _contestsListOriginal == null) {
      return;
    }
    contestsListFiltered = _contestsListOriginal;
    // Recorremos la lista de filtros
    _filterList.forEach((String key, dynamic value) {
      if (value != null && value.isNotEmpty) {
        switch(key) {
          case "FILTER_COMPETITION":
            contestsListFiltered = contestsListFiltered.where((contest) => value.contains(contest.competitionType)).toList();
          break;
          case "FILTER_CONTEST_NAME":
            contestsListFiltered = contestsListFiltered.where((contest) => contest.name.toUpperCase().contains(value.toUpperCase())).toList();
          break;
          case "FILTER_ENTRY_FEE":
            contestsListFiltered = contestsListFiltered.where((contest) =>  contest.entryFee >= int.parse(value[0].split('.')[0]) &&
                                                                            contest.entryFee <= int.parse(value[1].split('.')[0])).toList();
          break;
          case "FILTER_TIER":
            contestsListFiltered = contestsListFiltered.where((contest) => value.contains(contest.tier)).toList();
          break;
          case "FILTER_TOURNAMENT":
            contestsListFiltered = contestsListFiltered.where((contest) => value.contains(contest.tournamentType)).toList();
          break;
        }
      }
    });
    refreshListOrder();
    contestCount = contestsListFiltered.length;
  }


  /********* HANDLERS */
  void onRow(Contest contest) {
    if (onRowClick != null) {
      onRowClick({"contest":contest});
    }
  }

  void onAction(Contest contest) {
    if (onActionClick != null) {
      onActionClick({"contest":contest});
    }
  }

  void onPageChange(int currentPage, int itemsPerPage) {
    _currentPage = currentPage;
    _itemsPerPage = itemsPerPage;
    //Actualizamos la página actual de la lista.
    updatePage(_currentPage, _itemsPerPage);
  }

  /********* PRIVATE DECLARATIONS */
  // Lista original de los contest
  List<Contest> _contestsListOriginal;

  // Lista de filtros a aplicar
  Map<String,dynamic> _filterList = {};

  // Parametros de ordenación
  Map _sortOrder = {};

  int _contestCount   = 0;
  int _itemsPerPage   = 0;
  int _currentPage    = 0;

  ProfileService _profileService;
  ScreenDetectorService _scrDet;
}
