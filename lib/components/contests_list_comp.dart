library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:intl/intl.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/services/screen_detector_service.dart';

@Component(
    selector: 'contests-list',
    templateUrl: 'packages/webclient/components/contests_list_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)
class ContestsListComp {

  // Lista copia de la original que guardará los contest tras aplicar los filtros
  List<Contest> contestsListFiltered = [];

  // Lista de filtros a aplicar
  Map<String,dynamic> filterList;

  bool isToday(DateTime date) => (date.year == _dateTimeService.now.year && date.month == _dateTimeService.now.month && date.day == _dateTimeService.now.day);

  List<Contest> currentPageList = [];
  bool mustRefreshTheList = false;

  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    _contestsListOriginal = value;
    contestsListFiltered = _contestsListOriginal;
    refreshList();
  }

  //Setter de los filtros, Recibe la lista de los filtros aplicados.
  @NgOneWay("filter-by")
  void set filterBy(Map<String,dynamic> value) {
    if (value == null) {
      return;
    }
    filterList = value;
    refreshList();
  }

  @NgOneWay("sorted-by")
  void set sortedBy(String value) {
    if (value == null || value.isEmpty) {
      return;
    }
    _sortType = value;
    refreshList();
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "Ver";

  @NgCallback('on-list-change')
  Function onListChange;

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  ContestsListComp(this._profileService, this._dateTimeService, this._scrDet);

  String dateInfo(DateTime date) {
    // Avisamos cuando sea "Hoy"
    if (isToday(date)) {
      Duration duration = _dateTimeService.timeLeft(date);
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
    if (isToday(date) && date.isAfter(_dateTimeService.now)) {
      Duration duration = _dateTimeService.timeLeft(date);
      int minutesLeft = duration.inMinutes;
      if (minutesLeft >= 0 && minutesLeft < 120) {
        return (minutesLeft >= 30) ? "${minutesLeft} min." : "Faltan";
      }
    }
    return DateTimeService.formatTimeShort(date);
  }

  int getMyPosition(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los templateContest Históricos tendremos la posición registrada en el propio ContestEntry
    if (contest.templateContest.isHistory) {
      return mainContestEntry.position + 1;
    }

    return contest.getUserPosition(mainContestEntry);
  }

  int getMyFantasyPoints(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);

    // En los templateContest Históricos tendremos los fantasyPoints registrados en el propio ContestEntry
    if (contest.templateContest.isHistory) {
      return mainContestEntry.fantasyPoints;
    }

    return mainContestEntry.currentLivePoints;
  }

  int getMyPrize(Contest contest) {
    ContestEntry mainContestEntry = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainContestEntry.prize;
  }

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

  void refreshList() {
    refreshFilters();
    refreshSort();
    onListChange({"itemsCount": contestsListFiltered.length});
  }

  void refreshSort() {
    if (_sortType == null) {
      return;
    }

    List<String> sortParams = _sortType.split('_');

    if (sortParams.length != 2) {
      print("-CONTEST_LIST-: El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
    }

    switch(sortParams[0]) {
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
    mustRefreshTheList =  true;
  }

  void refreshFilters() {
    if (filterList == null) {
      return;
    }
    contestsListFiltered = _contestsListOriginal;
    //Recorremos la lista de filtros
    filterList.forEach((String key, dynamic value) {
      switch(key) {
        case "FILTER_CONTEST_NAME":
          contestsListFiltered = contestsListFiltered.where((contest) => contest.name.toUpperCase().contains(value.toUpperCase())).toList();
        break;
        case "FILTER_ENTRY_FEE":
          contestsListFiltered = contestsListFiltered.where((contest) =>  contest.templateContest.entryFee >= int.parse(value[0].split('.')[0]) &&
                                                                          contest.templateContest.entryFee <= int.parse(value[1].split('.')[0])).toList();
        break;
        case "FILTER_TOURNAMENT":
          contestsListFiltered = contestsListFiltered.where((contest) => value.contains(contest.templateContest.tournamentType)).toList();
        break;
        case "FILTER_TIER":
          contestsListFiltered = contestsListFiltered.where((contest) => value.contains(contest.templateContest.tier)).toList();
        break;
      }
    });
  }

  void onPageChange(int currentPage, int itemsPerPage) {
    // Determinamos que elementos se mostrarán en la pagina actual
    int rangeStart = currentPage * itemsPerPage;
    int rangeEnd =  (rangeStart + itemsPerPage < contestsListFiltered.length) ? rangeStart + itemsPerPage : contestsListFiltered.length;
    currentPageList = contestsListFiltered.getRange(rangeStart, rangeEnd).toList();
    mustRefreshTheList = false;
  }

  // Lista original de los contest
  List<Contest> _contestsListOriginal;

  String _sortType;
  int _contestsCount = 0;

  DateTimeService _dateTimeService;
  ProfileService _profileService;
  ScreenDetectorService _scrDet;
}
