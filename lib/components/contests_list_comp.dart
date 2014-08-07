library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:intl/intl.dart';

@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

  // Lista original de los contest
  List<Contest> contestsListOriginal;

  // Lista copia de la original que guardará los contest tras aplicar los filtros
  List<Contest> contestsListFiltered;

  // Lista de filtros a aplicar
  Map<String,String> filterList;

  DateFormat startDate = new DateFormat("dd/MM");
  DateFormat startTime = new DateFormat("HH:mm");
  //NumberFormat numFormat = new NumberFormat("#");


  @NgOneWay("contests-list")
  void set contestsList(List<Contest> value) {
    contestsListOriginal = value;
    contestsListFiltered = contestsListOriginal;
    refreshFilters();
  }

  //Setter de los filtros, Recibe la lista de los filtros aplicados.
  @NgOneWay("filter-by")
  void set filterBy(Map<String,String> value) {
    if (value == null)
      return;
    filterList = value;
    //Partimos siempre de la lista original de todos los players
    contestsListFiltered = _contestsListOriginal;
    refreshFilters();
  }

  @NgOneWay("sorted-by")
  void set sortedBy(String value) {
    if(value == null || value.isEmpty) {
      return;
    }

    List<String> sortParams = value.split('_');

    if (sortParams.length != 2) {
      print("El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
    }

    switch(sortParams[0])
    {
      case "contest-name":
        contestsListFiltered.sort(( contest1, contest2) => (sortParams[1] == "asc") ? contest1.name.compareTo(contest2.name): contest2.name.compareTo(contest1.name) );

      break;

      case "contest-entry-fee":
        contestsListFiltered.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.templateContest.entryFee.compareTo(contest2.templateContest.entryFee):
                                                                            contest2.templateContest.entryFee.compareTo(contest1.templateContest.entryFee)) );
      break;

      case "contest-start-time":
        contestsListFiltered.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.templateContest.startDate.compareTo(contest2.templateContest.startDate):
                                                                            contest2.templateContest.startDate.compareTo(contest1.templateContest.startDate)) );
      break;

      default:
        print('No se ha encontrado el campo para ordenar');
      break;
    }
    print('Ordenando la lista by: $sortParams');
  }

  @NgOneWay("action-button-title")
  String actionButtonTitle = "Ver";

  @NgCallback("on-row-click")
  Function onRowClick;

  @NgCallback("on-action-click")
  Function onActionClick;

  ContestsListComp();

  void onRow(Contest contest) {
    if (onRowClick != null)
      onRowClick({"contest":contest});
  }

  void onAction(Contest contest) {
    if (onActionClick != null)
      onActionClick({"contest":contest});
  }

  void refreshFilters() {
    if( filterList == null){
      return;
    }
    //Recorremos la lista de filtros
        filterList.forEach( (String key, String value )  {
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
         }
       });

  }

  // Lista original de los contest
  List<Contest> _contestsListOriginal;
}
