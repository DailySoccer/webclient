library transaction_history_comp;

import 'package:angular/angular.dart';
import 'package:webclient/models/transaction_info.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/components/base_comp.dart';

@Component(
    selector: 'transaction-history',
    templateUrl: 'packages/webclient/components/account/transaction_history_comp.html',
    useShadowDom: false
)
class TransactionHistoryComp extends BaseComp {

  List<TransactionInfo> transactions = new List<TransactionInfo>();
  // Lista de concursos visible en el componente
  List<TransactionInfo> currentPageList = [];

  int _itemsPerPage   = 0;
  int _currentPage    = 0;

  TransactionHistoryComp(this._router, this._profileService) {
    _profileService.getTransactionHistory()
      .then((List<TransactionInfo> _transactions) {
        transactions = _transactions.reversed.toList();
        updatePage(_currentPage, _itemsPerPage);
      });
  }

  void onPageChange(int currentPage, int itemsPerPage) {
    _currentPage = currentPage;
    _itemsPerPage = itemsPerPage;
    //Actualizamos la página actual de la lista.
    updatePage(_currentPage, _itemsPerPage);
  }

  void updatePage(int pageNum, int itemsPerPage) {
    if (transactions == null || itemsPerPage == 0) {
      return;
    }
    // Determinamos que elementos se mostrarán en la pagina actual
    int lastPosiblePage = (transactions.length / itemsPerPage).floor();
    //int tmpLastViewedPage = pageNum;
    pageNum = pageNum > lastPosiblePage? lastPosiblePage : pageNum;
    int rangeStart =  (transactions == null || transactions.length == 0) ? 0 : pageNum * itemsPerPage;
    int rangeEnd   =  (transactions == null) ? 0 : (rangeStart + itemsPerPage < transactions.length) ? rangeStart + itemsPerPage : transactions.length;

    currentPageList.clear();
    currentPageList = transactions.getRange(rangeStart, rangeEnd).toList();
  }

  ProfileService _profileService;
  Router _router;
}