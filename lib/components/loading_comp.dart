library loading_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/loading_service.dart';

@Component(
  selector: 'loading',
  templateUrl: 'packages/webclient/components/loading_comp.html',
  useShadowDom: false
)
class LoadingComp {
  bool get isLoading => LoadingService.loading;

  LoadingComp(this._loadingService) {
    print("loading...");
  }

  LoadingService _loadingService;
}