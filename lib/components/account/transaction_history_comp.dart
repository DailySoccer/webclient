library transaction_history_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/transaction_info.dart';
import 'package:webclient/services/profile_service.dart';

@Component(
    selector: 'transaction-history',
    templateUrl: 'packages/webclient/components/account/transaction_history_comp.html',
    useShadowDom: false
)
class TransactionHistoryComp {

  List<TransactionInfo> transactions = new List<TransactionInfo>();

  TransactionHistoryComp(this._router, this._profileService) {
    _profileService.getTransactionHistory()
      .then((List<TransactionInfo> _transactions) {
        transactions = _transactions.reversed.toList();
      });
  }

  ProfileService _profileService;
  Router _router;
}