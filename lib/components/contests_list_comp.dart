library contests_list_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';

@Component(selector: 'contests-list',
           templateUrl: 'packages/webclient/components/contests_list_comp.html',
           publishAs: 'comp',
           useShadowDom: false)
class ContestsListComp {

  @NgOneWay("contestsList")
  List<Contest> contestsList;


  final int FILTER_FIELD      = 0;
  final int FILTER_CONDITION  = 1;
  final int FILTER_VALUE      = 2;


  @NgOneWay("filterBy")
  void set filterBy(List<Map> value) {
    if(value == null)
      return;


  }

  @NgOneWay("sortedBy")
  void set sortedBy(String value) {
    if(value == null) {
      return;
    }

    List<String> sortParams = value.split('_');

    if(sortParams.length != 2) {
      print("El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
    }

    switch(sortParams[0])
    {
      case "contest-name":
        contestsList.sort(( contest1, contest2) => (sortParams[1] == "asc") ? contest1.name.compareTo(contest2.name): contest2.name.compareTo(contest1.name) );

      break;

      case "contest-entry-fee":
        contestsList.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.templateContest.entryFee.compareTo(contest2.templateContest.entryFee):
                                                                            contest2.templateContest.entryFee.compareTo(contest1.templateContest.entryFee)) );
      break;

      case "contest-start-time":
        contestsList.sort((contest1, contest2) => ( sortParams[1] == "asc"? contest1.templateContest.startDate.compareTo(contest2.templateContest.startDate):
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
}
