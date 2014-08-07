library contests_table_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/models/contest_entry.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'contests-table',
    templateUrl: 'packages/webclient/components/contests_table_comp.html',
    publishAs: 'comp',
    useShadowDom: false
)

class ContestsTableComp {

  List<Contest> data = [];
  dynamic header = [];

  DateFormat startDate = new DateFormat("dd/MM");
  DateFormat startTime = new DateFormat("HH:mm");

  @NgOneWay ('data')
  void set tableData (List<Contest> value) {
    data = value;
  }

  @NgOneWay ('columns-names')
  void set tableHeaders (String val) {
    if(val != null) {
      List<String> columns = val.split(",");
      columns.forEach( (col) {
        var colum = {'name': col.split('-')[0], 'size': col.split('-')[1]};
        header.add(colum);
      });
      print(header);
    }
  }

  int getFantasyPointsByContest(Contest contest) {
    ContestEntry mainPlayer = contest.getContestEntryWithUser(_profileService.user.userId);
    return mainPlayer.currentLivePoints;
  }

  ContestsTableComp(this._profileService){
  }

  ProfileService _profileService;
}
