library active_contest_list_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/services/contest_service.dart';
import 'package:webclient/models/contest.dart';



@Component(
    selector: 'active-contest-list', 
    templateUrl: 'packages/webclient/components/active_contest_list_comp.html', 
    publishAs: 'activeContestList', 
    useShadowDom: false
)
class ActiveContestListComp {

    ContestService contestService;
    Contest selectedContest;

    ActiveContestListComp(this._router, this.contestService) {
        this.contestService.refreshActiveContests();
    }

    void enterContest(Contest contest) {
         _router.go('enter_contest', { "contestId": contest.contestId });        
    }
    
   void selectContest(Contest contest) {
     selectedContest = contest;
     print("Me llaman a la funcion -selectContest- nombre:" + contest.contestId);
     
     //Esto soluciona el bug por el que no se muestra la ventana modal en Firefox;
     querySelector('#infoContestModal').style.display = "block";
   }
   
   Contest getSelectedContest() => selectedContest;
    Router _router;
}
