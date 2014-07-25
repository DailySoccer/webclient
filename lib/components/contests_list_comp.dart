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

  @NgOneWay("sortedBy")
  void set sortedBy(String value) {

    if(value == null)
       return;

    var sortParams = value.split('_');
    if(sortParams != null)
    {
      if(sortParams.length == 2) {
        switch(sortParams[0])
        {
          case "contest-name":
            if(sortParams[1] == "asc")
              contestsList.sort( (contest1, contest2) => contest1.name.compareTo(contest2.name) );
            else
              contestsList.sort( (contest1, contest2) => contest2.name.compareTo(contest1.name) );
          break;

          case "contest-entry-fee":
            if(sortParams[1] == "asc")
              contestsList.sort( (contest1, contest2) => contest1.templateContest.entryFee.compareTo(contest2.templateContest.entryFee) );
            else
              contestsList.sort( (contest1, contest2) => contest2.templateContest.entryFee.compareTo(contest1.templateContest.entryFee) );
          break;

          case "contest-start-time":
            if(sortParams[1] == "asc")
              contestsList.sort( (contest1, contest2) => contest1.templateContest.startDate.compareTo(contest2.templateContest.startDate) );
            else
              contestsList.sort( (contest1, contest2) => contest2.templateContest.startDate.compareTo(contest1.templateContest.startDate) );
          break;
          default:
            print('No se ha encontrado el campo para ordenar');
          break;
        }
        print('Ordenando la lista by: $sortParams');
      }
      else
      {
        print("El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
      }
    }
    else
    {
      print("El número de parametros no se ha establecido correctamente. La forma correcta es \'campo\'_\'dirección\'. Pon atención a la barra baja \'_\'");
    }

    //contestsList.sort( (contest1, contest2) => contest1.templateContest.salaryCap.compareTo(contest.) );
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
