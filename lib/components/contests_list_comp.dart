library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:intl/intl.dart';

@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

  @NgOneWay("contestsList")
  void set contestsList(List<Contest> value) {
    contestsListOriginal = value;
    contestsListFiltered = contestsListOriginal;
    refreshFilters();
  }

  // Lista original de los contest
  List<Contest> contestsListOriginal;
  // Lista copia de la original que guardará los contest tras aplicar los filtros
  List<Contest> contestsListFiltered;
  // Lista de filtros a aplicar
  Map<String,Map> filterList;
  DateFormat startDate = new DateFormat("dd/MM");
  DateFormat startTime = new DateFormat("HH:mm");

  /*******************************************/
    //Setter de los filtros, Recibe la lista de los filtros aplicados.
    //Los filtros son un mapa compuesto tal que así:
    //filtro = {'NOMBRE_FILTRO': {'FILTER_FIELD':'value'},{'FILTER_CONDITION':'value'},{'FILTER_VALUE':'value'}}

  @NgOneWay("filterBy")
  void set filterBy(Map<String,Map> value) {
    if (value == null)
      return;
    if (value.keys.length <= 0)
      return;
    //List<Contest> tmpContestList;

    //Recorremos la lista de filtros
    value.forEach( (String clave, Map<String,String> valor )  {
      //Guardamos los campos que nos vienen como parametros
      //String field          = valor["FILTER_FIELD"];
      //String condition      = valor["FILTER_CONDITION"];
      String valueToCompare = valor["FILTER_VALUE"]; //En principio solo voy a necesitar el Valor, por que el resto de datos los tengo que suponer.

      switch(clave)
      {
        case "FILTER_CONTEST_NAME":
          contestsListFiltered = contestsListOriginal.where((contest) => contest.name.toUpperCase().contains(valueToCompare.toUpperCase())).toList();
        break;
      }
    });
   // contestsListFiltered = tmpContestList;

   // print("-CONTEST LIST- Filtros recibidos ${value}");

  }

  /* Constantes para la identificación de los campos del mapa
  final int FILTER_FIELD      = 0;
  final int FILTER_CONDITION  = 1;
  final int FILTER_VALUE      = 2;
  */
  /*******************************************/
  @NgOneWay("sortedBy")
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

  @NgOneWay("actionButtonTitle")
  String actionButtonTitle = "Ver";

  @NgCallback("onRowClick")
  Function onRowClick;

  @NgCallback("onActionClick")
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
  }
}
